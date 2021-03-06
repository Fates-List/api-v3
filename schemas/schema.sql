PGDMP     
                    z         	   fateslist    14.0 (Debian 14.0-1.pgdg110+1)    14.3 ?               0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false                       0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false                       0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false                       1262    16384 	   fateslist    DATABASE     ]   CREATE DATABASE fateslist WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'en_US.utf8';
    DROP DATABASE fateslist;
             	   fateslist    false                       0    0 	   fateslist    DATABASE PROPERTIES     *   ALTER DATABASE fateslist SET jit TO 'on';
                  	   fateslist    false                        3079    215899    pg_trgm 	   EXTENSION     ;   CREATE EXTENSION IF NOT EXISTS pg_trgm WITH SCHEMA public;
    DROP EXTENSION pg_trgm;
                   false                       0    0    EXTENSION pg_trgm    COMMENT     e   COMMENT ON EXTENSION pg_trgm IS 'text similarity measurement and index searching based on trigrams';
                        false    3                        3079    16400 	   uuid-ossp 	   EXTENSION     ?   CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA public;
    DROP EXTENSION "uuid-ossp";
                   false                       0    0    EXTENSION "uuid-ossp"    COMMENT     W   COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';
                        false    2            ?            1259    187386    bot_commands    TABLE     k  CREATE TABLE public.bot_commands (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    bot_id bigint NOT NULL,
    cmd_type integer NOT NULL,
    groups text[] DEFAULT '{Default}'::text[] NOT NULL,
    name text NOT NULL,
    vote_locked boolean DEFAULT false NOT NULL,
    description text NOT NULL,
    args text[] DEFAULT '{}'::text[] NOT NULL,
    examples text[] DEFAULT '{}'::text[] NOT NULL,
    premium_only boolean DEFAULT false NOT NULL,
    notes text[] DEFAULT '{}'::text[] NOT NULL,
    doc_link text,
    nsfw boolean DEFAULT false,
    _lynxtag uuid DEFAULT public.uuid_generate_v4() NOT NULL
);
     DROP TABLE public.bot_commands;
       public         heap 	   fateslist    false    2    2                        1259    400638 
   bot_events    TABLE     P  CREATE TABLE public.bot_events (
    bot_id bigint NOT NULL,
    event_type integer NOT NULL,
    ts timestamp with time zone DEFAULT now() NOT NULL,
    reason text NOT NULL,
    css text DEFAULT ''::text NOT NULL,
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    _lynxtag uuid DEFAULT public.uuid_generate_v4() NOT NULL
);
    DROP TABLE public.bot_events;
       public         heap 	   fateslist    false    2    2            ?            1259    16444    bot_list_feature    TABLE     ?   CREATE TABLE public.bot_list_feature (
    feature_id integer NOT NULL,
    name text NOT NULL,
    iname text NOT NULL,
    description text,
    positive integer,
    _lynxtag uuid DEFAULT public.uuid_generate_v4() NOT NULL
);
 $   DROP TABLE public.bot_list_feature;
       public         heap 	   fateslist    false    2            ?            1259    16456    bot_list_tags    TABLE     ?   CREATE TABLE public.bot_list_tags (
    id text NOT NULL,
    icon text NOT NULL,
    _lynxtag uuid DEFAULT public.uuid_generate_v4() NOT NULL
);
 !   DROP TABLE public.bot_list_tags;
       public         heap    postgres    false    2            ?            1259    16467 	   bot_owner    TABLE     ?   CREATE TABLE public.bot_owner (
    bot_id bigint NOT NULL,
    owner bigint NOT NULL,
    main boolean DEFAULT false,
    id integer NOT NULL,
    _lynxtag uuid DEFAULT public.uuid_generate_v4() NOT NULL
);
    DROP TABLE public.bot_owner;
       public         heap    postgres    false    2            ?            1259    16471    bot_owner__id_seq    SEQUENCE     ?   CREATE SEQUENCE public.bot_owner__id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.bot_owner__id_seq;
       public          postgres    false    213                       0    0    bot_owner__id_seq    SEQUENCE OWNED BY     F   ALTER SEQUENCE public.bot_owner__id_seq OWNED BY public.bot_owner.id;
          public          postgres    false    214            ?            1259    16472 	   bot_packs    TABLE     t  CREATE TABLE public.bot_packs (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    icon text,
    banner text,
    owner bigint NOT NULL,
    bots bigint[] DEFAULT '{}'::bigint[] NOT NULL,
    description text NOT NULL,
    name text NOT NULL,
    created_at timestamp with time zone DEFAULT now(),
    _lynxtag uuid DEFAULT public.uuid_generate_v4() NOT NULL
);
    DROP TABLE public.bot_packs;
       public         heap    postgres    false    2    2            ?            1259    16478    bot_promotions    TABLE     ?   CREATE TABLE public.bot_promotions (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    bot_id bigint,
    title text,
    info text,
    css text,
    type integer DEFAULT 3,
    _lynxtag uuid DEFAULT public.uuid_generate_v4() NOT NULL
);
 "   DROP TABLE public.bot_promotions;
       public         heap    postgres    false    2    2            ?            1259    16501    bot_stats_votes_pm    TABLE     ?   CREATE TABLE public.bot_stats_votes_pm (
    bot_id bigint,
    votes bigint,
    epoch bigint,
    _lynxtag uuid DEFAULT public.uuid_generate_v4() NOT NULL
);
 &   DROP TABLE public.bot_stats_votes_pm;
       public         heap    postgres    false    2            ?            1259    16504    bot_tags    TABLE     ?   CREATE TABLE public.bot_tags (
    bot_id bigint NOT NULL,
    tag text NOT NULL,
    id integer NOT NULL,
    _lynxtag uuid DEFAULT public.uuid_generate_v4() NOT NULL
);
    DROP TABLE public.bot_tags;
       public         heap    postgres    false    2            ?            1259    16509    bot_tags_id_seq    SEQUENCE     ?   CREATE SEQUENCE public.bot_tags_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.bot_tags_id_seq;
       public          postgres    false    219                        0    0    bot_tags_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public.bot_tags_id_seq OWNED BY public.bot_tags.id;
          public          postgres    false    220            ?            1259    196509 
   bot_voters    TABLE       CREATE TABLE public.bot_voters (
    bot_id bigint NOT NULL,
    user_id bigint NOT NULL,
    timestamps timestamp with time zone[] DEFAULT '{"2022-03-20 16:36:11.388973+00"}'::timestamp with time zone[] NOT NULL,
    _lynxtag uuid DEFAULT public.uuid_generate_v4() NOT NULL
);
    DROP TABLE public.bot_voters;
       public         heap 	   fateslist    false    2            ?            1259    16517    bots    TABLE     ?  CREATE TABLE public.bots (
    bot_id bigint NOT NULL,
    votes bigint DEFAULT 0,
    guild_count bigint DEFAULT 0,
    shard_count bigint DEFAULT 0,
    bot_library text,
    webhook text,
    description text NOT NULL,
    long_description text NOT NULL,
    prefix text,
    api_token text,
    banner_card text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    invite text DEFAULT ''::text NOT NULL,
    features text[],
    invite_amount integer DEFAULT 0,
    user_count bigint DEFAULT 0,
    css text DEFAULT ''::text,
    shards integer[] DEFAULT '{}'::integer[],
    username_cached text DEFAULT ''::text NOT NULL,
    state integer DEFAULT 1 NOT NULL,
    long_description_type integer NOT NULL,
    verifier bigint,
    last_stats_post timestamp with time zone DEFAULT now() NOT NULL,
    webhook_secret text,
    webhook_type integer,
    di_text text,
    id bigint NOT NULL,
    banner_page text,
    total_votes bigint DEFAULT 0,
    client_id bigint,
    flags integer[] DEFAULT '{}'::integer[] NOT NULL,
    uptime_checks_total integer DEFAULT 0,
    uptime_checks_failed integer DEFAULT 0,
    page_style integer DEFAULT 0 NOT NULL,
    webhook_hmac_only boolean DEFAULT false,
    last_updated_at timestamp with time zone DEFAULT now() NOT NULL,
    avatar_cached text DEFAULT ''::text NOT NULL,
    disc_cached text DEFAULT ''::text NOT NULL,
    extra_links jsonb DEFAULT '{}'::jsonb NOT NULL,
    _lynxtag uuid DEFAULT public.uuid_generate_v4() NOT NULL
);
    DROP TABLE public.bots;
       public         heap    postgres    false    2                       1259    448552 
   extra_data    TABLE     ?   CREATE TABLE public.extra_data (
    name text,
    value jsonb,
    user_id bigint,
    _lynxtag uuid DEFAULT public.uuid_generate_v4() NOT NULL
);
    DROP TABLE public.extra_data;
       public         heap 	   fateslist    false    2            ?            1259    165169    features    TABLE     ?   CREATE TABLE public.features (
    id text NOT NULL,
    name text NOT NULL,
    description text NOT NULL,
    viewed_as text NOT NULL,
    _lynxtag uuid DEFAULT public.uuid_generate_v4() NOT NULL
);
    DROP TABLE public.features;
       public         heap 	   fateslist    false    2            ?            1259    275136    frostpaw_clients    TABLE     6  CREATE TABLE public.frostpaw_clients (
    id text NOT NULL,
    name text NOT NULL,
    domain text NOT NULL,
    privacy_policy text NOT NULL,
    secret text NOT NULL,
    owner_id bigint NOT NULL,
    _lynxtag uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    verified boolean DEFAULT false NOT NULL
);
 $   DROP TABLE public.frostpaw_clients;
       public         heap 	   fateslist    false    2            ?            1259    152291    leave_of_absence    TABLE     ?   CREATE TABLE public.leave_of_absence (
    reason text,
    estimated_time interval,
    start_date timestamp with time zone DEFAULT now(),
    user_id bigint,
    id integer NOT NULL,
    _lynxtag uuid DEFAULT public.uuid_generate_v4() NOT NULL
);
 $   DROP TABLE public.leave_of_absence;
       public         heap 	   fateslist    false    2            ?            1259    152308    leave_of_absence_id_seq    SEQUENCE     ?   CREATE SEQUENCE public.leave_of_absence_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE public.leave_of_absence_id_seq;
       public       	   fateslist    false    234            !           0    0    leave_of_absence_id_seq    SEQUENCE OWNED BY     S   ALTER SEQUENCE public.leave_of_absence_id_seq OWNED BY public.leave_of_absence.id;
          public       	   fateslist    false    235            ?            1259    179971 	   lynx_apps    TABLE     (  CREATE TABLE public.lynx_apps (
    user_id bigint,
    app_id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    questions jsonb,
    answers jsonb,
    app_version integer,
    created_at timestamp with time zone DEFAULT now(),
    _lynxtag uuid DEFAULT public.uuid_generate_v4() NOT NULL
);
    DROP TABLE public.lynx_apps;
       public         heap 	   fateslist    false    2    2            ?            1259    225662 	   lynx_data    TABLE     ?   CREATE TABLE public.lynx_data (
    default_user_experiments integer[],
    id integer NOT NULL,
    _lynxtag uuid DEFAULT public.uuid_generate_v4() NOT NULL
);
    DROP TABLE public.lynx_data;
       public         heap 	   fateslist    false    2            ?            1259    229858    lynx_data_id_seq    SEQUENCE     ?   CREATE SEQUENCE public.lynx_data_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE public.lynx_data_id_seq;
       public       	   fateslist    false    250            "           0    0    lynx_data_id_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE public.lynx_data_id_seq OWNED BY public.lynx_data.id;
          public       	   fateslist    false    251            ?            1259    180216 	   lynx_logs    TABLE     	  CREATE TABLE public.lynx_logs (
    user_id bigint NOT NULL,
    method text NOT NULL,
    url text NOT NULL,
    status_code integer NOT NULL,
    request_time timestamp with time zone DEFAULT now(),
    _lynxtag uuid DEFAULT public.uuid_generate_v4() NOT NULL
);
    DROP TABLE public.lynx_logs;
       public         heap 	   fateslist    false    2            ?            1259    182562    lynx_notifications    TABLE     4  CREATE TABLE public.lynx_notifications (
    acked_users bigint[] DEFAULT '{}'::bigint[] NOT NULL,
    message text NOT NULL,
    type text NOT NULL,
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    staff_only boolean DEFAULT false,
    _lynxtag uuid DEFAULT public.uuid_generate_v4() NOT NULL
);
 &   DROP TABLE public.lynx_notifications;
       public         heap 	   fateslist    false    2    2            ?            1259    183895    lynx_ratings    TABLE       CREATE TABLE public.lynx_ratings (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    feedback text NOT NULL,
    username_cached text NOT NULL,
    user_id bigint,
    page text NOT NULL,
    _lynxtag uuid DEFAULT public.uuid_generate_v4() NOT NULL
);
     DROP TABLE public.lynx_ratings;
       public         heap 	   fateslist    false    2    2            ?            1259    190736    lynx_survey_responses    TABLE     2  CREATE TABLE public.lynx_survey_responses (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    questions jsonb NOT NULL,
    answers jsonb NOT NULL,
    username_cached text NOT NULL,
    user_id bigint,
    survey_id uuid NOT NULL,
    _lynxtag uuid DEFAULT public.uuid_generate_v4() NOT NULL
);
 )   DROP TABLE public.lynx_survey_responses;
       public         heap 	   fateslist    false    2    2            ?            1259    190752    lynx_surveys    TABLE     	  CREATE TABLE public.lynx_surveys (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    title text NOT NULL,
    questions jsonb NOT NULL,
    created_at timestamp with time zone DEFAULT now(),
    _lynxtag uuid DEFAULT public.uuid_generate_v4() NOT NULL
);
     DROP TABLE public.lynx_surveys;
       public         heap 	   fateslist    false    2    2            ?            1259    16545 	   migration    TABLE     X  CREATE TABLE public.migration (
    id integer NOT NULL,
    name character varying(200) DEFAULT ''::character varying NOT NULL,
    app_name character varying(200) DEFAULT ''::character varying NOT NULL,
    ran_on timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    _lynxtag uuid DEFAULT public.uuid_generate_v4() NOT NULL
);
    DROP TABLE public.migration;
       public         heap    postgres    false    2            ?            1259    16551    migration_id_seq    SEQUENCE     ?   CREATE SEQUENCE public.migration_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE public.migration_id_seq;
       public          postgres    false    222            #           0    0    migration_id_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE public.migration_id_seq OWNED BY public.migration.id;
          public          postgres    false    223            ?            1259    16552    piccolo_user    TABLE     ?  CREATE TABLE public.piccolo_user (
    id integer NOT NULL,
    username character varying(100) DEFAULT ''::character varying NOT NULL,
    password character varying(255) DEFAULT ''::character varying NOT NULL,
    email character varying(255) DEFAULT ''::character varying NOT NULL,
    active boolean DEFAULT false NOT NULL,
    admin boolean DEFAULT false NOT NULL,
    first_name character varying(255) DEFAULT ''::character varying,
    last_name character varying(255) DEFAULT ''::character varying,
    superuser boolean DEFAULT false NOT NULL,
    last_login timestamp without time zone,
    _lynxtag uuid DEFAULT public.uuid_generate_v4() NOT NULL
);
     DROP TABLE public.piccolo_user;
       public         heap    postgres    false    2            ?            1259    16565    piccolo_user_id_seq    SEQUENCE     ?   CREATE SEQUENCE public.piccolo_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public.piccolo_user_id_seq;
       public          postgres    false    224            $           0    0    piccolo_user_id_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public.piccolo_user_id_seq OWNED BY public.piccolo_user.id;
          public          postgres    false    225            ?            1259    91776    platform_map    TABLE     ?   CREATE TABLE public.platform_map (
    fates_id numeric NOT NULL,
    platform_id text NOT NULL,
    _lynxtag uuid DEFAULT public.uuid_generate_v4() NOT NULL
);
     DROP TABLE public.platform_map;
       public         heap 	   fateslist    false    2            ?            1259    327698    push_notifications    TABLE       CREATE TABLE public.push_notifications (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    user_id bigint NOT NULL,
    endpoint text NOT NULL,
    p256dh text NOT NULL,
    auth text NOT NULL,
    _lynxtag uuid DEFAULT public.uuid_generate_v4() NOT NULL
);
 &   DROP TABLE public.push_notifications;
       public         heap 	   fateslist    false    2    2            ?            1259    172769    review_votes    TABLE     ?   CREATE TABLE public.review_votes (
    id uuid NOT NULL,
    user_id bigint NOT NULL,
    upvote boolean NOT NULL,
    _lynxtag uuid DEFAULT public.uuid_generate_v4() NOT NULL
);
     DROP TABLE public.review_votes;
       public         heap 	   fateslist    false    2            ?            1259    16485    reviews    TABLE     ?  CREATE TABLE public.reviews (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    target_id bigint NOT NULL,
    user_id bigint NOT NULL,
    star_rating numeric(4,2) DEFAULT 0.0 NOT NULL,
    review_text text NOT NULL,
    flagged boolean DEFAULT false NOT NULL,
    epoch bigint[] DEFAULT '{}'::bigint[] NOT NULL,
    target_type integer DEFAULT 0,
    parent_id uuid,
    _lynxtag uuid DEFAULT public.uuid_generate_v4() NOT NULL
);
    DROP TABLE public.reviews;
       public         heap    postgres    false    2    2            ?            1259    199497    server_audit_logs    TABLE     ?  CREATE TABLE public.server_audit_logs (
    guild_id bigint NOT NULL,
    user_id bigint NOT NULL,
    username text NOT NULL,
    user_guild_perms text NOT NULL,
    field text NOT NULL,
    value text NOT NULL,
    action_time timestamp with time zone DEFAULT now() NOT NULL,
    action_id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    _lynxtag uuid DEFAULT public.uuid_generate_v4() NOT NULL
);
 %   DROP TABLE public.server_audit_logs;
       public         heap 	   fateslist    false    2    2            ?            1259    65555    server_tags    TABLE     ?   CREATE TABLE public.server_tags (
    id text NOT NULL,
    name text NOT NULL,
    owner_guild bigint NOT NULL,
    iconify_data text NOT NULL,
    _lynxtag uuid DEFAULT public.uuid_generate_v4() NOT NULL
);
    DROP TABLE public.server_tags;
       public         heap 	   fateslist    false    2            ?            1259    196515    server_voters    TABLE       CREATE TABLE public.server_voters (
    guild_id bigint NOT NULL,
    user_id bigint NOT NULL,
    timestamps timestamp with time zone[] DEFAULT '{"2022-03-20 16:36:33.784499+00"}'::timestamp with time zone[] NOT NULL,
    _lynxtag uuid DEFAULT public.uuid_generate_v4() NOT NULL
);
 !   DROP TABLE public.server_voters;
       public         heap 	   fateslist    false    2            ?            1259    16572    servers    TABLE     n  CREATE TABLE public.servers (
    guild_id bigint NOT NULL,
    votes bigint DEFAULT 0,
    webhook text,
    description text DEFAULT 'No description set'::text NOT NULL,
    long_description text DEFAULT 'No long description set! Set one with /settings longdesc Long description'::text NOT NULL,
    css text DEFAULT ''::text,
    api_token text NOT NULL,
    invite_amount integer DEFAULT 0,
    invite_url text,
    name_cached text NOT NULL,
    long_description_type integer DEFAULT 0,
    state integer DEFAULT 0 NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    avatar_cached text DEFAULT 'Unlisted'::text,
    invite_channel bigint,
    guild_count bigint DEFAULT 0,
    banner_card text,
    banner_page text,
    webhook_secret text,
    webhook_type integer DEFAULT 1,
    total_votes bigint DEFAULT 0,
    tags text[] DEFAULT '{}'::text[],
    owner_id bigint NOT NULL,
    flags integer[] DEFAULT '{}'::integer[] NOT NULL,
    autorole_votes bigint[] DEFAULT '{}'::bigint[],
    whitelist_form text,
    webhook_hmac_only boolean DEFAULT false,
    old_state integer DEFAULT 0 NOT NULL,
    user_whitelist bigint[] DEFAULT '{}'::bigint[] NOT NULL,
    user_blacklist bigint[] DEFAULT '{}'::bigint[] NOT NULL,
    extra_links jsonb DEFAULT '{}'::jsonb NOT NULL,
    _lynxtag uuid DEFAULT public.uuid_generate_v4() NOT NULL
)
WITH (fillfactor='70');
    DROP TABLE public.servers;
       public         heap    postgres    false    2            ?            1259    16585    sessions    TABLE     ?  CREATE TABLE public.sessions (
    id integer NOT NULL,
    token character varying(100) DEFAULT ''::character varying NOT NULL,
    user_id integer DEFAULT 0 NOT NULL,
    expiry_date timestamp without time zone DEFAULT (CURRENT_TIMESTAMP + '01:00:00'::interval) NOT NULL,
    max_expiry_date timestamp without time zone DEFAULT (CURRENT_TIMESTAMP + '7 days'::interval) NOT NULL,
    _lynxtag uuid DEFAULT public.uuid_generate_v4() NOT NULL
);
    DROP TABLE public.sessions;
       public         heap    postgres    false    2            ?            1259    16592    sessions_id_seq    SEQUENCE     ?   CREATE SEQUENCE public.sessions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.sessions_id_seq;
       public          postgres    false    227            %           0    0    sessions_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public.sessions_id_seq OWNED BY public.sessions.id;
          public          postgres    false    228            ?            1259    81062    user_bot_logs    TABLE       CREATE TABLE public.user_bot_logs (
    user_id bigint NOT NULL,
    bot_id bigint NOT NULL,
    action_time timestamp with time zone DEFAULT now() NOT NULL,
    action integer NOT NULL,
    context text,
    _lynxtag uuid DEFAULT public.uuid_generate_v4() NOT NULL
);
 !   DROP TABLE public.user_bot_logs;
       public         heap 	   fateslist    false    2            ?            1259    275603    user_connections    TABLE       CREATE TABLE public.user_connections (
    user_id bigint NOT NULL,
    client_id text NOT NULL,
    refresh_token text NOT NULL,
    expires_on timestamp with time zone DEFAULT (now() + '7 days'::interval) NOT NULL,
    _lynxtag uuid DEFAULT public.uuid_generate_v4() NOT NULL
);
 $   DROP TABLE public.user_connections;
       public         heap 	   fateslist    false    2            ?            1259    196531    user_server_vote_table    TABLE     ?   CREATE TABLE public.user_server_vote_table (
    user_id bigint NOT NULL,
    guild_id bigint NOT NULL,
    expires_on timestamp with time zone DEFAULT (now() + '08:00:00'::interval),
    _lynxtag uuid DEFAULT public.uuid_generate_v4() NOT NULL
);
 *   DROP TABLE public.user_server_vote_table;
       public         heap 	   fateslist    false    2            ?            1259    177299    user_vote_table    TABLE     ?   CREATE TABLE public.user_vote_table (
    user_id bigint NOT NULL,
    bot_id bigint NOT NULL,
    expires_on timestamp with time zone DEFAULT (now() + '08:00:00'::interval),
    _lynxtag uuid DEFAULT public.uuid_generate_v4() NOT NULL
);
 #   DROP TABLE public.user_vote_table;
       public         heap 	   fateslist    false    2            ?            1259    16611    users    TABLE     ^  CREATE TABLE public.users (
    user_id bigint NOT NULL,
    api_token text NOT NULL,
    description text DEFAULT 'This user prefers to be an enigma'::text,
    badges text[],
    username text,
    user_css text DEFAULT ''::text,
    state integer DEFAULT 0 NOT NULL,
    coins integer DEFAULT 0,
    id bigint NOT NULL,
    site_lang text DEFAULT 'default'::text,
    profile_css text DEFAULT ''::text NOT NULL,
    vote_reminders bigint[] DEFAULT '{}'::bigint[] NOT NULL,
    vote_reminder_channel bigint,
    staff_verify_code text,
    vote_reminders_last_acked timestamp with time zone DEFAULT now() NOT NULL,
    vote_reminders_servers bigint[] DEFAULT '{}'::bigint[] NOT NULL,
    vote_reminders_servers_last_acked timestamp with time zone DEFAULT now() NOT NULL,
    vote_reminder_servers_channel bigint,
    experiments integer[] DEFAULT '{}'::integer[] NOT NULL,
    flags integer[] DEFAULT '{}'::integer[] NOT NULL,
    extra_links jsonb DEFAULT '{}'::jsonb NOT NULL,
    supabase_id uuid,
    totp_shared_key text,
    staff_password text,
    _lynxtag uuid DEFAULT public.uuid_generate_v4() NOT NULL
);
    DROP TABLE public.users;
       public         heap    postgres    false    2            ?            1259    16622    vanity    TABLE     ?   CREATE TABLE public.vanity (
    type integer,
    vanity_url text,
    redirect bigint,
    _lynxtag uuid DEFAULT public.uuid_generate_v4() NOT NULL
);
    DROP TABLE public.vanity;
       public         heap    postgres    false    2            ?            1259    400612 	   ws_events    TABLE     ?   CREATE TABLE public.ws_events (
    id bigint NOT NULL,
    type text NOT NULL,
    ts timestamp with time zone DEFAULT now() NOT NULL,
    event jsonb NOT NULL,
    _lynxtag uuid DEFAULT public.uuid_generate_v4() NOT NULL
);
    DROP TABLE public.ws_events;
       public         heap 	   fateslist    false    2            A           2604    16629    bot_owner id    DEFAULT     m   ALTER TABLE ONLY public.bot_owner ALTER COLUMN id SET DEFAULT nextval('public.bot_owner__id_seq'::regclass);
 ;   ALTER TABLE public.bot_owner ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    214    213            Q           2604    16630    bot_tags id    DEFAULT     j   ALTER TABLE ONLY public.bot_tags ALTER COLUMN id SET DEFAULT nextval('public.bot_tags_id_seq'::regclass);
 :   ALTER TABLE public.bot_tags ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    220    219            ?           2604    152309    leave_of_absence id    DEFAULT     z   ALTER TABLE ONLY public.leave_of_absence ALTER COLUMN id SET DEFAULT nextval('public.leave_of_absence_id_seq'::regclass);
 B   ALTER TABLE public.leave_of_absence ALTER COLUMN id DROP DEFAULT;
       public       	   fateslist    false    235    234            ?           2604    229859    lynx_data id    DEFAULT     l   ALTER TABLE ONLY public.lynx_data ALTER COLUMN id SET DEFAULT nextval('public.lynx_data_id_seq'::regclass);
 ;   ALTER TABLE public.lynx_data ALTER COLUMN id DROP DEFAULT;
       public       	   fateslist    false    251    250            l           2604    16632    migration id    DEFAULT     l   ALTER TABLE ONLY public.migration ALTER COLUMN id SET DEFAULT nextval('public.migration_id_seq'::regclass);
 ;   ALTER TABLE public.migration ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    223    222            v           2604    16633    piccolo_user id    DEFAULT     r   ALTER TABLE ONLY public.piccolo_user ALTER COLUMN id SET DEFAULT nextval('public.piccolo_user_id_seq'::regclass);
 >   ALTER TABLE public.piccolo_user ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    225    224            ?           2604    16634    sessions id    DEFAULT     j   ALTER TABLE ONLY public.sessions ALTER COLUMN id SET DEFAULT nextval('public.sessions_id_seq'::regclass);
 :   ALTER TABLE public.sessions ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    228    227            F           2606    427844    bot_commands bc_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.bot_commands
    ADD CONSTRAINT bc_pkey PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.bot_commands DROP CONSTRAINT bc_pkey;
       public         	   fateslist    false    243            H           2606    427907 &   bot_commands bot_commands__lynxtag_key 
   CONSTRAINT     e   ALTER TABLE ONLY public.bot_commands
    ADD CONSTRAINT bot_commands__lynxtag_key UNIQUE (_lynxtag);
 P   ALTER TABLE ONLY public.bot_commands DROP CONSTRAINT bot_commands__lynxtag_key;
       public         	   fateslist    false    243            l           2606    427928 "   bot_events bot_events__lynxtag_key 
   CONSTRAINT     a   ALTER TABLE ONLY public.bot_events
    ADD CONSTRAINT bot_events__lynxtag_key UNIQUE (_lynxtag);
 L   ALTER TABLE ONLY public.bot_events DROP CONSTRAINT bot_events__lynxtag_key;
       public         	   fateslist    false    256            ?           2606    92227    bots bot_id_unique 
   CONSTRAINT     O   ALTER TABLE ONLY public.bots
    ADD CONSTRAINT bot_id_unique UNIQUE (bot_id);
 <   ALTER TABLE ONLY public.bots DROP CONSTRAINT bot_id_unique;
       public            postgres    false    221            ?           2606    427937 .   bot_list_feature bot_list_feature__lynxtag_key 
   CONSTRAINT     m   ALTER TABLE ONLY public.bot_list_feature
    ADD CONSTRAINT bot_list_feature__lynxtag_key UNIQUE (_lynxtag);
 X   ALTER TABLE ONLY public.bot_list_feature DROP CONSTRAINT bot_list_feature__lynxtag_key;
       public         	   fateslist    false    211            ?           2606    16772 +   bot_list_feature bot_list_feature_iname_key 
   CONSTRAINT     g   ALTER TABLE ONLY public.bot_list_feature
    ADD CONSTRAINT bot_list_feature_iname_key UNIQUE (iname);
 U   ALTER TABLE ONLY public.bot_list_feature DROP CONSTRAINT bot_list_feature_iname_key;
       public         	   fateslist    false    211            ?           2606    16774 *   bot_list_feature bot_list_feature_name_key 
   CONSTRAINT     e   ALTER TABLE ONLY public.bot_list_feature
    ADD CONSTRAINT bot_list_feature_name_key UNIQUE (name);
 T   ALTER TABLE ONLY public.bot_list_feature DROP CONSTRAINT bot_list_feature_name_key;
       public         	   fateslist    false    211            ?           2606    16776 &   bot_list_feature bot_list_feature_pkey 
   CONSTRAINT     l   ALTER TABLE ONLY public.bot_list_feature
    ADD CONSTRAINT bot_list_feature_pkey PRIMARY KEY (feature_id);
 P   ALTER TABLE ONLY public.bot_list_feature DROP CONSTRAINT bot_list_feature_pkey;
       public         	   fateslist    false    211            ?           2606    427949 (   bot_list_tags bot_list_tags__lynxtag_key 
   CONSTRAINT     g   ALTER TABLE ONLY public.bot_list_tags
    ADD CONSTRAINT bot_list_tags__lynxtag_key UNIQUE (_lynxtag);
 R   ALTER TABLE ONLY public.bot_list_tags DROP CONSTRAINT bot_list_tags__lynxtag_key;
       public            postgres    false    212            ?           2606    16778 $   bot_list_tags bot_list_tags_icon_key 
   CONSTRAINT     _   ALTER TABLE ONLY public.bot_list_tags
    ADD CONSTRAINT bot_list_tags_icon_key UNIQUE (icon);
 N   ALTER TABLE ONLY public.bot_list_tags DROP CONSTRAINT bot_list_tags_icon_key;
       public            postgres    false    212            ?           2606    16780 "   bot_list_tags bot_list_tags_id_key 
   CONSTRAINT     [   ALTER TABLE ONLY public.bot_list_tags
    ADD CONSTRAINT bot_list_tags_id_key UNIQUE (id);
 L   ALTER TABLE ONLY public.bot_list_tags DROP CONSTRAINT bot_list_tags_id_key;
       public            postgres    false    212            ?           2606    427960     bot_owner bot_owner__lynxtag_key 
   CONSTRAINT     _   ALTER TABLE ONLY public.bot_owner
    ADD CONSTRAINT bot_owner__lynxtag_key UNIQUE (_lynxtag);
 J   ALTER TABLE ONLY public.bot_owner DROP CONSTRAINT bot_owner__lynxtag_key;
       public            postgres    false    213            ?           2606    427967     bot_packs bot_packs__lynxtag_key 
   CONSTRAINT     _   ALTER TABLE ONLY public.bot_packs
    ADD CONSTRAINT bot_packs__lynxtag_key UNIQUE (_lynxtag);
 J   ALTER TABLE ONLY public.bot_packs DROP CONSTRAINT bot_packs__lynxtag_key;
       public            postgres    false    215            ?           2606    16790    bot_packs bot_packs_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.bot_packs
    ADD CONSTRAINT bot_packs_pkey PRIMARY KEY (id);
 B   ALTER TABLE ONLY public.bot_packs DROP CONSTRAINT bot_packs_pkey;
       public            postgres    false    215            ?           2606    427977 *   bot_promotions bot_promotions__lynxtag_key 
   CONSTRAINT     i   ALTER TABLE ONLY public.bot_promotions
    ADD CONSTRAINT bot_promotions__lynxtag_key UNIQUE (_lynxtag);
 T   ALTER TABLE ONLY public.bot_promotions DROP CONSTRAINT bot_promotions__lynxtag_key;
       public            postgres    false    216            ?           2606    16792    reviews bot_reviews_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT bot_reviews_pkey PRIMARY KEY (id);
 B   ALTER TABLE ONLY public.reviews DROP CONSTRAINT bot_reviews_pkey;
       public            postgres    false    217            ?           2606    427987 2   bot_stats_votes_pm bot_stats_votes_pm__lynxtag_key 
   CONSTRAINT     q   ALTER TABLE ONLY public.bot_stats_votes_pm
    ADD CONSTRAINT bot_stats_votes_pm__lynxtag_key UNIQUE (_lynxtag);
 \   ALTER TABLE ONLY public.bot_stats_votes_pm DROP CONSTRAINT bot_stats_votes_pm__lynxtag_key;
       public            postgres    false    218            ?           2606    427994    bot_tags bot_tags__lynxtag_key 
   CONSTRAINT     ]   ALTER TABLE ONLY public.bot_tags
    ADD CONSTRAINT bot_tags__lynxtag_key UNIQUE (_lynxtag);
 H   ALTER TABLE ONLY public.bot_tags DROP CONSTRAINT bot_tags__lynxtag_key;
       public            postgres    false    219            P           2606    428003 "   bot_voters bot_voters__lynxtag_key 
   CONSTRAINT     a   ALTER TABLE ONLY public.bot_voters
    ADD CONSTRAINT bot_voters__lynxtag_key UNIQUE (_lynxtag);
 L   ALTER TABLE ONLY public.bot_voters DROP CONSTRAINT bot_voters__lynxtag_key;
       public         	   fateslist    false    246                       2606    428012    bots bots__lynxtag_key 
   CONSTRAINT     U   ALTER TABLE ONLY public.bots
    ADD CONSTRAINT bots__lynxtag_key UNIQUE (_lynxtag);
 @   ALTER TABLE ONLY public.bots DROP CONSTRAINT bots__lynxtag_key;
       public            postgres    false    221                       2606    16794    bots bots_api_token_key 
   CONSTRAINT     W   ALTER TABLE ONLY public.bots
    ADD CONSTRAINT bots_api_token_key UNIQUE (api_token);
 A   ALTER TABLE ONLY public.bots DROP CONSTRAINT bots_api_token_key;
       public            postgres    false    221                        2606    16796    vanity constraintname 
   CONSTRAINT     V   ALTER TABLE ONLY public.vanity
    ADD CONSTRAINT constraintname UNIQUE (vanity_url);
 ?   ALTER TABLE ONLY public.vanity DROP CONSTRAINT constraintname;
       public            postgres    false    230            n           2606    448564 "   extra_data extra_data__lynxtag_key 
   CONSTRAINT     a   ALTER TABLE ONLY public.extra_data
    ADD CONSTRAINT extra_data__lynxtag_key UNIQUE (_lynxtag);
 L   ALTER TABLE ONLY public.extra_data DROP CONSTRAINT extra_data__lynxtag_key;
       public         	   fateslist    false    257            2           2606    428181    features features__lynxtag_key 
   CONSTRAINT     ]   ALTER TABLE ONLY public.features
    ADD CONSTRAINT features__lynxtag_key UNIQUE (_lynxtag);
 H   ALTER TABLE ONLY public.features DROP CONSTRAINT features__lynxtag_key;
       public         	   fateslist    false    236            `           2606    428190 .   frostpaw_clients frostpaw_clients__lynxtag_key 
   CONSTRAINT     m   ALTER TABLE ONLY public.frostpaw_clients
    ADD CONSTRAINT frostpaw_clients__lynxtag_key UNIQUE (_lynxtag);
 X   ALTER TABLE ONLY public.frostpaw_clients DROP CONSTRAINT frostpaw_clients__lynxtag_key;
       public         	   fateslist    false    252            0           2606    428199 .   leave_of_absence leave_of_absence__lynxtag_key 
   CONSTRAINT     m   ALTER TABLE ONLY public.leave_of_absence
    ADD CONSTRAINT leave_of_absence__lynxtag_key UNIQUE (_lynxtag);
 X   ALTER TABLE ONLY public.leave_of_absence DROP CONSTRAINT leave_of_absence__lynxtag_key;
       public         	   fateslist    false    234            <           2606    428208     lynx_apps lynx_apps__lynxtag_key 
   CONSTRAINT     _   ALTER TABLE ONLY public.lynx_apps
    ADD CONSTRAINT lynx_apps__lynxtag_key UNIQUE (_lynxtag);
 J   ALTER TABLE ONLY public.lynx_apps DROP CONSTRAINT lynx_apps__lynxtag_key;
       public         	   fateslist    false    239            >           2606    179978    lynx_apps lynx_apps_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.lynx_apps
    ADD CONSTRAINT lynx_apps_pkey PRIMARY KEY (app_id);
 B   ALTER TABLE ONLY public.lynx_apps DROP CONSTRAINT lynx_apps_pkey;
       public         	   fateslist    false    239            \           2606    428220     lynx_data lynx_data__lynxtag_key 
   CONSTRAINT     _   ALTER TABLE ONLY public.lynx_data
    ADD CONSTRAINT lynx_data__lynxtag_key UNIQUE (_lynxtag);
 J   ALTER TABLE ONLY public.lynx_data DROP CONSTRAINT lynx_data__lynxtag_key;
       public         	   fateslist    false    250            ^           2606    229861    lynx_data lynx_data_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.lynx_data
    ADD CONSTRAINT lynx_data_pkey PRIMARY KEY (id);
 B   ALTER TABLE ONLY public.lynx_data DROP CONSTRAINT lynx_data_pkey;
       public         	   fateslist    false    250            @           2606    428230     lynx_logs lynx_logs__lynxtag_key 
   CONSTRAINT     _   ALTER TABLE ONLY public.lynx_logs
    ADD CONSTRAINT lynx_logs__lynxtag_key UNIQUE (_lynxtag);
 J   ALTER TABLE ONLY public.lynx_logs DROP CONSTRAINT lynx_logs__lynxtag_key;
       public         	   fateslist    false    240            B           2606    428239 2   lynx_notifications lynx_notifications__lynxtag_key 
   CONSTRAINT     q   ALTER TABLE ONLY public.lynx_notifications
    ADD CONSTRAINT lynx_notifications__lynxtag_key UNIQUE (_lynxtag);
 \   ALTER TABLE ONLY public.lynx_notifications DROP CONSTRAINT lynx_notifications__lynxtag_key;
       public         	   fateslist    false    241            D           2606    428248 &   lynx_ratings lynx_ratings__lynxtag_key 
   CONSTRAINT     e   ALTER TABLE ONLY public.lynx_ratings
    ADD CONSTRAINT lynx_ratings__lynxtag_key UNIQUE (_lynxtag);
 P   ALTER TABLE ONLY public.lynx_ratings DROP CONSTRAINT lynx_ratings__lynxtag_key;
       public         	   fateslist    false    242            J           2606    428257 8   lynx_survey_responses lynx_survey_responses__lynxtag_key 
   CONSTRAINT     w   ALTER TABLE ONLY public.lynx_survey_responses
    ADD CONSTRAINT lynx_survey_responses__lynxtag_key UNIQUE (_lynxtag);
 b   ALTER TABLE ONLY public.lynx_survey_responses DROP CONSTRAINT lynx_survey_responses__lynxtag_key;
       public         	   fateslist    false    244            L           2606    428266 &   lynx_surveys lynx_surveys__lynxtag_key 
   CONSTRAINT     e   ALTER TABLE ONLY public.lynx_surveys
    ADD CONSTRAINT lynx_surveys__lynxtag_key UNIQUE (_lynxtag);
 P   ALTER TABLE ONLY public.lynx_surveys DROP CONSTRAINT lynx_surveys__lynxtag_key;
       public         	   fateslist    false    245                       2606    428276     migration migration__lynxtag_key 
   CONSTRAINT     _   ALTER TABLE ONLY public.migration
    ADD CONSTRAINT migration__lynxtag_key UNIQUE (_lynxtag);
 J   ALTER TABLE ONLY public.migration DROP CONSTRAINT migration__lynxtag_key;
       public            postgres    false    222                       2606    16800    migration migration_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.migration
    ADD CONSTRAINT migration_pkey PRIMARY KEY (id);
 B   ALTER TABLE ONLY public.migration DROP CONSTRAINT migration_pkey;
       public            postgres    false    222            
           2606    428284 &   piccolo_user piccolo_user__lynxtag_key 
   CONSTRAINT     e   ALTER TABLE ONLY public.piccolo_user
    ADD CONSTRAINT piccolo_user__lynxtag_key UNIQUE (_lynxtag);
 P   ALTER TABLE ONLY public.piccolo_user DROP CONSTRAINT piccolo_user__lynxtag_key;
       public            postgres    false    224                       2606    16808 #   piccolo_user piccolo_user_email_key 
   CONSTRAINT     _   ALTER TABLE ONLY public.piccolo_user
    ADD CONSTRAINT piccolo_user_email_key UNIQUE (email);
 M   ALTER TABLE ONLY public.piccolo_user DROP CONSTRAINT piccolo_user_email_key;
       public            postgres    false    224                       2606    16810    piccolo_user piccolo_user_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.piccolo_user
    ADD CONSTRAINT piccolo_user_pkey PRIMARY KEY (id);
 H   ALTER TABLE ONLY public.piccolo_user DROP CONSTRAINT piccolo_user_pkey;
       public            postgres    false    224                       2606    16812 &   piccolo_user piccolo_user_username_key 
   CONSTRAINT     e   ALTER TABLE ONLY public.piccolo_user
    ADD CONSTRAINT piccolo_user_username_key UNIQUE (username);
 P   ALTER TABLE ONLY public.piccolo_user DROP CONSTRAINT piccolo_user_username_key;
       public            postgres    false    224            .           2606    428296 &   platform_map platform_map__lynxtag_key 
   CONSTRAINT     e   ALTER TABLE ONLY public.platform_map
    ADD CONSTRAINT platform_map__lynxtag_key UNIQUE (_lynxtag);
 P   ALTER TABLE ONLY public.platform_map DROP CONSTRAINT platform_map__lynxtag_key;
       public         	   fateslist    false    233            ?           2606    16814    bot_promotions promotions_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.bot_promotions
    ADD CONSTRAINT promotions_pkey PRIMARY KEY (id);
 H   ALTER TABLE ONLY public.bot_promotions DROP CONSTRAINT promotions_pkey;
       public            postgres    false    216            d           2606    428305 2   push_notifications push_notifications__lynxtag_key 
   CONSTRAINT     q   ALTER TABLE ONLY public.push_notifications
    ADD CONSTRAINT push_notifications__lynxtag_key UNIQUE (_lynxtag);
 \   ALTER TABLE ONLY public.push_notifications DROP CONSTRAINT push_notifications__lynxtag_key;
       public         	   fateslist    false    254            f           2606    327709 2   push_notifications push_notifications_endpoint_key 
   CONSTRAINT     q   ALTER TABLE ONLY public.push_notifications
    ADD CONSTRAINT push_notifications_endpoint_key UNIQUE (endpoint);
 \   ALTER TABLE ONLY public.push_notifications DROP CONSTRAINT push_notifications_endpoint_key;
       public         	   fateslist    false    254            h           2606    327707 *   push_notifications push_notifications_pkey 
   CONSTRAINT     h   ALTER TABLE ONLY public.push_notifications
    ADD CONSTRAINT push_notifications_pkey PRIMARY KEY (id);
 T   ALTER TABLE ONLY public.push_notifications DROP CONSTRAINT push_notifications_pkey;
       public         	   fateslist    false    254            4           2606    428316 &   review_votes review_votes__lynxtag_key 
   CONSTRAINT     e   ALTER TABLE ONLY public.review_votes
    ADD CONSTRAINT review_votes__lynxtag_key UNIQUE (_lynxtag);
 P   ALTER TABLE ONLY public.review_votes DROP CONSTRAINT review_votes__lynxtag_key;
       public         	   fateslist    false    237            6           2606    172955    review_votes review_votes_pkey 
   CONSTRAINT     e   ALTER TABLE ONLY public.review_votes
    ADD CONSTRAINT review_votes_pkey PRIMARY KEY (id, user_id);
 H   ALTER TABLE ONLY public.review_votes DROP CONSTRAINT review_votes_pkey;
       public         	   fateslist    false    237    237            ?           2606    428324    reviews reviews__lynxtag_key 
   CONSTRAINT     [   ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT reviews__lynxtag_key UNIQUE (_lynxtag);
 F   ALTER TABLE ONLY public.reviews DROP CONSTRAINT reviews__lynxtag_key;
       public            postgres    false    217            X           2606    428334 0   server_audit_logs server_audit_logs__lynxtag_key 
   CONSTRAINT     o   ALTER TABLE ONLY public.server_audit_logs
    ADD CONSTRAINT server_audit_logs__lynxtag_key UNIQUE (_lynxtag);
 Z   ALTER TABLE ONLY public.server_audit_logs DROP CONSTRAINT server_audit_logs__lynxtag_key;
       public         	   fateslist    false    249            Z           2606    199505 (   server_audit_logs server_audit_logs_pkey 
   CONSTRAINT     m   ALTER TABLE ONLY public.server_audit_logs
    ADD CONSTRAINT server_audit_logs_pkey PRIMARY KEY (action_id);
 R   ALTER TABLE ONLY public.server_audit_logs DROP CONSTRAINT server_audit_logs_pkey;
       public         	   fateslist    false    249            &           2606    428344 $   server_tags server_tags__lynxtag_key 
   CONSTRAINT     c   ALTER TABLE ONLY public.server_tags
    ADD CONSTRAINT server_tags__lynxtag_key UNIQUE (_lynxtag);
 N   ALTER TABLE ONLY public.server_tags DROP CONSTRAINT server_tags__lynxtag_key;
       public         	   fateslist    false    231            (           2606    65561    server_tags server_tags_id_key 
   CONSTRAINT     W   ALTER TABLE ONLY public.server_tags
    ADD CONSTRAINT server_tags_id_key UNIQUE (id);
 H   ALTER TABLE ONLY public.server_tags DROP CONSTRAINT server_tags_id_key;
       public         	   fateslist    false    231            *           2606    65563     server_tags server_tags_name_key 
   CONSTRAINT     [   ALTER TABLE ONLY public.server_tags
    ADD CONSTRAINT server_tags_name_key UNIQUE (name);
 J   ALTER TABLE ONLY public.server_tags DROP CONSTRAINT server_tags_name_key;
       public         	   fateslist    false    231            R           2606    428355 (   server_voters server_voters__lynxtag_key 
   CONSTRAINT     g   ALTER TABLE ONLY public.server_voters
    ADD CONSTRAINT server_voters__lynxtag_key UNIQUE (_lynxtag);
 R   ALTER TABLE ONLY public.server_voters DROP CONSTRAINT server_voters__lynxtag_key;
       public         	   fateslist    false    247                       2606    428364    servers servers__lynxtag_key 
   CONSTRAINT     [   ALTER TABLE ONLY public.servers
    ADD CONSTRAINT servers__lynxtag_key UNIQUE (_lynxtag);
 F   ALTER TABLE ONLY public.servers DROP CONSTRAINT servers__lynxtag_key;
       public            postgres    false    226                       2606    16816    servers servers_api_token_key 
   CONSTRAINT     ]   ALTER TABLE ONLY public.servers
    ADD CONSTRAINT servers_api_token_key UNIQUE (api_token);
 G   ALTER TABLE ONLY public.servers DROP CONSTRAINT servers_api_token_key;
       public            postgres    false    226                       2606    92152    servers servers_guild_id_key 
   CONSTRAINT     [   ALTER TABLE ONLY public.servers
    ADD CONSTRAINT servers_guild_id_key UNIQUE (guild_id);
 F   ALTER TABLE ONLY public.servers DROP CONSTRAINT servers_guild_id_key;
       public            postgres    false    226                       2606    428375    sessions sessions__lynxtag_key 
   CONSTRAINT     ]   ALTER TABLE ONLY public.sessions
    ADD CONSTRAINT sessions__lynxtag_key UNIQUE (_lynxtag);
 H   ALTER TABLE ONLY public.sessions DROP CONSTRAINT sessions__lynxtag_key;
       public            postgres    false    227                       2606    16820    sessions sessions_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.sessions
    ADD CONSTRAINT sessions_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.sessions DROP CONSTRAINT sessions_pkey;
       public            postgres    false    227            N           2606    190794    lynx_surveys survey_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.lynx_surveys
    ADD CONSTRAINT survey_pkey PRIMARY KEY (id);
 B   ALTER TABLE ONLY public.lynx_surveys DROP CONSTRAINT survey_pkey;
       public         	   fateslist    false    245            ,           2606    428383 (   user_bot_logs user_bot_logs__lynxtag_key 
   CONSTRAINT     g   ALTER TABLE ONLY public.user_bot_logs
    ADD CONSTRAINT user_bot_logs__lynxtag_key UNIQUE (_lynxtag);
 R   ALTER TABLE ONLY public.user_bot_logs DROP CONSTRAINT user_bot_logs__lynxtag_key;
       public         	   fateslist    false    232            b           2606    428392 .   user_connections user_connections__lynxtag_key 
   CONSTRAINT     m   ALTER TABLE ONLY public.user_connections
    ADD CONSTRAINT user_connections__lynxtag_key UNIQUE (_lynxtag);
 X   ALTER TABLE ONLY public.user_connections DROP CONSTRAINT user_connections__lynxtag_key;
       public         	   fateslist    false    253            T           2606    428401 :   user_server_vote_table user_server_vote_table__lynxtag_key 
   CONSTRAINT     y   ALTER TABLE ONLY public.user_server_vote_table
    ADD CONSTRAINT user_server_vote_table__lynxtag_key UNIQUE (_lynxtag);
 d   ALTER TABLE ONLY public.user_server_vote_table DROP CONSTRAINT user_server_vote_table__lynxtag_key;
       public         	   fateslist    false    248            V           2606    196536 2   user_server_vote_table user_server_vote_table_pkey 
   CONSTRAINT     u   ALTER TABLE ONLY public.user_server_vote_table
    ADD CONSTRAINT user_server_vote_table_pkey PRIMARY KEY (user_id);
 \   ALTER TABLE ONLY public.user_server_vote_table DROP CONSTRAINT user_server_vote_table_pkey;
       public         	   fateslist    false    248                       2606    92204    users user_unique 
   CONSTRAINT     O   ALTER TABLE ONLY public.users
    ADD CONSTRAINT user_unique UNIQUE (user_id);
 ;   ALTER TABLE ONLY public.users DROP CONSTRAINT user_unique;
       public            postgres    false    229            8           2606    428409 ,   user_vote_table user_vote_table__lynxtag_key 
   CONSTRAINT     k   ALTER TABLE ONLY public.user_vote_table
    ADD CONSTRAINT user_vote_table__lynxtag_key UNIQUE (_lynxtag);
 V   ALTER TABLE ONLY public.user_vote_table DROP CONSTRAINT user_vote_table__lynxtag_key;
       public         	   fateslist    false    238            :           2606    177304 $   user_vote_table user_vote_table_pkey 
   CONSTRAINT     g   ALTER TABLE ONLY public.user_vote_table
    ADD CONSTRAINT user_vote_table_pkey PRIMARY KEY (user_id);
 N   ALTER TABLE ONLY public.user_vote_table DROP CONSTRAINT user_vote_table_pkey;
       public         	   fateslist    false    238                       2606    428417    users users__lynxtag_key 
   CONSTRAINT     W   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users__lynxtag_key UNIQUE (_lynxtag);
 B   ALTER TABLE ONLY public.users DROP CONSTRAINT users__lynxtag_key;
       public            postgres    false    229            "           2606    428427    vanity vanity__lynxtag_key 
   CONSTRAINT     Y   ALTER TABLE ONLY public.vanity
    ADD CONSTRAINT vanity__lynxtag_key UNIQUE (_lynxtag);
 D   ALTER TABLE ONLY public.vanity DROP CONSTRAINT vanity__lynxtag_key;
       public            postgres    false    230            $           2606    16824    vanity vanity_redirect_key 
   CONSTRAINT     Y   ALTER TABLE ONLY public.vanity
    ADD CONSTRAINT vanity_redirect_key UNIQUE (redirect);
 D   ALTER TABLE ONLY public.vanity DROP CONSTRAINT vanity_redirect_key;
       public            postgres    false    230            j           2606    428438     ws_events ws_events__lynxtag_key 
   CONSTRAINT     _   ALTER TABLE ONLY public.ws_events
    ADD CONSTRAINT ws_events__lynxtag_key UNIQUE (_lynxtag);
 J   ALTER TABLE ONLY public.ws_events DROP CONSTRAINT ws_events__lynxtag_key;
       public         	   fateslist    false    255                       1259    92228 
   bots_index    INDEX     =   CREATE INDEX bots_index ON public.bots USING btree (bot_id);
    DROP INDEX public.bots_index;
       public            postgres    false    221            o           2606    92229    bot_owner bots_fk    FK CONSTRAINT     ?   ALTER TABLE ONLY public.bot_owner
    ADD CONSTRAINT bots_fk FOREIGN KEY (bot_id) REFERENCES public.bots(bot_id) ON UPDATE CASCADE ON DELETE CASCADE;
 ;   ALTER TABLE ONLY public.bot_owner DROP CONSTRAINT bots_fk;
       public          postgres    false    221    3583    213            p           2606    92244    bot_promotions bots_fk    FK CONSTRAINT     ?   ALTER TABLE ONLY public.bot_promotions
    ADD CONSTRAINT bots_fk FOREIGN KEY (bot_id) REFERENCES public.bots(bot_id) ON UPDATE CASCADE ON DELETE CASCADE;
 @   ALTER TABLE ONLY public.bot_promotions DROP CONSTRAINT bots_fk;
       public          postgres    false    3583    221    216            t           2606    92259    bot_tags bots_fk    FK CONSTRAINT     ?   ALTER TABLE ONLY public.bot_tags
    ADD CONSTRAINT bots_fk FOREIGN KEY (bot_id) REFERENCES public.bots(bot_id) ON UPDATE CASCADE ON DELETE CASCADE;
 :   ALTER TABLE ONLY public.bot_tags DROP CONSTRAINT bots_fk;
       public          postgres    false    221    219    3583            ~           2606    187397    bot_commands bots_fk    FK CONSTRAINT     ?   ALTER TABLE ONLY public.bot_commands
    ADD CONSTRAINT bots_fk FOREIGN KEY (bot_id) REFERENCES public.bots(bot_id) ON UPDATE CASCADE ON DELETE CASCADE;
 >   ALTER TABLE ONLY public.bot_commands DROP CONSTRAINT bots_fk;
       public       	   fateslist    false    221    243    3583            ?           2606    400645    bot_events bots_fk    FK CONSTRAINT     ?   ALTER TABLE ONLY public.bot_events
    ADD CONSTRAINT bots_fk FOREIGN KEY (bot_id) REFERENCES public.bots(bot_id) ON UPDATE CASCADE ON DELETE CASCADE;
 <   ALTER TABLE ONLY public.bot_events DROP CONSTRAINT bots_fk;
       public       	   fateslist    false    221    256    3583            r           2606    172301    reviews review_parent_id    FK CONSTRAINT     ?   ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT review_parent_id FOREIGN KEY (parent_id) REFERENCES public.reviews(id) ON UPDATE CASCADE ON DELETE CASCADE;
 B   ALTER TABLE ONLY public.reviews DROP CONSTRAINT review_parent_id;
       public          postgres    false    3575    217    217            x           2606    172772 !   review_votes review_votes_id_fkey    FK CONSTRAINT     ?   ALTER TABLE ONLY public.review_votes
    ADD CONSTRAINT review_votes_id_fkey FOREIGN KEY (id) REFERENCES public.reviews(id) ON UPDATE CASCADE ON DELETE CASCADE;
 K   ALTER TABLE ONLY public.review_votes DROP CONSTRAINT review_votes_id_fkey;
       public       	   fateslist    false    237    3575    217            ?           2606    199506    server_audit_logs servers_fk    FK CONSTRAINT     ?   ALTER TABLE ONLY public.server_audit_logs
    ADD CONSTRAINT servers_fk FOREIGN KEY (guild_id) REFERENCES public.servers(guild_id) ON UPDATE CASCADE ON DELETE CASCADE;
 F   ALTER TABLE ONLY public.server_audit_logs DROP CONSTRAINT servers_fk;
       public       	   fateslist    false    226    249    3606                       2606    190800 !   lynx_survey_responses survey_fkey    FK CONSTRAINT     ?   ALTER TABLE ONLY public.lynx_survey_responses
    ADD CONSTRAINT survey_fkey FOREIGN KEY (survey_id) REFERENCES public.lynx_surveys(id) ON UPDATE CASCADE ON DELETE CASCADE;
 K   ALTER TABLE ONLY public.lynx_survey_responses DROP CONSTRAINT survey_fkey;
       public       	   fateslist    false    244    245    3662            s           2606    16882    bot_tags tags_fk    FK CONSTRAINT     ?   ALTER TABLE ONLY public.bot_tags
    ADD CONSTRAINT tags_fk FOREIGN KEY (tag) REFERENCES public.bot_list_tags(id) ON UPDATE CASCADE ON DELETE CASCADE;
 :   ALTER TABLE ONLY public.bot_tags DROP CONSTRAINT tags_fk;
       public          postgres    false    219    3563    212            {           2606    179979    lynx_apps user_fk    FK CONSTRAINT     ?   ALTER TABLE ONLY public.lynx_apps
    ADD CONSTRAINT user_fk FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON UPDATE CASCADE ON DELETE CASCADE;
 ;   ALTER TABLE ONLY public.lynx_apps DROP CONSTRAINT user_fk;
       public       	   fateslist    false    3612    239    229            u           2606    221870    servers user_fk    FK CONSTRAINT     ?   ALTER TABLE ONLY public.servers
    ADD CONSTRAINT user_fk FOREIGN KEY (owner_id) REFERENCES public.users(user_id) ON UPDATE CASCADE ON DELETE CASCADE;
 9   ALTER TABLE ONLY public.servers DROP CONSTRAINT user_fk;
       public          postgres    false    229    3612    226            ?           2606    221885    server_audit_logs user_fk    FK CONSTRAINT     ?   ALTER TABLE ONLY public.server_audit_logs
    ADD CONSTRAINT user_fk FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON UPDATE CASCADE ON DELETE CASCADE;
 C   ALTER TABLE ONLY public.server_audit_logs DROP CONSTRAINT user_fk;
       public       	   fateslist    false    229    249    3612            |           2606    221890    lynx_logs user_fk    FK CONSTRAINT     ?   ALTER TABLE ONLY public.lynx_logs
    ADD CONSTRAINT user_fk FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON UPDATE CASCADE ON DELETE CASCADE;
 ;   ALTER TABLE ONLY public.lynx_logs DROP CONSTRAINT user_fk;
       public       	   fateslist    false    240    3612    229            ?           2606    275608    user_connections user_fk    FK CONSTRAINT     ?   ALTER TABLE ONLY public.user_connections
    ADD CONSTRAINT user_fk FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON UPDATE CASCADE ON DELETE CASCADE;
 B   ALTER TABLE ONLY public.user_connections DROP CONSTRAINT user_fk;
       public       	   fateslist    false    3612    253    229            ?           2606    285157    frostpaw_clients user_fk    FK CONSTRAINT     ?   ALTER TABLE ONLY public.frostpaw_clients
    ADD CONSTRAINT user_fk FOREIGN KEY (owner_id) REFERENCES public.users(user_id) ON UPDATE CASCADE ON DELETE CASCADE;
 B   ALTER TABLE ONLY public.frostpaw_clients DROP CONSTRAINT user_fk;
       public       	   fateslist    false    3612    252    229            w           2606    327591    leave_of_absence user_fk    FK CONSTRAINT     ?   ALTER TABLE ONLY public.leave_of_absence
    ADD CONSTRAINT user_fk FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON UPDATE CASCADE ON DELETE CASCADE;
 B   ALTER TABLE ONLY public.leave_of_absence DROP CONSTRAINT user_fk;
       public       	   fateslist    false    234    3612    229            ?           2606    327710    push_notifications user_fk    FK CONSTRAINT     ?   ALTER TABLE ONLY public.push_notifications
    ADD CONSTRAINT user_fk FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON UPDATE CASCADE ON DELETE CASCADE;
 D   ALTER TABLE ONLY public.push_notifications DROP CONSTRAINT user_fk;
       public       	   fateslist    false    254    229    3612            q           2606    92210    reviews users_fk    FK CONSTRAINT     ?   ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT users_fk FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON UPDATE CASCADE ON DELETE CASCADE;
 :   ALTER TABLE ONLY public.reviews DROP CONSTRAINT users_fk;
       public          postgres    false    217    3612    229            v           2606    92215    user_bot_logs users_fk    FK CONSTRAINT     ?   ALTER TABLE ONLY public.user_bot_logs
    ADD CONSTRAINT users_fk FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON UPDATE CASCADE ON DELETE CASCADE;
 @   ALTER TABLE ONLY public.user_bot_logs DROP CONSTRAINT users_fk;
       public       	   fateslist    false    229    3612    232            ?           2606    221739    lynx_survey_responses users_fk    FK CONSTRAINT     ?   ALTER TABLE ONLY public.lynx_survey_responses
    ADD CONSTRAINT users_fk FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON UPDATE CASCADE ON DELETE CASCADE;
 H   ALTER TABLE ONLY public.lynx_survey_responses DROP CONSTRAINT users_fk;
       public       	   fateslist    false    229    3612    244            }           2606    221744    lynx_ratings users_fk    FK CONSTRAINT     ?   ALTER TABLE ONLY public.lynx_ratings
    ADD CONSTRAINT users_fk FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON UPDATE CASCADE ON DELETE CASCADE;
 ?   ALTER TABLE ONLY public.lynx_ratings DROP CONSTRAINT users_fk;
       public       	   fateslist    false    3612    242    229            ?           2606    221765    bot_voters users_fk    FK CONSTRAINT     ?   ALTER TABLE ONLY public.bot_voters
    ADD CONSTRAINT users_fk FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON UPDATE CASCADE ON DELETE CASCADE;
 =   ALTER TABLE ONLY public.bot_voters DROP CONSTRAINT users_fk;
       public       	   fateslist    false    246    229    3612            ?           2606    221770    server_voters users_fk    FK CONSTRAINT     ?   ALTER TABLE ONLY public.server_voters
    ADD CONSTRAINT users_fk FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON UPDATE CASCADE ON DELETE CASCADE;
 @   ALTER TABLE ONLY public.server_voters DROP CONSTRAINT users_fk;
       public       	   fateslist    false    247    3612    229            z           2606    221785    user_vote_table users_fk    FK CONSTRAINT     ?   ALTER TABLE ONLY public.user_vote_table
    ADD CONSTRAINT users_fk FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON UPDATE CASCADE ON DELETE CASCADE;
 B   ALTER TABLE ONLY public.user_vote_table DROP CONSTRAINT users_fk;
       public       	   fateslist    false    229    238    3612            ?           2606    221790    user_server_vote_table users_fk    FK CONSTRAINT     ?   ALTER TABLE ONLY public.user_server_vote_table
    ADD CONSTRAINT users_fk FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON UPDATE CASCADE ON DELETE CASCADE;
 I   ALTER TABLE ONLY public.user_server_vote_table DROP CONSTRAINT users_fk;
       public       	   fateslist    false    248    3612    229            y           2606    221795    review_votes users_fk    FK CONSTRAINT     ?   ALTER TABLE ONLY public.review_votes
    ADD CONSTRAINT users_fk FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON UPDATE CASCADE ON DELETE CASCADE;
 ?   ALTER TABLE ONLY public.review_votes DROP CONSTRAINT users_fk;
       public       	   fateslist    false    237    229    3612            ?           2606    448557    extra_data users_fk    FK CONSTRAINT     ?   ALTER TABLE ONLY public.extra_data
    ADD CONSTRAINT users_fk FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON UPDATE CASCADE ON DELETE CASCADE;
 =   ALTER TABLE ONLY public.extra_data DROP CONSTRAINT users_fk;
       public       	   fateslist    false    257    229    3612           