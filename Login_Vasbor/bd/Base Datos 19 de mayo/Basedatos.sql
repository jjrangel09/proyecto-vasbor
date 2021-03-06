PGDMP                          x            proyectovasbor    11.7    11.7 �    �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                       false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                       false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                       false            �           1262    25136    proyectovasbor    DATABASE     �   CREATE DATABASE proyectovasbor WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'Spanish_Colombia.1252' LC_CTYPE = 'Spanish_Colombia.1252';
    DROP DATABASE proyectovasbor;
             postgres    false                        2615    25137    restaurante    SCHEMA        CREATE SCHEMA restaurante;
    DROP SCHEMA restaurante;
             postgres    false            �            1259    25316 	   domicilio    TABLE     .  CREATE TABLE restaurante.domicilio (
    id bigint NOT NULL,
    direccion text,
    telefono bigint,
    descripcion text,
    total bigint,
    num_productos integer,
    id_usuario integer,
    fecha timestamp with time zone,
    pago integer,
    tipo_domicilio integer,
    producto_id integer
);
 "   DROP TABLE restaurante.domicilio;
       restaurante         postgres    false    7            �            1259    25314    Domicilio_id_seq    SEQUENCE     �   CREATE SEQUENCE restaurante."Domicilio_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE restaurante."Domicilio_id_seq";
       restaurante       postgres    false    7    220            �           0    0    Domicilio_id_seq    SEQUENCE OWNED BY     Q   ALTER SEQUENCE restaurante."Domicilio_id_seq" OWNED BY restaurante.domicilio.id;
            restaurante       postgres    false    219            �            1259    25252    carrito    TABLE     �   CREATE TABLE restaurante.carrito (
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
       restaurante       postgres    false    212    7            �           0    0    carrito_id_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE restaurante.carrito_id_seq OWNED BY restaurante.carrito.id;
            restaurante       postgres    false    211            �            1259    25375    detalle_pedido    TABLE     �   CREATE TABLE restaurante.detalle_pedido (
    id bigint NOT NULL,
    id_pedido integer,
    cantidad integer,
    total bigint,
    fecha timestamp with time zone,
    id_usuario integer
);
 '   DROP TABLE restaurante.detalle_pedido;
       restaurante         postgres    false    7            �            1259    25373    detalle_pedido_id_seq    SEQUENCE     �   CREATE SEQUENCE restaurante.detalle_pedido_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 1   DROP SEQUENCE restaurante.detalle_pedido_id_seq;
       restaurante       postgres    false    229    7            �           0    0    detalle_pedido_id_seq    SEQUENCE OWNED BY     Y   ALTER SEQUENCE restaurante.detalle_pedido_id_seq OWNED BY restaurante.detalle_pedido.id;
            restaurante       postgres    false    228            �            1259    25363 
   domiciliou    TABLE     �   CREATE TABLE restaurante.domiciliou (
    id bigint NOT NULL,
    id_usuario bigint NOT NULL,
    direccion text,
    pais text,
    ciudad text,
    codigop integer
);
 #   DROP TABLE restaurante.domiciliou;
       restaurante         postgres    false    7            �            1259    25359    domiciliou_id_seq    SEQUENCE        CREATE SEQUENCE restaurante.domiciliou_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE restaurante.domiciliou_id_seq;
       restaurante       postgres    false    7    227            �           0    0    domiciliou_id_seq    SEQUENCE OWNED BY     Q   ALTER SEQUENCE restaurante.domiciliou_id_seq OWNED BY restaurante.domiciliou.id;
            restaurante       postgres    false    225            �            1259    25361    domiciliou_id_usuario_seq    SEQUENCE     �   CREATE SEQUENCE restaurante.domiciliou_id_usuario_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 5   DROP SEQUENCE restaurante.domiciliou_id_usuario_seq;
       restaurante       postgres    false    7    227            �           0    0    domiciliou_id_usuario_seq    SEQUENCE OWNED BY     a   ALTER SEQUENCE restaurante.domiciliou_id_usuario_seq OWNED BY restaurante.domiciliou.id_usuario;
            restaurante       postgres    false    226            �            1259    25305    estado_domicilio    TABLE     X   CREATE TABLE restaurante.estado_domicilio (
    id integer NOT NULL,
    estado text
);
 )   DROP TABLE restaurante.estado_domicilio;
       restaurante         postgres    false    7            �            1259    25303    estado_domicilio_id_seq    SEQUENCE     �   CREATE SEQUENCE restaurante.estado_domicilio_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 3   DROP SEQUENCE restaurante.estado_domicilio_id_seq;
       restaurante       postgres    false    218    7            �           0    0    estado_domicilio_id_seq    SEQUENCE OWNED BY     ]   ALTER SEQUENCE restaurante.estado_domicilio_id_seq OWNED BY restaurante.estado_domicilio.id;
            restaurante       postgres    false    217            �            1259    25260    estado_registro    TABLE     e   CREATE TABLE restaurante.estado_registro (
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
       restaurante       postgres    false    214    7            �           0    0    estado_registro_id_seq    SEQUENCE OWNED BY     [   ALTER SEQUENCE restaurante.estado_registro_id_seq OWNED BY restaurante.estado_registro.id;
            restaurante       postgres    false    213            �            1259    25294    metodo_pago    TABLE     X   CREATE TABLE restaurante.metodo_pago (
    id integer NOT NULL,
    descripcion text
);
 $   DROP TABLE restaurante.metodo_pago;
       restaurante         postgres    false    7            �            1259    25292    metodo_pago_id_seq    SEQUENCE     �   CREATE SEQUENCE restaurante.metodo_pago_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE restaurante.metodo_pago_id_seq;
       restaurante       postgres    false    7    216            �           0    0    metodo_pago_id_seq    SEQUENCE OWNED BY     S   ALTER SEQUENCE restaurante.metodo_pago_id_seq OWNED BY restaurante.metodo_pago.id;
            restaurante       postgres    false    215            �            1259    25348    pedido    TABLE     �   CREATE TABLE restaurante.pedido (
    id bigint NOT NULL,
    id_usuario integer,
    id_pago integer,
    id_domicilio integer,
    total bigint,
    fecha timestamp with time zone
);
    DROP TABLE restaurante.pedido;
       restaurante         postgres    false    7            �            1259    25351    pedido_id_seq    SEQUENCE     {   CREATE SEQUENCE restaurante.pedido_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE restaurante.pedido_id_seq;
       restaurante       postgres    false    223    7            �           0    0    pedido_id_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE restaurante.pedido_id_seq OWNED BY restaurante.pedido.id;
            restaurante       postgres    false    224            �            1259    25138    producto    TABLE       CREATE TABLE restaurante.producto (
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
       restaurante       postgres    false    197    7            �           0    0    producto_id_seq    SEQUENCE OWNED BY     M   ALTER SEQUENCE restaurante.producto_id_seq OWNED BY restaurante.producto.id;
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
       restaurante       postgres    false    7    199            �           0    0    registro_administrador_id_seq    SEQUENCE OWNED BY     i   ALTER SEQUENCE restaurante.registro_administrador_id_seq OWNED BY restaurante.registro_administrador.id;
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
       restaurante       postgres    false    201    7            �           0    0    registro_empleado_id_seq    SEQUENCE OWNED BY     _   ALTER SEQUENCE restaurante.registro_empleado_id_seq OWNED BY restaurante.registro_empleado.id;
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
       restaurante       postgres    false    203    7            �           0    0    registro_usuario_id_seq    SEQUENCE OWNED BY     ]   ALTER SEQUENCE restaurante.registro_usuario_id_seq OWNED BY restaurante.registro_usuario.id;
            restaurante       postgres    false    204            �            1259    25337    reporte_monetario    TABLE     �   CREATE TABLE restaurante.reporte_monetario (
    id bigint NOT NULL,
    id_persona bigint,
    total bigint,
    fecha timestamp with time zone
);
 *   DROP TABLE restaurante.reporte_monetario;
       restaurante         postgres    false    7            �            1259    25340    reporte_monetario_id_seq    SEQUENCE     �   CREATE SEQUENCE restaurante.reporte_monetario_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 4   DROP SEQUENCE restaurante.reporte_monetario_id_seq;
       restaurante       postgres    false    221    7            �           0    0    reporte_monetario_id_seq    SEQUENCE OWNED BY     _   ALTER SEQUENCE restaurante.reporte_monetario_id_seq OWNED BY restaurante.reporte_monetario.id;
            restaurante       postgres    false    222            �            1259    25171    rol_categoria    TABLE     W   CREATE TABLE restaurante.rol_categoria (
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
       restaurante       postgres    false    7    205            �           0    0    rol_categoria_id_seq    SEQUENCE OWNED BY     W   ALTER SEQUENCE restaurante.rol_categoria_id_seq OWNED BY restaurante.rol_categoria.id;
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
       restaurante       postgres    false    7    207            �           0    0    rol_login_Id_Rol_seq    SEQUENCE OWNED BY     [   ALTER SEQUENCE restaurante."rol_login_Id_Rol_seq" OWNED BY restaurante.rol_login."Id_Rol";
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
       restaurante       postgres    false    7    209            �           0    0    sub_rol_categoria_id_seq    SEQUENCE OWNED BY     _   ALTER SEQUENCE restaurante.sub_rol_categoria_id_seq OWNED BY restaurante.sub_rol_categoria.id;
            restaurante       postgres    false    210            �
           2604    25255 
   carrito id    DEFAULT     r   ALTER TABLE ONLY restaurante.carrito ALTER COLUMN id SET DEFAULT nextval('restaurante.carrito_id_seq'::regclass);
 >   ALTER TABLE restaurante.carrito ALTER COLUMN id DROP DEFAULT;
       restaurante       postgres    false    212    211    212            �
           2604    25378    detalle_pedido id    DEFAULT     �   ALTER TABLE ONLY restaurante.detalle_pedido ALTER COLUMN id SET DEFAULT nextval('restaurante.detalle_pedido_id_seq'::regclass);
 E   ALTER TABLE restaurante.detalle_pedido ALTER COLUMN id DROP DEFAULT;
       restaurante       postgres    false    229    228    229            �
           2604    25319    domicilio id    DEFAULT     x   ALTER TABLE ONLY restaurante.domicilio ALTER COLUMN id SET DEFAULT nextval('restaurante."Domicilio_id_seq"'::regclass);
 @   ALTER TABLE restaurante.domicilio ALTER COLUMN id DROP DEFAULT;
       restaurante       postgres    false    219    220    220            �
           2604    25366    domiciliou id    DEFAULT     x   ALTER TABLE ONLY restaurante.domiciliou ALTER COLUMN id SET DEFAULT nextval('restaurante.domiciliou_id_seq'::regclass);
 A   ALTER TABLE restaurante.domiciliou ALTER COLUMN id DROP DEFAULT;
       restaurante       postgres    false    225    227    227            �
           2604    25367    domiciliou id_usuario    DEFAULT     �   ALTER TABLE ONLY restaurante.domiciliou ALTER COLUMN id_usuario SET DEFAULT nextval('restaurante.domiciliou_id_usuario_seq'::regclass);
 I   ALTER TABLE restaurante.domiciliou ALTER COLUMN id_usuario DROP DEFAULT;
       restaurante       postgres    false    226    227    227            �
           2604    25308    estado_domicilio id    DEFAULT     �   ALTER TABLE ONLY restaurante.estado_domicilio ALTER COLUMN id SET DEFAULT nextval('restaurante.estado_domicilio_id_seq'::regclass);
 G   ALTER TABLE restaurante.estado_domicilio ALTER COLUMN id DROP DEFAULT;
       restaurante       postgres    false    217    218    218            �
           2604    25263    estado_registro id    DEFAULT     �   ALTER TABLE ONLY restaurante.estado_registro ALTER COLUMN id SET DEFAULT nextval('restaurante.estado_registro_id_seq'::regclass);
 F   ALTER TABLE restaurante.estado_registro ALTER COLUMN id DROP DEFAULT;
       restaurante       postgres    false    213    214    214            �
           2604    25297    metodo_pago id    DEFAULT     z   ALTER TABLE ONLY restaurante.metodo_pago ALTER COLUMN id SET DEFAULT nextval('restaurante.metodo_pago_id_seq'::regclass);
 B   ALTER TABLE restaurante.metodo_pago ALTER COLUMN id DROP DEFAULT;
       restaurante       postgres    false    216    215    216            �
           2604    25353 	   pedido id    DEFAULT     p   ALTER TABLE ONLY restaurante.pedido ALTER COLUMN id SET DEFAULT nextval('restaurante.pedido_id_seq'::regclass);
 =   ALTER TABLE restaurante.pedido ALTER COLUMN id DROP DEFAULT;
       restaurante       postgres    false    224    223            �
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
           2604    25342    reporte_monetario id    DEFAULT     �   ALTER TABLE ONLY restaurante.reporte_monetario ALTER COLUMN id SET DEFAULT nextval('restaurante.reporte_monetario_id_seq'::regclass);
 H   ALTER TABLE restaurante.reporte_monetario ALTER COLUMN id DROP DEFAULT;
       restaurante       postgres    false    222    221            �
           2604    25199    rol_categoria id    DEFAULT     ~   ALTER TABLE ONLY restaurante.rol_categoria ALTER COLUMN id SET DEFAULT nextval('restaurante.rol_categoria_id_seq'::regclass);
 D   ALTER TABLE restaurante.rol_categoria ALTER COLUMN id DROP DEFAULT;
       restaurante       postgres    false    206    205            �
           2604    25200    rol_login Id_Rol    DEFAULT     �   ALTER TABLE ONLY restaurante.rol_login ALTER COLUMN "Id_Rol" SET DEFAULT nextval('restaurante."rol_login_Id_Rol_seq"'::regclass);
 F   ALTER TABLE restaurante.rol_login ALTER COLUMN "Id_Rol" DROP DEFAULT;
       restaurante       postgres    false    208    207            �
           2604    25201    sub_rol_categoria id    DEFAULT     �   ALTER TABLE ONLY restaurante.sub_rol_categoria ALTER COLUMN id SET DEFAULT nextval('restaurante.sub_rol_categoria_id_seq'::regclass);
 H   ALTER TABLE restaurante.sub_rol_categoria ALTER COLUMN id DROP DEFAULT;
       restaurante       postgres    false    210    209            �          0    25252    carrito 
   TABLE DATA               \   COPY restaurante.carrito (id, usuario_id, producto_id, cantidad, fecha, precio) FROM stdin;
    restaurante       postgres    false    212   ��       �          0    25375    detalle_pedido 
   TABLE DATA               `   COPY restaurante.detalle_pedido (id, id_pedido, cantidad, total, fecha, id_usuario) FROM stdin;
    restaurante       postgres    false    229   Т       �          0    25316 	   domicilio 
   TABLE DATA               �   COPY restaurante.domicilio (id, direccion, telefono, descripcion, total, num_productos, id_usuario, fecha, pago, tipo_domicilio, producto_id) FROM stdin;
    restaurante       postgres    false    220   �       �          0    25363 
   domiciliou 
   TABLE DATA               [   COPY restaurante.domiciliou (id, id_usuario, direccion, pais, ciudad, codigop) FROM stdin;
    restaurante       postgres    false    227   q�       �          0    25305    estado_domicilio 
   TABLE DATA               ;   COPY restaurante.estado_domicilio (id, estado) FROM stdin;
    restaurante       postgres    false    218   ��       �          0    25260    estado_registro 
   TABLE DATA               ?   COPY restaurante.estado_registro (id, descripcion) FROM stdin;
    restaurante       postgres    false    214   -�       �          0    25294    metodo_pago 
   TABLE DATA               ;   COPY restaurante.metodo_pago (id, descripcion) FROM stdin;
    restaurante       postgres    false    216   m�       �          0    25348    pedido 
   TABLE DATA               Z   COPY restaurante.pedido (id, id_usuario, id_pago, id_domicilio, total, fecha) FROM stdin;
    restaurante       postgres    false    223   ��       �          0    25138    producto 
   TABLE DATA               s   COPY restaurante.producto (id, nombre, categoria, subcategoria, precio, descripcion, imagen, cantidad) FROM stdin;
    restaurante       postgres    false    197   ˤ       �          0    25146    registro_administrador 
   TABLE DATA               |   COPY restaurante.registro_administrador (id, nombre, apellido, correo, username, clave, identificacion, id_rol) FROM stdin;
    restaurante       postgres    false    199   �       �          0    25154    registro_empleado 
   TABLE DATA                  COPY restaurante.registro_empleado (id, nombre, apellido, telefono, id_rol, id_codigo, username, clave, estado_id) FROM stdin;
    restaurante       postgres    false    201   s�       �          0    25162    registro_usuario 
   TABLE DATA               �   COPY restaurante.registro_usuario (id, identificacion, nombre, apellido, correo, username, "contraseña", telefono, rol, estado_id, token, vencimiento_token, session) FROM stdin;
    restaurante       postgres    false    203    �       �          0    25337    reporte_monetario 
   TABLE DATA               N   COPY restaurante.reporte_monetario (id, id_persona, total, fecha) FROM stdin;
    restaurante       postgres    false    221   ֧       �          0    25171    rol_categoria 
   TABLE DATA               ;   COPY restaurante.rol_categoria (id, categoria) FROM stdin;
    restaurante       postgres    false    205   :�       �          0    25179 	   rol_login 
   TABLE DATA               E   COPY restaurante.rol_login ("Id_Rol", "Descripcion_Rol") FROM stdin;
    restaurante       postgres    false    207   �       �          0    25187    sub_rol_categoria 
   TABLE DATA               M   COPY restaurante.sub_rol_categoria (id, subcategoria, categoria) FROM stdin;
    restaurante       postgres    false    209   ��       �           0    0    Domicilio_id_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('restaurante."Domicilio_id_seq"', 18, true);
            restaurante       postgres    false    219            �           0    0    carrito_id_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('restaurante.carrito_id_seq', 138, true);
            restaurante       postgres    false    211            �           0    0    detalle_pedido_id_seq    SEQUENCE SET     I   SELECT pg_catalog.setval('restaurante.detalle_pedido_id_seq', 21, true);
            restaurante       postgres    false    228            �           0    0    domiciliou_id_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('restaurante.domiciliou_id_seq', 11, true);
            restaurante       postgres    false    225            �           0    0    domiciliou_id_usuario_seq    SEQUENCE SET     M   SELECT pg_catalog.setval('restaurante.domiciliou_id_usuario_seq', 1, false);
            restaurante       postgres    false    226            �           0    0    estado_domicilio_id_seq    SEQUENCE SET     K   SELECT pg_catalog.setval('restaurante.estado_domicilio_id_seq', 1, false);
            restaurante       postgres    false    217            �           0    0    estado_registro_id_seq    SEQUENCE SET     J   SELECT pg_catalog.setval('restaurante.estado_registro_id_seq', 1, false);
            restaurante       postgres    false    213            �           0    0    metodo_pago_id_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('restaurante.metodo_pago_id_seq', 1, false);
            restaurante       postgres    false    215            �           0    0    pedido_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('restaurante.pedido_id_seq', 52, true);
            restaurante       postgres    false    224            �           0    0    producto_id_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('restaurante.producto_id_seq', 20, true);
            restaurante       postgres    false    198            �           0    0    registro_administrador_id_seq    SEQUENCE SET     P   SELECT pg_catalog.setval('restaurante.registro_administrador_id_seq', 3, true);
            restaurante       postgres    false    200            �           0    0    registro_empleado_id_seq    SEQUENCE SET     K   SELECT pg_catalog.setval('restaurante.registro_empleado_id_seq', 7, true);
            restaurante       postgres    false    202            �           0    0    registro_usuario_id_seq    SEQUENCE SET     K   SELECT pg_catalog.setval('restaurante.registro_usuario_id_seq', 18, true);
            restaurante       postgres    false    204            �           0    0    reporte_monetario_id_seq    SEQUENCE SET     K   SELECT pg_catalog.setval('restaurante.reporte_monetario_id_seq', 3, true);
            restaurante       postgres    false    222            �           0    0    rol_categoria_id_seq    SEQUENCE SET     G   SELECT pg_catalog.setval('restaurante.rol_categoria_id_seq', 5, true);
            restaurante       postgres    false    206            �           0    0    rol_login_Id_Rol_seq    SEQUENCE SET     J   SELECT pg_catalog.setval('restaurante."rol_login_Id_Rol_seq"', 1, false);
            restaurante       postgres    false    208            �           0    0    sub_rol_categoria_id_seq    SEQUENCE SET     K   SELECT pg_catalog.setval('restaurante.sub_rol_categoria_id_seq', 7, true);
            restaurante       postgres    false    210                       2606    25324    domicilio Domicilio_pkey 
   CONSTRAINT     ]   ALTER TABLE ONLY restaurante.domicilio
    ADD CONSTRAINT "Domicilio_pkey" PRIMARY KEY (id);
 I   ALTER TABLE ONLY restaurante.domicilio DROP CONSTRAINT "Domicilio_pkey";
       restaurante         postgres    false    220                       2606    25380 "   detalle_pedido detalle_pedido_pkey 
   CONSTRAINT     e   ALTER TABLE ONLY restaurante.detalle_pedido
    ADD CONSTRAINT detalle_pedido_pkey PRIMARY KEY (id);
 Q   ALTER TABLE ONLY restaurante.detalle_pedido DROP CONSTRAINT detalle_pedido_pkey;
       restaurante         postgres    false    229                       2606    25372    domiciliou domiciliou_pkey 
   CONSTRAINT     ]   ALTER TABLE ONLY restaurante.domiciliou
    ADD CONSTRAINT domiciliou_pkey PRIMARY KEY (id);
 I   ALTER TABLE ONLY restaurante.domiciliou DROP CONSTRAINT domiciliou_pkey;
       restaurante         postgres    false    227                       2606    25313 &   estado_domicilio estado_domicilio_pkey 
   CONSTRAINT     i   ALTER TABLE ONLY restaurante.estado_domicilio
    ADD CONSTRAINT estado_domicilio_pkey PRIMARY KEY (id);
 U   ALTER TABLE ONLY restaurante.estado_domicilio DROP CONSTRAINT estado_domicilio_pkey;
       restaurante         postgres    false    218                       2606    25268 $   estado_registro estado_registro_pkey 
   CONSTRAINT     g   ALTER TABLE ONLY restaurante.estado_registro
    ADD CONSTRAINT estado_registro_pkey PRIMARY KEY (id);
 S   ALTER TABLE ONLY restaurante.estado_registro DROP CONSTRAINT estado_registro_pkey;
       restaurante         postgres    false    214                       2606    25302    metodo_pago metodo_pago_pkey 
   CONSTRAINT     _   ALTER TABLE ONLY restaurante.metodo_pago
    ADD CONSTRAINT metodo_pago_pkey PRIMARY KEY (id);
 K   ALTER TABLE ONLY restaurante.metodo_pago DROP CONSTRAINT metodo_pago_pkey;
       restaurante         postgres    false    216                       2606    25358    pedido pedido_pkey 
   CONSTRAINT     U   ALTER TABLE ONLY restaurante.pedido
    ADD CONSTRAINT pedido_pkey PRIMARY KEY (id);
 A   ALTER TABLE ONLY restaurante.pedido DROP CONSTRAINT pedido_pkey;
       restaurante         postgres    false    223                       2606    25257    carrito pk_carrito 
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
       restaurante         postgres    false    199                        2606    25207 (   registro_empleado registro_empleado_pkey 
   CONSTRAINT     k   ALTER TABLE ONLY restaurante.registro_empleado
    ADD CONSTRAINT registro_empleado_pkey PRIMARY KEY (id);
 W   ALTER TABLE ONLY restaurante.registro_empleado DROP CONSTRAINT registro_empleado_pkey;
       restaurante         postgres    false    201                       2606    25209 &   registro_usuario registro_usuario_pkey 
   CONSTRAINT     i   ALTER TABLE ONLY restaurante.registro_usuario
    ADD CONSTRAINT registro_usuario_pkey PRIMARY KEY (id);
 U   ALTER TABLE ONLY restaurante.registro_usuario DROP CONSTRAINT registro_usuario_pkey;
       restaurante         postgres    false    203                       2606    25347 (   reporte_monetario reporte_monetario_pkey 
   CONSTRAINT     k   ALTER TABLE ONLY restaurante.reporte_monetario
    ADD CONSTRAINT reporte_monetario_pkey PRIMARY KEY (id);
 W   ALTER TABLE ONLY restaurante.reporte_monetario DROP CONSTRAINT reporte_monetario_pkey;
       restaurante         postgres    false    221                       2606    25211     rol_categoria rol_categoria_pkey 
   CONSTRAINT     c   ALTER TABLE ONLY restaurante.rol_categoria
    ADD CONSTRAINT rol_categoria_pkey PRIMARY KEY (id);
 O   ALTER TABLE ONLY restaurante.rol_categoria DROP CONSTRAINT rol_categoria_pkey;
       restaurante         postgres    false    205                       2606    25213    rol_login rol_login_pkey 
   CONSTRAINT     a   ALTER TABLE ONLY restaurante.rol_login
    ADD CONSTRAINT rol_login_pkey PRIMARY KEY ("Id_Rol");
 G   ALTER TABLE ONLY restaurante.rol_login DROP CONSTRAINT rol_login_pkey;
       restaurante         postgres    false    207                       2606    25215 (   sub_rol_categoria sub_rol_categoria_pkey 
   CONSTRAINT     k   ALTER TABLE ONLY restaurante.sub_rol_categoria
    ADD CONSTRAINT sub_rol_categoria_pkey PRIMARY KEY (id);
 W   ALTER TABLE ONLY restaurante.sub_rol_categoria DROP CONSTRAINT sub_rol_categoria_pkey;
       restaurante         postgres    false    209                       1259    25274    fki_fk_estado    INDEX     T   CREATE INDEX fki_fk_estado ON restaurante.registro_usuario USING btree (estado_id);
 &   DROP INDEX restaurante.fki_fk_estado;
       restaurante         postgres    false    203                       1259    25330    fki_fk_pago    INDEX     F   CREATE INDEX fki_fk_pago ON restaurante.domicilio USING btree (pago);
 $   DROP INDEX restaurante.fki_fk_pago;
       restaurante         postgres    false    220                       1259    25216 
   fki_fk_rol    INDEX     K   CREATE INDEX fki_fk_rol ON restaurante.registro_usuario USING btree (rol);
 #   DROP INDEX restaurante.fki_fk_rol;
       restaurante         postgres    false    203            �
           1259    25217    fki_fk_rolProducto    INDEX     S   CREATE INDEX "fki_fk_rolProducto" ON restaurante.producto USING btree (categoria);
 -   DROP INDEX restaurante."fki_fk_rolProducto";
       restaurante         postgres    false    197            �
           1259    25218    fki_fk_subRProducto    INDEX     W   CREATE INDEX "fki_fk_subRProducto" ON restaurante.producto USING btree (subcategoria);
 .   DROP INDEX restaurante."fki_fk_subRProducto";
       restaurante         postgres    false    197            	           1259    25219    fki_fk_subcategoria    INDEX     [   CREATE INDEX fki_fk_subcategoria ON restaurante.sub_rol_categoria USING btree (categoria);
 ,   DROP INDEX restaurante.fki_fk_subcategoria;
       restaurante         postgres    false    209                       1259    25336    fki_fk_tipod    INDEX     Q   CREATE INDEX fki_fk_tipod ON restaurante.domicilio USING btree (tipo_domicilio);
 %   DROP INDEX restaurante.fki_fk_tipod;
       restaurante         postgres    false    220            '           2606    25220    sub_rol_categoria fk_cat    FK CONSTRAINT     �   ALTER TABLE ONLY restaurante.sub_rol_categoria
    ADD CONSTRAINT fk_cat FOREIGN KEY (categoria) REFERENCES restaurante.rol_categoria(id);
 G   ALTER TABLE ONLY restaurante.sub_rol_categoria DROP CONSTRAINT fk_cat;
       restaurante       postgres    false    2822    205    209                        2606    25225    producto fk_cat    FK CONSTRAINT     �   ALTER TABLE ONLY restaurante.producto
    ADD CONSTRAINT fk_cat FOREIGN KEY (categoria) REFERENCES restaurante.rol_categoria(id);
 >   ALTER TABLE ONLY restaurante.producto DROP CONSTRAINT fk_cat;
       restaurante       postgres    false    197    205    2822            &           2606    25269    registro_usuario fk_estado    FK CONSTRAINT     �   ALTER TABLE ONLY restaurante.registro_usuario
    ADD CONSTRAINT fk_estado FOREIGN KEY (estado_id) REFERENCES restaurante.estado_registro(id);
 I   ALTER TABLE ONLY restaurante.registro_usuario DROP CONSTRAINT fk_estado;
       restaurante       postgres    false    214    2831    203            $           2606    25287    registro_empleado fk_estado    FK CONSTRAINT     �   ALTER TABLE ONLY restaurante.registro_empleado
    ADD CONSTRAINT fk_estado FOREIGN KEY (estado_id) REFERENCES restaurante.estado_registro(id);
 J   ALTER TABLE ONLY restaurante.registro_empleado DROP CONSTRAINT fk_estado;
       restaurante       postgres    false    2831    214    201            (           2606    25325    domicilio fk_pago    FK CONSTRAINT     }   ALTER TABLE ONLY restaurante.domicilio
    ADD CONSTRAINT fk_pago FOREIGN KEY (pago) REFERENCES restaurante.metodo_pago(id);
 @   ALTER TABLE ONLY restaurante.domicilio DROP CONSTRAINT fk_pago;
       restaurante       postgres    false    220    2833    216            %           2606    25230    registro_usuario fk_rol    FK CONSTRAINT     �   ALTER TABLE ONLY restaurante.registro_usuario
    ADD CONSTRAINT fk_rol FOREIGN KEY (rol) REFERENCES restaurante.rol_login("Id_Rol");
 F   ALTER TABLE ONLY restaurante.registro_usuario DROP CONSTRAINT fk_rol;
       restaurante       postgres    false    203    207    2824            "           2606    25235    registro_administrador fk_rol    FK CONSTRAINT     �   ALTER TABLE ONLY restaurante.registro_administrador
    ADD CONSTRAINT fk_rol FOREIGN KEY (id_rol) REFERENCES restaurante.rol_login("Id_Rol");
 L   ALTER TABLE ONLY restaurante.registro_administrador DROP CONSTRAINT fk_rol;
       restaurante       postgres    false    2824    207    199            #           2606    25240    registro_empleado fk_rol    FK CONSTRAINT     �   ALTER TABLE ONLY restaurante.registro_empleado
    ADD CONSTRAINT fk_rol FOREIGN KEY (id_rol) REFERENCES restaurante.rol_login("Id_Rol");
 G   ALTER TABLE ONLY restaurante.registro_empleado DROP CONSTRAINT fk_rol;
       restaurante       postgres    false    201    207    2824            !           2606    25245    producto fk_sub    FK CONSTRAINT     �   ALTER TABLE ONLY restaurante.producto
    ADD CONSTRAINT fk_sub FOREIGN KEY (subcategoria) REFERENCES restaurante.sub_rol_categoria(id);
 >   ALTER TABLE ONLY restaurante.producto DROP CONSTRAINT fk_sub;
       restaurante       postgres    false    197    2827    209            )           2606    25331    domicilio fk_tipod    FK CONSTRAINT     �   ALTER TABLE ONLY restaurante.domicilio
    ADD CONSTRAINT fk_tipod FOREIGN KEY (tipo_domicilio) REFERENCES restaurante.estado_domicilio(id);
 A   ALTER TABLE ONLY restaurante.domicilio DROP CONSTRAINT fk_tipod;
       restaurante       postgres    false    220    218    2835            �      x������ � �      �   7   x��A  �w������:��ga�e��ivήݬ�>�Q�Z�)��	
      �   J   x��1� �z�~ �{p��Fc�X���Dm'#l�1�y�FØ�o$!Hp:#�.�]��1ʧm�f�>�      �   |   x�3�44�LN,*J-JT0SPV0�55�t����M�L�tKLN,I,�,K�425605�2�4���*M�S(HL��ǧ�� dxayjQIei&����������+�*����\����``���=... ��6      �       x�3�t�+�L,�2�JM��J������ VC]      �   0   x�3��HL���,IL��2�JM.-H-JL����2����@���qqq �4      �   1   x�3�tMKM.�,��2�I,JO-ITp.JM�,��2����&�b���� ���      �      x������ � �      �   	  x�M�Mr�0F��>A�Bɶ�?��0eۍ .�q�F����vB�h'��YR^A��ɏ(Z�v��A��Аފ��^�����ޝF�e���'<�8j�#k(b�1�ÞX4d���h	��"�O���m�Uod����{r����L��@��R�mp^BVh���,�}��`���|��UE���<��P�Ћ���#�zRSjRkh�G�t&��s8V%�F�	|#��\fJ�;^zϣ�7����+C.�p��k�e�����      �      x�3��HM.�/RpKL�L�S�H-J�RH��M,���+ q�L*3�����s93�B��F�&�������F��\F�^�E�
�y)E��
����@�|�Ks�af!�UPT�����Ű=... �."      �   }   x�u���0E��Sd���$C 1 �FT)�Q�'Q�J8=�zςϲ�^w�)��1O/�X|����>������C��\��G���νJ;�j1����mn[���2�Yb����҉��[����E(5/      �   �   x�U����0���S�A�k&U�K��Iצ�DF2ld�"<}���Ni���v�a��o+�p�4�X�����9Kq�ԏq��s=���ҧ�D�����c�[����x@w`W�=V��mY�s���" �0O��^An��C�wys4���2�F�9ܿ4�G�a�X>�[��S��>qISUoi��ٵE�y-�1/3G�      �   T   x�e���0��s:�y:��A{ɧ_�L!%A b0�ȓq0���Vە��0a���epf)�lKߟ|eN�i�dD����1^0P      �   5   x�3�tN,�K�2�H-NNL��2�t-.HM�L��LIL�2�t,K-����� 0��      �   0   x�3�tL����,.)JL�/�2�t�-�I���9C�K�2�b���� (r�      �   A   x�3�J-�4�2�tN-J��L8}�8���9�2�)g@~NN>���{bNNf^"����� ���     