PGDMP                       |            asky    16.3    16.3 �    �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            �           1262    24872    asky    DATABASE        CREATE DATABASE asky WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'English_United States.1252';
    DROP DATABASE asky;
                postgres    false            u           1247    24916    coupon_status_enum    TYPE     [   CREATE TYPE public.coupon_status_enum AS ENUM (
    'active',
    'expired',
    'used'
);
 %   DROP TYPE public.coupon_status_enum;
       public          postgres    false            l           1247    24890    order_status_enum    TYPE     p   CREATE TYPE public.order_status_enum AS ENUM (
    'pending',
    'shipped',
    'delivered',
    'canceled'
);
 $   DROP TYPE public.order_status_enum;
       public          postgres    false            o           1247    24900    payment_status_enum    TYPE     a   CREATE TYPE public.payment_status_enum AS ENUM (
    'pending',
    'completed',
    'failed'
);
 &   DROP TYPE public.payment_status_enum;
       public          postgres    false            f           1247    24874 	   role_enum    TYPE     T   CREATE TYPE public.role_enum AS ENUM (
    'admin',
    'customer',
    'vendor'
);
    DROP TYPE public.role_enum;
       public          postgres    false            r           1247    24908    shipping_status_enum    TYPE     c   CREATE TYPE public.shipping_status_enum AS ENUM (
    'pending',
    'shipped',
    'delivered'
);
 '   DROP TYPE public.shipping_status_enum;
       public          postgres    false            i           1247    24882    user_status_enum    TYPE     ^   CREATE TYPE public.user_status_enum AS ENUM (
    'active',
    'suspended',
    'deleted'
);
 #   DROP TYPE public.user_status_enum;
       public          postgres    false            �            1259    25178    attribute_types    TABLE     k   CREATE TABLE public.attribute_types (
    id integer NOT NULL,
    name character varying(255) NOT NULL
);
 #   DROP TABLE public.attribute_types;
       public         heap    postgres    false            �            1259    25177    attribute_types_id_seq    SEQUENCE     �   CREATE SEQUENCE public.attribute_types_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE public.attribute_types_id_seq;
       public          postgres    false    240            �           0    0    attribute_types_id_seq    SEQUENCE OWNED BY     Q   ALTER SEQUENCE public.attribute_types_id_seq OWNED BY public.attribute_types.id;
          public          postgres    false    239            �            1259    25185    attribute_values    TABLE     �   CREATE TABLE public.attribute_values (
    id integer NOT NULL,
    attribute_type_id integer,
    value character varying(255) NOT NULL
);
 $   DROP TABLE public.attribute_values;
       public         heap    postgres    false            �            1259    25184    attribute_values_id_seq    SEQUENCE     �   CREATE SEQUENCE public.attribute_values_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE public.attribute_values_id_seq;
       public          postgres    false    242            �           0    0    attribute_values_id_seq    SEQUENCE OWNED BY     S   ALTER SEQUENCE public.attribute_values_id_seq OWNED BY public.attribute_values.id;
          public          postgres    false    241            �            1259    24976 
   categories    TABLE       CREATE TABLE public.categories (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    description text,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);
    DROP TABLE public.categories;
       public         heap    postgres    false            �            1259    24975    categories_id_seq    SEQUENCE     �   CREATE SEQUENCE public.categories_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.categories_id_seq;
       public          postgres    false    218            �           0    0    categories_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.categories_id_seq OWNED BY public.categories.id;
          public          postgres    false    217            �            1259    25103    coupons    TABLE     9  CREATE TABLE public.coupons (
    id integer NOT NULL,
    code character varying(100) NOT NULL,
    discount_value numeric(10,2) NOT NULL,
    valid_from timestamp without time zone,
    valid_until timestamp without time zone,
    status public.coupon_status_enum DEFAULT 'active'::public.coupon_status_enum
);
    DROP TABLE public.coupons;
       public         heap    postgres    false    885    885            �            1259    25102    coupons_id_seq    SEQUENCE     �   CREATE SEQUENCE public.coupons_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 %   DROP SEQUENCE public.coupons_id_seq;
       public          postgres    false    234            �           0    0    coupons_id_seq    SEQUENCE OWNED BY     A   ALTER SEQUENCE public.coupons_id_seq OWNED BY public.coupons.id;
          public          postgres    false    233            �            1259    25020    order_items    TABLE     �   CREATE TABLE public.order_items (
    id integer NOT NULL,
    order_id integer,
    product_id integer,
    quantity integer NOT NULL,
    price numeric(10,2) NOT NULL
);
    DROP TABLE public.order_items;
       public         heap    postgres    false            �            1259    25019    order_items_id_seq    SEQUENCE     �   CREATE SEQUENCE public.order_items_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE public.order_items_id_seq;
       public          postgres    false    224            �           0    0    order_items_id_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE public.order_items_id_seq OWNED BY public.order_items.id;
          public          postgres    false    223            �            1259    25003    orders    TABLE     v  CREATE TABLE public.orders (
    id integer NOT NULL,
    user_id integer,
    status public.order_status_enum DEFAULT 'pending'::public.order_status_enum,
    total_price numeric(10,2) NOT NULL,
    shipping_address text NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);
    DROP TABLE public.orders;
       public         heap    postgres    false    876    876            �            1259    25002    orders_id_seq    SEQUENCE     �   CREATE SEQUENCE public.orders_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 $   DROP SEQUENCE public.orders_id_seq;
       public          postgres    false    222            �           0    0    orders_id_seq    SEQUENCE OWNED BY     ?   ALTER SEQUENCE public.orders_id_seq OWNED BY public.orders.id;
          public          postgres    false    221            �            1259    25037    payments    TABLE     u  CREATE TABLE public.payments (
    id integer NOT NULL,
    order_id integer,
    payment_method character varying(100) NOT NULL,
    payment_status public.payment_status_enum DEFAULT 'pending'::public.payment_status_enum,
    amount numeric(10,2) NOT NULL,
    transaction_id character varying(255),
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);
    DROP TABLE public.payments;
       public         heap    postgres    false    879    879            �            1259    25036    payments_id_seq    SEQUENCE     �   CREATE SEQUENCE public.payments_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.payments_id_seq;
       public          postgres    false    226            �           0    0    payments_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public.payments_id_seq OWNED BY public.payments.id;
          public          postgres    false    225            �            1259    25113    product_images    TABLE     �   CREATE TABLE public.product_images (
    id integer NOT NULL,
    product_id integer,
    image_url character varying(255) NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);
 "   DROP TABLE public.product_images;
       public         heap    postgres    false            �            1259    25112    product_images_id_seq    SEQUENCE     �   CREATE SEQUENCE public.product_images_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.product_images_id_seq;
       public          postgres    false    236            �           0    0    product_images_id_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE public.product_images_id_seq OWNED BY public.product_images.id;
          public          postgres    false    235            �            1259    25208    product_variant_attributes    TABLE     �   CREATE TABLE public.product_variant_attributes (
    product_variant_id integer NOT NULL,
    attribute_value_id integer NOT NULL
);
 .   DROP TABLE public.product_variant_attributes;
       public         heap    postgres    false            �            1259    25197    product_variants    TABLE     �   CREATE TABLE public.product_variants (
    id integer NOT NULL,
    product_id integer,
    stock_quantity integer,
    price numeric(10,2),
    image_url character varying(255),
    sku character varying(255)
);
 $   DROP TABLE public.product_variants;
       public         heap    postgres    false            �            1259    25196    product_variants_id_seq    SEQUENCE     �   CREATE SEQUENCE public.product_variants_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE public.product_variants_id_seq;
       public          postgres    false    244            �           0    0    product_variants_id_seq    SEQUENCE OWNED BY     S   ALTER SEQUENCE public.product_variants_id_seq OWNED BY public.product_variants.id;
          public          postgres    false    243            �            1259    24987    products    TABLE     ,  CREATE TABLE public.products (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    description text,
    image_url character varying(255),
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);
    DROP TABLE public.products;
       public         heap    postgres    false            �            1259    24986    products_id_seq    SEQUENCE     �   CREATE SEQUENCE public.products_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.products_id_seq;
       public          postgres    false    220            �           0    0    products_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public.products_id_seq OWNED BY public.products.id;
          public          postgres    false    219            �            1259    25070    reviews    TABLE     *  CREATE TABLE public.reviews (
    id integer NOT NULL,
    user_id integer,
    product_id integer,
    rating integer NOT NULL,
    comment text,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT reviews_rating_check CHECK (((rating >= 1) AND (rating <= 5)))
);
    DROP TABLE public.reviews;
       public         heap    postgres    false            �            1259    25069    reviews_id_seq    SEQUENCE     �   CREATE SEQUENCE public.reviews_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 %   DROP SEQUENCE public.reviews_id_seq;
       public          postgres    false    230            �           0    0    reviews_id_seq    SEQUENCE OWNED BY     A   ALTER SEQUENCE public.reviews_id_seq OWNED BY public.reviews.id;
          public          postgres    false    229            �            1259    25091    shipping    TABLE     5  CREATE TABLE public.shipping (
    id integer NOT NULL,
    order_id integer,
    shipping_method character varying(100) NOT NULL,
    shipping_cost numeric(10,2) NOT NULL,
    tracking_number character varying(255),
    shipped_at timestamp without time zone,
    delivered_at timestamp without time zone
);
    DROP TABLE public.shipping;
       public         heap    postgres    false            �            1259    25090    shipping_id_seq    SEQUENCE     �   CREATE SEQUENCE public.shipping_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.shipping_id_seq;
       public          postgres    false    232            �           0    0    shipping_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public.shipping_id_seq OWNED BY public.shipping.id;
          public          postgres    false    231            �            1259    25051    shopping_cart    TABLE       CREATE TABLE public.shopping_cart (
    id integer NOT NULL,
    user_id integer,
    product_id integer,
    quantity integer NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);
 !   DROP TABLE public.shopping_cart;
       public         heap    postgres    false            �            1259    25050    shopping_cart_id_seq    SEQUENCE     �   CREATE SEQUENCE public.shopping_cart_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE public.shopping_cart_id_seq;
       public          postgres    false    228            �           0    0    shopping_cart_id_seq    SEQUENCE OWNED BY     M   ALTER SEQUENCE public.shopping_cart_id_seq OWNED BY public.shopping_cart.id;
          public          postgres    false    227            �            1259    24950    users    TABLE     	  CREATE TABLE public.users (
    id integer NOT NULL,
    first_name character varying(100) NOT NULL,
    last_name character varying(100) NOT NULL,
    email character varying(255) NOT NULL,
    password character varying(255) NOT NULL,
    role public.role_enum DEFAULT 'customer'::public.role_enum,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    status public.user_status_enum DEFAULT 'active'::public.user_status_enum
);
    DROP TABLE public.users;
       public         heap    postgres    false    870    873    870    873            �            1259    24949    users_id_seq    SEQUENCE     �   CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.users_id_seq;
       public          postgres    false    216            �           0    0    users_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;
          public          postgres    false    215            �            1259    25126 	   wishlists    TABLE     �   CREATE TABLE public.wishlists (
    id integer NOT NULL,
    user_id integer,
    product_id integer,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);
    DROP TABLE public.wishlists;
       public         heap    postgres    false            �            1259    25125    wishlists_id_seq    SEQUENCE     �   CREATE SEQUENCE public.wishlists_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE public.wishlists_id_seq;
       public          postgres    false    238            �           0    0    wishlists_id_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE public.wishlists_id_seq OWNED BY public.wishlists.id;
          public          postgres    false    237            �           2604    25181    attribute_types id    DEFAULT     x   ALTER TABLE ONLY public.attribute_types ALTER COLUMN id SET DEFAULT nextval('public.attribute_types_id_seq'::regclass);
 A   ALTER TABLE public.attribute_types ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    240    239    240            �           2604    25188    attribute_values id    DEFAULT     z   ALTER TABLE ONLY public.attribute_values ALTER COLUMN id SET DEFAULT nextval('public.attribute_values_id_seq'::regclass);
 B   ALTER TABLE public.attribute_values ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    241    242    242            �           2604    24979    categories id    DEFAULT     n   ALTER TABLE ONLY public.categories ALTER COLUMN id SET DEFAULT nextval('public.categories_id_seq'::regclass);
 <   ALTER TABLE public.categories ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    217    218    218            �           2604    25106 
   coupons id    DEFAULT     h   ALTER TABLE ONLY public.coupons ALTER COLUMN id SET DEFAULT nextval('public.coupons_id_seq'::regclass);
 9   ALTER TABLE public.coupons ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    233    234    234            �           2604    25023    order_items id    DEFAULT     p   ALTER TABLE ONLY public.order_items ALTER COLUMN id SET DEFAULT nextval('public.order_items_id_seq'::regclass);
 =   ALTER TABLE public.order_items ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    223    224    224            �           2604    25006 	   orders id    DEFAULT     f   ALTER TABLE ONLY public.orders ALTER COLUMN id SET DEFAULT nextval('public.orders_id_seq'::regclass);
 8   ALTER TABLE public.orders ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    222    221    222            �           2604    25040    payments id    DEFAULT     j   ALTER TABLE ONLY public.payments ALTER COLUMN id SET DEFAULT nextval('public.payments_id_seq'::regclass);
 :   ALTER TABLE public.payments ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    225    226    226            �           2604    25116    product_images id    DEFAULT     v   ALTER TABLE ONLY public.product_images ALTER COLUMN id SET DEFAULT nextval('public.product_images_id_seq'::regclass);
 @   ALTER TABLE public.product_images ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    235    236    236            �           2604    25200    product_variants id    DEFAULT     z   ALTER TABLE ONLY public.product_variants ALTER COLUMN id SET DEFAULT nextval('public.product_variants_id_seq'::regclass);
 B   ALTER TABLE public.product_variants ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    243    244    244            �           2604    24990    products id    DEFAULT     j   ALTER TABLE ONLY public.products ALTER COLUMN id SET DEFAULT nextval('public.products_id_seq'::regclass);
 :   ALTER TABLE public.products ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    219    220    220            �           2604    25073 
   reviews id    DEFAULT     h   ALTER TABLE ONLY public.reviews ALTER COLUMN id SET DEFAULT nextval('public.reviews_id_seq'::regclass);
 9   ALTER TABLE public.reviews ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    230    229    230            �           2604    25094    shipping id    DEFAULT     j   ALTER TABLE ONLY public.shipping ALTER COLUMN id SET DEFAULT nextval('public.shipping_id_seq'::regclass);
 :   ALTER TABLE public.shipping ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    232    231    232            �           2604    25054    shopping_cart id    DEFAULT     t   ALTER TABLE ONLY public.shopping_cart ALTER COLUMN id SET DEFAULT nextval('public.shopping_cart_id_seq'::regclass);
 ?   ALTER TABLE public.shopping_cart ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    227    228    228            �           2604    24953    users id    DEFAULT     d   ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);
 7   ALTER TABLE public.users ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    215    216    216            �           2604    25129    wishlists id    DEFAULT     l   ALTER TABLE ONLY public.wishlists ALTER COLUMN id SET DEFAULT nextval('public.wishlists_id_seq'::regclass);
 ;   ALTER TABLE public.wishlists ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    238    237    238            �          0    25178    attribute_types 
   TABLE DATA           3   COPY public.attribute_types (id, name) FROM stdin;
    public          postgres    false    240   ��       �          0    25185    attribute_values 
   TABLE DATA           H   COPY public.attribute_values (id, attribute_type_id, value) FROM stdin;
    public          postgres    false    242   ��       �          0    24976 
   categories 
   TABLE DATA           S   COPY public.categories (id, name, description, created_at, updated_at) FROM stdin;
    public          postgres    false    218   �       �          0    25103    coupons 
   TABLE DATA           \   COPY public.coupons (id, code, discount_value, valid_from, valid_until, status) FROM stdin;
    public          postgres    false    234   W�       �          0    25020    order_items 
   TABLE DATA           P   COPY public.order_items (id, order_id, product_id, quantity, price) FROM stdin;
    public          postgres    false    224   t�       �          0    25003    orders 
   TABLE DATA           l   COPY public.orders (id, user_id, status, total_price, shipping_address, created_at, updated_at) FROM stdin;
    public          postgres    false    222   ��       �          0    25037    payments 
   TABLE DATA           t   COPY public.payments (id, order_id, payment_method, payment_status, amount, transaction_id, created_at) FROM stdin;
    public          postgres    false    226   ��       �          0    25113    product_images 
   TABLE DATA           O   COPY public.product_images (id, product_id, image_url, created_at) FROM stdin;
    public          postgres    false    236   ˯       �          0    25208    product_variant_attributes 
   TABLE DATA           \   COPY public.product_variant_attributes (product_variant_id, attribute_value_id) FROM stdin;
    public          postgres    false    245   �       �          0    25197    product_variants 
   TABLE DATA           a   COPY public.product_variants (id, product_id, stock_quantity, price, image_url, sku) FROM stdin;
    public          postgres    false    244   �       �          0    24987    products 
   TABLE DATA           \   COPY public.products (id, name, description, image_url, created_at, updated_at) FROM stdin;
    public          postgres    false    220   ��       �          0    25070    reviews 
   TABLE DATA           W   COPY public.reviews (id, user_id, product_id, rating, comment, created_at) FROM stdin;
    public          postgres    false    230   G�       �          0    25091    shipping 
   TABLE DATA           {   COPY public.shipping (id, order_id, shipping_method, shipping_cost, tracking_number, shipped_at, delivered_at) FROM stdin;
    public          postgres    false    232   d�       �          0    25051    shopping_cart 
   TABLE DATA           b   COPY public.shopping_cart (id, user_id, product_id, quantity, created_at, updated_at) FROM stdin;
    public          postgres    false    228   ��       �          0    24950    users 
   TABLE DATA           q   COPY public.users (id, first_name, last_name, email, password, role, created_at, updated_at, status) FROM stdin;
    public          postgres    false    216   ��       �          0    25126 	   wishlists 
   TABLE DATA           H   COPY public.wishlists (id, user_id, product_id, created_at) FROM stdin;
    public          postgres    false    238   ��       �           0    0    attribute_types_id_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.attribute_types_id_seq', 2, true);
          public          postgres    false    239            �           0    0    attribute_values_id_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('public.attribute_values_id_seq', 8, true);
          public          postgres    false    241            �           0    0    categories_id_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('public.categories_id_seq', 1, true);
          public          postgres    false    217            �           0    0    coupons_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public.coupons_id_seq', 1, false);
          public          postgres    false    233            �           0    0    order_items_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public.order_items_id_seq', 1, false);
          public          postgres    false    223            �           0    0    orders_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('public.orders_id_seq', 1, false);
          public          postgres    false    221            �           0    0    payments_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.payments_id_seq', 1, false);
          public          postgres    false    225            �           0    0    product_images_id_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.product_images_id_seq', 1, false);
          public          postgres    false    235            �           0    0    product_variants_id_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('public.product_variants_id_seq', 34, true);
          public          postgres    false    243            �           0    0    products_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.products_id_seq', 27, true);
          public          postgres    false    219            �           0    0    reviews_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public.reviews_id_seq', 1, false);
          public          postgres    false    229            �           0    0    shipping_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.shipping_id_seq', 1, false);
          public          postgres    false    231            �           0    0    shopping_cart_id_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public.shopping_cart_id_seq', 1, false);
          public          postgres    false    227            �           0    0    users_id_seq    SEQUENCE SET     :   SELECT pg_catalog.setval('public.users_id_seq', 2, true);
          public          postgres    false    215            �           0    0    wishlists_id_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('public.wishlists_id_seq', 1, false);
          public          postgres    false    237            �           2606    25183 $   attribute_types attribute_types_pkey 
   CONSTRAINT     b   ALTER TABLE ONLY public.attribute_types
    ADD CONSTRAINT attribute_types_pkey PRIMARY KEY (id);
 N   ALTER TABLE ONLY public.attribute_types DROP CONSTRAINT attribute_types_pkey;
       public            postgres    false    240            �           2606    25190 &   attribute_values attribute_values_pkey 
   CONSTRAINT     d   ALTER TABLE ONLY public.attribute_values
    ADD CONSTRAINT attribute_values_pkey PRIMARY KEY (id);
 P   ALTER TABLE ONLY public.attribute_values DROP CONSTRAINT attribute_values_pkey;
       public            postgres    false    242            �           2606    24985    categories categories_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (id);
 D   ALTER TABLE ONLY public.categories DROP CONSTRAINT categories_pkey;
       public            postgres    false    218            �           2606    25111    coupons coupons_code_key 
   CONSTRAINT     S   ALTER TABLE ONLY public.coupons
    ADD CONSTRAINT coupons_code_key UNIQUE (code);
 B   ALTER TABLE ONLY public.coupons DROP CONSTRAINT coupons_code_key;
       public            postgres    false    234            �           2606    25109    coupons coupons_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.coupons
    ADD CONSTRAINT coupons_pkey PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.coupons DROP CONSTRAINT coupons_pkey;
       public            postgres    false    234            �           2606    25025    order_items order_items_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT order_items_pkey PRIMARY KEY (id);
 F   ALTER TABLE ONLY public.order_items DROP CONSTRAINT order_items_pkey;
       public            postgres    false    224            �           2606    25013    orders orders_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (id);
 <   ALTER TABLE ONLY public.orders DROP CONSTRAINT orders_pkey;
       public            postgres    false    222            �           2606    25044    payments payments_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.payments
    ADD CONSTRAINT payments_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.payments DROP CONSTRAINT payments_pkey;
       public            postgres    false    226            �           2606    25119 "   product_images product_images_pkey 
   CONSTRAINT     `   ALTER TABLE ONLY public.product_images
    ADD CONSTRAINT product_images_pkey PRIMARY KEY (id);
 L   ALTER TABLE ONLY public.product_images DROP CONSTRAINT product_images_pkey;
       public            postgres    false    236            �           2606    25212 :   product_variant_attributes product_variant_attributes_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.product_variant_attributes
    ADD CONSTRAINT product_variant_attributes_pkey PRIMARY KEY (product_variant_id, attribute_value_id);
 d   ALTER TABLE ONLY public.product_variant_attributes DROP CONSTRAINT product_variant_attributes_pkey;
       public            postgres    false    245    245            �           2606    25202 &   product_variants product_variants_pkey 
   CONSTRAINT     d   ALTER TABLE ONLY public.product_variants
    ADD CONSTRAINT product_variants_pkey PRIMARY KEY (id);
 P   ALTER TABLE ONLY public.product_variants DROP CONSTRAINT product_variants_pkey;
       public            postgres    false    244            �           2606    25224 )   product_variants product_variants_sku_key 
   CONSTRAINT     c   ALTER TABLE ONLY public.product_variants
    ADD CONSTRAINT product_variants_sku_key UNIQUE (sku);
 S   ALTER TABLE ONLY public.product_variants DROP CONSTRAINT product_variants_sku_key;
       public            postgres    false    244            �           2606    24996    products products_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.products DROP CONSTRAINT products_pkey;
       public            postgres    false    220            �           2606    25079    reviews reviews_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT reviews_pkey PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.reviews DROP CONSTRAINT reviews_pkey;
       public            postgres    false    230            �           2606    25096    shipping shipping_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.shipping
    ADD CONSTRAINT shipping_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.shipping DROP CONSTRAINT shipping_pkey;
       public            postgres    false    232            �           2606    25058     shopping_cart shopping_cart_pkey 
   CONSTRAINT     ^   ALTER TABLE ONLY public.shopping_cart
    ADD CONSTRAINT shopping_cart_pkey PRIMARY KEY (id);
 J   ALTER TABLE ONLY public.shopping_cart DROP CONSTRAINT shopping_cart_pkey;
       public            postgres    false    228            �           2606    24963    users users_email_key 
   CONSTRAINT     Q   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);
 ?   ALTER TABLE ONLY public.users DROP CONSTRAINT users_email_key;
       public            postgres    false    216            �           2606    24961    users users_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.users DROP CONSTRAINT users_pkey;
       public            postgres    false    216            �           2606    25132    wishlists wishlists_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.wishlists
    ADD CONSTRAINT wishlists_pkey PRIMARY KEY (id);
 B   ALTER TABLE ONLY public.wishlists DROP CONSTRAINT wishlists_pkey;
       public            postgres    false    238            �           1259    25146    idx_order_items_order_id    INDEX     T   CREATE INDEX idx_order_items_order_id ON public.order_items USING btree (order_id);
 ,   DROP INDEX public.idx_order_items_order_id;
       public            postgres    false    224            �           1259    25147    idx_order_items_product_id    INDEX     X   CREATE INDEX idx_order_items_product_id ON public.order_items USING btree (product_id);
 .   DROP INDEX public.idx_order_items_product_id;
       public            postgres    false    224            �           1259    25145    idx_orders_user_id    INDEX     H   CREATE INDEX idx_orders_user_id ON public.orders USING btree (user_id);
 &   DROP INDEX public.idx_orders_user_id;
       public            postgres    false    222            �           1259    25144    idx_products_name    INDEX     F   CREATE INDEX idx_products_name ON public.products USING btree (name);
 %   DROP INDEX public.idx_products_name;
       public            postgres    false    220            �           1259    25148    idx_reviews_product_id    INDEX     P   CREATE INDEX idx_reviews_product_id ON public.reviews USING btree (product_id);
 *   DROP INDEX public.idx_reviews_product_id;
       public            postgres    false    230            �           1259    25143    idx_users_email    INDEX     B   CREATE INDEX idx_users_email ON public.users USING btree (email);
 #   DROP INDEX public.idx_users_email;
       public            postgres    false    216            �           1259    25149    idx_wishlists_user_id    INDEX     N   CREATE INDEX idx_wishlists_user_id ON public.wishlists USING btree (user_id);
 )   DROP INDEX public.idx_wishlists_user_id;
       public            postgres    false    238                       2606    25191 8   attribute_values attribute_values_attribute_type_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.attribute_values
    ADD CONSTRAINT attribute_values_attribute_type_id_fkey FOREIGN KEY (attribute_type_id) REFERENCES public.attribute_types(id);
 b   ALTER TABLE ONLY public.attribute_values DROP CONSTRAINT attribute_values_attribute_type_id_fkey;
       public          postgres    false    242    240    4851            �           2606    25026 %   order_items order_items_order_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT order_items_order_id_fkey FOREIGN KEY (order_id) REFERENCES public.orders(id) ON DELETE CASCADE;
 O   ALTER TABLE ONLY public.order_items DROP CONSTRAINT order_items_order_id_fkey;
       public          postgres    false    224    4827    222            �           2606    25031 '   order_items order_items_product_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT order_items_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.products(id) ON DELETE CASCADE;
 Q   ALTER TABLE ONLY public.order_items DROP CONSTRAINT order_items_product_id_fkey;
       public          postgres    false    220    4824    224            �           2606    25014    orders orders_user_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;
 D   ALTER TABLE ONLY public.orders DROP CONSTRAINT orders_user_id_fkey;
       public          postgres    false    216    222    4819            �           2606    25045    payments payments_order_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.payments
    ADD CONSTRAINT payments_order_id_fkey FOREIGN KEY (order_id) REFERENCES public.orders(id) ON DELETE CASCADE;
 I   ALTER TABLE ONLY public.payments DROP CONSTRAINT payments_order_id_fkey;
       public          postgres    false    226    222    4827                       2606    25120 -   product_images product_images_product_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.product_images
    ADD CONSTRAINT product_images_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.products(id) ON DELETE CASCADE;
 W   ALTER TABLE ONLY public.product_images DROP CONSTRAINT product_images_product_id_fkey;
       public          postgres    false    220    4824    236            
           2606    25218 M   product_variant_attributes product_variant_attributes_attribute_value_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.product_variant_attributes
    ADD CONSTRAINT product_variant_attributes_attribute_value_id_fkey FOREIGN KEY (attribute_value_id) REFERENCES public.attribute_values(id);
 w   ALTER TABLE ONLY public.product_variant_attributes DROP CONSTRAINT product_variant_attributes_attribute_value_id_fkey;
       public          postgres    false    242    4853    245                       2606    25213 M   product_variant_attributes product_variant_attributes_product_variant_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.product_variant_attributes
    ADD CONSTRAINT product_variant_attributes_product_variant_id_fkey FOREIGN KEY (product_variant_id) REFERENCES public.product_variants(id) ON DELETE CASCADE;
 w   ALTER TABLE ONLY public.product_variant_attributes DROP CONSTRAINT product_variant_attributes_product_variant_id_fkey;
       public          postgres    false    244    4855    245            	           2606    25203 1   product_variants product_variants_product_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.product_variants
    ADD CONSTRAINT product_variants_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.products(id) ON DELETE CASCADE;
 [   ALTER TABLE ONLY public.product_variants DROP CONSTRAINT product_variants_product_id_fkey;
       public          postgres    false    220    4824    244                       2606    25085    reviews reviews_product_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT reviews_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.products(id) ON DELETE CASCADE;
 I   ALTER TABLE ONLY public.reviews DROP CONSTRAINT reviews_product_id_fkey;
       public          postgres    false    220    230    4824                       2606    25080    reviews reviews_user_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT reviews_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;
 F   ALTER TABLE ONLY public.reviews DROP CONSTRAINT reviews_user_id_fkey;
       public          postgres    false    230    4819    216                       2606    25097    shipping shipping_order_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.shipping
    ADD CONSTRAINT shipping_order_id_fkey FOREIGN KEY (order_id) REFERENCES public.orders(id) ON DELETE CASCADE;
 I   ALTER TABLE ONLY public.shipping DROP CONSTRAINT shipping_order_id_fkey;
       public          postgres    false    232    222    4827                        2606    25064 +   shopping_cart shopping_cart_product_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.shopping_cart
    ADD CONSTRAINT shopping_cart_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.products(id) ON DELETE CASCADE;
 U   ALTER TABLE ONLY public.shopping_cart DROP CONSTRAINT shopping_cart_product_id_fkey;
       public          postgres    false    228    220    4824                       2606    25059 (   shopping_cart shopping_cart_user_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.shopping_cart
    ADD CONSTRAINT shopping_cart_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;
 R   ALTER TABLE ONLY public.shopping_cart DROP CONSTRAINT shopping_cart_user_id_fkey;
       public          postgres    false    228    216    4819                       2606    25138 #   wishlists wishlists_product_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.wishlists
    ADD CONSTRAINT wishlists_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.products(id) ON DELETE CASCADE;
 M   ALTER TABLE ONLY public.wishlists DROP CONSTRAINT wishlists_product_id_fkey;
       public          postgres    false    4824    220    238                       2606    25133     wishlists wishlists_user_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.wishlists
    ADD CONSTRAINT wishlists_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;
 J   ALTER TABLE ONLY public.wishlists DROP CONSTRAINT wishlists_user_id_fkey;
       public          postgres    false    238    216    4819            �      x�3�t���/�2�άJ����� 7��      �   J   x�3�4�JM�2��E��y\�@�SNi*�	�g�)��M���2�|SS2Ks�́j��3��,�b�\1z\\\ _��      �   A   x�3�tN,IM�/��tI-N.�,(����4202�54�5�T02�2��21�327627�#����� ��      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �   !   x�36�4�26�4�26�4�26�4����� -}X      �   �   x���=� ��پ��(=DO�%�?% ��%Y������ga`b�4�,%_��)�h^�����\�Uk�*������";�S�kP[�b<�������?�b�]��,�J��s����GB�/o�Ml      �   �   x���1
� ����^ �Om��:f�D��4��סt*N��~����v��{9����Tx]�%l�y���r�|��%�<1H�Aa���^o���t"�^9��QJ\DU{䠼� ��h��++Fc��~D� �V�w�      �      x������ � �      �      x������ � �      �      x������ � �      �   �   x�}�Ao�0��s�;p��Z(x�(Pu�#�.�Ҍ���]2��&&��M�ɓ����
��GU򜃟�3��W��*aVk`bn"��䓍Ѣ��f�������g�l�[l{�@�x^����Q�i��o� <ת��d�����-�{��ĝ͞%��j~�f����h�#s��/�X�Bբ(��]l:����pX*�FL�'!�O6�+s���9Μx�Ô8γt�~C�0�|�c�      �      x������ � �     