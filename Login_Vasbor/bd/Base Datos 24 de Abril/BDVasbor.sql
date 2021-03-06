PGDMP                         x            ProyectoVasborU    11.7    11.7 @    R           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                       false            S           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                       false            T           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                       false            U           1262    65718    ProyectoVasborU    DATABASE     �   CREATE DATABASE "ProyectoVasborU" WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'Spanish_Colombia.1252' LC_CTYPE = 'Spanish_Colombia.1252';
 !   DROP DATABASE "ProyectoVasborU";
             postgres    false                        2615    65719    restaurante    SCHEMA        CREATE SCHEMA restaurante;
    DROP SCHEMA restaurante;
             postgres    false            �            1259    65720    producto    TABLE       CREATE TABLE restaurante.producto (
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
       restaurante         postgres    false    4            �            1259    65726    producto_id_seq    SEQUENCE     �   CREATE SEQUENCE restaurante.producto_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE restaurante.producto_id_seq;
       restaurante       postgres    false    4    197            V           0    0    producto_id_seq    SEQUENCE OWNED BY     M   ALTER SEQUENCE restaurante.producto_id_seq OWNED BY restaurante.producto.id;
            restaurante       postgres    false    198            �            1259    65728    registro_administrador    TABLE       CREATE TABLE restaurante.registro_administrador (
    id integer NOT NULL,
    nombre text NOT NULL,
    apellido text NOT NULL,
    correo text NOT NULL,
    username text NOT NULL,
    clave text NOT NULL,
    identificacion bigint NOT NULL,
    id_rol integer NOT NULL
);
 /   DROP TABLE restaurante.registro_administrador;
       restaurante         postgres    false    4            �            1259    65734    registro_administrador_id_seq    SEQUENCE     �   CREATE SEQUENCE restaurante.registro_administrador_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 9   DROP SEQUENCE restaurante.registro_administrador_id_seq;
       restaurante       postgres    false    199    4            W           0    0    registro_administrador_id_seq    SEQUENCE OWNED BY     i   ALTER SEQUENCE restaurante.registro_administrador_id_seq OWNED BY restaurante.registro_administrador.id;
            restaurante       postgres    false    200            �            1259    65736    registro_empleado    TABLE       CREATE TABLE restaurante.registro_empleado (
    id bigint NOT NULL,
    nombre text NOT NULL,
    apellido text NOT NULL,
    telefono bigint NOT NULL,
    id_rol integer NOT NULL,
    id_codigo bigint NOT NULL,
    username text NOT NULL,
    clave text NOT NULL
);
 *   DROP TABLE restaurante.registro_empleado;
       restaurante         postgres    false    4            �            1259    65742    registro_empleado_id_seq    SEQUENCE     �   CREATE SEQUENCE restaurante.registro_empleado_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 4   DROP SEQUENCE restaurante.registro_empleado_id_seq;
       restaurante       postgres    false    201    4            X           0    0    registro_empleado_id_seq    SEQUENCE OWNED BY     _   ALTER SEQUENCE restaurante.registro_empleado_id_seq OWNED BY restaurante.registro_empleado.id;
            restaurante       postgres    false    202            �            1259    65744    registro_usuario    TABLE     E  CREATE TABLE restaurante.registro_usuario (
    id bigint NOT NULL,
    identificacion bigint NOT NULL,
    nombre text NOT NULL,
    apellido text NOT NULL,
    correo text NOT NULL,
    username text NOT NULL,
    "contraseña" text,
    telefono bigint,
    rol integer,
    estado_id integer DEFAULT 1,
    token text
);
 )   DROP TABLE restaurante.registro_usuario;
       restaurante         postgres    false    4            �            1259    65750    registro_usuario_id_seq    SEQUENCE     �   CREATE SEQUENCE restaurante.registro_usuario_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 3   DROP SEQUENCE restaurante.registro_usuario_id_seq;
       restaurante       postgres    false    4    203            Y           0    0    registro_usuario_id_seq    SEQUENCE OWNED BY     ]   ALTER SEQUENCE restaurante.registro_usuario_id_seq OWNED BY restaurante.registro_usuario.id;
            restaurante       postgres    false    204            �            1259    65752    rol_categoria    TABLE     W   CREATE TABLE restaurante.rol_categoria (
    id bigint NOT NULL,
    categoria text
);
 &   DROP TABLE restaurante.rol_categoria;
       restaurante         postgres    false    4            �            1259    65758    rol_categoria_id_seq    SEQUENCE     �   CREATE SEQUENCE restaurante.rol_categoria_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 0   DROP SEQUENCE restaurante.rol_categoria_id_seq;
       restaurante       postgres    false    205    4            Z           0    0    rol_categoria_id_seq    SEQUENCE OWNED BY     W   ALTER SEQUENCE restaurante.rol_categoria_id_seq OWNED BY restaurante.rol_categoria.id;
            restaurante       postgres    false    206            �            1259    65760 	   rol_login    TABLE     b   CREATE TABLE restaurante.rol_login (
    "Id_Rol" integer NOT NULL,
    "Descripcion_Rol" text
);
 "   DROP TABLE restaurante.rol_login;
       restaurante         postgres    false    4            �            1259    65766    rol_login_Id_Rol_seq    SEQUENCE     �   CREATE SEQUENCE restaurante."rol_login_Id_Rol_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 2   DROP SEQUENCE restaurante."rol_login_Id_Rol_seq";
       restaurante       postgres    false    207    4            [           0    0    rol_login_Id_Rol_seq    SEQUENCE OWNED BY     [   ALTER SEQUENCE restaurante."rol_login_Id_Rol_seq" OWNED BY restaurante.rol_login."Id_Rol";
            restaurante       postgres    false    208            �            1259    65768    sub_rol_categoria    TABLE     t   CREATE TABLE restaurante.sub_rol_categoria (
    id bigint NOT NULL,
    subcategoria text,
    categoria bigint
);
 *   DROP TABLE restaurante.sub_rol_categoria;
       restaurante         postgres    false    4            �            1259    65774    sub_rol_categoria_id_seq    SEQUENCE     �   CREATE SEQUENCE restaurante.sub_rol_categoria_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 4   DROP SEQUENCE restaurante.sub_rol_categoria_id_seq;
       restaurante       postgres    false    209    4            \           0    0    sub_rol_categoria_id_seq    SEQUENCE OWNED BY     _   ALTER SEQUENCE restaurante.sub_rol_categoria_id_seq OWNED BY restaurante.sub_rol_categoria.id;
            restaurante       postgres    false    210            �
           2604    65776    producto id    DEFAULT     t   ALTER TABLE ONLY restaurante.producto ALTER COLUMN id SET DEFAULT nextval('restaurante.producto_id_seq'::regclass);
 ?   ALTER TABLE restaurante.producto ALTER COLUMN id DROP DEFAULT;
       restaurante       postgres    false    198    197            �
           2604    65777    registro_administrador id    DEFAULT     �   ALTER TABLE ONLY restaurante.registro_administrador ALTER COLUMN id SET DEFAULT nextval('restaurante.registro_administrador_id_seq'::regclass);
 M   ALTER TABLE restaurante.registro_administrador ALTER COLUMN id DROP DEFAULT;
       restaurante       postgres    false    200    199            �
           2604    65778    registro_empleado id    DEFAULT     �   ALTER TABLE ONLY restaurante.registro_empleado ALTER COLUMN id SET DEFAULT nextval('restaurante.registro_empleado_id_seq'::regclass);
 H   ALTER TABLE restaurante.registro_empleado ALTER COLUMN id DROP DEFAULT;
       restaurante       postgres    false    202    201            �
           2604    65779    registro_usuario id    DEFAULT     �   ALTER TABLE ONLY restaurante.registro_usuario ALTER COLUMN id SET DEFAULT nextval('restaurante.registro_usuario_id_seq'::regclass);
 G   ALTER TABLE restaurante.registro_usuario ALTER COLUMN id DROP DEFAULT;
       restaurante       postgres    false    204    203            �
           2604    65780    rol_categoria id    DEFAULT     ~   ALTER TABLE ONLY restaurante.rol_categoria ALTER COLUMN id SET DEFAULT nextval('restaurante.rol_categoria_id_seq'::regclass);
 D   ALTER TABLE restaurante.rol_categoria ALTER COLUMN id DROP DEFAULT;
       restaurante       postgres    false    206    205            �
           2604    65781    rol_login Id_Rol    DEFAULT     �   ALTER TABLE ONLY restaurante.rol_login ALTER COLUMN "Id_Rol" SET DEFAULT nextval('restaurante."rol_login_Id_Rol_seq"'::regclass);
 F   ALTER TABLE restaurante.rol_login ALTER COLUMN "Id_Rol" DROP DEFAULT;
       restaurante       postgres    false    208    207            �
           2604    65782    sub_rol_categoria id    DEFAULT     �   ALTER TABLE ONLY restaurante.sub_rol_categoria ALTER COLUMN id SET DEFAULT nextval('restaurante.sub_rol_categoria_id_seq'::regclass);
 H   ALTER TABLE restaurante.sub_rol_categoria ALTER COLUMN id DROP DEFAULT;
       restaurante       postgres    false    210    209            B          0    65720    producto 
   TABLE DATA               s   COPY restaurante.producto (id, nombre, categoria, subcategoria, precio, descripcion, imagen, cantidad) FROM stdin;
    restaurante       postgres    false    197   �L       D          0    65728    registro_administrador 
   TABLE DATA               |   COPY restaurante.registro_administrador (id, nombre, apellido, correo, username, clave, identificacion, id_rol) FROM stdin;
    restaurante       postgres    false    199   �M       F          0    65736    registro_empleado 
   TABLE DATA               t   COPY restaurante.registro_empleado (id, nombre, apellido, telefono, id_rol, id_codigo, username, clave) FROM stdin;
    restaurante       postgres    false    201   3N       H          0    65744    registro_usuario 
   TABLE DATA               �   COPY restaurante.registro_usuario (id, identificacion, nombre, apellido, correo, username, "contraseña", telefono, rol, estado_id, token) FROM stdin;
    restaurante       postgres    false    203   �N       J          0    65752    rol_categoria 
   TABLE DATA               ;   COPY restaurante.rol_categoria (id, categoria) FROM stdin;
    restaurante       postgres    false    205   bO       L          0    65760 	   rol_login 
   TABLE DATA               E   COPY restaurante.rol_login ("Id_Rol", "Descripcion_Rol") FROM stdin;
    restaurante       postgres    false    207   �O       N          0    65768    sub_rol_categoria 
   TABLE DATA               M   COPY restaurante.sub_rol_categoria (id, subcategoria, categoria) FROM stdin;
    restaurante       postgres    false    209   �O       ]           0    0    producto_id_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('restaurante.producto_id_seq', 19, true);
            restaurante       postgres    false    198            ^           0    0    registro_administrador_id_seq    SEQUENCE SET     P   SELECT pg_catalog.setval('restaurante.registro_administrador_id_seq', 1, true);
            restaurante       postgres    false    200            _           0    0    registro_empleado_id_seq    SEQUENCE SET     K   SELECT pg_catalog.setval('restaurante.registro_empleado_id_seq', 1, true);
            restaurante       postgres    false    202            `           0    0    registro_usuario_id_seq    SEQUENCE SET     K   SELECT pg_catalog.setval('restaurante.registro_usuario_id_seq', 14, true);
            restaurante       postgres    false    204            a           0    0    rol_categoria_id_seq    SEQUENCE SET     G   SELECT pg_catalog.setval('restaurante.rol_categoria_id_seq', 5, true);
            restaurante       postgres    false    206            b           0    0    rol_login_Id_Rol_seq    SEQUENCE SET     J   SELECT pg_catalog.setval('restaurante."rol_login_Id_Rol_seq"', 1, false);
            restaurante       postgres    false    208            c           0    0    sub_rol_categoria_id_seq    SEQUENCE SET     K   SELECT pg_catalog.setval('restaurante.sub_rol_categoria_id_seq', 7, true);
            restaurante       postgres    false    210            �
           2606    65784    producto producto_pkey 
   CONSTRAINT     Y   ALTER TABLE ONLY restaurante.producto
    ADD CONSTRAINT producto_pkey PRIMARY KEY (id);
 E   ALTER TABLE ONLY restaurante.producto DROP CONSTRAINT producto_pkey;
       restaurante         postgres    false    197            �
           2606    65786 2   registro_administrador registro_administrador_pkey 
   CONSTRAINT     u   ALTER TABLE ONLY restaurante.registro_administrador
    ADD CONSTRAINT registro_administrador_pkey PRIMARY KEY (id);
 a   ALTER TABLE ONLY restaurante.registro_administrador DROP CONSTRAINT registro_administrador_pkey;
       restaurante         postgres    false    199            �
           2606    65788 (   registro_empleado registro_empleado_pkey 
   CONSTRAINT     k   ALTER TABLE ONLY restaurante.registro_empleado
    ADD CONSTRAINT registro_empleado_pkey PRIMARY KEY (id);
 W   ALTER TABLE ONLY restaurante.registro_empleado DROP CONSTRAINT registro_empleado_pkey;
       restaurante         postgres    false    201            �
           2606    65790 &   registro_usuario registro_usuario_pkey 
   CONSTRAINT     i   ALTER TABLE ONLY restaurante.registro_usuario
    ADD CONSTRAINT registro_usuario_pkey PRIMARY KEY (id);
 U   ALTER TABLE ONLY restaurante.registro_usuario DROP CONSTRAINT registro_usuario_pkey;
       restaurante         postgres    false    203            �
           2606    65792     rol_categoria rol_categoria_pkey 
   CONSTRAINT     c   ALTER TABLE ONLY restaurante.rol_categoria
    ADD CONSTRAINT rol_categoria_pkey PRIMARY KEY (id);
 O   ALTER TABLE ONLY restaurante.rol_categoria DROP CONSTRAINT rol_categoria_pkey;
       restaurante         postgres    false    205            �
           2606    65794    rol_login rol_login_pkey 
   CONSTRAINT     a   ALTER TABLE ONLY restaurante.rol_login
    ADD CONSTRAINT rol_login_pkey PRIMARY KEY ("Id_Rol");
 G   ALTER TABLE ONLY restaurante.rol_login DROP CONSTRAINT rol_login_pkey;
       restaurante         postgres    false    207            �
           2606    65796 (   sub_rol_categoria sub_rol_categoria_pkey 
   CONSTRAINT     k   ALTER TABLE ONLY restaurante.sub_rol_categoria
    ADD CONSTRAINT sub_rol_categoria_pkey PRIMARY KEY (id);
 W   ALTER TABLE ONLY restaurante.sub_rol_categoria DROP CONSTRAINT sub_rol_categoria_pkey;
       restaurante         postgres    false    209            �
           1259    65797 
   fki_fk_rol    INDEX     K   CREATE INDEX fki_fk_rol ON restaurante.registro_usuario USING btree (rol);
 #   DROP INDEX restaurante.fki_fk_rol;
       restaurante         postgres    false    203            �
           1259    65798    fki_fk_rolProducto    INDEX     S   CREATE INDEX "fki_fk_rolProducto" ON restaurante.producto USING btree (categoria);
 -   DROP INDEX restaurante."fki_fk_rolProducto";
       restaurante         postgres    false    197            �
           1259    65799    fki_fk_subRProducto    INDEX     W   CREATE INDEX "fki_fk_subRProducto" ON restaurante.producto USING btree (subcategoria);
 .   DROP INDEX restaurante."fki_fk_subRProducto";
       restaurante         postgres    false    197            �
           1259    65800    fki_fk_subcategoria    INDEX     [   CREATE INDEX fki_fk_subcategoria ON restaurante.sub_rol_categoria USING btree (categoria);
 ,   DROP INDEX restaurante.fki_fk_subcategoria;
       restaurante         postgres    false    209            �
           2606    65801    sub_rol_categoria fk_cat    FK CONSTRAINT     �   ALTER TABLE ONLY restaurante.sub_rol_categoria
    ADD CONSTRAINT fk_cat FOREIGN KEY (categoria) REFERENCES restaurante.rol_categoria(id);
 G   ALTER TABLE ONLY restaurante.sub_rol_categoria DROP CONSTRAINT fk_cat;
       restaurante       postgres    false    205    209    2749            �
           2606    65806    producto fk_cat    FK CONSTRAINT     �   ALTER TABLE ONLY restaurante.producto
    ADD CONSTRAINT fk_cat FOREIGN KEY (categoria) REFERENCES restaurante.rol_categoria(id);
 >   ALTER TABLE ONLY restaurante.producto DROP CONSTRAINT fk_cat;
       restaurante       postgres    false    2749    205    197            �
           2606    65811    registro_usuario fk_rol    FK CONSTRAINT     �   ALTER TABLE ONLY restaurante.registro_usuario
    ADD CONSTRAINT fk_rol FOREIGN KEY (rol) REFERENCES restaurante.rol_login("Id_Rol");
 F   ALTER TABLE ONLY restaurante.registro_usuario DROP CONSTRAINT fk_rol;
       restaurante       postgres    false    207    203    2751            �
           2606    65816    registro_administrador fk_rol    FK CONSTRAINT     �   ALTER TABLE ONLY restaurante.registro_administrador
    ADD CONSTRAINT fk_rol FOREIGN KEY (id_rol) REFERENCES restaurante.rol_login("Id_Rol");
 L   ALTER TABLE ONLY restaurante.registro_administrador DROP CONSTRAINT fk_rol;
       restaurante       postgres    false    2751    199    207            �
           2606    65821    registro_empleado fk_rol    FK CONSTRAINT     �   ALTER TABLE ONLY restaurante.registro_empleado
    ADD CONSTRAINT fk_rol FOREIGN KEY (id_rol) REFERENCES restaurante.rol_login("Id_Rol");
 G   ALTER TABLE ONLY restaurante.registro_empleado DROP CONSTRAINT fk_rol;
       restaurante       postgres    false    201    207    2751            �
           2606    65826    producto fk_sub    FK CONSTRAINT     �   ALTER TABLE ONLY restaurante.producto
    ADD CONSTRAINT fk_sub FOREIGN KEY (subcategoria) REFERENCES restaurante.sub_rol_categoria(id);
 >   ALTER TABLE ONLY restaurante.producto DROP CONSTRAINT fk_sub;
       restaurante       postgres    false    2754    209    197            B   �   x�M�Ar�0E��:A�8@ȶ��*3L�v���q�V��k;��h'����WК~ZG�֑�'%�R
��z\�w58�^����wןr��� �:��x2�I�Y�*�u����Xv����:�5�$#�_?Ć�=��O�d�I�`䒬�||)~�QLp�/���v����2�4�*Bsϐ����lY�a�3?���;g����!�t��O�[�	7��cGnN���ț�ԔzP��.˲?MCv"      D   Q   x�3��HM.�/RpKL�L��H-J�RH��M,���+ q�L*3�����s93�B��F�&�������F��\1z\\\  ��      F   A   x�3��M-N-�W(*MMJ�P
ANcCC#CC#KKN#N3 ���Ă3� ����؄+F��� �:�      H   �   x�]N�n�0����"uo�֥]�f!�6�#�� ��*N;� 	��#" ط����<�\���@�}(����Y�ﺼֹ[�|3��X�<^3H�(�<������:�������r��)�g��ʧ�u���A�H~����y�����C׎A��}2-�@"f2�-)u.��-R��E�f$�^{#.:�=y��r!��Y)��Qu      J   5   x�3�tN,�K�2�H-NNL��2�t-.HM�L��LIL�2�t,K-����� 0��      L   0   x�3�tL����,.)JL�/�2�t�-�I���9C�K�2�b���� (r�      N   A   x�3�J-�4�2�tN-J��L8}�8���9�2�)g@~NN>���{bNNf^"����� ���     