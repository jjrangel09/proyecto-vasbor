PGDMP     '                    x            proyectovasbor    11.7    11.7 �    �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                       false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                       false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                       false            �           1262    25136    proyectovasbor    DATABASE     �   CREATE DATABASE proyectovasbor WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'Spanish_Colombia.1252' LC_CTYPE = 'Spanish_Colombia.1252';
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
       security       postgres    false    6            �            1259    25162    registro_usuario    TABLE     �  CREATE TABLE restaurante.registro_usuario (
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
       security       postgres    false    204    6    204            �            1259    25252    carrito    TABLE     �   CREATE TABLE restaurante.carrito (
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
       restaurante       postgres    false    8    228            �           0    0    carrito_empleado_id_seq    SEQUENCE OWNED BY     ]   ALTER SEQUENCE restaurante.carrito_empleado_id_seq OWNED BY restaurante.carrito_empleado.id;
            restaurante       postgres    false    227            �            1259    25250    carrito_id_seq    SEQUENCE     �   CREATE SEQUENCE restaurante.carrito_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE restaurante.carrito_id_seq;
       restaurante       postgres    false    8    213            �           0    0    carrito_id_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE restaurante.carrito_id_seq OWNED BY restaurante.carrito.id;
            restaurante       postgres    false    212            �            1259    25375    detalle_pedido    TABLE     �   CREATE TABLE restaurante.detalle_pedido (
    id bigint NOT NULL,
    id_pedido integer,
    cantidad integer,
    total bigint,
    fecha timestamp with time zone,
    id_usuario integer,
    detalle json
);
 '   DROP TABLE restaurante.detalle_pedido;
       restaurante         postgres    false    8            �            1259    25373    detalle_pedido_id_seq    SEQUENCE     �   CREATE SEQUENCE restaurante.detalle_pedido_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 1   DROP SEQUENCE restaurante.detalle_pedido_id_seq;
       restaurante       postgres    false    8    226            �           0    0    detalle_pedido_id_seq    SEQUENCE OWNED BY     Y   ALTER SEQUENCE restaurante.detalle_pedido_id_seq OWNED BY restaurante.detalle_pedido.id;
            restaurante       postgres    false    225            �            1259    25454    detalle_pedido_mesero    TABLE     �   CREATE TABLE restaurante.detalle_pedido_mesero (
    id bigint NOT NULL,
    id_pedido bigint,
    cantidad bigint,
    total bigint,
    fecha timestamp with time zone,
    id_mesero bigint,
    "detalleP" json
);
 .   DROP TABLE restaurante.detalle_pedido_mesero;
       restaurante         postgres    false    8            �            1259    25452    detalle_pedido_mesero_id_seq    SEQUENCE     �   CREATE SEQUENCE restaurante.detalle_pedido_mesero_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 8   DROP SEQUENCE restaurante.detalle_pedido_mesero_id_seq;
       restaurante       postgres    false    234    8            �           0    0    detalle_pedido_mesero_id_seq    SEQUENCE OWNED BY     g   ALTER SEQUENCE restaurante.detalle_pedido_mesero_id_seq OWNED BY restaurante.detalle_pedido_mesero.id;
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
       restaurante       postgres    false    224    8            �           0    0    domiciliou_id_seq    SEQUENCE OWNED BY     Q   ALTER SEQUENCE restaurante.domiciliou_id_seq OWNED BY restaurante.domiciliou.id;
            restaurante       postgres    false    222            �            1259    25361    domiciliou_id_usuario_seq    SEQUENCE     �   CREATE SEQUENCE restaurante.domiciliou_id_usuario_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 5   DROP SEQUENCE restaurante.domiciliou_id_usuario_seq;
       restaurante       postgres    false    8    224                        0    0    domiciliou_id_usuario_seq    SEQUENCE OWNED BY     a   ALTER SEQUENCE restaurante.domiciliou_id_usuario_seq OWNED BY restaurante.domiciliou.id_usuario;
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
       restaurante       postgres    false    215    8                       0    0    estado_registro_id_seq    SEQUENCE OWNED BY     [   ALTER SEQUENCE restaurante.estado_registro_id_seq OWNED BY restaurante.estado_registro.id;
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
       restaurante       postgres    false    230    8                       0    0    mesas_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE restaurante.mesas_id_seq OWNED BY restaurante.mesas.id;
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
       restaurante       postgres    false    8    217                       0    0    metodo_pago_id_seq    SEQUENCE OWNED BY     S   ALTER SEQUENCE restaurante.metodo_pago_id_seq OWNED BY restaurante.metodo_pago.id;
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
       restaurante       postgres    false    8    220                       0    0    pedido_id_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE restaurante.pedido_id_seq OWNED BY restaurante.pedido.id;
            restaurante       postgres    false    221            �            1259    25407    pedido_mesero    TABLE     �   CREATE TABLE restaurante.pedido_mesero (
    id bigint NOT NULL,
    id_mesero integer,
    id_pago integer,
    total bigint,
    fecha timestamp with time zone,
    numero_mesa integer,
    detalle json
);
 &   DROP TABLE restaurante.pedido_mesero;
       restaurante         postgres    false    8            �            1259    25405    pedido_mesero_id_seq    SEQUENCE     �   CREATE SEQUENCE restaurante.pedido_mesero_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 0   DROP SEQUENCE restaurante.pedido_mesero_id_seq;
       restaurante       postgres    false    232    8                       0    0    pedido_mesero_id_seq    SEQUENCE OWNED BY     W   ALTER SEQUENCE restaurante.pedido_mesero_id_seq OWNED BY restaurante.pedido_mesero.id;
            restaurante       postgres    false    231            �            1259    25138    producto    TABLE       CREATE TABLE restaurante.producto (
    id integer NOT NULL,
    nombre text NOT NULL,
    categoria integer NOT NULL,
    subcategoria integer NOT NULL,
    precio double precision NOT NULL,
    descripcion text NOT NULL,
    imagen text NOT NULL,
    cantidad integer NOT NULL
);
 !   DROP TABLE restaurante.producto;
       restaurante         postgres    false    8            �            1259    25144    producto_id_seq    SEQUENCE     �   CREATE SEQUENCE restaurante.producto_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE restaurante.producto_id_seq;
       restaurante       postgres    false    198    8                       0    0    producto_id_seq    SEQUENCE OWNED BY     M   ALTER SEQUENCE restaurante.producto_id_seq OWNED BY restaurante.producto.id;
            restaurante       postgres    false    199            �            1259    25146    registro_administrador    TABLE     �   CREATE TABLE restaurante.registro_administrador (
    id integer NOT NULL,
    nombre text,
    apellido text,
    correo text,
    username text,
    clave text,
    identificacion bigint,
    id_rol integer
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
       restaurante       postgres    false    200    8                       0    0    registro_administrador_id_seq    SEQUENCE OWNED BY     i   ALTER SEQUENCE restaurante.registro_administrador_id_seq OWNED BY restaurante.registro_administrador.id;
            restaurante       postgres    false    201            �            1259    25154    registro_empleado    TABLE     �   CREATE TABLE restaurante.registro_empleado (
    id bigint NOT NULL,
    nombre text,
    apellido text,
    telefono bigint,
    id_rol integer,
    id_codigo bigint,
    username text,
    clave text,
    estado_id integer DEFAULT 1
);
 *   DROP TABLE restaurante.registro_empleado;
       restaurante         postgres    false    8            �            1259    25160    registro_empleado_id_seq    SEQUENCE     �   CREATE SEQUENCE restaurante.registro_empleado_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 4   DROP SEQUENCE restaurante.registro_empleado_id_seq;
       restaurante       postgres    false    8    202                       0    0    registro_empleado_id_seq    SEQUENCE OWNED BY     _   ALTER SEQUENCE restaurante.registro_empleado_id_seq OWNED BY restaurante.registro_empleado.id;
            restaurante       postgres    false    203            �            1259    25169    registro_usuario_id_seq    SEQUENCE     �   CREATE SEQUENCE restaurante.registro_usuario_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 3   DROP SEQUENCE restaurante.registro_usuario_id_seq;
       restaurante       postgres    false    204    8            	           0    0    registro_usuario_id_seq    SEQUENCE OWNED BY     ]   ALTER SEQUENCE restaurante.registro_usuario_id_seq OWNED BY restaurante.registro_usuario.id;
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
       restaurante       postgres    false    218    8            
           0    0    reporte_monetario_id_seq    SEQUENCE OWNED BY     _   ALTER SEQUENCE restaurante.reporte_monetario_id_seq OWNED BY restaurante.reporte_monetario.id;
            restaurante       postgres    false    219            �            1259    25171    rol_categoria    TABLE     W   CREATE TABLE restaurante.rol_categoria (
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
       restaurante       postgres    false    8    206                       0    0    rol_categoria_id_seq    SEQUENCE OWNED BY     W   ALTER SEQUENCE restaurante.rol_categoria_id_seq OWNED BY restaurante.rol_categoria.id;
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
       restaurante       postgres    false    8    208                       0    0    rol_login_Id_Rol_seq    SEQUENCE OWNED BY     [   ALTER SEQUENCE restaurante."rol_login_Id_Rol_seq" OWNED BY restaurante.rol_login."Id_Rol";
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
       restaurante       postgres    false    8    210                       0    0    sub_rol_categoria_id_seq    SEQUENCE OWNED BY     _   ALTER SEQUENCE restaurante.sub_rol_categoria_id_seq OWNED BY restaurante.sub_rol_categoria.id;
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
       security       postgres    false    6    235                       0    0    auditoria_id_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE security.auditoria_id_seq OWNED BY security.auditoria.id;
            security       postgres    false    236            �            1259    25486    function_db_view    VIEW     �  CREATE VIEW security.function_db_view AS
 SELECT pp.proname AS b_function,
    oidvectortypes(pp.proargtypes) AS b_type_parameters
   FROM (pg_proc pp
     JOIN pg_namespace pn ON ((pn.oid = pp.pronamespace)))
  WHERE ((pn.nspname)::text <> ALL (ARRAY[('pg_catalog'::character varying)::text, ('information_schema'::character varying)::text, ('admin_control'::character varying)::text, ('vial'::character varying)::text]));
 %   DROP VIEW security.function_db_view;
       security       postgres    false    6                       2604    25255 
   carrito id    DEFAULT     r   ALTER TABLE ONLY restaurante.carrito ALTER COLUMN id SET DEFAULT nextval('restaurante.carrito_id_seq'::regclass);
 >   ALTER TABLE restaurante.carrito ALTER COLUMN id DROP DEFAULT;
       restaurante       postgres    false    213    212    213                       2604    25390    carrito_empleado id    DEFAULT     �   ALTER TABLE ONLY restaurante.carrito_empleado ALTER COLUMN id SET DEFAULT nextval('restaurante.carrito_empleado_id_seq'::regclass);
 G   ALTER TABLE restaurante.carrito_empleado ALTER COLUMN id DROP DEFAULT;
       restaurante       postgres    false    227    228    228                       2604    25378    detalle_pedido id    DEFAULT     �   ALTER TABLE ONLY restaurante.detalle_pedido ALTER COLUMN id SET DEFAULT nextval('restaurante.detalle_pedido_id_seq'::regclass);
 E   ALTER TABLE restaurante.detalle_pedido ALTER COLUMN id DROP DEFAULT;
       restaurante       postgres    false    226    225    226                       2604    25457    detalle_pedido_mesero id    DEFAULT     �   ALTER TABLE ONLY restaurante.detalle_pedido_mesero ALTER COLUMN id SET DEFAULT nextval('restaurante.detalle_pedido_mesero_id_seq'::regclass);
 L   ALTER TABLE restaurante.detalle_pedido_mesero ALTER COLUMN id DROP DEFAULT;
       restaurante       postgres    false    234    233    234                       2604    25366    domiciliou id    DEFAULT     x   ALTER TABLE ONLY restaurante.domiciliou ALTER COLUMN id SET DEFAULT nextval('restaurante.domiciliou_id_seq'::regclass);
 A   ALTER TABLE restaurante.domiciliou ALTER COLUMN id DROP DEFAULT;
       restaurante       postgres    false    222    224    224                       2604    25367    domiciliou id_usuario    DEFAULT     �   ALTER TABLE ONLY restaurante.domiciliou ALTER COLUMN id_usuario SET DEFAULT nextval('restaurante.domiciliou_id_usuario_seq'::regclass);
 I   ALTER TABLE restaurante.domiciliou ALTER COLUMN id_usuario DROP DEFAULT;
       restaurante       postgres    false    223    224    224                       2604    25263    estado_registro id    DEFAULT     �   ALTER TABLE ONLY restaurante.estado_registro ALTER COLUMN id SET DEFAULT nextval('restaurante.estado_registro_id_seq'::regclass);
 F   ALTER TABLE restaurante.estado_registro ALTER COLUMN id DROP DEFAULT;
       restaurante       postgres    false    214    215    215                       2604    25399    mesas id    DEFAULT     n   ALTER TABLE ONLY restaurante.mesas ALTER COLUMN id SET DEFAULT nextval('restaurante.mesas_id_seq'::regclass);
 <   ALTER TABLE restaurante.mesas ALTER COLUMN id DROP DEFAULT;
       restaurante       postgres    false    230    229    230                       2604    25297    metodo_pago id    DEFAULT     z   ALTER TABLE ONLY restaurante.metodo_pago ALTER COLUMN id SET DEFAULT nextval('restaurante.metodo_pago_id_seq'::regclass);
 B   ALTER TABLE restaurante.metodo_pago ALTER COLUMN id DROP DEFAULT;
       restaurante       postgres    false    217    216    217                       2604    25353 	   pedido id    DEFAULT     p   ALTER TABLE ONLY restaurante.pedido ALTER COLUMN id SET DEFAULT nextval('restaurante.pedido_id_seq'::regclass);
 =   ALTER TABLE restaurante.pedido ALTER COLUMN id DROP DEFAULT;
       restaurante       postgres    false    221    220                       2604    25410    pedido_mesero id    DEFAULT     ~   ALTER TABLE ONLY restaurante.pedido_mesero ALTER COLUMN id SET DEFAULT nextval('restaurante.pedido_mesero_id_seq'::regclass);
 D   ALTER TABLE restaurante.pedido_mesero ALTER COLUMN id DROP DEFAULT;
       restaurante       postgres    false    232    231    232                       2604    25195    producto id    DEFAULT     t   ALTER TABLE ONLY restaurante.producto ALTER COLUMN id SET DEFAULT nextval('restaurante.producto_id_seq'::regclass);
 ?   ALTER TABLE restaurante.producto ALTER COLUMN id DROP DEFAULT;
       restaurante       postgres    false    199    198                       2604    25196    registro_administrador id    DEFAULT     �   ALTER TABLE ONLY restaurante.registro_administrador ALTER COLUMN id SET DEFAULT nextval('restaurante.registro_administrador_id_seq'::regclass);
 M   ALTER TABLE restaurante.registro_administrador ALTER COLUMN id DROP DEFAULT;
       restaurante       postgres    false    201    200                       2604    25197    registro_empleado id    DEFAULT     �   ALTER TABLE ONLY restaurante.registro_empleado ALTER COLUMN id SET DEFAULT nextval('restaurante.registro_empleado_id_seq'::regclass);
 H   ALTER TABLE restaurante.registro_empleado ALTER COLUMN id DROP DEFAULT;
       restaurante       postgres    false    203    202                       2604    25198    registro_usuario id    DEFAULT     �   ALTER TABLE ONLY restaurante.registro_usuario ALTER COLUMN id SET DEFAULT nextval('restaurante.registro_usuario_id_seq'::regclass);
 G   ALTER TABLE restaurante.registro_usuario ALTER COLUMN id DROP DEFAULT;
       restaurante       postgres    false    205    204                       2604    25342    reporte_monetario id    DEFAULT     �   ALTER TABLE ONLY restaurante.reporte_monetario ALTER COLUMN id SET DEFAULT nextval('restaurante.reporte_monetario_id_seq'::regclass);
 H   ALTER TABLE restaurante.reporte_monetario ALTER COLUMN id DROP DEFAULT;
       restaurante       postgres    false    219    218                       2604    25199    rol_categoria id    DEFAULT     ~   ALTER TABLE ONLY restaurante.rol_categoria ALTER COLUMN id SET DEFAULT nextval('restaurante.rol_categoria_id_seq'::regclass);
 D   ALTER TABLE restaurante.rol_categoria ALTER COLUMN id DROP DEFAULT;
       restaurante       postgres    false    207    206            	           2604    25200    rol_login Id_Rol    DEFAULT     �   ALTER TABLE ONLY restaurante.rol_login ALTER COLUMN "Id_Rol" SET DEFAULT nextval('restaurante."rol_login_Id_Rol_seq"'::regclass);
 F   ALTER TABLE restaurante.rol_login ALTER COLUMN "Id_Rol" DROP DEFAULT;
       restaurante       postgres    false    209    208            
           2604    25201    sub_rol_categoria id    DEFAULT     �   ALTER TABLE ONLY restaurante.sub_rol_categoria ALTER COLUMN id SET DEFAULT nextval('restaurante.sub_rol_categoria_id_seq'::regclass);
 H   ALTER TABLE restaurante.sub_rol_categoria ALTER COLUMN id DROP DEFAULT;
       restaurante       postgres    false    211    210                       2604    25475    auditoria id    DEFAULT     p   ALTER TABLE ONLY security.auditoria ALTER COLUMN id SET DEFAULT nextval('security.auditoria_id_seq'::regclass);
 =   ALTER TABLE security.auditoria ALTER COLUMN id DROP DEFAULT;
       security       postgres    false    236    235            �          0    25252    carrito 
   TABLE DATA               \   COPY restaurante.carrito (id, usuario_id, producto_id, cantidad, fecha, precio) FROM stdin;
    restaurante       postgres    false    213   p       �          0    25387    carrito_empleado 
   TABLE DATA               d   COPY restaurante.carrito_empleado (id, id_mesero, producto_id, cantidad, fecha, precio) FROM stdin;
    restaurante       postgres    false    228   �       �          0    25375    detalle_pedido 
   TABLE DATA               i   COPY restaurante.detalle_pedido (id, id_pedido, cantidad, total, fecha, id_usuario, detalle) FROM stdin;
    restaurante       postgres    false    226   �       �          0    25454    detalle_pedido_mesero 
   TABLE DATA               r   COPY restaurante.detalle_pedido_mesero (id, id_pedido, cantidad, total, fecha, id_mesero, "detalleP") FROM stdin;
    restaurante       postgres    false    234   B      �          0    25363 
   domiciliou 
   TABLE DATA               [   COPY restaurante.domiciliou (id, id_usuario, direccion, pais, ciudad, codigop) FROM stdin;
    restaurante       postgres    false    224   �      �          0    25260    estado_registro 
   TABLE DATA               ?   COPY restaurante.estado_registro (id, descripcion) FROM stdin;
    restaurante       postgres    false    215   S      �          0    25396    mesas 
   TABLE DATA               :   COPY restaurante.mesas (id, descripcion_mesa) FROM stdin;
    restaurante       postgres    false    230   �      �          0    25294    metodo_pago 
   TABLE DATA               ;   COPY restaurante.metodo_pago (id, descripcion) FROM stdin;
    restaurante       postgres    false    217   �      �          0    25348    pedido 
   TABLE DATA               Z   COPY restaurante.pedido (id, id_usuario, id_pago, id_domicilio, total, fecha) FROM stdin;
    restaurante       postgres    false    220   <      �          0    25407    pedido_mesero 
   TABLE DATA               h   COPY restaurante.pedido_mesero (id, id_mesero, id_pago, total, fecha, numero_mesa, detalle) FROM stdin;
    restaurante       postgres    false    232   Y      �          0    25138    producto 
   TABLE DATA               s   COPY restaurante.producto (id, nombre, categoria, subcategoria, precio, descripcion, imagen, cantidad) FROM stdin;
    restaurante       postgres    false    198   v      �          0    25146    registro_administrador 
   TABLE DATA               |   COPY restaurante.registro_administrador (id, nombre, apellido, correo, username, clave, identificacion, id_rol) FROM stdin;
    restaurante       postgres    false    200   �      �          0    25154    registro_empleado 
   TABLE DATA                  COPY restaurante.registro_empleado (id, nombre, apellido, telefono, id_rol, id_codigo, username, clave, estado_id) FROM stdin;
    restaurante       postgres    false    202   L      �          0    25162    registro_usuario 
   TABLE DATA               �   COPY restaurante.registro_usuario (id, identificacion, nombre, apellido, correo, username, "contraseña", telefono, rol, estado_id, token, vencimiento_token, session, last_modifity) FROM stdin;
    restaurante       postgres    false    204   �      �          0    25337    reporte_monetario 
   TABLE DATA               N   COPY restaurante.reporte_monetario (id, id_persona, total, fecha) FROM stdin;
    restaurante       postgres    false    218   
      �          0    25171    rol_categoria 
   TABLE DATA               ;   COPY restaurante.rol_categoria (id, categoria) FROM stdin;
    restaurante       postgres    false    206   o
      �          0    25179 	   rol_login 
   TABLE DATA               E   COPY restaurante.rol_login ("Id_Rol", "Descripcion_Rol") FROM stdin;
    restaurante       postgres    false    208   �
      �          0    25187    sub_rol_categoria 
   TABLE DATA               M   COPY restaurante.sub_rol_categoria (id, subcategoria, categoria) FROM stdin;
    restaurante       postgres    false    210   �
      �          0    25467 	   auditoria 
   TABLE DATA               c   COPY security.auditoria (schema, tabla, session, fecha, accion, user_bd, data, pk, id) FROM stdin;
    security       postgres    false    235   E                 0    0    carrito_empleado_id_seq    SEQUENCE SET     K   SELECT pg_catalog.setval('restaurante.carrito_empleado_id_seq', 35, true);
            restaurante       postgres    false    227                       0    0    carrito_id_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('restaurante.carrito_id_seq', 169, true);
            restaurante       postgres    false    212                       0    0    detalle_pedido_id_seq    SEQUENCE SET     I   SELECT pg_catalog.setval('restaurante.detalle_pedido_id_seq', 42, true);
            restaurante       postgres    false    225                       0    0    detalle_pedido_mesero_id_seq    SEQUENCE SET     P   SELECT pg_catalog.setval('restaurante.detalle_pedido_mesero_id_seq', 18, true);
            restaurante       postgres    false    233                       0    0    domiciliou_id_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('restaurante.domiciliou_id_seq', 12, true);
            restaurante       postgres    false    222                       0    0    domiciliou_id_usuario_seq    SEQUENCE SET     M   SELECT pg_catalog.setval('restaurante.domiciliou_id_usuario_seq', 1, false);
            restaurante       postgres    false    223                       0    0    estado_registro_id_seq    SEQUENCE SET     J   SELECT pg_catalog.setval('restaurante.estado_registro_id_seq', 1, false);
            restaurante       postgres    false    214                       0    0    mesas_id_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('restaurante.mesas_id_seq', 1, true);
            restaurante       postgres    false    229                       0    0    metodo_pago_id_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('restaurante.metodo_pago_id_seq', 1, false);
            restaurante       postgres    false    216                       0    0    pedido_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('restaurante.pedido_id_seq', 77, true);
            restaurante       postgres    false    221                       0    0    pedido_mesero_id_seq    SEQUENCE SET     H   SELECT pg_catalog.setval('restaurante.pedido_mesero_id_seq', 27, true);
            restaurante       postgres    false    231                       0    0    producto_id_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('restaurante.producto_id_seq', 24, true);
            restaurante       postgres    false    199                       0    0    registro_administrador_id_seq    SEQUENCE SET     P   SELECT pg_catalog.setval('restaurante.registro_administrador_id_seq', 3, true);
            restaurante       postgres    false    201                       0    0    registro_empleado_id_seq    SEQUENCE SET     K   SELECT pg_catalog.setval('restaurante.registro_empleado_id_seq', 7, true);
            restaurante       postgres    false    203                       0    0    registro_usuario_id_seq    SEQUENCE SET     K   SELECT pg_catalog.setval('restaurante.registro_usuario_id_seq', 22, true);
            restaurante       postgres    false    205                       0    0    reporte_monetario_id_seq    SEQUENCE SET     K   SELECT pg_catalog.setval('restaurante.reporte_monetario_id_seq', 3, true);
            restaurante       postgres    false    219                       0    0    rol_categoria_id_seq    SEQUENCE SET     H   SELECT pg_catalog.setval('restaurante.rol_categoria_id_seq', 10, true);
            restaurante       postgres    false    207                        0    0    rol_login_Id_Rol_seq    SEQUENCE SET     J   SELECT pg_catalog.setval('restaurante."rol_login_Id_Rol_seq"', 1, false);
            restaurante       postgres    false    209            !           0    0    sub_rol_categoria_id_seq    SEQUENCE SET     K   SELECT pg_catalog.setval('restaurante.sub_rol_categoria_id_seq', 9, true);
            restaurante       postgres    false    211            "           0    0    auditoria_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('security.auditoria_id_seq', 15, true);
            security       postgres    false    236            <           2606    25392 &   carrito_empleado carrito_empleado_pkey 
   CONSTRAINT     i   ALTER TABLE ONLY restaurante.carrito_empleado
    ADD CONSTRAINT carrito_empleado_pkey PRIMARY KEY (id);
 U   ALTER TABLE ONLY restaurante.carrito_empleado DROP CONSTRAINT carrito_empleado_pkey;
       restaurante         postgres    false    228            C           2606    25459 0   detalle_pedido_mesero detalle_pedido_mesero_pkey 
   CONSTRAINT     s   ALTER TABLE ONLY restaurante.detalle_pedido_mesero
    ADD CONSTRAINT detalle_pedido_mesero_pkey PRIMARY KEY (id);
 _   ALTER TABLE ONLY restaurante.detalle_pedido_mesero DROP CONSTRAINT detalle_pedido_mesero_pkey;
       restaurante         postgres    false    234            :           2606    25380 "   detalle_pedido detalle_pedido_pkey 
   CONSTRAINT     e   ALTER TABLE ONLY restaurante.detalle_pedido
    ADD CONSTRAINT detalle_pedido_pkey PRIMARY KEY (id);
 Q   ALTER TABLE ONLY restaurante.detalle_pedido DROP CONSTRAINT detalle_pedido_pkey;
       restaurante         postgres    false    226            8           2606    25372    domiciliou domiciliou_pkey 
   CONSTRAINT     ]   ALTER TABLE ONLY restaurante.domiciliou
    ADD CONSTRAINT domiciliou_pkey PRIMARY KEY (id);
 I   ALTER TABLE ONLY restaurante.domiciliou DROP CONSTRAINT domiciliou_pkey;
       restaurante         postgres    false    224            .           2606    25268 $   estado_registro estado_registro_pkey 
   CONSTRAINT     g   ALTER TABLE ONLY restaurante.estado_registro
    ADD CONSTRAINT estado_registro_pkey PRIMARY KEY (id);
 S   ALTER TABLE ONLY restaurante.estado_registro DROP CONSTRAINT estado_registro_pkey;
       restaurante         postgres    false    215            >           2606    25404    mesas mesas_pkey 
   CONSTRAINT     S   ALTER TABLE ONLY restaurante.mesas
    ADD CONSTRAINT mesas_pkey PRIMARY KEY (id);
 ?   ALTER TABLE ONLY restaurante.mesas DROP CONSTRAINT mesas_pkey;
       restaurante         postgres    false    230            0           2606    25302    metodo_pago metodo_pago_pkey 
   CONSTRAINT     _   ALTER TABLE ONLY restaurante.metodo_pago
    ADD CONSTRAINT metodo_pago_pkey PRIMARY KEY (id);
 K   ALTER TABLE ONLY restaurante.metodo_pago DROP CONSTRAINT metodo_pago_pkey;
       restaurante         postgres    false    217            A           2606    25412     pedido_mesero pedido_mesero_pkey 
   CONSTRAINT     c   ALTER TABLE ONLY restaurante.pedido_mesero
    ADD CONSTRAINT pedido_mesero_pkey PRIMARY KEY (id);
 O   ALTER TABLE ONLY restaurante.pedido_mesero DROP CONSTRAINT pedido_mesero_pkey;
       restaurante         postgres    false    232            6           2606    25358    pedido pedido_pkey 
   CONSTRAINT     U   ALTER TABLE ONLY restaurante.pedido
    ADD CONSTRAINT pedido_pkey PRIMARY KEY (id);
 A   ALTER TABLE ONLY restaurante.pedido DROP CONSTRAINT pedido_pkey;
       restaurante         postgres    false    220            ,           2606    25257    carrito pk_carrito 
   CONSTRAINT     U   ALTER TABLE ONLY restaurante.carrito
    ADD CONSTRAINT pk_carrito PRIMARY KEY (id);
 A   ALTER TABLE ONLY restaurante.carrito DROP CONSTRAINT pk_carrito;
       restaurante         postgres    false    213                       2606    25203    producto producto_pkey 
   CONSTRAINT     Y   ALTER TABLE ONLY restaurante.producto
    ADD CONSTRAINT producto_pkey PRIMARY KEY (id);
 E   ALTER TABLE ONLY restaurante.producto DROP CONSTRAINT producto_pkey;
       restaurante         postgres    false    198                       2606    25205 2   registro_administrador registro_administrador_pkey 
   CONSTRAINT     u   ALTER TABLE ONLY restaurante.registro_administrador
    ADD CONSTRAINT registro_administrador_pkey PRIMARY KEY (id);
 a   ALTER TABLE ONLY restaurante.registro_administrador DROP CONSTRAINT registro_administrador_pkey;
       restaurante         postgres    false    200                       2606    25207 (   registro_empleado registro_empleado_pkey 
   CONSTRAINT     k   ALTER TABLE ONLY restaurante.registro_empleado
    ADD CONSTRAINT registro_empleado_pkey PRIMARY KEY (id);
 W   ALTER TABLE ONLY restaurante.registro_empleado DROP CONSTRAINT registro_empleado_pkey;
       restaurante         postgres    false    202            #           2606    25209 &   registro_usuario registro_usuario_pkey 
   CONSTRAINT     i   ALTER TABLE ONLY restaurante.registro_usuario
    ADD CONSTRAINT registro_usuario_pkey PRIMARY KEY (id);
 U   ALTER TABLE ONLY restaurante.registro_usuario DROP CONSTRAINT registro_usuario_pkey;
       restaurante         postgres    false    204            2           2606    25347 (   reporte_monetario reporte_monetario_pkey 
   CONSTRAINT     k   ALTER TABLE ONLY restaurante.reporte_monetario
    ADD CONSTRAINT reporte_monetario_pkey PRIMARY KEY (id);
 W   ALTER TABLE ONLY restaurante.reporte_monetario DROP CONSTRAINT reporte_monetario_pkey;
       restaurante         postgres    false    218            %           2606    25211     rol_categoria rol_categoria_pkey 
   CONSTRAINT     c   ALTER TABLE ONLY restaurante.rol_categoria
    ADD CONSTRAINT rol_categoria_pkey PRIMARY KEY (id);
 O   ALTER TABLE ONLY restaurante.rol_categoria DROP CONSTRAINT rol_categoria_pkey;
       restaurante         postgres    false    206            '           2606    25213    rol_login rol_login_pkey 
   CONSTRAINT     a   ALTER TABLE ONLY restaurante.rol_login
    ADD CONSTRAINT rol_login_pkey PRIMARY KEY ("Id_Rol");
 G   ALTER TABLE ONLY restaurante.rol_login DROP CONSTRAINT rol_login_pkey;
       restaurante         postgres    false    208            *           2606    25215 (   sub_rol_categoria sub_rol_categoria_pkey 
   CONSTRAINT     k   ALTER TABLE ONLY restaurante.sub_rol_categoria
    ADD CONSTRAINT sub_rol_categoria_pkey PRIMARY KEY (id);
 W   ALTER TABLE ONLY restaurante.sub_rol_categoria DROP CONSTRAINT sub_rol_categoria_pkey;
       restaurante         postgres    false    210            E           2606    25483    auditoria auditoria_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY security.auditoria
    ADD CONSTRAINT auditoria_pkey PRIMARY KEY (id);
 D   ALTER TABLE ONLY security.auditoria DROP CONSTRAINT auditoria_pkey;
       security         postgres    false    235                        1259    25274    fki_fk_estado    INDEX     T   CREATE INDEX fki_fk_estado ON restaurante.registro_usuario USING btree (estado_id);
 &   DROP INDEX restaurante.fki_fk_estado;
       restaurante         postgres    false    204            3           1259    25440    fki_fk_id_domicilio    INDEX     S   CREATE INDEX fki_fk_id_domicilio ON restaurante.pedido USING btree (id_domicilio);
 ,   DROP INDEX restaurante.fki_fk_id_domicilio;
       restaurante         postgres    false    220            4           1259    25429    fki_fk_id_usuario    INDEX     O   CREATE INDEX fki_fk_id_usuario ON restaurante.pedido USING btree (id_usuario);
 *   DROP INDEX restaurante.fki_fk_id_usuario;
       restaurante         postgres    false    220            !           1259    25216 
   fki_fk_rol    INDEX     K   CREATE INDEX fki_fk_rol ON restaurante.registro_usuario USING btree (rol);
 #   DROP INDEX restaurante.fki_fk_rol;
       restaurante         postgres    false    204                       1259    25217    fki_fk_rolProducto    INDEX     S   CREATE INDEX "fki_fk_rolProducto" ON restaurante.producto USING btree (categoria);
 -   DROP INDEX restaurante."fki_fk_rolProducto";
       restaurante         postgres    false    198                       1259    25218    fki_fk_subRProducto    INDEX     W   CREATE INDEX "fki_fk_subRProducto" ON restaurante.producto USING btree (subcategoria);
 .   DROP INDEX restaurante."fki_fk_subRProducto";
       restaurante         postgres    false    198            (           1259    25219    fki_fk_subcategoria    INDEX     [   CREATE INDEX fki_fk_subcategoria ON restaurante.sub_rol_categoria USING btree (categoria);
 ,   DROP INDEX restaurante.fki_fk_subcategoria;
       restaurante         postgres    false    210            ?           1259    25418    fki_mesa    INDEX     N   CREATE INDEX fki_mesa ON restaurante.pedido_mesero USING btree (numero_mesa);
 !   DROP INDEX restaurante.fki_mesa;
       restaurante         postgres    false    232            S           2620    25491 0   registro_usuario tg_restaurante_registro_usuario    TRIGGER     �   CREATE TRIGGER tg_restaurante_registro_usuario AFTER INSERT OR DELETE OR UPDATE ON restaurante.registro_usuario FOR EACH ROW EXECUTE PROCEDURE security.f_log_auditoria();
 N   DROP TRIGGER tg_restaurante_registro_usuario ON restaurante.registro_usuario;
       restaurante       postgres    false    238    204            M           2606    25220    sub_rol_categoria fk_cat    FK CONSTRAINT     �   ALTER TABLE ONLY restaurante.sub_rol_categoria
    ADD CONSTRAINT fk_cat FOREIGN KEY (categoria) REFERENCES restaurante.rol_categoria(id);
 G   ALTER TABLE ONLY restaurante.sub_rol_categoria DROP CONSTRAINT fk_cat;
       restaurante       postgres    false    2853    206    210            F           2606    25225    producto fk_cat    FK CONSTRAINT     �   ALTER TABLE ONLY restaurante.producto
    ADD CONSTRAINT fk_cat FOREIGN KEY (categoria) REFERENCES restaurante.rol_categoria(id);
 >   ALTER TABLE ONLY restaurante.producto DROP CONSTRAINT fk_cat;
       restaurante       postgres    false    206    198    2853            L           2606    25269    registro_usuario fk_estado    FK CONSTRAINT     �   ALTER TABLE ONLY restaurante.registro_usuario
    ADD CONSTRAINT fk_estado FOREIGN KEY (estado_id) REFERENCES restaurante.estado_registro(id);
 I   ALTER TABLE ONLY restaurante.registro_usuario DROP CONSTRAINT fk_estado;
       restaurante       postgres    false    2862    215    204            J           2606    25287    registro_empleado fk_estado    FK CONSTRAINT     �   ALTER TABLE ONLY restaurante.registro_empleado
    ADD CONSTRAINT fk_estado FOREIGN KEY (estado_id) REFERENCES restaurante.estado_registro(id);
 J   ALTER TABLE ONLY restaurante.registro_empleado DROP CONSTRAINT fk_estado;
       restaurante       postgres    false    215    2862    202            P           2606    25435    pedido fk_id_domicilio    FK CONSTRAINT     �   ALTER TABLE ONLY restaurante.pedido
    ADD CONSTRAINT fk_id_domicilio FOREIGN KEY (id_domicilio) REFERENCES restaurante.domiciliou(id);
 E   ALTER TABLE ONLY restaurante.pedido DROP CONSTRAINT fk_id_domicilio;
       restaurante       postgres    false    2872    220    224            N           2606    25424    pedido fk_id_usuario    FK CONSTRAINT     �   ALTER TABLE ONLY restaurante.pedido
    ADD CONSTRAINT fk_id_usuario FOREIGN KEY (id_usuario) REFERENCES restaurante.registro_usuario(id);
 C   ALTER TABLE ONLY restaurante.pedido DROP CONSTRAINT fk_id_usuario;
       restaurante       postgres    false    2851    220    204            Q           2606    25441    domiciliou fk_id_usuario    FK CONSTRAINT     �   ALTER TABLE ONLY restaurante.domiciliou
    ADD CONSTRAINT fk_id_usuario FOREIGN KEY (id_usuario) REFERENCES restaurante.registro_usuario(id);
 G   ALTER TABLE ONLY restaurante.domiciliou DROP CONSTRAINT fk_id_usuario;
       restaurante       postgres    false    2851    224    204            R           2606    25419    pedido_mesero fk_mesa    FK CONSTRAINT     �   ALTER TABLE ONLY restaurante.pedido_mesero
    ADD CONSTRAINT fk_mesa FOREIGN KEY (numero_mesa) REFERENCES restaurante.mesas(id);
 D   ALTER TABLE ONLY restaurante.pedido_mesero DROP CONSTRAINT fk_mesa;
       restaurante       postgres    false    232    230    2878            O           2606    25430    pedido fk_pago    FK CONSTRAINT     }   ALTER TABLE ONLY restaurante.pedido
    ADD CONSTRAINT fk_pago FOREIGN KEY (id_pago) REFERENCES restaurante.metodo_pago(id);
 =   ALTER TABLE ONLY restaurante.pedido DROP CONSTRAINT fk_pago;
       restaurante       postgres    false    2864    217    220            K           2606    25230    registro_usuario fk_rol    FK CONSTRAINT     �   ALTER TABLE ONLY restaurante.registro_usuario
    ADD CONSTRAINT fk_rol FOREIGN KEY (rol) REFERENCES restaurante.rol_login("Id_Rol");
 F   ALTER TABLE ONLY restaurante.registro_usuario DROP CONSTRAINT fk_rol;
       restaurante       postgres    false    204    2855    208            H           2606    25235    registro_administrador fk_rol    FK CONSTRAINT     �   ALTER TABLE ONLY restaurante.registro_administrador
    ADD CONSTRAINT fk_rol FOREIGN KEY (id_rol) REFERENCES restaurante.rol_login("Id_Rol");
 L   ALTER TABLE ONLY restaurante.registro_administrador DROP CONSTRAINT fk_rol;
       restaurante       postgres    false    2855    208    200            I           2606    25240    registro_empleado fk_rol    FK CONSTRAINT     �   ALTER TABLE ONLY restaurante.registro_empleado
    ADD CONSTRAINT fk_rol FOREIGN KEY (id_rol) REFERENCES restaurante.rol_login("Id_Rol");
 G   ALTER TABLE ONLY restaurante.registro_empleado DROP CONSTRAINT fk_rol;
       restaurante       postgres    false    208    2855    202            G           2606    25245    producto fk_sub    FK CONSTRAINT     �   ALTER TABLE ONLY restaurante.producto
    ADD CONSTRAINT fk_sub FOREIGN KEY (subcategoria) REFERENCES restaurante.sub_rol_categoria(id);
 >   ALTER TABLE ONLY restaurante.producto DROP CONSTRAINT fk_sub;
       restaurante       postgres    false    198    2858    210            �      x������ � �      �      x������ � �      �   �  x�œ;o�0�g�+,��<�c�R��R�&�J9�*�+]���א�*�*�P/��{��'��`�M$Б���Z�Ďg��5Dl�u�
0ρ2?O��:R=���h_��Kj��<�%Ic��XѬH"Z�V�ޱ�@��v��m*�pm�q��!����0���ȁ4�9[^дj\��w�q/X���)eo��i�d��a}�1˪����Jj���wS��U���X�]�������=oS�þ=�QϣKo0�:ڽҰ(Eu
��j{QL�6ЁeP�!y���h6�n��ڙDm^�ϡ6�]*b� 3��	�#cLzu(��yȧ	��ȶg縮�������.&���|��q���6�||ٹ�)�S�U.�t�p.p��y��k`�)��(ډ(      �   d  x��M��0���WD�w#{��[E�j/�r+�U6Xl��Tz���^;aI�	-R%��L�_ϣ��@@��Pc� ���h@tDp�EȹEl�e^�� �Q��a1�w���,�dS<�.CZ����ʬMY�x���&]��i�D?��5��q�h�(RT%)�xܞ�$��]L��̧b�R�7mnܩ�`���i�n���U�4�{���^iuk���� �M=�n���帽��YeZ���w�n��/I;=-��h�g�&�\���Q'~���^���?�W'k���s�{|��,�=��8���(���PG�!������d�kHDx�h��5p�5�\�@/9z�\�HJM�v�(9�4�\���~�i��L�P�C�񌈸
5�q_���2�� �Ԋ4p.og���t��-�Y"D�Cp �eI$�#�'O��)b�HuC���t�		`�C�F��(�%Gɝu�@�V�@�\u���t�I������� ���9h�����}��l�H���Y��6yݖe�N��@�����$.s�����{H0�N�e�=L�U�0H��gg�@�^ĺ!4��<�I ~���.���f{E�j!@�N/�;����h���      �   �   x�}�;�0��z}�����A6� :*Z��e���`G�\ܥ@���D�!g���'l=�e��dh���N�Z-ʐ,����ؘƨ������@���\���Ձ5�[��rí}��h����ǡ-U�n���F7C      �   0   x�3��HL���,IL��2�JM.-H-JL����2����@���qqq �4      �   X   x�U�+�0@�;Ş�t������@4%�(��f�3<mW/t�[b,�����t��{y��G���i�U�M(!��l~���Q�,�      �   1   x�3�tMKM.�,��2�I,JO-ITp.JM�,��2����&�b���� ���      �      x������ � �      �      x������ � �      �   7  x��ѱn�0���~�D؁4YCڪC$Ԭ,����6�}��i�!�X��}��C��R�0��+��$ �Y�AI�O���5)�U��H�]�������u娛ڑ�녙��鳇��'8Nv�����1�ƀ5�M8bC��N�1I����u=O'XLl�B����C�䰒�^~@� NLT�1����ީ �'�iL�΍F{��W��r��1��r�k��H�����_/=[~D������j�ϑ2��G�)bN�j��}wh;u�
��ś���($y���63X��_���/�w2qE��%c�����      �      x�3��HM.�/RpKL�L�S�H-J�RH��M,���+ q�L*3�����s93�B��F�&�������F��\F�^�E�
�y)E��
����@�|�Ks�af!�UPT�����Ű=... �."      �   h   x�]�;�0Cg�0����+�`	�_!�� $&����!GB:Ķ#�q��\:�'t c��g�>�Ba�Q�0�kX��}����$�Q�VS����1��G"�      �   7  x�]��n�0D��W�,��CG�4��ҺYK�Ȣ@����BI �!��,��Y��,W,���4�on0W�4��Q�a�n$h��2��4es�nH*{��|x#�L"ӹ v@�l��
e��P�@�(�2�~��6��!8���%Bo�Gcc��d/�|]Ͼ�)�QH<UZ?,+Bd����8oG�grf��9�塪� �O�N���<|'^w���(��ˉ�d;Ͳ�T+1�B`�e�
�e��F<D�w�w4�	.=��N���k�eϹ �Mu��&tH��]��J����<x7Z��䅊���$��o�w�v      �   T   x�e���0��s:�y:��A{ɧ_�L!%A b0�ȓq0���Vە��0a���epf)�lKߟ|eN�i�dD����1^0P      �   5   x�3�tN,�K�2�H-NNL��2�t-.HM�L��LIL�2�t,K-����� 0��      �   0   x�3�tL����,.)JL�/�2�t�-�I���9C�K�2�b���� (r�      �   A   x�3�J-�4�2�tN-J��L8}�8���9�2�)g@~NN>���{bNNf^"����� ���      �     x��V�n�0>;OQ���~l٧h�b�nǖo��IN�v�C��b��5�c;?]g�D��G�#)%t�T\V�Qb��J��J�b�K�����K�.1��0b�� ���rs��v�,��fJh�[�Bd���r%�ҍ.���\4�:��2�~O���!KH�,AsL���"�d�z�������0;�?�?����t��d�j��(w�rUF�H��ܗ�r1Ub'u�2J��5:-��e��B_���(�	��)�G�.ZSN�� ��Ѯ�Pe��@hE]N���6ٔ�����+n� Z���&i���C�nj|�Ԙ ��F!T��(+c�ĉ�z����e�/rsHN�e~r08�u(@"D<�Y���@�p�6�K=�}�=����o1׹Cύ�Gy>"�'Ň��x��"�#�<��COI���?n��eӄ���������TZ�P�zQ��ħ��u��^wg�o���K����z�f�Lo������Y���<e����t;?�O�?�7Gp��7 ��8v�׹y?����YBܹ���G��˷e����m
X�!�Gz�`�O�B�`����۪�v���¶짆}�����%�^�7�O'z��N�����;���\����h�%�3}bQ3DC��y���iV��u���ԭ;���UO�`�� �ɑ]�EB#F��
NB�~��;	o�b��ϟ����V�N�Z*��6�3�&o�p���$ '�Frx5�o� �L�y�s,���L� ����F @���     