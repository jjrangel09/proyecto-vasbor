PGDMP     '            	        x            proyectovasbor    11.7    11.7 Q    m           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                       false            n           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                       false            o           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                       false            p           1262    25136    proyectovasbor    DATABASE     �   CREATE DATABASE proyectovasbor WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'Spanish_Colombia.1252' LC_CTYPE = 'Spanish_Colombia.1252';
    DROP DATABASE proyectovasbor;
             postgres    false                        2615    25137    restaurante    SCHEMA        CREATE SCHEMA restaurante;
    DROP SCHEMA restaurante;
             postgres    false            �            1259    25252    carrito    TABLE     �   CREATE TABLE restaurante.carrito (
    id integer NOT NULL,
    usuario_id integer,
    producto_id integer,
    cantidad integer,
    fecha timestamp with time zone,
    precio integer
);
     DROP TABLE restaurante.carrito;
       restaurante         postgres    false    7            �            1259    25250    carrito_id_seq    SEQUENCE     �   CREATE SEQUENCE restaurante.carrito_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE restaurante.carrito_id_seq;
       restaurante       postgres    false    212    7            q           0    0    carrito_id_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE restaurante.carrito_id_seq OWNED BY restaurante.carrito.id;
            restaurante       postgres    false    211            �            1259    25260    estado_registro    TABLE     e   CREATE TABLE restaurante.estado_registro (
    id integer NOT NULL,
    descripcion text NOT NULL
);
 (   DROP TABLE restaurante.estado_registro;
       restaurante         postgres    false    7            �            1259    25258    estado_registro_id_seq    SEQUENCE     �   CREATE SEQUENCE restaurante.estado_registro_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 2   DROP SEQUENCE restaurante.estado_registro_id_seq;
       restaurante       postgres    false    214    7            r           0    0    estado_registro_id_seq    SEQUENCE OWNED BY     [   ALTER SEQUENCE restaurante.estado_registro_id_seq OWNED BY restaurante.estado_registro.id;
            restaurante       postgres    false    213            �            1259    25138    producto    TABLE       CREATE TABLE restaurante.producto (
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
       restaurante         postgres    false    7            �            1259    25144    producto_id_seq    SEQUENCE     �   CREATE SEQUENCE restaurante.producto_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE restaurante.producto_id_seq;
       restaurante       postgres    false    197    7            s           0    0    producto_id_seq    SEQUENCE OWNED BY     M   ALTER SEQUENCE restaurante.producto_id_seq OWNED BY restaurante.producto.id;
            restaurante       postgres    false    198            �            1259    25146    registro_administrador    TABLE     �   CREATE TABLE restaurante.registro_administrador (
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
       restaurante         postgres    false    7            �            1259    25152    registro_administrador_id_seq    SEQUENCE     �   CREATE SEQUENCE restaurante.registro_administrador_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 9   DROP SEQUENCE restaurante.registro_administrador_id_seq;
       restaurante       postgres    false    7    199            t           0    0    registro_administrador_id_seq    SEQUENCE OWNED BY     i   ALTER SEQUENCE restaurante.registro_administrador_id_seq OWNED BY restaurante.registro_administrador.id;
            restaurante       postgres    false    200            �            1259    25154    registro_empleado    TABLE     �   CREATE TABLE restaurante.registro_empleado (
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
       restaurante         postgres    false    7            �            1259    25160    registro_empleado_id_seq    SEQUENCE     �   CREATE SEQUENCE restaurante.registro_empleado_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 4   DROP SEQUENCE restaurante.registro_empleado_id_seq;
       restaurante       postgres    false    7    201            u           0    0    registro_empleado_id_seq    SEQUENCE OWNED BY     _   ALTER SEQUENCE restaurante.registro_empleado_id_seq OWNED BY restaurante.registro_empleado.id;
            restaurante       postgres    false    202            �            1259    25162    registro_usuario    TABLE     ]  CREATE TABLE restaurante.registro_usuario (
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
    session text
);
 )   DROP TABLE restaurante.registro_usuario;
       restaurante         postgres    false    7            �            1259    25169    registro_usuario_id_seq    SEQUENCE     �   CREATE SEQUENCE restaurante.registro_usuario_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 3   DROP SEQUENCE restaurante.registro_usuario_id_seq;
       restaurante       postgres    false    7    203            v           0    0    registro_usuario_id_seq    SEQUENCE OWNED BY     ]   ALTER SEQUENCE restaurante.registro_usuario_id_seq OWNED BY restaurante.registro_usuario.id;
            restaurante       postgres    false    204            �            1259    25171    rol_categoria    TABLE     W   CREATE TABLE restaurante.rol_categoria (
    id bigint NOT NULL,
    categoria text
);
 &   DROP TABLE restaurante.rol_categoria;
       restaurante         postgres    false    7            �            1259    25177    rol_categoria_id_seq    SEQUENCE     �   CREATE SEQUENCE restaurante.rol_categoria_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 0   DROP SEQUENCE restaurante.rol_categoria_id_seq;
       restaurante       postgres    false    7    205            w           0    0    rol_categoria_id_seq    SEQUENCE OWNED BY     W   ALTER SEQUENCE restaurante.rol_categoria_id_seq OWNED BY restaurante.rol_categoria.id;
            restaurante       postgres    false    206            �            1259    25179 	   rol_login    TABLE     b   CREATE TABLE restaurante.rol_login (
    "Id_Rol" integer NOT NULL,
    "Descripcion_Rol" text
);
 "   DROP TABLE restaurante.rol_login;
       restaurante         postgres    false    7            �            1259    25185    rol_login_Id_Rol_seq    SEQUENCE     �   CREATE SEQUENCE restaurante."rol_login_Id_Rol_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 2   DROP SEQUENCE restaurante."rol_login_Id_Rol_seq";
       restaurante       postgres    false    207    7            x           0    0    rol_login_Id_Rol_seq    SEQUENCE OWNED BY     [   ALTER SEQUENCE restaurante."rol_login_Id_Rol_seq" OWNED BY restaurante.rol_login."Id_Rol";
            restaurante       postgres    false    208            �            1259    25187    sub_rol_categoria    TABLE     t   CREATE TABLE restaurante.sub_rol_categoria (
    id bigint NOT NULL,
    subcategoria text,
    categoria bigint
);
 *   DROP TABLE restaurante.sub_rol_categoria;
       restaurante         postgres    false    7            �            1259    25193    sub_rol_categoria_id_seq    SEQUENCE     �   CREATE SEQUENCE restaurante.sub_rol_categoria_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 4   DROP SEQUENCE restaurante.sub_rol_categoria_id_seq;
       restaurante       postgres    false    209    7            y           0    0    sub_rol_categoria_id_seq    SEQUENCE OWNED BY     _   ALTER SEQUENCE restaurante.sub_rol_categoria_id_seq OWNED BY restaurante.sub_rol_categoria.id;
            restaurante       postgres    false    210            �
           2604    25255 
   carrito id    DEFAULT     r   ALTER TABLE ONLY restaurante.carrito ALTER COLUMN id SET DEFAULT nextval('restaurante.carrito_id_seq'::regclass);
 >   ALTER TABLE restaurante.carrito ALTER COLUMN id DROP DEFAULT;
       restaurante       postgres    false    212    211    212            �
           2604    25263    estado_registro id    DEFAULT     �   ALTER TABLE ONLY restaurante.estado_registro ALTER COLUMN id SET DEFAULT nextval('restaurante.estado_registro_id_seq'::regclass);
 F   ALTER TABLE restaurante.estado_registro ALTER COLUMN id DROP DEFAULT;
       restaurante       postgres    false    213    214    214            �
           2604    25195    producto id    DEFAULT     t   ALTER TABLE ONLY restaurante.producto ALTER COLUMN id SET DEFAULT nextval('restaurante.producto_id_seq'::regclass);
 ?   ALTER TABLE restaurante.producto ALTER COLUMN id DROP DEFAULT;
       restaurante       postgres    false    198    197            �
           2604    25196    registro_administrador id    DEFAULT     �   ALTER TABLE ONLY restaurante.registro_administrador ALTER COLUMN id SET DEFAULT nextval('restaurante.registro_administrador_id_seq'::regclass);
 M   ALTER TABLE restaurante.registro_administrador ALTER COLUMN id DROP DEFAULT;
       restaurante       postgres    false    200    199            �
           2604    25197    registro_empleado id    DEFAULT     �   ALTER TABLE ONLY restaurante.registro_empleado ALTER COLUMN id SET DEFAULT nextval('restaurante.registro_empleado_id_seq'::regclass);
 H   ALTER TABLE restaurante.registro_empleado ALTER COLUMN id DROP DEFAULT;
       restaurante       postgres    false    202    201            �
           2604    25198    registro_usuario id    DEFAULT     �   ALTER TABLE ONLY restaurante.registro_usuario ALTER COLUMN id SET DEFAULT nextval('restaurante.registro_usuario_id_seq'::regclass);
 G   ALTER TABLE restaurante.registro_usuario ALTER COLUMN id DROP DEFAULT;
       restaurante       postgres    false    204    203            �
           2604    25199    rol_categoria id    DEFAULT     ~   ALTER TABLE ONLY restaurante.rol_categoria ALTER COLUMN id SET DEFAULT nextval('restaurante.rol_categoria_id_seq'::regclass);
 D   ALTER TABLE restaurante.rol_categoria ALTER COLUMN id DROP DEFAULT;
       restaurante       postgres    false    206    205            �
           2604    25200    rol_login Id_Rol    DEFAULT     �   ALTER TABLE ONLY restaurante.rol_login ALTER COLUMN "Id_Rol" SET DEFAULT nextval('restaurante."rol_login_Id_Rol_seq"'::regclass);
 F   ALTER TABLE restaurante.rol_login ALTER COLUMN "Id_Rol" DROP DEFAULT;
       restaurante       postgres    false    208    207            �
           2604    25201    sub_rol_categoria id    DEFAULT     �   ALTER TABLE ONLY restaurante.sub_rol_categoria ALTER COLUMN id SET DEFAULT nextval('restaurante.sub_rol_categoria_id_seq'::regclass);
 H   ALTER TABLE restaurante.sub_rol_categoria ALTER COLUMN id DROP DEFAULT;
       restaurante       postgres    false    210    209            h          0    25252    carrito 
   TABLE DATA               \   COPY restaurante.carrito (id, usuario_id, producto_id, cantidad, fecha, precio) FROM stdin;
    restaurante       postgres    false    212   �`       j          0    25260    estado_registro 
   TABLE DATA               ?   COPY restaurante.estado_registro (id, descripcion) FROM stdin;
    restaurante       postgres    false    214   �`       Y          0    25138    producto 
   TABLE DATA               s   COPY restaurante.producto (id, nombre, categoria, subcategoria, precio, descripcion, imagen, cantidad) FROM stdin;
    restaurante       postgres    false    197   #a       [          0    25146    registro_administrador 
   TABLE DATA               |   COPY restaurante.registro_administrador (id, nombre, apellido, correo, username, clave, identificacion, id_rol) FROM stdin;
    restaurante       postgres    false    199   %b       ]          0    25154    registro_empleado 
   TABLE DATA                  COPY restaurante.registro_empleado (id, nombre, apellido, telefono, id_rol, id_codigo, username, clave, estado_id) FROM stdin;
    restaurante       postgres    false    201   �b       _          0    25162    registro_usuario 
   TABLE DATA               �   COPY restaurante.registro_usuario (id, identificacion, nombre, apellido, correo, username, "contraseña", telefono, rol, estado_id, token, vencimiento_token, session) FROM stdin;
    restaurante       postgres    false    203   Ac       a          0    25171    rol_categoria 
   TABLE DATA               ;   COPY restaurante.rol_categoria (id, categoria) FROM stdin;
    restaurante       postgres    false    205   d       c          0    25179 	   rol_login 
   TABLE DATA               E   COPY restaurante.rol_login ("Id_Rol", "Descripcion_Rol") FROM stdin;
    restaurante       postgres    false    207   ]d       e          0    25187    sub_rol_categoria 
   TABLE DATA               M   COPY restaurante.sub_rol_categoria (id, subcategoria, categoria) FROM stdin;
    restaurante       postgres    false    209   �d       z           0    0    carrito_id_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('restaurante.carrito_id_seq', 82, true);
            restaurante       postgres    false    211            {           0    0    estado_registro_id_seq    SEQUENCE SET     J   SELECT pg_catalog.setval('restaurante.estado_registro_id_seq', 1, false);
            restaurante       postgres    false    213            |           0    0    producto_id_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('restaurante.producto_id_seq', 19, true);
            restaurante       postgres    false    198            }           0    0    registro_administrador_id_seq    SEQUENCE SET     P   SELECT pg_catalog.setval('restaurante.registro_administrador_id_seq', 3, true);
            restaurante       postgres    false    200            ~           0    0    registro_empleado_id_seq    SEQUENCE SET     K   SELECT pg_catalog.setval('restaurante.registro_empleado_id_seq', 7, true);
            restaurante       postgres    false    202                       0    0    registro_usuario_id_seq    SEQUENCE SET     K   SELECT pg_catalog.setval('restaurante.registro_usuario_id_seq', 18, true);
            restaurante       postgres    false    204            �           0    0    rol_categoria_id_seq    SEQUENCE SET     G   SELECT pg_catalog.setval('restaurante.rol_categoria_id_seq', 5, true);
            restaurante       postgres    false    206            �           0    0    rol_login_Id_Rol_seq    SEQUENCE SET     J   SELECT pg_catalog.setval('restaurante."rol_login_Id_Rol_seq"', 1, false);
            restaurante       postgres    false    208            �           0    0    sub_rol_categoria_id_seq    SEQUENCE SET     K   SELECT pg_catalog.setval('restaurante.sub_rol_categoria_id_seq', 7, true);
            restaurante       postgres    false    210            �
           2606    25268 $   estado_registro estado_registro_pkey 
   CONSTRAINT     g   ALTER TABLE ONLY restaurante.estado_registro
    ADD CONSTRAINT estado_registro_pkey PRIMARY KEY (id);
 S   ALTER TABLE ONLY restaurante.estado_registro DROP CONSTRAINT estado_registro_pkey;
       restaurante         postgres    false    214            �
           2606    25257    carrito pk_carrito 
   CONSTRAINT     U   ALTER TABLE ONLY restaurante.carrito
    ADD CONSTRAINT pk_carrito PRIMARY KEY (id);
 A   ALTER TABLE ONLY restaurante.carrito DROP CONSTRAINT pk_carrito;
       restaurante         postgres    false    212            �
           2606    25203    producto producto_pkey 
   CONSTRAINT     Y   ALTER TABLE ONLY restaurante.producto
    ADD CONSTRAINT producto_pkey PRIMARY KEY (id);
 E   ALTER TABLE ONLY restaurante.producto DROP CONSTRAINT producto_pkey;
       restaurante         postgres    false    197            �
           2606    25205 2   registro_administrador registro_administrador_pkey 
   CONSTRAINT     u   ALTER TABLE ONLY restaurante.registro_administrador
    ADD CONSTRAINT registro_administrador_pkey PRIMARY KEY (id);
 a   ALTER TABLE ONLY restaurante.registro_administrador DROP CONSTRAINT registro_administrador_pkey;
       restaurante         postgres    false    199            �
           2606    25207 (   registro_empleado registro_empleado_pkey 
   CONSTRAINT     k   ALTER TABLE ONLY restaurante.registro_empleado
    ADD CONSTRAINT registro_empleado_pkey PRIMARY KEY (id);
 W   ALTER TABLE ONLY restaurante.registro_empleado DROP CONSTRAINT registro_empleado_pkey;
       restaurante         postgres    false    201            �
           2606    25209 &   registro_usuario registro_usuario_pkey 
   CONSTRAINT     i   ALTER TABLE ONLY restaurante.registro_usuario
    ADD CONSTRAINT registro_usuario_pkey PRIMARY KEY (id);
 U   ALTER TABLE ONLY restaurante.registro_usuario DROP CONSTRAINT registro_usuario_pkey;
       restaurante         postgres    false    203            �
           2606    25211     rol_categoria rol_categoria_pkey 
   CONSTRAINT     c   ALTER TABLE ONLY restaurante.rol_categoria
    ADD CONSTRAINT rol_categoria_pkey PRIMARY KEY (id);
 O   ALTER TABLE ONLY restaurante.rol_categoria DROP CONSTRAINT rol_categoria_pkey;
       restaurante         postgres    false    205            �
           2606    25213    rol_login rol_login_pkey 
   CONSTRAINT     a   ALTER TABLE ONLY restaurante.rol_login
    ADD CONSTRAINT rol_login_pkey PRIMARY KEY ("Id_Rol");
 G   ALTER TABLE ONLY restaurante.rol_login DROP CONSTRAINT rol_login_pkey;
       restaurante         postgres    false    207            �
           2606    25215 (   sub_rol_categoria sub_rol_categoria_pkey 
   CONSTRAINT     k   ALTER TABLE ONLY restaurante.sub_rol_categoria
    ADD CONSTRAINT sub_rol_categoria_pkey PRIMARY KEY (id);
 W   ALTER TABLE ONLY restaurante.sub_rol_categoria DROP CONSTRAINT sub_rol_categoria_pkey;
       restaurante         postgres    false    209            �
           1259    25274    fki_fk_estado    INDEX     T   CREATE INDEX fki_fk_estado ON restaurante.registro_usuario USING btree (estado_id);
 &   DROP INDEX restaurante.fki_fk_estado;
       restaurante         postgres    false    203            �
           1259    25216 
   fki_fk_rol    INDEX     K   CREATE INDEX fki_fk_rol ON restaurante.registro_usuario USING btree (rol);
 #   DROP INDEX restaurante.fki_fk_rol;
       restaurante         postgres    false    203            �
           1259    25217    fki_fk_rolProducto    INDEX     S   CREATE INDEX "fki_fk_rolProducto" ON restaurante.producto USING btree (categoria);
 -   DROP INDEX restaurante."fki_fk_rolProducto";
       restaurante         postgres    false    197            �
           1259    25218    fki_fk_subRProducto    INDEX     W   CREATE INDEX "fki_fk_subRProducto" ON restaurante.producto USING btree (subcategoria);
 .   DROP INDEX restaurante."fki_fk_subRProducto";
       restaurante         postgres    false    197            �
           1259    25219    fki_fk_subcategoria    INDEX     [   CREATE INDEX fki_fk_subcategoria ON restaurante.sub_rol_categoria USING btree (categoria);
 ,   DROP INDEX restaurante.fki_fk_subcategoria;
       restaurante         postgres    false    209            �
           2606    25220    sub_rol_categoria fk_cat    FK CONSTRAINT     �   ALTER TABLE ONLY restaurante.sub_rol_categoria
    ADD CONSTRAINT fk_cat FOREIGN KEY (categoria) REFERENCES restaurante.rol_categoria(id);
 G   ALTER TABLE ONLY restaurante.sub_rol_categoria DROP CONSTRAINT fk_cat;
       restaurante       postgres    false    209    2766    205            �
           2606    25225    producto fk_cat    FK CONSTRAINT     �   ALTER TABLE ONLY restaurante.producto
    ADD CONSTRAINT fk_cat FOREIGN KEY (categoria) REFERENCES restaurante.rol_categoria(id);
 >   ALTER TABLE ONLY restaurante.producto DROP CONSTRAINT fk_cat;
       restaurante       postgres    false    2766    205    197            �
           2606    25269    registro_usuario fk_estado    FK CONSTRAINT     �   ALTER TABLE ONLY restaurante.registro_usuario
    ADD CONSTRAINT fk_estado FOREIGN KEY (estado_id) REFERENCES restaurante.estado_registro(id);
 I   ALTER TABLE ONLY restaurante.registro_usuario DROP CONSTRAINT fk_estado;
       restaurante       postgres    false    214    2775    203            �
           2606    25287    registro_empleado fk_estado    FK CONSTRAINT     �   ALTER TABLE ONLY restaurante.registro_empleado
    ADD CONSTRAINT fk_estado FOREIGN KEY (estado_id) REFERENCES restaurante.estado_registro(id);
 J   ALTER TABLE ONLY restaurante.registro_empleado DROP CONSTRAINT fk_estado;
       restaurante       postgres    false    2775    201    214            �
           2606    25230    registro_usuario fk_rol    FK CONSTRAINT     �   ALTER TABLE ONLY restaurante.registro_usuario
    ADD CONSTRAINT fk_rol FOREIGN KEY (rol) REFERENCES restaurante.rol_login("Id_Rol");
 F   ALTER TABLE ONLY restaurante.registro_usuario DROP CONSTRAINT fk_rol;
       restaurante       postgres    false    203    2768    207            �
           2606    25235    registro_administrador fk_rol    FK CONSTRAINT     �   ALTER TABLE ONLY restaurante.registro_administrador
    ADD CONSTRAINT fk_rol FOREIGN KEY (id_rol) REFERENCES restaurante.rol_login("Id_Rol");
 L   ALTER TABLE ONLY restaurante.registro_administrador DROP CONSTRAINT fk_rol;
       restaurante       postgres    false    2768    207    199            �
           2606    25240    registro_empleado fk_rol    FK CONSTRAINT     �   ALTER TABLE ONLY restaurante.registro_empleado
    ADD CONSTRAINT fk_rol FOREIGN KEY (id_rol) REFERENCES restaurante.rol_login("Id_Rol");
 G   ALTER TABLE ONLY restaurante.registro_empleado DROP CONSTRAINT fk_rol;
       restaurante       postgres    false    2768    207    201            �
           2606    25245    producto fk_sub    FK CONSTRAINT     �   ALTER TABLE ONLY restaurante.producto
    ADD CONSTRAINT fk_sub FOREIGN KEY (subcategoria) REFERENCES restaurante.sub_rol_categoria(id);
 >   ALTER TABLE ONLY restaurante.producto DROP CONSTRAINT fk_sub;
       restaurante       postgres    false    2771    209    197            h   8   x����0�����.� �t�9�{^T(�f�K�Cm�����]�Hƿ"� �0�      j   0   x�3��HL���,IL��2�JM.-H-JL����2����@���qqq �4      Y   �   x�M��n�0���)�UH����S%4���A�4�������o���v��[O?�9�	4T�k�tta�F,;ǰ��?#�*�khIF�/�2~�]�P�^?Փqx&���K���e��b��xˎoK�!I-�Z@3�"4�y(���e	m��I�[e�9�P����AWQ{���L���=v��D�ɏ�Г�R!�����:��|?�땠���<��]Φ.���rr�g߻,�� v#      [      x�3��HM.�/RpKL�L�S�H-J�RH��M,���+ q�L*3�����s93�B��F�&�������F��\F�^�E�
�y)E��
����@�|�Ks�af!�UPT�����Ű=... �."      ]   }   x�u���0E��Sd���$C 1 �FT)�Q�'Q�J8=�zςϲ�^w�)��1O/�X|����>������C��\��G���νJ;�j1����mn[���2�Yb����҉��[����E(5/      _   �   x�=��n�0D����v�LN�-�T�z�ŉ,�dpd�!|}���F��̼6`j��mE�79�'�}7gW\R�G��[d��|w����7�9���խ���	!����B������J�i컧���1O��}��m
��˛c����K���̂�����/���P>�[��Ӆ���K���-.�<�����|#��R�SG�      a   5   x�3�tN,�K�2�H-NNL��2�t-.HM�L��LIL�2�t,K-����� 0��      c   0   x�3�tL����,.)JL�/�2�t�-�I���9C�K�2�b���� (r�      e   A   x�3�J-�4�2�tN-J��L8}�8���9�2�)g@~NN>���{bNNf^"����� ���     