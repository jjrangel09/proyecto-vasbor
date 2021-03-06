PGDMP     	                    x            proyectovasbor    11.7    11.7 �               0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                       false                       0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                       false                       0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                       false                       1262    25136    proyectovasbor    DATABASE     �   CREATE DATABASE proyectovasbor WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'Spanish_Colombia.1252' LC_CTYPE = 'Spanish_Colombia.1252';
    DROP DATABASE proyectovasbor;
             postgres    false                        2615    25137    restaurante    SCHEMA        CREATE SCHEMA restaurante;
    DROP SCHEMA restaurante;
             postgres    false                        2615    25463    security    SCHEMA        CREATE SCHEMA security;
    DROP SCHEMA security;
             postgres    false            �            1255    25484    f_log_auditoria()    FUNCTION     �   CREATE FUNCTION security.f_log_auditoria() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
	 DECLARE
		_pk TEXT :='';		-- Representa la llave primaria de la tabla que esta siedno modificada.
		_sql TEXT;		-- Variable para la creacion del procedured.
		_column_guia RECORD; 	-- Variable para el FOR guarda los nombre de las columnas.
		_column_key RECORD; 	-- Variable para el FOR guarda los PK de las columnas.
		_session TEXT;	-- Almacena el usuario que genera el cambio.
		_user_db TEXT;		-- Almacena el usuario de bd que genera la transaccion.
		_control INT;		-- Variabel de control par alas llaves primarias.
		_count_key INT = 0;	-- Cantidad de columnas pertenecientes al PK.
		_sql_insert TEXT;	-- Variable para la construcción del insert del json de forma dinamica.
		_sql_delete TEXT;	-- Variable para la construcción del delete del json de forma dinamica.
		_sql_update TEXT;	-- Variable para la construcción del update del json de forma dinamica.
		_new_data RECORD; 	-- Fila que representa los campos nuevos del registro.
		_old_data RECORD;	-- Fila que representa los campos viejos del registro.

	BEGIN

			-- Se genera la evaluacion para determianr el tipo de accion sobre la tabla
		 IF (TG_OP = 'INSERT') THEN
			_new_data := NEW;
			_old_data := NEW;
		ELSEIF (TG_OP = 'UPDATE') THEN
			_new_data := NEW;
			_old_data := OLD;
		ELSE
			_new_data := OLD;
			_old_data := OLD;
		END IF;

		-- Se genera la evaluacion para determianr el tipo de accion sobre la tabla
		IF ((SELECT COUNT(*) FROM information_schema.columns WHERE table_schema = TG_TABLE_SCHEMA AND table_name = TG_TABLE_NAME AND column_name = 'id' ) > 0) THEN
			_pk := _new_data.id;
		ELSE
			_pk := '-1';
		END IF;

		-- Se valida que exista el campo modified_by
		IF ((SELECT COUNT(*) FROM information_schema.columns WHERE table_schema = TG_TABLE_SCHEMA AND table_name = TG_TABLE_NAME AND column_name = 'session') > 0) THEN
			_session := _new_data.session;
		ELSE
			_session := '';
		END IF;

		-- Se guarda el susuario de bd que genera la transaccion
		_user_db := (SELECT CURRENT_USER);

		-- Se evalua que exista el procedimeinto adecuado
		IF (SELECT COUNT(*) FROM security.function_db_view acfdv WHERE acfdv.b_function = 'field_audit' AND acfdv.b_type_parameters = TG_TABLE_SCHEMA || '.'|| TG_TABLE_NAME || ', '|| TG_TABLE_SCHEMA || '.'|| TG_TABLE_NAME || ', character varying, character varying, character varying, text, character varying, text, text') > 0
			THEN
				-- Se realiza la invocación del procedured generado dinamivamente
				PERFORM security.field_audit(_new_data, _old_data, TG_OP, _session, _user_db , _pk, ''::text);
		ELSE
			-- Se empieza la construcción del Procedured generico
			_sql := 'CREATE OR REPLACE FUNCTION security.field_audit( _data_new '|| TG_TABLE_SCHEMA || '.'|| TG_TABLE_NAME || ', _data_old '|| TG_TABLE_SCHEMA || '.'|| TG_TABLE_NAME || ', _accion character varying, _session text, _user_db character varying, _table_pk text, _init text)'
			|| ' RETURNS TEXT AS ''
'
			|| '
'
	|| '	DECLARE
'
	|| '		_column_data TEXT;
	 	_datos jsonb;
	 	
'
	|| '	BEGIN
			_datos = ''''{}'''';
';
			-- Se evalua si hay que actualizar la pk del registro de auditoria.
			IF _pk = '-1'
				THEN
					_sql := _sql
					|| '
		_column_data := ';

					-- Se genera el update con la clave pk de la tabla
					SELECT
						COUNT(isk.column_name)
					INTO
						_control
					FROM
						information_schema.table_constraints istc JOIN information_schema.key_column_usage isk ON isk.constraint_name = istc.constraint_name
					WHERE
						istc.table_schema = TG_TABLE_SCHEMA
					 AND	istc.table_name = TG_TABLE_NAME
					 AND	istc.constraint_type ilike '%primary%';

					-- Se agregan las columnas que componen la pk de la tabla.
					FOR _column_key IN SELECT
							isk.column_name
						FROM
							information_schema.table_constraints istc JOIN information_schema.key_column_usage isk ON isk.constraint_name = istc.constraint_name
						WHERE
							istc.table_schema = TG_TABLE_SCHEMA
						 AND	istc.table_name = TG_TABLE_NAME
						 AND	istc.constraint_type ilike '%primary%'
						ORDER BY 
							isk.ordinal_position  LOOP

						_sql := _sql || ' _data_new.' || _column_key.column_name;
						
						_count_key := _count_key + 1 ;
						
						IF _count_key < _control THEN
							_sql :=	_sql || ' || ' || ''''',''''' || ' ||';
						END IF;
					END LOOP;
				_sql := _sql || ';';
			END IF;

			_sql_insert:='
		IF _accion = ''''INSERT''''
			THEN
				';
			_sql_delete:='
		ELSEIF _accion = ''''DELETE''''
			THEN
				';
			_sql_update:='
		ELSE
			';

			-- Se genera el ciclo de agregado de columnas para el nuevo procedured
			FOR _column_guia IN SELECT column_name, data_type FROM information_schema.columns WHERE table_schema = TG_TABLE_SCHEMA AND table_name = TG_TABLE_NAME
				LOOP
						
					_sql_insert:= _sql_insert || '_datos := _datos || json_build_object('''''
					|| _column_guia.column_name
					|| '_nuevo'
					|| ''''', '
					|| '_data_new.'
					|| _column_guia.column_name;

					IF _column_guia.data_type IN ('bytea', 'USER-DEFINED') THEN 
						_sql_insert:= _sql_insert
						||'::text';
					END IF;

					_sql_insert:= _sql_insert || ')::jsonb;
				';

					_sql_delete := _sql_delete || '_datos := _datos || json_build_object('''''
					|| _column_guia.column_name
					|| '_anterior'
					|| ''''', '
					|| '_data_old.'
					|| _column_guia.column_name;

					IF _column_guia.data_type IN ('bytea', 'USER-DEFINED') THEN 
						_sql_delete:= _sql_delete
						||'::text';
					END IF;

					_sql_delete:= _sql_delete || ')::jsonb;
				';

					IF _column_guia.data_type IN ('json') THEN 
						_sql_update:= _sql_update || 'IF (_data_old.' || _column_guia.column_name;
					ELSE
						_sql_update := _sql_update || 'IF _data_old.' || _column_guia.column_name;
					END IF;

					IF _column_guia.data_type IN ('bytea','USER-DEFINED') THEN 
						_sql_update:= _sql_update
						||'::text';
					END IF;

					IF _column_guia.data_type IN ('json') THEN 
						_sql_update:= _sql_update
						||'::jsonb';

						_sql_update:= _sql_update || ' @>  _data_new.' || _column_guia.column_name;
					ELSE
						_sql_update:= _sql_update || ' <> _data_new.' || _column_guia.column_name;
					END IF;

					IF _column_guia.data_type IN ('bytea','USER-DEFINED') THEN 
						_sql_update:= _sql_update
						||'::text';
					END IF;

					IF _column_guia.data_type IN ('json') THEN 
						_sql_update:= _sql_update
						||'::jsonb ) = FALSE';

						_sql_update:= _sql_update || '
				THEN _datos := _datos || _data_old.' || _column_guia.column_name;

					ELSE

					_sql_update:= _sql_update || '
				THEN _datos := _datos || json_build_object('''''
					|| _column_guia.column_name
					|| '_anterior'
					|| ''''', '
					|| '_data_old.'
					|| _column_guia.column_name;

					END IF;

					IF _column_guia.data_type IN ('bytea','USER-DEFINED') THEN 
						_sql_update:= _sql_update
						||'::text';
					END IF;

					IF _column_guia.data_type IN ('json') THEN 

					ELSE

						_sql_update:= _sql_update
						|| ', '''''
						|| _column_guia.column_name
						|| '_nuevo'
						|| ''''', _data_new.'
						|| _column_guia.column_name;
					END IF;

					IF _column_guia.data_type IN ('bytea', 'USER-DEFINED') THEN 
						_sql_update:= _sql_update
						||'::text';
					END IF;

					IF _column_guia.data_type IN ('json') THEN 
					_sql_update:= _sql_update
					|| '::jsonb;
			END IF;
			';
					ELSE
					_sql_update:= _sql_update
					|| ')::jsonb;
			END IF;
			';
					END IF;
			END LOOP;

			-- Se le agrega la parte final del procedured generico
			
			_sql:= _sql || _sql_insert || _sql_delete || _sql_update
			|| ' 
		END IF;

		INSERT INTO security.auditoria
		(
			fecha,
			accion,
			schema,
			tabla,
			pk,
			session,
			user_bd,
			data
		)
		VALUES
		(
			CURRENT_TIMESTAMP,
			_accion,
			''''' || TG_TABLE_SCHEMA || ''''',
			''''' || TG_TABLE_NAME || ''''',
			_table_pk,
			_session,
			_user_db,
			_datos::jsonb
			);

		RETURN NULL; 
	END;'''
|| '
LANGUAGE plpgsql;';

			-- Se genera la ejecución de _sql, es decir se crea el nuevo procedured de forma generica.
			EXECUTE _sql;

		-- Se realiza la invocación del procedured generado dinamivamente
			PERFORM security.field_audit(_new_data, _old_data, TG_OP::character varying, _session, _user_db, _pk, ''::text);

		END IF;

		RETURN NULL;

END;
$$;
 *   DROP FUNCTION security.f_log_auditoria();
       security       postgres    false    6            �            1259    25138    producto    TABLE     X  CREATE TABLE restaurante.producto (
    id integer NOT NULL,
    nombre text NOT NULL,
    categoria integer NOT NULL,
    subcategoria integer NOT NULL,
    precio double precision NOT NULL,
    descripcion text NOT NULL,
    imagen text NOT NULL,
    cantidad integer NOT NULL,
    session text,
    last_modifity timestamp with time zone
);
 !   DROP TABLE restaurante.producto;
       restaurante         postgres    false    8            �            1255    25681 o   field_audit(restaurante.producto, restaurante.producto, character varying, text, character varying, text, text)    FUNCTION     G  CREATE FUNCTION security.field_audit(_data_new restaurante.producto, _data_old restaurante.producto, _accion character varying, _session text, _user_db character varying, _table_pk text, _init text) RETURNS text
    LANGUAGE plpgsql
    AS $$

	DECLARE
		_column_data TEXT;
	 	_datos jsonb;
	 	
	BEGIN
			_datos = '{}';

		IF _accion = 'INSERT'
			THEN
				_datos := _datos || json_build_object('id_nuevo', _data_new.id)::jsonb;
				_datos := _datos || json_build_object('nombre_nuevo', _data_new.nombre)::jsonb;
				_datos := _datos || json_build_object('categoria_nuevo', _data_new.categoria)::jsonb;
				_datos := _datos || json_build_object('subcategoria_nuevo', _data_new.subcategoria)::jsonb;
				_datos := _datos || json_build_object('precio_nuevo', _data_new.precio)::jsonb;
				_datos := _datos || json_build_object('descripcion_nuevo', _data_new.descripcion)::jsonb;
				_datos := _datos || json_build_object('imagen_nuevo', _data_new.imagen)::jsonb;
				_datos := _datos || json_build_object('cantidad_nuevo', _data_new.cantidad)::jsonb;
				_datos := _datos || json_build_object('session_nuevo', _data_new.session)::jsonb;
				_datos := _datos || json_build_object('last_modifity_nuevo', _data_new.last_modifity)::jsonb;
				
		ELSEIF _accion = 'DELETE'
			THEN
				_datos := _datos || json_build_object('id_anterior', _data_old.id)::jsonb;
				_datos := _datos || json_build_object('nombre_anterior', _data_old.nombre)::jsonb;
				_datos := _datos || json_build_object('categoria_anterior', _data_old.categoria)::jsonb;
				_datos := _datos || json_build_object('subcategoria_anterior', _data_old.subcategoria)::jsonb;
				_datos := _datos || json_build_object('precio_anterior', _data_old.precio)::jsonb;
				_datos := _datos || json_build_object('descripcion_anterior', _data_old.descripcion)::jsonb;
				_datos := _datos || json_build_object('imagen_anterior', _data_old.imagen)::jsonb;
				_datos := _datos || json_build_object('cantidad_anterior', _data_old.cantidad)::jsonb;
				_datos := _datos || json_build_object('session_anterior', _data_old.session)::jsonb;
				_datos := _datos || json_build_object('last_modifity_anterior', _data_old.last_modifity)::jsonb;
				
		ELSE
			IF _data_old.id <> _data_new.id
				THEN _datos := _datos || json_build_object('id_anterior', _data_old.id, 'id_nuevo', _data_new.id)::jsonb;
			END IF;
			IF _data_old.nombre <> _data_new.nombre
				THEN _datos := _datos || json_build_object('nombre_anterior', _data_old.nombre, 'nombre_nuevo', _data_new.nombre)::jsonb;
			END IF;
			IF _data_old.categoria <> _data_new.categoria
				THEN _datos := _datos || json_build_object('categoria_anterior', _data_old.categoria, 'categoria_nuevo', _data_new.categoria)::jsonb;
			END IF;
			IF _data_old.subcategoria <> _data_new.subcategoria
				THEN _datos := _datos || json_build_object('subcategoria_anterior', _data_old.subcategoria, 'subcategoria_nuevo', _data_new.subcategoria)::jsonb;
			END IF;
			IF _data_old.precio <> _data_new.precio
				THEN _datos := _datos || json_build_object('precio_anterior', _data_old.precio, 'precio_nuevo', _data_new.precio)::jsonb;
			END IF;
			IF _data_old.descripcion <> _data_new.descripcion
				THEN _datos := _datos || json_build_object('descripcion_anterior', _data_old.descripcion, 'descripcion_nuevo', _data_new.descripcion)::jsonb;
			END IF;
			IF _data_old.imagen <> _data_new.imagen
				THEN _datos := _datos || json_build_object('imagen_anterior', _data_old.imagen, 'imagen_nuevo', _data_new.imagen)::jsonb;
			END IF;
			IF _data_old.cantidad <> _data_new.cantidad
				THEN _datos := _datos || json_build_object('cantidad_anterior', _data_old.cantidad, 'cantidad_nuevo', _data_new.cantidad)::jsonb;
			END IF;
			IF _data_old.session <> _data_new.session
				THEN _datos := _datos || json_build_object('session_anterior', _data_old.session, 'session_nuevo', _data_new.session)::jsonb;
			END IF;
			IF _data_old.last_modifity <> _data_new.last_modifity
				THEN _datos := _datos || json_build_object('last_modifity_anterior', _data_old.last_modifity, 'last_modifity_nuevo', _data_new.last_modifity)::jsonb;
			END IF;
			 
		END IF;

		INSERT INTO security.auditoria
		(
			fecha,
			accion,
			schema,
			tabla,
			pk,
			session,
			user_bd,
			data
		)
		VALUES
		(
			CURRENT_TIMESTAMP,
			_accion,
			'restaurante',
			'producto',
			_table_pk,
			_session,
			_user_db,
			_datos::jsonb
			);

		RETURN NULL; 
	END;$$;
 �   DROP FUNCTION security.field_audit(_data_new restaurante.producto, _data_old restaurante.producto, _accion character varying, _session text, _user_db character varying, _table_pk text, _init text);
       security       postgres    false    198    198    6            �            1259    25162    registro_usuario    TABLE     �  CREATE TABLE restaurante.registro_usuario (
    id bigint NOT NULL,
    identificacion bigint,
    nombre text,
    apellido text,
    correo text,
    username text,
    "contraseña" text,
    telefono bigint,
    rol integer,
    estado_id integer DEFAULT 1,
    token text,
    vencimiento_token timestamp without time zone,
    session text,
    last_modifity timestamp with time zone
);
 )   DROP TABLE restaurante.registro_usuario;
       restaurante         postgres    false    8            �            1255    25492    field_audit(restaurante.registro_usuario, restaurante.registro_usuario, character varying, text, character varying, text, text)    FUNCTION     ]  CREATE FUNCTION security.field_audit(_data_new restaurante.registro_usuario, _data_old restaurante.registro_usuario, _accion character varying, _session text, _user_db character varying, _table_pk text, _init text) RETURNS text
    LANGUAGE plpgsql
    AS $$

	DECLARE
		_column_data TEXT;
	 	_datos jsonb;
	 	
	BEGIN
			_datos = '{}';

		IF _accion = 'INSERT'
			THEN
				_datos := _datos || json_build_object('id_nuevo', _data_new.id)::jsonb;
				_datos := _datos || json_build_object('identificacion_nuevo', _data_new.identificacion)::jsonb;
				_datos := _datos || json_build_object('nombre_nuevo', _data_new.nombre)::jsonb;
				_datos := _datos || json_build_object('apellido_nuevo', _data_new.apellido)::jsonb;
				_datos := _datos || json_build_object('correo_nuevo', _data_new.correo)::jsonb;
				_datos := _datos || json_build_object('username_nuevo', _data_new.username)::jsonb;
				_datos := _datos || json_build_object('contraseña_nuevo', _data_new.contraseña)::jsonb;
				_datos := _datos || json_build_object('telefono_nuevo', _data_new.telefono)::jsonb;
				_datos := _datos || json_build_object('rol_nuevo', _data_new.rol)::jsonb;
				_datos := _datos || json_build_object('estado_id_nuevo', _data_new.estado_id)::jsonb;
				_datos := _datos || json_build_object('token_nuevo', _data_new.token)::jsonb;
				_datos := _datos || json_build_object('vencimiento_token_nuevo', _data_new.vencimiento_token)::jsonb;
				_datos := _datos || json_build_object('session_nuevo', _data_new.session)::jsonb;
				_datos := _datos || json_build_object('last_modifity_nuevo', _data_new.last_modifity)::jsonb;
				
		ELSEIF _accion = 'DELETE'
			THEN
				_datos := _datos || json_build_object('id_anterior', _data_old.id)::jsonb;
				_datos := _datos || json_build_object('identificacion_anterior', _data_old.identificacion)::jsonb;
				_datos := _datos || json_build_object('nombre_anterior', _data_old.nombre)::jsonb;
				_datos := _datos || json_build_object('apellido_anterior', _data_old.apellido)::jsonb;
				_datos := _datos || json_build_object('correo_anterior', _data_old.correo)::jsonb;
				_datos := _datos || json_build_object('username_anterior', _data_old.username)::jsonb;
				_datos := _datos || json_build_object('contraseña_anterior', _data_old.contraseña)::jsonb;
				_datos := _datos || json_build_object('telefono_anterior', _data_old.telefono)::jsonb;
				_datos := _datos || json_build_object('rol_anterior', _data_old.rol)::jsonb;
				_datos := _datos || json_build_object('estado_id_anterior', _data_old.estado_id)::jsonb;
				_datos := _datos || json_build_object('token_anterior', _data_old.token)::jsonb;
				_datos := _datos || json_build_object('vencimiento_token_anterior', _data_old.vencimiento_token)::jsonb;
				_datos := _datos || json_build_object('session_anterior', _data_old.session)::jsonb;
				_datos := _datos || json_build_object('last_modifity_anterior', _data_old.last_modifity)::jsonb;
				
		ELSE
			IF _data_old.id <> _data_new.id
				THEN _datos := _datos || json_build_object('id_anterior', _data_old.id, 'id_nuevo', _data_new.id)::jsonb;
			END IF;
			IF _data_old.identificacion <> _data_new.identificacion
				THEN _datos := _datos || json_build_object('identificacion_anterior', _data_old.identificacion, 'identificacion_nuevo', _data_new.identificacion)::jsonb;
			END IF;
			IF _data_old.nombre <> _data_new.nombre
				THEN _datos := _datos || json_build_object('nombre_anterior', _data_old.nombre, 'nombre_nuevo', _data_new.nombre)::jsonb;
			END IF;
			IF _data_old.apellido <> _data_new.apellido
				THEN _datos := _datos || json_build_object('apellido_anterior', _data_old.apellido, 'apellido_nuevo', _data_new.apellido)::jsonb;
			END IF;
			IF _data_old.correo <> _data_new.correo
				THEN _datos := _datos || json_build_object('correo_anterior', _data_old.correo, 'correo_nuevo', _data_new.correo)::jsonb;
			END IF;
			IF _data_old.username <> _data_new.username
				THEN _datos := _datos || json_build_object('username_anterior', _data_old.username, 'username_nuevo', _data_new.username)::jsonb;
			END IF;
			IF _data_old.contraseña <> _data_new.contraseña
				THEN _datos := _datos || json_build_object('contraseña_anterior', _data_old.contraseña, 'contraseña_nuevo', _data_new.contraseña)::jsonb;
			END IF;
			IF _data_old.telefono <> _data_new.telefono
				THEN _datos := _datos || json_build_object('telefono_anterior', _data_old.telefono, 'telefono_nuevo', _data_new.telefono)::jsonb;
			END IF;
			IF _data_old.rol <> _data_new.rol
				THEN _datos := _datos || json_build_object('rol_anterior', _data_old.rol, 'rol_nuevo', _data_new.rol)::jsonb;
			END IF;
			IF _data_old.estado_id <> _data_new.estado_id
				THEN _datos := _datos || json_build_object('estado_id_anterior', _data_old.estado_id, 'estado_id_nuevo', _data_new.estado_id)::jsonb;
			END IF;
			IF _data_old.token <> _data_new.token
				THEN _datos := _datos || json_build_object('token_anterior', _data_old.token, 'token_nuevo', _data_new.token)::jsonb;
			END IF;
			IF _data_old.vencimiento_token <> _data_new.vencimiento_token
				THEN _datos := _datos || json_build_object('vencimiento_token_anterior', _data_old.vencimiento_token, 'vencimiento_token_nuevo', _data_new.vencimiento_token)::jsonb;
			END IF;
			IF _data_old.session <> _data_new.session
				THEN _datos := _datos || json_build_object('session_anterior', _data_old.session, 'session_nuevo', _data_new.session)::jsonb;
			END IF;
			IF _data_old.last_modifity <> _data_new.last_modifity
				THEN _datos := _datos || json_build_object('last_modifity_anterior', _data_old.last_modifity, 'last_modifity_nuevo', _data_new.last_modifity)::jsonb;
			END IF;
			 
		END IF;

		INSERT INTO security.auditoria
		(
			fecha,
			accion,
			schema,
			tabla,
			pk,
			session,
			user_bd,
			data
		)
		VALUES
		(
			CURRENT_TIMESTAMP,
			_accion,
			'restaurante',
			'registro_usuario',
			_table_pk,
			_session,
			_user_db,
			_datos::jsonb
			);

		RETURN NULL; 
	END;$$;
 �   DROP FUNCTION security.field_audit(_data_new restaurante.registro_usuario, _data_old restaurante.registro_usuario, _accion character varying, _session text, _user_db character varying, _table_pk text, _init text);
       security       postgres    false    6    204    204            �            1259    25252    carrito    TABLE     �   CREATE TABLE restaurante.carrito (
    id integer NOT NULL,
    usuario_id integer,
    producto_id integer,
    cantidad integer,
    fecha timestamp with time zone,
    precio integer
);
     DROP TABLE restaurante.carrito;
       restaurante         postgres    false    8            �            1259    25387    carrito_empleado    TABLE     �   CREATE TABLE restaurante.carrito_empleado (
    id bigint NOT NULL,
    id_mesero bigint,
    producto_id bigint,
    cantidad bigint,
    fecha timestamp with time zone,
    precio bigint
);
 )   DROP TABLE restaurante.carrito_empleado;
       restaurante         postgres    false    8            �            1259    25385    carrito_empleado_id_seq    SEQUENCE     �   CREATE SEQUENCE restaurante.carrito_empleado_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 3   DROP SEQUENCE restaurante.carrito_empleado_id_seq;
       restaurante       postgres    false    8    228                       0    0    carrito_empleado_id_seq    SEQUENCE OWNED BY     ]   ALTER SEQUENCE restaurante.carrito_empleado_id_seq OWNED BY restaurante.carrito_empleado.id;
            restaurante       postgres    false    227            �            1259    25250    carrito_id_seq    SEQUENCE     �   CREATE SEQUENCE restaurante.carrito_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE restaurante.carrito_id_seq;
       restaurante       postgres    false    8    213            	           0    0    carrito_id_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE restaurante.carrito_id_seq OWNED BY restaurante.carrito.id;
            restaurante       postgres    false    212            �            1259    25375    detalle_pedido    TABLE     �   CREATE TABLE restaurante.detalle_pedido (
    id bigint NOT NULL,
    id_pedido integer,
    cantidad integer,
    total bigint,
    fecha timestamp with time zone,
    id_usuario integer,
    detalle json,
    id_pago integer
);
 '   DROP TABLE restaurante.detalle_pedido;
       restaurante         postgres    false    8            �            1259    25373    detalle_pedido_id_seq    SEQUENCE     �   CREATE SEQUENCE restaurante.detalle_pedido_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 1   DROP SEQUENCE restaurante.detalle_pedido_id_seq;
       restaurante       postgres    false    8    226            
           0    0    detalle_pedido_id_seq    SEQUENCE OWNED BY     Y   ALTER SEQUENCE restaurante.detalle_pedido_id_seq OWNED BY restaurante.detalle_pedido.id;
            restaurante       postgres    false    225            �            1259    25454    detalle_pedido_mesero    TABLE     �   CREATE TABLE restaurante.detalle_pedido_mesero (
    id bigint NOT NULL,
    id_pedido bigint,
    cantidad bigint,
    total bigint,
    fecha timestamp with time zone,
    id_mesero bigint,
    "detalleP" json,
    id_pago integer
);
 .   DROP TABLE restaurante.detalle_pedido_mesero;
       restaurante         postgres    false    8            �            1259    25452    detalle_pedido_mesero_id_seq    SEQUENCE     �   CREATE SEQUENCE restaurante.detalle_pedido_mesero_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 8   DROP SEQUENCE restaurante.detalle_pedido_mesero_id_seq;
       restaurante       postgres    false    234    8                       0    0    detalle_pedido_mesero_id_seq    SEQUENCE OWNED BY     g   ALTER SEQUENCE restaurante.detalle_pedido_mesero_id_seq OWNED BY restaurante.detalle_pedido_mesero.id;
            restaurante       postgres    false    233            �            1259    25363 
   domiciliou    TABLE     �   CREATE TABLE restaurante.domiciliou (
    id bigint NOT NULL,
    id_usuario bigint NOT NULL,
    direccion text,
    pais text,
    ciudad text,
    codigop integer
);
 #   DROP TABLE restaurante.domiciliou;
       restaurante         postgres    false    8            �            1259    25359    domiciliou_id_seq    SEQUENCE        CREATE SEQUENCE restaurante.domiciliou_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE restaurante.domiciliou_id_seq;
       restaurante       postgres    false    8    224                       0    0    domiciliou_id_seq    SEQUENCE OWNED BY     Q   ALTER SEQUENCE restaurante.domiciliou_id_seq OWNED BY restaurante.domiciliou.id;
            restaurante       postgres    false    222            �            1259    25361    domiciliou_id_usuario_seq    SEQUENCE     �   CREATE SEQUENCE restaurante.domiciliou_id_usuario_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 5   DROP SEQUENCE restaurante.domiciliou_id_usuario_seq;
       restaurante       postgres    false    8    224                       0    0    domiciliou_id_usuario_seq    SEQUENCE OWNED BY     a   ALTER SEQUENCE restaurante.domiciliou_id_usuario_seq OWNED BY restaurante.domiciliou.id_usuario;
            restaurante       postgres    false    223            �            1259    25260    estado_registro    TABLE     e   CREATE TABLE restaurante.estado_registro (
    id integer NOT NULL,
    descripcion text NOT NULL
);
 (   DROP TABLE restaurante.estado_registro;
       restaurante         postgres    false    8            �            1259    25258    estado_registro_id_seq    SEQUENCE     �   CREATE SEQUENCE restaurante.estado_registro_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 2   DROP SEQUENCE restaurante.estado_registro_id_seq;
       restaurante       postgres    false    8    215                       0    0    estado_registro_id_seq    SEQUENCE OWNED BY     [   ALTER SEQUENCE restaurante.estado_registro_id_seq OWNED BY restaurante.estado_registro.id;
            restaurante       postgres    false    214            �            1259    25396    mesas    TABLE     V   CREATE TABLE restaurante.mesas (
    id bigint NOT NULL,
    descripcion_mesa text
);
    DROP TABLE restaurante.mesas;
       restaurante         postgres    false    8            �            1259    25394    mesas_id_seq    SEQUENCE     z   CREATE SEQUENCE restaurante.mesas_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE restaurante.mesas_id_seq;
       restaurante       postgres    false    230    8                       0    0    mesas_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE restaurante.mesas_id_seq OWNED BY restaurante.mesas.id;
            restaurante       postgres    false    229            �            1259    25294    metodo_pago    TABLE     X   CREATE TABLE restaurante.metodo_pago (
    id integer NOT NULL,
    descripcion text
);
 $   DROP TABLE restaurante.metodo_pago;
       restaurante         postgres    false    8            �            1259    25292    metodo_pago_id_seq    SEQUENCE     �   CREATE SEQUENCE restaurante.metodo_pago_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE restaurante.metodo_pago_id_seq;
       restaurante       postgres    false    217    8                       0    0    metodo_pago_id_seq    SEQUENCE OWNED BY     S   ALTER SEQUENCE restaurante.metodo_pago_id_seq OWNED BY restaurante.metodo_pago.id;
            restaurante       postgres    false    216            �            1259    25348    pedido    TABLE     �   CREATE TABLE restaurante.pedido (
    id bigint NOT NULL,
    id_usuario integer,
    id_pago integer,
    id_domicilio integer,
    total bigint,
    fecha timestamp with time zone
);
    DROP TABLE restaurante.pedido;
       restaurante         postgres    false    8            �            1259    25351    pedido_id_seq    SEQUENCE     {   CREATE SEQUENCE restaurante.pedido_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE restaurante.pedido_id_seq;
       restaurante       postgres    false    220    8                       0    0    pedido_id_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE restaurante.pedido_id_seq OWNED BY restaurante.pedido.id;
            restaurante       postgres    false    221            �            1259    25407    pedido_mesero    TABLE     �   CREATE TABLE restaurante.pedido_mesero (
    id bigint NOT NULL,
    id_mesero integer,
    id_mesa integer,
    total bigint,
    fecha timestamp with time zone,
    detalle json,
    id_pago integer,
    cantidad integer
);
 &   DROP TABLE restaurante.pedido_mesero;
       restaurante         postgres    false    8            �            1259    25405    pedido_mesero_id_seq    SEQUENCE     �   CREATE SEQUENCE restaurante.pedido_mesero_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 0   DROP SEQUENCE restaurante.pedido_mesero_id_seq;
       restaurante       postgres    false    8    232                       0    0    pedido_mesero_id_seq    SEQUENCE OWNED BY     W   ALTER SEQUENCE restaurante.pedido_mesero_id_seq OWNED BY restaurante.pedido_mesero.id;
            restaurante       postgres    false    231            �            1259    25144    producto_id_seq    SEQUENCE     �   CREATE SEQUENCE restaurante.producto_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE restaurante.producto_id_seq;
       restaurante       postgres    false    198    8                       0    0    producto_id_seq    SEQUENCE OWNED BY     M   ALTER SEQUENCE restaurante.producto_id_seq OWNED BY restaurante.producto.id;
            restaurante       postgres    false    199            �            1259    25146    registro_administrador    TABLE       CREATE TABLE restaurante.registro_administrador (
    id integer NOT NULL,
    nombre text,
    apellido text,
    correo text,
    username text,
    clave text,
    identificacion bigint,
    id_rol integer,
    session text,
    last_modifity timestamp with time zone
);
 /   DROP TABLE restaurante.registro_administrador;
       restaurante         postgres    false    8            �            1259    25152    registro_administrador_id_seq    SEQUENCE     �   CREATE SEQUENCE restaurante.registro_administrador_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 9   DROP SEQUENCE restaurante.registro_administrador_id_seq;
       restaurante       postgres    false    200    8                       0    0    registro_administrador_id_seq    SEQUENCE OWNED BY     i   ALTER SEQUENCE restaurante.registro_administrador_id_seq OWNED BY restaurante.registro_administrador.id;
            restaurante       postgres    false    201            �            1259    25154    registro_empleado    TABLE     ,  CREATE TABLE restaurante.registro_empleado (
    id bigint NOT NULL,
    nombre text,
    apellido text,
    telefono bigint,
    id_rol integer,
    id_codigo bigint,
    username text,
    clave text,
    estado_id integer DEFAULT 1,
    session text,
    last_modifity timestamp with time zone
);
 *   DROP TABLE restaurante.registro_empleado;
       restaurante         postgres    false    8            �            1259    25160    registro_empleado_id_seq    SEQUENCE     �   CREATE SEQUENCE restaurante.registro_empleado_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 4   DROP SEQUENCE restaurante.registro_empleado_id_seq;
       restaurante       postgres    false    8    202                       0    0    registro_empleado_id_seq    SEQUENCE OWNED BY     _   ALTER SEQUENCE restaurante.registro_empleado_id_seq OWNED BY restaurante.registro_empleado.id;
            restaurante       postgres    false    203            �            1259    25169    registro_usuario_id_seq    SEQUENCE     �   CREATE SEQUENCE restaurante.registro_usuario_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 3   DROP SEQUENCE restaurante.registro_usuario_id_seq;
       restaurante       postgres    false    204    8                       0    0    registro_usuario_id_seq    SEQUENCE OWNED BY     ]   ALTER SEQUENCE restaurante.registro_usuario_id_seq OWNED BY restaurante.registro_usuario.id;
            restaurante       postgres    false    205            �            1259    25337    reporte_monetario    TABLE     �   CREATE TABLE restaurante.reporte_monetario (
    id bigint NOT NULL,
    id_persona bigint,
    total bigint,
    fecha timestamp with time zone
);
 *   DROP TABLE restaurante.reporte_monetario;
       restaurante         postgres    false    8            �            1259    25340    reporte_monetario_id_seq    SEQUENCE     �   CREATE SEQUENCE restaurante.reporte_monetario_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 4   DROP SEQUENCE restaurante.reporte_monetario_id_seq;
       restaurante       postgres    false    218    8                       0    0    reporte_monetario_id_seq    SEQUENCE OWNED BY     _   ALTER SEQUENCE restaurante.reporte_monetario_id_seq OWNED BY restaurante.reporte_monetario.id;
            restaurante       postgres    false    219            �            1259    25495    reporte_monetario_m    TABLE     �   CREATE TABLE restaurante.reporte_monetario_m (
    id bigint NOT NULL,
    id_mesero integer,
    total bigint,
    fecha timestamp with time zone
);
 ,   DROP TABLE restaurante.reporte_monetario_m;
       restaurante         postgres    false    8            �            1259    25493    reporte_monetario_m_id_seq    SEQUENCE     �   CREATE SEQUENCE restaurante.reporte_monetario_m_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 6   DROP SEQUENCE restaurante.reporte_monetario_m_id_seq;
       restaurante       postgres    false    239    8                       0    0    reporte_monetario_m_id_seq    SEQUENCE OWNED BY     c   ALTER SEQUENCE restaurante.reporte_monetario_m_id_seq OWNED BY restaurante.reporte_monetario_m.id;
            restaurante       postgres    false    238            �            1259    25171    rol_categoria    TABLE     W   CREATE TABLE restaurante.rol_categoria (
    id bigint NOT NULL,
    categoria text
);
 &   DROP TABLE restaurante.rol_categoria;
       restaurante         postgres    false    8            �            1259    25177    rol_categoria_id_seq    SEQUENCE     �   CREATE SEQUENCE restaurante.rol_categoria_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 0   DROP SEQUENCE restaurante.rol_categoria_id_seq;
       restaurante       postgres    false    8    206                       0    0    rol_categoria_id_seq    SEQUENCE OWNED BY     W   ALTER SEQUENCE restaurante.rol_categoria_id_seq OWNED BY restaurante.rol_categoria.id;
            restaurante       postgres    false    207            �            1259    25179 	   rol_login    TABLE     b   CREATE TABLE restaurante.rol_login (
    "Id_Rol" integer NOT NULL,
    "Descripcion_Rol" text
);
 "   DROP TABLE restaurante.rol_login;
       restaurante         postgres    false    8            �            1259    25185    rol_login_Id_Rol_seq    SEQUENCE     �   CREATE SEQUENCE restaurante."rol_login_Id_Rol_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 2   DROP SEQUENCE restaurante."rol_login_Id_Rol_seq";
       restaurante       postgres    false    208    8                       0    0    rol_login_Id_Rol_seq    SEQUENCE OWNED BY     [   ALTER SEQUENCE restaurante."rol_login_Id_Rol_seq" OWNED BY restaurante.rol_login."Id_Rol";
            restaurante       postgres    false    209            �            1259    25187    sub_rol_categoria    TABLE     t   CREATE TABLE restaurante.sub_rol_categoria (
    id bigint NOT NULL,
    subcategoria text,
    categoria bigint
);
 *   DROP TABLE restaurante.sub_rol_categoria;
       restaurante         postgres    false    8            �            1259    25193    sub_rol_categoria_id_seq    SEQUENCE     �   CREATE SEQUENCE restaurante.sub_rol_categoria_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 4   DROP SEQUENCE restaurante.sub_rol_categoria_id_seq;
       restaurante       postgres    false    210    8                       0    0    sub_rol_categoria_id_seq    SEQUENCE OWNED BY     _   ALTER SEQUENCE restaurante.sub_rol_categoria_id_seq OWNED BY restaurante.sub_rol_categoria.id;
            restaurante       postgres    false    211            �            1259    25467 	   auditoria    TABLE     
  CREATE TABLE security.auditoria (
    schema character varying,
    tabla character varying,
    session text,
    fecha timestamp without time zone,
    accion character varying,
    user_bd character varying,
    data jsonb,
    pk text,
    id bigint NOT NULL
);
    DROP TABLE security.auditoria;
       security         postgres    false    6            �            1259    25473    auditoria_id_seq    SEQUENCE     {   CREATE SEQUENCE security.auditoria_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE security.auditoria_id_seq;
       security       postgres    false    6    235                       0    0    auditoria_id_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE security.auditoria_id_seq OWNED BY security.auditoria.id;
            security       postgres    false    236            �            1259    25486    function_db_view    VIEW     �  CREATE VIEW security.function_db_view AS
 SELECT pp.proname AS b_function,
    oidvectortypes(pp.proargtypes) AS b_type_parameters
   FROM (pg_proc pp
     JOIN pg_namespace pn ON ((pn.oid = pp.pronamespace)))
  WHERE ((pn.nspname)::text <> ALL (ARRAY[('pg_catalog'::character varying)::text, ('information_schema'::character varying)::text, ('admin_control'::character varying)::text, ('vial'::character varying)::text]));
 %   DROP VIEW security.function_db_view;
       security       postgres    false    6                       2604    25255 
   carrito id    DEFAULT     r   ALTER TABLE ONLY restaurante.carrito ALTER COLUMN id SET DEFAULT nextval('restaurante.carrito_id_seq'::regclass);
 >   ALTER TABLE restaurante.carrito ALTER COLUMN id DROP DEFAULT;
       restaurante       postgres    false    212    213    213                       2604    25390    carrito_empleado id    DEFAULT     �   ALTER TABLE ONLY restaurante.carrito_empleado ALTER COLUMN id SET DEFAULT nextval('restaurante.carrito_empleado_id_seq'::regclass);
 G   ALTER TABLE restaurante.carrito_empleado ALTER COLUMN id DROP DEFAULT;
       restaurante       postgres    false    228    227    228                       2604    25378    detalle_pedido id    DEFAULT     �   ALTER TABLE ONLY restaurante.detalle_pedido ALTER COLUMN id SET DEFAULT nextval('restaurante.detalle_pedido_id_seq'::regclass);
 E   ALTER TABLE restaurante.detalle_pedido ALTER COLUMN id DROP DEFAULT;
       restaurante       postgres    false    226    225    226                       2604    25457    detalle_pedido_mesero id    DEFAULT     �   ALTER TABLE ONLY restaurante.detalle_pedido_mesero ALTER COLUMN id SET DEFAULT nextval('restaurante.detalle_pedido_mesero_id_seq'::regclass);
 L   ALTER TABLE restaurante.detalle_pedido_mesero ALTER COLUMN id DROP DEFAULT;
       restaurante       postgres    false    234    233    234                       2604    25366    domiciliou id    DEFAULT     x   ALTER TABLE ONLY restaurante.domiciliou ALTER COLUMN id SET DEFAULT nextval('restaurante.domiciliou_id_seq'::regclass);
 A   ALTER TABLE restaurante.domiciliou ALTER COLUMN id DROP DEFAULT;
       restaurante       postgres    false    224    222    224                       2604    25367    domiciliou id_usuario    DEFAULT     �   ALTER TABLE ONLY restaurante.domiciliou ALTER COLUMN id_usuario SET DEFAULT nextval('restaurante.domiciliou_id_usuario_seq'::regclass);
 I   ALTER TABLE restaurante.domiciliou ALTER COLUMN id_usuario DROP DEFAULT;
       restaurante       postgres    false    223    224    224                       2604    25263    estado_registro id    DEFAULT     �   ALTER TABLE ONLY restaurante.estado_registro ALTER COLUMN id SET DEFAULT nextval('restaurante.estado_registro_id_seq'::regclass);
 F   ALTER TABLE restaurante.estado_registro ALTER COLUMN id DROP DEFAULT;
       restaurante       postgres    false    214    215    215                       2604    25399    mesas id    DEFAULT     n   ALTER TABLE ONLY restaurante.mesas ALTER COLUMN id SET DEFAULT nextval('restaurante.mesas_id_seq'::regclass);
 <   ALTER TABLE restaurante.mesas ALTER COLUMN id DROP DEFAULT;
       restaurante       postgres    false    230    229    230                       2604    25297    metodo_pago id    DEFAULT     z   ALTER TABLE ONLY restaurante.metodo_pago ALTER COLUMN id SET DEFAULT nextval('restaurante.metodo_pago_id_seq'::regclass);
 B   ALTER TABLE restaurante.metodo_pago ALTER COLUMN id DROP DEFAULT;
       restaurante       postgres    false    217    216    217                       2604    25353 	   pedido id    DEFAULT     p   ALTER TABLE ONLY restaurante.pedido ALTER COLUMN id SET DEFAULT nextval('restaurante.pedido_id_seq'::regclass);
 =   ALTER TABLE restaurante.pedido ALTER COLUMN id DROP DEFAULT;
       restaurante       postgres    false    221    220                       2604    25410    pedido_mesero id    DEFAULT     ~   ALTER TABLE ONLY restaurante.pedido_mesero ALTER COLUMN id SET DEFAULT nextval('restaurante.pedido_mesero_id_seq'::regclass);
 D   ALTER TABLE restaurante.pedido_mesero ALTER COLUMN id DROP DEFAULT;
       restaurante       postgres    false    232    231    232            	           2604    25195    producto id    DEFAULT     t   ALTER TABLE ONLY restaurante.producto ALTER COLUMN id SET DEFAULT nextval('restaurante.producto_id_seq'::regclass);
 ?   ALTER TABLE restaurante.producto ALTER COLUMN id DROP DEFAULT;
       restaurante       postgres    false    199    198            
           2604    25196    registro_administrador id    DEFAULT     �   ALTER TABLE ONLY restaurante.registro_administrador ALTER COLUMN id SET DEFAULT nextval('restaurante.registro_administrador_id_seq'::regclass);
 M   ALTER TABLE restaurante.registro_administrador ALTER COLUMN id DROP DEFAULT;
       restaurante       postgres    false    201    200                       2604    25197    registro_empleado id    DEFAULT     �   ALTER TABLE ONLY restaurante.registro_empleado ALTER COLUMN id SET DEFAULT nextval('restaurante.registro_empleado_id_seq'::regclass);
 H   ALTER TABLE restaurante.registro_empleado ALTER COLUMN id DROP DEFAULT;
       restaurante       postgres    false    203    202                       2604    25198    registro_usuario id    DEFAULT     �   ALTER TABLE ONLY restaurante.registro_usuario ALTER COLUMN id SET DEFAULT nextval('restaurante.registro_usuario_id_seq'::regclass);
 G   ALTER TABLE restaurante.registro_usuario ALTER COLUMN id DROP DEFAULT;
       restaurante       postgres    false    205    204                       2604    25342    reporte_monetario id    DEFAULT     �   ALTER TABLE ONLY restaurante.reporte_monetario ALTER COLUMN id SET DEFAULT nextval('restaurante.reporte_monetario_id_seq'::regclass);
 H   ALTER TABLE restaurante.reporte_monetario ALTER COLUMN id DROP DEFAULT;
       restaurante       postgres    false    219    218                       2604    25498    reporte_monetario_m id    DEFAULT     �   ALTER TABLE ONLY restaurante.reporte_monetario_m ALTER COLUMN id SET DEFAULT nextval('restaurante.reporte_monetario_m_id_seq'::regclass);
 J   ALTER TABLE restaurante.reporte_monetario_m ALTER COLUMN id DROP DEFAULT;
       restaurante       postgres    false    238    239    239                       2604    25199    rol_categoria id    DEFAULT     ~   ALTER TABLE ONLY restaurante.rol_categoria ALTER COLUMN id SET DEFAULT nextval('restaurante.rol_categoria_id_seq'::regclass);
 D   ALTER TABLE restaurante.rol_categoria ALTER COLUMN id DROP DEFAULT;
       restaurante       postgres    false    207    206                       2604    25200    rol_login Id_Rol    DEFAULT     �   ALTER TABLE ONLY restaurante.rol_login ALTER COLUMN "Id_Rol" SET DEFAULT nextval('restaurante."rol_login_Id_Rol_seq"'::regclass);
 F   ALTER TABLE restaurante.rol_login ALTER COLUMN "Id_Rol" DROP DEFAULT;
       restaurante       postgres    false    209    208                       2604    25201    sub_rol_categoria id    DEFAULT     �   ALTER TABLE ONLY restaurante.sub_rol_categoria ALTER COLUMN id SET DEFAULT nextval('restaurante.sub_rol_categoria_id_seq'::regclass);
 H   ALTER TABLE restaurante.sub_rol_categoria ALTER COLUMN id DROP DEFAULT;
       restaurante       postgres    false    211    210                       2604    25475    auditoria id    DEFAULT     p   ALTER TABLE ONLY security.auditoria ALTER COLUMN id SET DEFAULT nextval('security.auditoria_id_seq'::regclass);
 =   ALTER TABLE security.auditoria ALTER COLUMN id DROP DEFAULT;
       security       postgres    false    236    235            �          0    25252    carrito 
   TABLE DATA               \   COPY restaurante.carrito (id, usuario_id, producto_id, cantidad, fecha, precio) FROM stdin;
    restaurante       postgres    false    213          �          0    25387    carrito_empleado 
   TABLE DATA               d   COPY restaurante.carrito_empleado (id, id_mesero, producto_id, cantidad, fecha, precio) FROM stdin;
    restaurante       postgres    false    228   #       �          0    25375    detalle_pedido 
   TABLE DATA               r   COPY restaurante.detalle_pedido (id, id_pedido, cantidad, total, fecha, id_usuario, detalle, id_pago) FROM stdin;
    restaurante       postgres    false    226   @       �          0    25454    detalle_pedido_mesero 
   TABLE DATA               {   COPY restaurante.detalle_pedido_mesero (id, id_pedido, cantidad, total, fecha, id_mesero, "detalleP", id_pago) FROM stdin;
    restaurante       postgres    false    234   �&      �          0    25363 
   domiciliou 
   TABLE DATA               [   COPY restaurante.domiciliou (id, id_usuario, direccion, pais, ciudad, codigop) FROM stdin;
    restaurante       postgres    false    224    (      �          0    25260    estado_registro 
   TABLE DATA               ?   COPY restaurante.estado_registro (id, descripcion) FROM stdin;
    restaurante       postgres    false    215   �(      �          0    25396    mesas 
   TABLE DATA               :   COPY restaurante.mesas (id, descripcion_mesa) FROM stdin;
    restaurante       postgres    false    230   )      �          0    25294    metodo_pago 
   TABLE DATA               ;   COPY restaurante.metodo_pago (id, descripcion) FROM stdin;
    restaurante       postgres    false    217   {)      �          0    25348    pedido 
   TABLE DATA               Z   COPY restaurante.pedido (id, id_usuario, id_pago, id_domicilio, total, fecha) FROM stdin;
    restaurante       postgres    false    220   �)      �          0    25407    pedido_mesero 
   TABLE DATA               n   COPY restaurante.pedido_mesero (id, id_mesero, id_mesa, total, fecha, detalle, id_pago, cantidad) FROM stdin;
    restaurante       postgres    false    232   �)      �          0    25138    producto 
   TABLE DATA               �   COPY restaurante.producto (id, nombre, categoria, subcategoria, precio, descripcion, imagen, cantidad, session, last_modifity) FROM stdin;
    restaurante       postgres    false    198   �)      �          0    25146    registro_administrador 
   TABLE DATA               �   COPY restaurante.registro_administrador (id, nombre, apellido, correo, username, clave, identificacion, id_rol, session, last_modifity) FROM stdin;
    restaurante       postgres    false    200   9+      �          0    25154    registro_empleado 
   TABLE DATA               �   COPY restaurante.registro_empleado (id, nombre, apellido, telefono, id_rol, id_codigo, username, clave, estado_id, session, last_modifity) FROM stdin;
    restaurante       postgres    false    202   �+      �          0    25162    registro_usuario 
   TABLE DATA               �   COPY restaurante.registro_usuario (id, identificacion, nombre, apellido, correo, username, "contraseña", telefono, rol, estado_id, token, vencimiento_token, session, last_modifity) FROM stdin;
    restaurante       postgres    false    204   Y,      �          0    25337    reporte_monetario 
   TABLE DATA               N   COPY restaurante.reporte_monetario (id, id_persona, total, fecha) FROM stdin;
    restaurante       postgres    false    218   �-                0    25495    reporte_monetario_m 
   TABLE DATA               O   COPY restaurante.reporte_monetario_m (id, id_mesero, total, fecha) FROM stdin;
    restaurante       postgres    false    239   /      �          0    25171    rol_categoria 
   TABLE DATA               ;   COPY restaurante.rol_categoria (id, categoria) FROM stdin;
    restaurante       postgres    false    206   ^1      �          0    25179 	   rol_login 
   TABLE DATA               E   COPY restaurante.rol_login ("Id_Rol", "Descripcion_Rol") FROM stdin;
    restaurante       postgres    false    208   �1      �          0    25187    sub_rol_categoria 
   TABLE DATA               M   COPY restaurante.sub_rol_categoria (id, subcategoria, categoria) FROM stdin;
    restaurante       postgres    false    210   �1      �          0    25467 	   auditoria 
   TABLE DATA               c   COPY security.auditoria (schema, tabla, session, fecha, accion, user_bd, data, pk, id) FROM stdin;
    security       postgres    false    235   42                 0    0    carrito_empleado_id_seq    SEQUENCE SET     L   SELECT pg_catalog.setval('restaurante.carrito_empleado_id_seq', 106, true);
            restaurante       postgres    false    227                       0    0    carrito_id_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('restaurante.carrito_id_seq', 243, true);
            restaurante       postgres    false    212                       0    0    detalle_pedido_id_seq    SEQUENCE SET     I   SELECT pg_catalog.setval('restaurante.detalle_pedido_id_seq', 83, true);
            restaurante       postgres    false    225                        0    0    detalle_pedido_mesero_id_seq    SEQUENCE SET     P   SELECT pg_catalog.setval('restaurante.detalle_pedido_mesero_id_seq', 77, true);
            restaurante       postgres    false    233            !           0    0    domiciliou_id_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('restaurante.domiciliou_id_seq', 13, true);
            restaurante       postgres    false    222            "           0    0    domiciliou_id_usuario_seq    SEQUENCE SET     M   SELECT pg_catalog.setval('restaurante.domiciliou_id_usuario_seq', 1, false);
            restaurante       postgres    false    223            #           0    0    estado_registro_id_seq    SEQUENCE SET     J   SELECT pg_catalog.setval('restaurante.estado_registro_id_seq', 1, false);
            restaurante       postgres    false    214            $           0    0    mesas_id_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('restaurante.mesas_id_seq', 1, true);
            restaurante       postgres    false    229            %           0    0    metodo_pago_id_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('restaurante.metodo_pago_id_seq', 1, false);
            restaurante       postgres    false    216            &           0    0    pedido_id_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('restaurante.pedido_id_seq', 118, true);
            restaurante       postgres    false    221            '           0    0    pedido_mesero_id_seq    SEQUENCE SET     H   SELECT pg_catalog.setval('restaurante.pedido_mesero_id_seq', 88, true);
            restaurante       postgres    false    231            (           0    0    producto_id_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('restaurante.producto_id_seq', 24, true);
            restaurante       postgres    false    199            )           0    0    registro_administrador_id_seq    SEQUENCE SET     P   SELECT pg_catalog.setval('restaurante.registro_administrador_id_seq', 3, true);
            restaurante       postgres    false    201            *           0    0    registro_empleado_id_seq    SEQUENCE SET     K   SELECT pg_catalog.setval('restaurante.registro_empleado_id_seq', 7, true);
            restaurante       postgres    false    203            +           0    0    registro_usuario_id_seq    SEQUENCE SET     K   SELECT pg_catalog.setval('restaurante.registro_usuario_id_seq', 23, true);
            restaurante       postgres    false    205            ,           0    0    reporte_monetario_id_seq    SEQUENCE SET     L   SELECT pg_catalog.setval('restaurante.reporte_monetario_id_seq', 22, true);
            restaurante       postgres    false    219            -           0    0    reporte_monetario_m_id_seq    SEQUENCE SET     N   SELECT pg_catalog.setval('restaurante.reporte_monetario_m_id_seq', 45, true);
            restaurante       postgres    false    238            .           0    0    rol_categoria_id_seq    SEQUENCE SET     H   SELECT pg_catalog.setval('restaurante.rol_categoria_id_seq', 10, true);
            restaurante       postgres    false    207            /           0    0    rol_login_Id_Rol_seq    SEQUENCE SET     J   SELECT pg_catalog.setval('restaurante."rol_login_Id_Rol_seq"', 1, false);
            restaurante       postgres    false    209            0           0    0    sub_rol_categoria_id_seq    SEQUENCE SET     K   SELECT pg_catalog.setval('restaurante.sub_rol_categoria_id_seq', 9, true);
            restaurante       postgres    false    211            1           0    0    auditoria_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('security.auditoria_id_seq', 24, true);
            security       postgres    false    236            D           2606    25392 &   carrito_empleado carrito_empleado_pkey 
   CONSTRAINT     i   ALTER TABLE ONLY restaurante.carrito_empleado
    ADD CONSTRAINT carrito_empleado_pkey PRIMARY KEY (id);
 U   ALTER TABLE ONLY restaurante.carrito_empleado DROP CONSTRAINT carrito_empleado_pkey;
       restaurante         postgres    false    228            J           2606    25459 0   detalle_pedido_mesero detalle_pedido_mesero_pkey 
   CONSTRAINT     s   ALTER TABLE ONLY restaurante.detalle_pedido_mesero
    ADD CONSTRAINT detalle_pedido_mesero_pkey PRIMARY KEY (id);
 _   ALTER TABLE ONLY restaurante.detalle_pedido_mesero DROP CONSTRAINT detalle_pedido_mesero_pkey;
       restaurante         postgres    false    234            B           2606    25380 "   detalle_pedido detalle_pedido_pkey 
   CONSTRAINT     e   ALTER TABLE ONLY restaurante.detalle_pedido
    ADD CONSTRAINT detalle_pedido_pkey PRIMARY KEY (id);
 Q   ALTER TABLE ONLY restaurante.detalle_pedido DROP CONSTRAINT detalle_pedido_pkey;
       restaurante         postgres    false    226            @           2606    25372    domiciliou domiciliou_pkey 
   CONSTRAINT     ]   ALTER TABLE ONLY restaurante.domiciliou
    ADD CONSTRAINT domiciliou_pkey PRIMARY KEY (id);
 I   ALTER TABLE ONLY restaurante.domiciliou DROP CONSTRAINT domiciliou_pkey;
       restaurante         postgres    false    224            6           2606    25268 $   estado_registro estado_registro_pkey 
   CONSTRAINT     g   ALTER TABLE ONLY restaurante.estado_registro
    ADD CONSTRAINT estado_registro_pkey PRIMARY KEY (id);
 S   ALTER TABLE ONLY restaurante.estado_registro DROP CONSTRAINT estado_registro_pkey;
       restaurante         postgres    false    215            F           2606    25404    mesas mesas_pkey 
   CONSTRAINT     S   ALTER TABLE ONLY restaurante.mesas
    ADD CONSTRAINT mesas_pkey PRIMARY KEY (id);
 ?   ALTER TABLE ONLY restaurante.mesas DROP CONSTRAINT mesas_pkey;
       restaurante         postgres    false    230            8           2606    25302    metodo_pago metodo_pago_pkey 
   CONSTRAINT     _   ALTER TABLE ONLY restaurante.metodo_pago
    ADD CONSTRAINT metodo_pago_pkey PRIMARY KEY (id);
 K   ALTER TABLE ONLY restaurante.metodo_pago DROP CONSTRAINT metodo_pago_pkey;
       restaurante         postgres    false    217            H           2606    25412     pedido_mesero pedido_mesero_pkey 
   CONSTRAINT     c   ALTER TABLE ONLY restaurante.pedido_mesero
    ADD CONSTRAINT pedido_mesero_pkey PRIMARY KEY (id);
 O   ALTER TABLE ONLY restaurante.pedido_mesero DROP CONSTRAINT pedido_mesero_pkey;
       restaurante         postgres    false    232            >           2606    25358    pedido pedido_pkey 
   CONSTRAINT     U   ALTER TABLE ONLY restaurante.pedido
    ADD CONSTRAINT pedido_pkey PRIMARY KEY (id);
 A   ALTER TABLE ONLY restaurante.pedido DROP CONSTRAINT pedido_pkey;
       restaurante         postgres    false    220            4           2606    25257    carrito pk_carrito 
   CONSTRAINT     U   ALTER TABLE ONLY restaurante.carrito
    ADD CONSTRAINT pk_carrito PRIMARY KEY (id);
 A   ALTER TABLE ONLY restaurante.carrito DROP CONSTRAINT pk_carrito;
       restaurante         postgres    false    213            #           2606    25203    producto producto_pkey 
   CONSTRAINT     Y   ALTER TABLE ONLY restaurante.producto
    ADD CONSTRAINT producto_pkey PRIMARY KEY (id);
 E   ALTER TABLE ONLY restaurante.producto DROP CONSTRAINT producto_pkey;
       restaurante         postgres    false    198            %           2606    25205 2   registro_administrador registro_administrador_pkey 
   CONSTRAINT     u   ALTER TABLE ONLY restaurante.registro_administrador
    ADD CONSTRAINT registro_administrador_pkey PRIMARY KEY (id);
 a   ALTER TABLE ONLY restaurante.registro_administrador DROP CONSTRAINT registro_administrador_pkey;
       restaurante         postgres    false    200            '           2606    25207 (   registro_empleado registro_empleado_pkey 
   CONSTRAINT     k   ALTER TABLE ONLY restaurante.registro_empleado
    ADD CONSTRAINT registro_empleado_pkey PRIMARY KEY (id);
 W   ALTER TABLE ONLY restaurante.registro_empleado DROP CONSTRAINT registro_empleado_pkey;
       restaurante         postgres    false    202            +           2606    25209 &   registro_usuario registro_usuario_pkey 
   CONSTRAINT     i   ALTER TABLE ONLY restaurante.registro_usuario
    ADD CONSTRAINT registro_usuario_pkey PRIMARY KEY (id);
 U   ALTER TABLE ONLY restaurante.registro_usuario DROP CONSTRAINT registro_usuario_pkey;
       restaurante         postgres    false    204            N           2606    25500 ,   reporte_monetario_m reporte_monetario_m_pkey 
   CONSTRAINT     o   ALTER TABLE ONLY restaurante.reporte_monetario_m
    ADD CONSTRAINT reporte_monetario_m_pkey PRIMARY KEY (id);
 [   ALTER TABLE ONLY restaurante.reporte_monetario_m DROP CONSTRAINT reporte_monetario_m_pkey;
       restaurante         postgres    false    239            :           2606    25347 (   reporte_monetario reporte_monetario_pkey 
   CONSTRAINT     k   ALTER TABLE ONLY restaurante.reporte_monetario
    ADD CONSTRAINT reporte_monetario_pkey PRIMARY KEY (id);
 W   ALTER TABLE ONLY restaurante.reporte_monetario DROP CONSTRAINT reporte_monetario_pkey;
       restaurante         postgres    false    218            -           2606    25211     rol_categoria rol_categoria_pkey 
   CONSTRAINT     c   ALTER TABLE ONLY restaurante.rol_categoria
    ADD CONSTRAINT rol_categoria_pkey PRIMARY KEY (id);
 O   ALTER TABLE ONLY restaurante.rol_categoria DROP CONSTRAINT rol_categoria_pkey;
       restaurante         postgres    false    206            /           2606    25213    rol_login rol_login_pkey 
   CONSTRAINT     a   ALTER TABLE ONLY restaurante.rol_login
    ADD CONSTRAINT rol_login_pkey PRIMARY KEY ("Id_Rol");
 G   ALTER TABLE ONLY restaurante.rol_login DROP CONSTRAINT rol_login_pkey;
       restaurante         postgres    false    208            2           2606    25215 (   sub_rol_categoria sub_rol_categoria_pkey 
   CONSTRAINT     k   ALTER TABLE ONLY restaurante.sub_rol_categoria
    ADD CONSTRAINT sub_rol_categoria_pkey PRIMARY KEY (id);
 W   ALTER TABLE ONLY restaurante.sub_rol_categoria DROP CONSTRAINT sub_rol_categoria_pkey;
       restaurante         postgres    false    210            L           2606    25483    auditoria auditoria_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY security.auditoria
    ADD CONSTRAINT auditoria_pkey PRIMARY KEY (id);
 D   ALTER TABLE ONLY security.auditoria DROP CONSTRAINT auditoria_pkey;
       security         postgres    false    235            (           1259    25274    fki_fk_estado    INDEX     T   CREATE INDEX fki_fk_estado ON restaurante.registro_usuario USING btree (estado_id);
 &   DROP INDEX restaurante.fki_fk_estado;
       restaurante         postgres    false    204            ;           1259    25440    fki_fk_id_domicilio    INDEX     S   CREATE INDEX fki_fk_id_domicilio ON restaurante.pedido USING btree (id_domicilio);
 ,   DROP INDEX restaurante.fki_fk_id_domicilio;
       restaurante         postgres    false    220            <           1259    25429    fki_fk_id_usuario    INDEX     O   CREATE INDEX fki_fk_id_usuario ON restaurante.pedido USING btree (id_usuario);
 *   DROP INDEX restaurante.fki_fk_id_usuario;
       restaurante         postgres    false    220            )           1259    25216 
   fki_fk_rol    INDEX     K   CREATE INDEX fki_fk_rol ON restaurante.registro_usuario USING btree (rol);
 #   DROP INDEX restaurante.fki_fk_rol;
       restaurante         postgres    false    204                        1259    25217    fki_fk_rolProducto    INDEX     S   CREATE INDEX "fki_fk_rolProducto" ON restaurante.producto USING btree (categoria);
 -   DROP INDEX restaurante."fki_fk_rolProducto";
       restaurante         postgres    false    198            !           1259    25218    fki_fk_subRProducto    INDEX     W   CREATE INDEX "fki_fk_subRProducto" ON restaurante.producto USING btree (subcategoria);
 .   DROP INDEX restaurante."fki_fk_subRProducto";
       restaurante         postgres    false    198            0           1259    25219    fki_fk_subcategoria    INDEX     [   CREATE INDEX fki_fk_subcategoria ON restaurante.sub_rol_categoria USING btree (categoria);
 ,   DROP INDEX restaurante.fki_fk_subcategoria;
       restaurante         postgres    false    210            [           2620    25680     producto tg_restaurante_producto    TRIGGER     �   CREATE TRIGGER tg_restaurante_producto AFTER INSERT OR DELETE OR UPDATE ON restaurante.producto FOR EACH ROW EXECUTE PROCEDURE security.f_log_auditoria();
 >   DROP TRIGGER tg_restaurante_producto ON restaurante.producto;
       restaurante       postgres    false    240    198            \           2620    25679 <   registro_administrador tg_restaurante_registro_administrador    TRIGGER     �   CREATE TRIGGER tg_restaurante_registro_administrador AFTER INSERT OR DELETE OR UPDATE ON restaurante.registro_administrador FOR EACH ROW EXECUTE PROCEDURE security.f_log_auditoria();
 Z   DROP TRIGGER tg_restaurante_registro_administrador ON restaurante.registro_administrador;
       restaurante       postgres    false    200    240            ]           2620    25678 2   registro_empleado tg_restaurante_registro_empleado    TRIGGER     �   CREATE TRIGGER tg_restaurante_registro_empleado AFTER INSERT OR DELETE OR UPDATE ON restaurante.registro_empleado FOR EACH ROW EXECUTE PROCEDURE security.f_log_auditoria();
 P   DROP TRIGGER tg_restaurante_registro_empleado ON restaurante.registro_empleado;
       restaurante       postgres    false    202    240            ^           2620    25491 0   registro_usuario tg_restaurante_registro_usuario    TRIGGER     �   CREATE TRIGGER tg_restaurante_registro_usuario AFTER INSERT OR DELETE OR UPDATE ON restaurante.registro_usuario FOR EACH ROW EXECUTE PROCEDURE security.f_log_auditoria();
 N   DROP TRIGGER tg_restaurante_registro_usuario ON restaurante.registro_usuario;
       restaurante       postgres    false    204    240            V           2606    25220    sub_rol_categoria fk_cat    FK CONSTRAINT     �   ALTER TABLE ONLY restaurante.sub_rol_categoria
    ADD CONSTRAINT fk_cat FOREIGN KEY (categoria) REFERENCES restaurante.rol_categoria(id);
 G   ALTER TABLE ONLY restaurante.sub_rol_categoria DROP CONSTRAINT fk_cat;
       restaurante       postgres    false    210    206    2861            O           2606    25225    producto fk_cat    FK CONSTRAINT     �   ALTER TABLE ONLY restaurante.producto
    ADD CONSTRAINT fk_cat FOREIGN KEY (categoria) REFERENCES restaurante.rol_categoria(id);
 >   ALTER TABLE ONLY restaurante.producto DROP CONSTRAINT fk_cat;
       restaurante       postgres    false    198    206    2861            U           2606    25269    registro_usuario fk_estado    FK CONSTRAINT     �   ALTER TABLE ONLY restaurante.registro_usuario
    ADD CONSTRAINT fk_estado FOREIGN KEY (estado_id) REFERENCES restaurante.estado_registro(id);
 I   ALTER TABLE ONLY restaurante.registro_usuario DROP CONSTRAINT fk_estado;
       restaurante       postgres    false    204    2870    215            S           2606    25287    registro_empleado fk_estado    FK CONSTRAINT     �   ALTER TABLE ONLY restaurante.registro_empleado
    ADD CONSTRAINT fk_estado FOREIGN KEY (estado_id) REFERENCES restaurante.estado_registro(id);
 J   ALTER TABLE ONLY restaurante.registro_empleado DROP CONSTRAINT fk_estado;
       restaurante       postgres    false    202    2870    215            Y           2606    25435    pedido fk_id_domicilio    FK CONSTRAINT     �   ALTER TABLE ONLY restaurante.pedido
    ADD CONSTRAINT fk_id_domicilio FOREIGN KEY (id_domicilio) REFERENCES restaurante.domiciliou(id);
 E   ALTER TABLE ONLY restaurante.pedido DROP CONSTRAINT fk_id_domicilio;
       restaurante       postgres    false    2880    220    224            W           2606    25424    pedido fk_id_usuario    FK CONSTRAINT     �   ALTER TABLE ONLY restaurante.pedido
    ADD CONSTRAINT fk_id_usuario FOREIGN KEY (id_usuario) REFERENCES restaurante.registro_usuario(id);
 C   ALTER TABLE ONLY restaurante.pedido DROP CONSTRAINT fk_id_usuario;
       restaurante       postgres    false    220    2859    204            Z           2606    25441    domiciliou fk_id_usuario    FK CONSTRAINT     �   ALTER TABLE ONLY restaurante.domiciliou
    ADD CONSTRAINT fk_id_usuario FOREIGN KEY (id_usuario) REFERENCES restaurante.registro_usuario(id);
 G   ALTER TABLE ONLY restaurante.domiciliou DROP CONSTRAINT fk_id_usuario;
       restaurante       postgres    false    2859    204    224            X           2606    25430    pedido fk_pago    FK CONSTRAINT     }   ALTER TABLE ONLY restaurante.pedido
    ADD CONSTRAINT fk_pago FOREIGN KEY (id_pago) REFERENCES restaurante.metodo_pago(id);
 =   ALTER TABLE ONLY restaurante.pedido DROP CONSTRAINT fk_pago;
       restaurante       postgres    false    217    220    2872            T           2606    25230    registro_usuario fk_rol    FK CONSTRAINT     �   ALTER TABLE ONLY restaurante.registro_usuario
    ADD CONSTRAINT fk_rol FOREIGN KEY (rol) REFERENCES restaurante.rol_login("Id_Rol");
 F   ALTER TABLE ONLY restaurante.registro_usuario DROP CONSTRAINT fk_rol;
       restaurante       postgres    false    208    204    2863            Q           2606    25235    registro_administrador fk_rol    FK CONSTRAINT     �   ALTER TABLE ONLY restaurante.registro_administrador
    ADD CONSTRAINT fk_rol FOREIGN KEY (id_rol) REFERENCES restaurante.rol_login("Id_Rol");
 L   ALTER TABLE ONLY restaurante.registro_administrador DROP CONSTRAINT fk_rol;
       restaurante       postgres    false    200    2863    208            R           2606    25240    registro_empleado fk_rol    FK CONSTRAINT     �   ALTER TABLE ONLY restaurante.registro_empleado
    ADD CONSTRAINT fk_rol FOREIGN KEY (id_rol) REFERENCES restaurante.rol_login("Id_Rol");
 G   ALTER TABLE ONLY restaurante.registro_empleado DROP CONSTRAINT fk_rol;
       restaurante       postgres    false    202    2863    208            P           2606    25245    producto fk_sub    FK CONSTRAINT     �   ALTER TABLE ONLY restaurante.producto
    ADD CONSTRAINT fk_sub FOREIGN KEY (subcategoria) REFERENCES restaurante.sub_rol_categoria(id);
 >   ALTER TABLE ONLY restaurante.producto DROP CONSTRAINT fk_sub;
       restaurante       postgres    false    198    2866    210            �      x������ � �      �      x������ � �      �   �  x��Mo�F��ԯ|N��ٝ��u�"�F��"`d�Q�Xm�R����"%ڒ�K�D��ޕ�!�̻�#�J�K0A��$(P��i.DF*#�*?a�M �߯�������i>?{{}����W���bs����|X�S��owy��M@=q��ޯ��0L�~�\|���Ym�em���fB�=>�r���7I�v���v�������K}2�����b�3<��"/n6�w�ϛ��b�������,oË�������n���H�@8\8Z������~�����U^,����S���x��_�����Џ?�������Ex�(��}�`S,6����I�������������K��cbOh},���(�[m�Q
O$8#J�H ��SR����b�)����ѕ-�f)oi/:oy����~�����6ѝnu�� M��{y���b�^?�2�H'<e <���ߔ���f�b6�;������	�弸�ض^�s�^�nH����Q���؎>�M�0���:�;+Rm�r6ܰ����wf@����\�ȶ��"�[4�Y֥��m�{��˦���� �ղ��!�,"�
�zy��<_��D�ᶇz�C[@�Xt��p�x-�����U�܆ֲ���X�r����Q�9Q
��S�6q�)(3)�N�|M�R��`�vQ4���N��E4���N��D7���L���6��o*R�F�I��R�8Jg�m�C�b3I)i��5�Cs�ʙ�S�Z��U�L�;̌���i�8
�pu[B&\JF#�`�[Ta�(��*mjl��`a�Ð<֐8ͱ�L�����p����K���`�ĺkL�	�φN��Tj(sl~���2�ⰷVY�a��9-bjp��UG�58Vd������Xr�e�,����$�j�H��w�u��5Ve��O����Uⶍ@��6(��2T������/)�x+�(�[k����8��:&Ј�v��&P{XeC�{��=:���Ku�.S.�(q��������C��*�u�t41�^!�����mƠ̤̔K�4e+Np���1,G�Vm�!]�I�-��/,.��qf�k�UKX�[�,>tڔ����7V�RM��em��F�Y���:N��Ŏ��9��T&U�gD�+v4F�-��*�P��}41�03�a6eR�&��ҵ-�/v��m_إU�P��	�l�aۓ�)� ����3��v�Q V�^�����3�<kǱv�8��Xm�yM>�c�����S��*�Jd(R$+ms˾_�}=Ϯ�2BZ3��Ž6���"}�t&M*��F�8�H٧acve��hM�]fi�{�	��s³�e )b��8�����]Y%�����y�+_��ث��C[B�ZU�%7��#��� C!����c~��%��fQ%yQł=-��^���Jk�;�l��̋$�2����B�+�"$Er��jjo��R�>��������J(��#��̀R��H9S�[CnW��K��&����xZ�|ar�ڞۨӪ;��$N:$�O��T�)>��;Ӫn6X��Al��9�VG@g=�P].���	Y�a�HMр�X^N	Ƕ��fY��6����z�]�V�6sp�{7 S�"_������\�V)��LS9yj�cr��nצ��O�t����::ٳ�Ыt6����=�      �   <  x��Q=O�0��_aen�g;�H6��Ă"э��M���(MY�v�/��K������=���H� �@a|M"2�YN�4�2s�k{*��G�c�J��$G��/R�>V�ݶ%VA�vof�_�[ݏm�}7_�;S�h%�����r��`T��R���M�zu��e0,̃��s��e�l4*:��I�ͽnL�{�Jwک4�>	�Ŭ�#�_ߚ$\j4��i��ws���
��v���u��h��L|��9b���E�H3�)�#㗊�A�(v���X�H�3���LP�'3q��8`��L^ef,.q�߮Km�      �   �   x�}�;�0�z}���������Q�Ҭ#�ϑ8!�@�ߌfA�1�Ȩq��P5��'�6�r�����"��Vp��=�(�\~�٘����ywm�)��
�l^a�@�g���}�D����MYOm���Ŏ��He�/�M�%�J�B�7��Q�      �   0   x�3��HL���,IL��2�JM.-H-JL����2����@���qqq �4      �   X   x�U�+�0@�;Ş�t������@4%�(��f�3<mW/t�[b,�����t��{y��G���i�U�M(!��l~���Q�,�      �   1   x�3�tMKM.�,��2�I,JO-ITp.JM�,��2����&�b���� ���      �      x������ � �      �      x������ � �      �   3  x����n�0Eg�+�	,���X����hV-�-�
�����^Iu�(� \�璗�P��s84ܗ(�4��ܨث�i ��R��SVR֎ک�ϓ��gE
�ݿ��`?���y�-���:��x �*�ɘȾ��𥜧�񋰳Q#�J�6�.@��SF7�dMϖ����m��t�����E*�EZ,Ċ��6϶�\��|�Մ�P���:d�A������7M�&�F��T��x?�3S�v�|s��vNA*�ʕ��}������]C��#�AGb/N��2�!��է�d1�r×�$I~ ^!À      �   �   x�3��HM.�/RpKL�L�S�H-J�RH��M,���+ q�L*3�����s93�B��F�&�������F���1~@�e��_������R�Z�P�鞟4�71�47)f����E��I��8������ 4�0�      �   |   x�]�A
�0DדSx���M�� =A7�6P��%�.<��M���03<�C��* �1x<�ܶ<�JBߩ��R�4���">�ò#�gz��iz�Y
���a��.�1*�Z-��iI5}���?c��)�      �   H  x�e�ˎ�0E��W���Ѧ����4[6�}�4U���O��d)��k�P��DeJ�6�?�!^��������w۷��&�H�қ��O��Ҟ��>���H!�H�b���~H��_!���B��������~!��	z���v ��L��Ǫ8�U������)���]o��V��$2q�t�:ZA�����I�0�<I�\�و��MZ=�N��:�h���� {
��h���=�1��:ؙ�C2.���M7ֆM�޻��C?�$���5��2�Mg��8=Ԧ������B� �{��
)c�>�1U9� �T�`���O�(��X�      �   E  x�u��m1��l��Z� c�%�����8ҜF��/�ˈ���^d/�'k��ߘns�}��u��.���XD()��J��R���YUWI-��<��#\lEA;Dn	I��P	i9K�P$|����'d�b�xH�uD��!��F��?S����'�P�hO���]w�{�:�&�-T�:�=B���8g�.�����rδ���K{Ϭ�e*U&XŻw�ؼK�Ց����[�C�E2�Է�z'�>�L�=�A>�-����O6��d������V�s��LPW7:R��2��i�������u�$������ߦ��Q����V��_��x|s��         H  x�}��q#1D�RN�,�?�e�c�|���u�@��1���+ <�A�I��7�[�Q�T�0ۄ���9.N��FQ�bQ*�5(��@�+,t
jsGNp���oO,P7�bV�l�<0lU�kt��{1�ͼ$��<�*Dc����Өl�2pf�j���ǹ��,�>����,#��!y�ˁ�E�)���a��z�v������0������Z��U��<�Y�/|y[2��
]R<�!懒�5���i�a;��!f�!��<7���a<�S��7m
�-� ����a�5�N_MNL�cn�����E�&Z����z�n�ځ��`�"�E+;Ԑ~H?K�ºn�4�V(�2TZC���t�uv|$��1�@<
ɡ9W�ue ���HR%��O׌�W�Q��̹m��#�{v
lgz���8���XG���^%�G�>��7��*�!_����7�w:�Nj�9���3��.�J�����޵I�9�z�9&z7�ER�U����	��"��-�a��X����6��}��2����O3a�G����L�u4��!y�P�es�?H����#���|>�aM7      �   5   x�3�tN,�K�2�H-NNL��2�t-.HM�L��LIL�2�t,K-����� 0��      �   0   x�3�tL����,.)JL�/�2�t�-�I���9C�K�2�b���� (r�      �   A   x�3�J-�4�2�tN-J��L8}�8���9�2�)g@~NN>���{bNNf^"����� ���      �   G  x��X�n�V�&Oaq�Eg�?\m�M�J�jզw+E�Mjs\��$�>T��/��4�`1�I��3�����wRfUʸ�3���yU���P�27���%�| �e#!� ��߿|����ۛ�^�Y�����6[�������т�R���v�\�f��}� ��|ɏ=��*!������� �Om�(���J ����o׿������1
�Ti��B��#+N+�a���Ĕef�W�[��iՏ�4++S��WeU��ΐ?�}s8�g�m�v ~r���I��	�0��C��E����l/�t�Y+f8FS�e\e��w��2�\��U}�3�l^?v�]�o�3"y��!��<͊�%qb��X���ϊ$��x����ݣ�ѷ� �H�@�!C�@�e�>�Ѥ�H��R��A�a�i/����=>_F��0E�$|çG|1"B#*J@�#���/�o�+��2��n[=�x��=�+��5���@3ə�P�����7w��$H��wU}��������p�f�J�%υ��S����}��9�J1M�b���X��So��e�U@4!�}�����3�?|{�����>��1�GD��'q�w��f��-)��;�}�M��+�q�� g�?rDO�N|v'�f2:>��5���M�L�i��c|��4���gBaކ���[��e#��o=�0����H����<���ɰ~�����,1��f{E�+)��6�� �[���b�F#{y4�mpt���@ �1��f3k�!䂄gM3V�ȷ'�W�Ҥ�����%B�Hu
�C�*J�z��� M�{^�p	�*�M�ŀA��p<W`������
g.ʝ���!.w���H�N��K�B�|J������Ͳ��WF$���M��V�g�䥧{�<é��٘:ۗ�l;��X��oI�)�6��wj��h�����"�~͙�l^I*C|�8��XZJJ���-�i�鉲��oS1c.����?I���rQ�>����]��a);g�����p��'d]���t:{�>�T]�,�jc
� ��Ibl>�v@P�N�l�	��W_������]:     