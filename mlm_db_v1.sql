--
-- PostgreSQL database dump
--

-- Dumped from database version 12.4 (Ubuntu 12.4-0ubuntu0.20.04.1)
-- Dumped by pg_dump version 12.4 (Ubuntu 12.4-0ubuntu0.20.04.1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: postgis; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS postgis WITH SCHEMA public;


--
-- Name: EXTENSION postgis; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION postgis IS 'PostGIS geometry, geography, and raster spatial types and functions';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: auth_group; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_group (
    id integer NOT NULL,
    name character varying(150) NOT NULL
);


ALTER TABLE public.auth_group OWNER TO postgres;

--
-- Name: auth_group_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.auth_group_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_group_id_seq OWNER TO postgres;

--
-- Name: auth_group_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.auth_group_id_seq OWNED BY public.auth_group.id;


--
-- Name: auth_group_permissions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_group_permissions (
    id integer NOT NULL,
    group_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.auth_group_permissions OWNER TO postgres;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.auth_group_permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_group_permissions_id_seq OWNER TO postgres;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.auth_group_permissions_id_seq OWNED BY public.auth_group_permissions.id;


--
-- Name: auth_permission; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_permission (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    content_type_id integer NOT NULL,
    codename character varying(100) NOT NULL
);


ALTER TABLE public.auth_permission OWNER TO postgres;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.auth_permission_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_permission_id_seq OWNER TO postgres;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.auth_permission_id_seq OWNED BY public.auth_permission.id;


--
-- Name: auth_user; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_user (
    id integer NOT NULL,
    password character varying(128) NOT NULL,
    last_login timestamp with time zone,
    is_superuser boolean NOT NULL,
    username character varying(150) NOT NULL,
    first_name character varying(150) NOT NULL,
    last_name character varying(150) NOT NULL,
    email character varying(254) NOT NULL,
    is_staff boolean NOT NULL,
    is_active boolean NOT NULL,
    date_joined timestamp with time zone NOT NULL
);


ALTER TABLE public.auth_user OWNER TO postgres;

--
-- Name: auth_user_groups; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_user_groups (
    id integer NOT NULL,
    user_id integer NOT NULL,
    group_id integer NOT NULL
);


ALTER TABLE public.auth_user_groups OWNER TO postgres;

--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.auth_user_groups_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_user_groups_id_seq OWNER TO postgres;

--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.auth_user_groups_id_seq OWNED BY public.auth_user_groups.id;


--
-- Name: auth_user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.auth_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_user_id_seq OWNER TO postgres;

--
-- Name: auth_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.auth_user_id_seq OWNED BY public.auth_user.id;


--
-- Name: auth_user_user_permissions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_user_user_permissions (
    id integer NOT NULL,
    user_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.auth_user_user_permissions OWNER TO postgres;

--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.auth_user_user_permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_user_user_permissions_id_seq OWNER TO postgres;

--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.auth_user_user_permissions_id_seq OWNED BY public.auth_user_user_permissions.id;


--
-- Name: celery_taskmeta; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.celery_taskmeta (
    id integer NOT NULL,
    task_id character varying(255) NOT NULL,
    status character varying(50) NOT NULL,
    result text,
    date_done timestamp with time zone NOT NULL,
    traceback text,
    hidden boolean NOT NULL,
    meta text
);


ALTER TABLE public.celery_taskmeta OWNER TO postgres;

--
-- Name: celery_taskmeta_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.celery_taskmeta_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.celery_taskmeta_id_seq OWNER TO postgres;

--
-- Name: celery_taskmeta_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.celery_taskmeta_id_seq OWNED BY public.celery_taskmeta.id;


--
-- Name: celery_tasksetmeta; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.celery_tasksetmeta (
    id integer NOT NULL,
    taskset_id character varying(255) NOT NULL,
    result text NOT NULL,
    date_done timestamp with time zone NOT NULL,
    hidden boolean NOT NULL
);


ALTER TABLE public.celery_tasksetmeta OWNER TO postgres;

--
-- Name: celery_tasksetmeta_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.celery_tasksetmeta_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.celery_tasksetmeta_id_seq OWNER TO postgres;

--
-- Name: celery_tasksetmeta_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.celery_tasksetmeta_id_seq OWNED BY public.celery_tasksetmeta.id;


--
-- Name: django_admin_log; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_admin_log (
    id integer NOT NULL,
    action_time timestamp with time zone NOT NULL,
    object_id text,
    object_repr character varying(200) NOT NULL,
    action_flag smallint NOT NULL,
    change_message text NOT NULL,
    content_type_id integer,
    user_id integer NOT NULL,
    CONSTRAINT django_admin_log_action_flag_check CHECK ((action_flag >= 0))
);


ALTER TABLE public.django_admin_log OWNER TO postgres;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.django_admin_log_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_admin_log_id_seq OWNER TO postgres;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.django_admin_log_id_seq OWNED BY public.django_admin_log.id;


--
-- Name: django_content_type; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_content_type (
    id integer NOT NULL,
    app_label character varying(100) NOT NULL,
    model character varying(100) NOT NULL
);


ALTER TABLE public.django_content_type OWNER TO postgres;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.django_content_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_content_type_id_seq OWNER TO postgres;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.django_content_type_id_seq OWNED BY public.django_content_type.id;


--
-- Name: django_migrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_migrations (
    id integer NOT NULL,
    app character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    applied timestamp with time zone NOT NULL
);


ALTER TABLE public.django_migrations OWNER TO postgres;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.django_migrations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_migrations_id_seq OWNER TO postgres;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.django_migrations_id_seq OWNED BY public.django_migrations.id;


--
-- Name: django_session; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_session (
    session_key character varying(40) NOT NULL,
    session_data text NOT NULL,
    expire_date timestamp with time zone NOT NULL
);


ALTER TABLE public.django_session OWNER TO postgres;

--
-- Name: djcelery_crontabschedule; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.djcelery_crontabschedule (
    id integer NOT NULL,
    minute character varying(64) NOT NULL,
    hour character varying(64) NOT NULL,
    day_of_week character varying(64) NOT NULL,
    day_of_month character varying(64) NOT NULL,
    month_of_year character varying(64) NOT NULL
);


ALTER TABLE public.djcelery_crontabschedule OWNER TO postgres;

--
-- Name: djcelery_crontabschedule_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.djcelery_crontabschedule_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.djcelery_crontabschedule_id_seq OWNER TO postgres;

--
-- Name: djcelery_crontabschedule_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.djcelery_crontabschedule_id_seq OWNED BY public.djcelery_crontabschedule.id;


--
-- Name: djcelery_intervalschedule; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.djcelery_intervalschedule (
    id integer NOT NULL,
    every integer NOT NULL,
    period character varying(24) NOT NULL
);


ALTER TABLE public.djcelery_intervalschedule OWNER TO postgres;

--
-- Name: djcelery_intervalschedule_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.djcelery_intervalschedule_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.djcelery_intervalschedule_id_seq OWNER TO postgres;

--
-- Name: djcelery_intervalschedule_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.djcelery_intervalschedule_id_seq OWNED BY public.djcelery_intervalschedule.id;


--
-- Name: djcelery_periodictask; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.djcelery_periodictask (
    id integer NOT NULL,
    name character varying(200) NOT NULL,
    task character varying(200) NOT NULL,
    args text NOT NULL,
    kwargs text NOT NULL,
    queue character varying(200),
    exchange character varying(200),
    routing_key character varying(200),
    expires timestamp with time zone,
    enabled boolean NOT NULL,
    last_run_at timestamp with time zone,
    total_run_count integer NOT NULL,
    date_changed timestamp with time zone NOT NULL,
    description text NOT NULL,
    crontab_id integer,
    interval_id integer,
    CONSTRAINT djcelery_periodictask_total_run_count_check CHECK ((total_run_count >= 0))
);


ALTER TABLE public.djcelery_periodictask OWNER TO postgres;

--
-- Name: djcelery_periodictask_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.djcelery_periodictask_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.djcelery_periodictask_id_seq OWNER TO postgres;

--
-- Name: djcelery_periodictask_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.djcelery_periodictask_id_seq OWNED BY public.djcelery_periodictask.id;


--
-- Name: djcelery_periodictasks; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.djcelery_periodictasks (
    ident smallint NOT NULL,
    last_update timestamp with time zone NOT NULL
);


ALTER TABLE public.djcelery_periodictasks OWNER TO postgres;

--
-- Name: djcelery_taskstate; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.djcelery_taskstate (
    id integer NOT NULL,
    state character varying(64) NOT NULL,
    task_id character varying(36) NOT NULL,
    name character varying(200),
    tstamp timestamp with time zone NOT NULL,
    args text,
    kwargs text,
    eta timestamp with time zone,
    expires timestamp with time zone,
    result text,
    traceback text,
    runtime double precision,
    retries integer NOT NULL,
    hidden boolean NOT NULL,
    worker_id integer
);


ALTER TABLE public.djcelery_taskstate OWNER TO postgres;

--
-- Name: djcelery_taskstate_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.djcelery_taskstate_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.djcelery_taskstate_id_seq OWNER TO postgres;

--
-- Name: djcelery_taskstate_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.djcelery_taskstate_id_seq OWNED BY public.djcelery_taskstate.id;


--
-- Name: djcelery_workerstate; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.djcelery_workerstate (
    id integer NOT NULL,
    hostname character varying(255) NOT NULL,
    last_heartbeat timestamp with time zone
);


ALTER TABLE public.djcelery_workerstate OWNER TO postgres;

--
-- Name: djcelery_workerstate_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.djcelery_workerstate_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.djcelery_workerstate_id_seq OWNER TO postgres;

--
-- Name: djcelery_workerstate_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.djcelery_workerstate_id_seq OWNED BY public.djcelery_workerstate.id;


--
-- Name: mlm_invite; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.mlm_invite (
    id integer NOT NULL,
    created_on timestamp with time zone,
    last_updated_on timestamp with time zone,
    created_by character varying(60),
    last_updated_by character varying(60),
    status character varying(20) NOT NULL,
    email character varying(255) NOT NULL,
    user_id integer NOT NULL
);


ALTER TABLE public.mlm_invite OWNER TO postgres;

--
-- Name: mlm_invite_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.mlm_invite_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.mlm_invite_id_seq OWNER TO postgres;

--
-- Name: mlm_invite_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.mlm_invite_id_seq OWNED BY public.mlm_invite.id;


--
-- Name: mlm_user_hierarchy; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.mlm_user_hierarchy (
    id integer NOT NULL,
    created_on timestamp with time zone,
    last_updated_on timestamp with time zone,
    created_by character varying(60),
    last_updated_by character varying(60),
    parent_user_id integer NOT NULL,
    user_id integer NOT NULL,
    course integer NOT NULL
);


ALTER TABLE public.mlm_user_hierarchy OWNER TO postgres;

--
-- Name: mlm_user_hierarchy_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.mlm_user_hierarchy_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.mlm_user_hierarchy_id_seq OWNER TO postgres;

--
-- Name: mlm_user_hierarchy_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.mlm_user_hierarchy_id_seq OWNED BY public.mlm_user_hierarchy.id;


--
-- Name: mlm_user_profile; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.mlm_user_profile (
    id integer NOT NULL,
    created_on timestamp with time zone,
    last_updated_on timestamp with time zone,
    created_by character varying(60),
    last_updated_by character varying(60),
    mobile character varying(20),
    picture character varying(100),
    designation character varying(60) NOT NULL,
    prefix character varying(20),
    payment_status character varying(20) NOT NULL,
    user_id integer NOT NULL,
    course integer NOT NULL,
    "group" integer NOT NULL,
    hr_tree jsonb
);


ALTER TABLE public.mlm_user_profile OWNER TO postgres;

--
-- Name: mlm_user_profile_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.mlm_user_profile_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.mlm_user_profile_id_seq OWNER TO postgres;

--
-- Name: mlm_user_profile_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.mlm_user_profile_id_seq OWNED BY public.mlm_user_profile.id;


--
-- Name: auth_group id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group ALTER COLUMN id SET DEFAULT nextval('public.auth_group_id_seq'::regclass);


--
-- Name: auth_group_permissions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions ALTER COLUMN id SET DEFAULT nextval('public.auth_group_permissions_id_seq'::regclass);


--
-- Name: auth_permission id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission ALTER COLUMN id SET DEFAULT nextval('public.auth_permission_id_seq'::regclass);


--
-- Name: auth_user id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user ALTER COLUMN id SET DEFAULT nextval('public.auth_user_id_seq'::regclass);


--
-- Name: auth_user_groups id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_groups ALTER COLUMN id SET DEFAULT nextval('public.auth_user_groups_id_seq'::regclass);


--
-- Name: auth_user_user_permissions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_user_permissions ALTER COLUMN id SET DEFAULT nextval('public.auth_user_user_permissions_id_seq'::regclass);


--
-- Name: celery_taskmeta id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.celery_taskmeta ALTER COLUMN id SET DEFAULT nextval('public.celery_taskmeta_id_seq'::regclass);


--
-- Name: celery_tasksetmeta id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.celery_tasksetmeta ALTER COLUMN id SET DEFAULT nextval('public.celery_tasksetmeta_id_seq'::regclass);


--
-- Name: django_admin_log id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_admin_log ALTER COLUMN id SET DEFAULT nextval('public.django_admin_log_id_seq'::regclass);


--
-- Name: django_content_type id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_content_type ALTER COLUMN id SET DEFAULT nextval('public.django_content_type_id_seq'::regclass);


--
-- Name: django_migrations id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_migrations ALTER COLUMN id SET DEFAULT nextval('public.django_migrations_id_seq'::regclass);


--
-- Name: djcelery_crontabschedule id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.djcelery_crontabschedule ALTER COLUMN id SET DEFAULT nextval('public.djcelery_crontabschedule_id_seq'::regclass);


--
-- Name: djcelery_intervalschedule id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.djcelery_intervalschedule ALTER COLUMN id SET DEFAULT nextval('public.djcelery_intervalschedule_id_seq'::regclass);


--
-- Name: djcelery_periodictask id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.djcelery_periodictask ALTER COLUMN id SET DEFAULT nextval('public.djcelery_periodictask_id_seq'::regclass);


--
-- Name: djcelery_taskstate id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.djcelery_taskstate ALTER COLUMN id SET DEFAULT nextval('public.djcelery_taskstate_id_seq'::regclass);


--
-- Name: djcelery_workerstate id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.djcelery_workerstate ALTER COLUMN id SET DEFAULT nextval('public.djcelery_workerstate_id_seq'::regclass);


--
-- Name: mlm_invite id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mlm_invite ALTER COLUMN id SET DEFAULT nextval('public.mlm_invite_id_seq'::regclass);


--
-- Name: mlm_user_hierarchy id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mlm_user_hierarchy ALTER COLUMN id SET DEFAULT nextval('public.mlm_user_hierarchy_id_seq'::regclass);


--
-- Name: mlm_user_profile id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mlm_user_profile ALTER COLUMN id SET DEFAULT nextval('public.mlm_user_profile_id_seq'::regclass);


--
-- Data for Name: auth_group; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_group (id, name) FROM stdin;
\.


--
-- Data for Name: auth_group_permissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_group_permissions (id, group_id, permission_id) FROM stdin;
\.


--
-- Data for Name: auth_permission; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_permission (id, name, content_type_id, codename) FROM stdin;
1	Can add log entry	1	add_logentry
2	Can change log entry	1	change_logentry
3	Can delete log entry	1	delete_logentry
4	Can view log entry	1	view_logentry
5	Can add permission	2	add_permission
6	Can change permission	2	change_permission
7	Can delete permission	2	delete_permission
8	Can view permission	2	view_permission
9	Can add group	3	add_group
10	Can change group	3	change_group
11	Can delete group	3	delete_group
12	Can view group	3	view_group
13	Can add user	4	add_user
14	Can change user	4	change_user
15	Can delete user	4	delete_user
16	Can view user	4	view_user
17	Can add content type	5	add_contenttype
18	Can change content type	5	change_contenttype
19	Can delete content type	5	delete_contenttype
20	Can view content type	5	view_contenttype
21	Can add session	6	add_session
22	Can change session	6	change_session
23	Can delete session	6	delete_session
24	Can view session	6	view_session
25	Can add user profile	7	add_userprofile
26	Can change user profile	7	change_userprofile
27	Can delete user profile	7	delete_userprofile
28	Can view user profile	7	view_userprofile
29	Can add invite	8	add_invite
30	Can change invite	8	change_invite
31	Can delete invite	8	delete_invite
32	Can view invite	8	view_invite
33	Can add user hierarchy	9	add_userhierarchy
34	Can change user hierarchy	9	change_userhierarchy
35	Can delete user hierarchy	9	delete_userhierarchy
36	Can view user hierarchy	9	view_userhierarchy
37	Can add crontab	10	add_crontabschedule
38	Can change crontab	10	change_crontabschedule
39	Can delete crontab	10	delete_crontabschedule
40	Can view crontab	10	view_crontabschedule
41	Can add interval	11	add_intervalschedule
42	Can change interval	11	change_intervalschedule
43	Can delete interval	11	delete_intervalschedule
44	Can view interval	11	view_intervalschedule
45	Can add periodic task	12	add_periodictask
46	Can change periodic task	12	change_periodictask
47	Can delete periodic task	12	delete_periodictask
48	Can view periodic task	12	view_periodictask
49	Can add periodic tasks	13	add_periodictasks
50	Can change periodic tasks	13	change_periodictasks
51	Can delete periodic tasks	13	delete_periodictasks
52	Can view periodic tasks	13	view_periodictasks
53	Can add task state	14	add_taskmeta
54	Can change task state	14	change_taskmeta
55	Can delete task state	14	delete_taskmeta
56	Can view task state	14	view_taskmeta
57	Can add saved group result	15	add_tasksetmeta
58	Can change saved group result	15	change_tasksetmeta
59	Can delete saved group result	15	delete_tasksetmeta
60	Can view saved group result	15	view_tasksetmeta
61	Can add task	16	add_taskstate
62	Can change task	16	change_taskstate
63	Can delete task	16	delete_taskstate
64	Can view task	16	view_taskstate
65	Can add worker	17	add_workerstate
66	Can change worker	17	change_workerstate
67	Can delete worker	17	delete_workerstate
68	Can view worker	17	view_workerstate
\.


--
-- Data for Name: auth_user; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_user (id, password, last_login, is_superuser, username, first_name, last_name, email, is_staff, is_active, date_joined) FROM stdin;
8	pbkdf2_sha256$216000$5KQ4Xkb6Xj7Z$vXZ9ym+oQPBH0rldiEVM3ICDgDRuIm/s5AowOmNfA4Y=	2020-10-25 16:53:25.809797+05:30	f	demouser2@gmail.com	demo	user2	demouser2@gmail.com	f	t	2020-10-25 16:53:23.871343+05:30
28	pbkdf2_sha256$216000$A7PVNN075z83$mE8SnKup3U2ZUhuNgekX/MfIj346RcJ+Qu6ZS06WOPg=	\N	t	kannan			kannan.p@gnapitech.com	t	t	2020-10-26 16:13:42.744914+05:30
9	pbkdf2_sha256$216000$z5KGUZXhIdwq$eLf+Pi1bfx1UzAd3PR3ZFVHA3VGtLtOkMInkfcyzXn8=	2020-10-25 16:53:59.493412+05:30	f	demouser3@mlm.com	Demo	user3	demouser3@mlm.com	f	t	2020-10-25 16:53:57.359261+05:30
23	pbkdf2_sha256$216000$n2gVyBuCmYUl$CYnnuwLEgmo0Jwmc7+FRGT5/2r+mcJ0WUxNVGTxP6n8=	2020-10-26 16:00:48.423881+05:30	f	demouser17@mlm.com	Demo	user17	demouser17@mlm.com	f	t	2020-10-26 16:00:46.126706+05:30
10	pbkdf2_sha256$216000$SdHoVUnuPo75$PDzyQDKVL5sv5ttqE+kQql0eDhH6Y5rwHioJPc773qQ=	2020-10-25 16:54:29.284023+05:30	f	demouser4@mlm.com	demo	user4	demouser4@mlm.com	f	t	2020-10-25 16:54:26.865986+05:30
27	pbkdf2_sha256$216000$IRMgZdV5I5la$zu7HiEMK/Tnk9JEe2xqF85XJqpyL7Aip626aVmGuYmc=	2020-10-26 16:17:19.97651+05:30	t	admin			admin@mlm.com	t	t	2020-10-26 16:13:08.722708+05:30
11	pbkdf2_sha256$216000$iMCJFDgMe6Ln$cEJmQ90AApTECBAtf+vwEVZ6l1MfODOHrCdSyYW0Rco=	2020-10-25 17:03:55.920892+05:30	f	demouser5@mlm.com	demo	user5	demouser5@mlm.com	f	t	2020-10-25 17:03:53.65799+05:30
24	pbkdf2_sha256$216000$0072qyqSo2kR$pVyChwPv63i/9Z9hBGzOqdHb8SfcWGE3+sAAgyWuRCQ=	2020-10-26 16:01:20.292299+05:30	f	demouser18@mlm.com	Demo	user18	demouser18@mlm.com	f	t	2020-10-26 16:01:17.452065+05:30
12	pbkdf2_sha256$216000$WVwMAsUZLT7R$ofEyqgoXqU8332AeDNJJJ4wRIjm2yTpl3Z90P64W/eU=	2020-10-25 17:04:25.056727+05:30	f	demouser6@mlm.com	demo	user6	demouser6@mlm.com	f	t	2020-10-25 17:04:22.837717+05:30
13	pbkdf2_sha256$216000$0fWx8u7abtv8$CgLIg8hD7etFyGDbVB/eJF7O9hll4TG5pOdaXalQqFE=	2020-10-25 17:04:52.090442+05:30	f	demouser7@mlm.com	demo	user7	demouser7@mlm.com	f	t	2020-10-25 17:04:50.021751+05:30
14	pbkdf2_sha256$216000$h1oOXZRsnR6D$I8rC0QbQ/TG2I39r6+YDgcPAcQbertnyIEvFYGIqjk0=	2020-10-25 17:05:38.367025+05:30	f	demouser8@mlm.com	demo	user8	demouser8@mlm.com	f	t	2020-10-25 17:05:36.35588+05:30
5	pbkdf2_sha256$216000$lKx6IXLXmYJP$O8bydIeU+j7cppZObtpASqJFPB+Abr2EJxTSCY+joyg=	2020-10-24 15:18:41+05:30	f	user1	User	1	user1@mlm.com	f	t	2020-10-24 15:18:37+05:30
6	pbkdf2_sha256$216000$mclKt9o15y14$S/5BR3La1BeoNPwXr5FQ1uzHKj6kns4Z7NCoxHzZts4=	2020-10-24 15:21:42+05:30	f	user2	user	2	user2@mlm.com	f	t	2020-10-24 15:21:40+05:30
15	pbkdf2_sha256$216000$iJ5u3rFTAfgL$GHP5w/uuxFfFVUDdOnfEHoHp3F/U8Swl3VxvVD5up7M=	2020-10-25 17:06:14.112824+05:30	f	demouser9@mlm.com	demo	user9	demouser9@mlm.com	f	t	2020-10-25 17:06:11.897219+05:30
19	pbkdf2_sha256$216000$ydSlJbp2Helm$D/9Wy4YrYGjja2pQSvAhrLUvXqtVUjqzPo560rt4YjY=	2020-10-26 11:04:46.962052+05:30	f	demouser13@mlm.com	Demo	user13	demouser13@mlm.com	f	t	2020-10-26 11:04:45.216962+05:30
25	pbkdf2_sha256$216000$VHPLrBXa5s5z$UuUl9Cvken9FX/RpluYwZCMppEKfe5+3dymN9HPSF7M=	2020-10-26 16:02:09.124055+05:30	f	demouser19@mlm.com	demo	user19	demouser19@mlm.com	f	t	2020-10-26 16:02:07.276922+05:30
16	pbkdf2_sha256$216000$ezeEbv2Zz14O$YLA74O5B2KVEQVOV2YcSeeZ0q2+q1huIJsdUqBaPv64=	2020-10-25 17:06:47.65881+05:30	f	demouser10@mlm.com	demo	user10	demouser10@mlm.com	f	t	2020-10-25 17:06:45.55824+05:30
7	pbkdf2_sha256$216000$H56IXNA3djtH$qZGiUdy9K+1x1evife+GDz3T0LQWOBlAV34CbRMWPMk=	2020-10-25 16:52:43.037187+05:30	f	demouser1@gmail.com	demo	user1	demouser1@gmail.com	f	t	2020-10-25 16:52:40.299131+05:30
20	pbkdf2_sha256$216000$JdJ5ortnp7U3$O59p0Q2RakrdtBaRGacUjKm7qvKykJpameztFuf2ZK0=	2020-10-26 11:05:34.769857+05:30	f	demouser14@mlm.com	Demo	user14	demouser14@mlm.com	f	t	2020-10-26 11:05:32.098126+05:30
17	pbkdf2_sha256$216000$Oehb7bmqrVPR$C8GFR2BYJ44t/igf2AZUasdIPByC69Vhe6m6WjXNTfI=	2020-10-25 17:07:22.854966+05:30	f	demouser11@mlm.com	demo	user11	demouser11@mlm.com	f	t	2020-10-25 17:07:20.166314+05:30
18	pbkdf2_sha256$216000$FRGNkkos7Mou$B9WQ+Ra1eSdp3wkjA3qQYNLM6wtblDIc0Whf/6SCGXA=	2020-10-25 17:08:02.267031+05:30	f	demouser12@mlm.com	demo	user12	demouser12@mlm.com	f	t	2020-10-25 17:07:59.728929+05:30
26	pbkdf2_sha256$216000$VbANkQbMrUlW$C4gkCC10oSWSpZMa/9OhK9LzwOd7qJxYOVsWNUn0+FY=	2020-10-26 16:02:40.767105+05:30	f	demouser20@mlm.com	demo	user20	demouser20@mlm.com	f	t	2020-10-26 16:02:38.937028+05:30
4	pbkdf2_sha256$216000$SXhm80i3wksx$+urN8648XFUq82kkp6Jf8VXDpTzUn0k7shMSqX2HoiA=	2020-10-26 16:21:38.391823+05:30	f	firstuser1	First	User	firstuser1@mlm.com	f	t	2020-10-24 09:52:39+05:30
21	pbkdf2_sha256$216000$N65ZF2frVD9H$Q2jeIlwf4SGJMQLILQq6OskeTpfMQ63ken5Z6KJbrlY=	2020-10-26 15:59:42.394791+05:30	f	demouser15@mlm.com	Demo	user15	demouser15@mlm.com	f	t	2020-10-26 15:59:39.560553+05:30
22	pbkdf2_sha256$216000$T3InUCFcqxzX$nkh6cFR+sAwL8Ka/js1s1sOdovjdfQ53MojkjDvgXQc=	2020-10-26 16:00:23.873798+05:30	f	demouser16@mlm.com	Demo	User16	demouser16@mlm.com	f	t	2020-10-26 16:00:21.488117+05:30
1	pbkdf2_sha256$216000$FqpEWvROlGXI$8kcfYeZ7xOYHIDNXJJ2ISm/hFYHqIpt9yPWsLoNu4Eg=	2020-10-26 16:10:23.131288+05:30	t	vinoth			vinoth@gnapitech.com	t	t	2020-10-21 13:52:07+05:30
\.


--
-- Data for Name: auth_user_groups; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_user_groups (id, user_id, group_id) FROM stdin;
\.


--
-- Data for Name: auth_user_user_permissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_user_user_permissions (id, user_id, permission_id) FROM stdin;
\.


--
-- Data for Name: celery_taskmeta; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.celery_taskmeta (id, task_id, status, result, date_done, traceback, hidden, meta) FROM stdin;
\.


--
-- Data for Name: celery_tasksetmeta; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.celery_tasksetmeta (id, taskset_id, result, date_done, hidden) FROM stdin;
\.


--
-- Data for Name: django_admin_log; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) FROM stdin;
1	2020-10-21 16:55:58.95541+05:30	2	demouser	1	[{"added": {}}]	4	1
2	2020-10-21 16:56:24.28066+05:30	2	demouser	2	[{"changed": {"fields": ["First name", "Last name", "Email address"]}}]	4	1
3	2020-10-26 16:07:41.974262+05:30	5	user1@mlm.com	2	[{"changed": {"fields": ["Username", "First name", "Last name"]}}]	4	1
4	2020-10-26 16:08:09.0848+05:30	6	user2@mlm.com	2	[{"changed": {"fields": ["Username", "First name", "Last name"]}}]	4	1
5	2020-10-26 16:09:10.221251+05:30	4	rootuser1@mlm.com	2	[{"changed": {"fields": ["Username", "First name", "Last name", "Email address"]}}]	4	1
6	2020-10-26 16:09:56.184096+05:30	1	vinoth	2	[{"changed": {"fields": ["Username", "Email address"]}}]	4	1
7	2020-10-26 16:17:53.291999+05:30	5	user1	2	[{"changed": {"fields": ["Username", "Email address"]}}]	4	27
8	2020-10-26 16:18:17.17735+05:30	6	user2	2	[{"changed": {"fields": ["Username", "Email address"]}}]	4	27
9	2020-10-26 16:18:50.641264+05:30	4	rootuser1	2	[{"changed": {"fields": ["Username"]}}]	4	27
10	2020-10-26 16:19:36.443505+05:30	4	firstuser1	2	[{"changed": {"fields": ["Username", "First name", "Email address"]}}]	4	27
\.


--
-- Data for Name: django_content_type; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_content_type (id, app_label, model) FROM stdin;
1	admin	logentry
2	auth	permission
3	auth	group
4	auth	user
5	contenttypes	contenttype
6	sessions	session
7	main	userprofile
8	main	invite
9	main	userhierarchy
10	djcelery	crontabschedule
11	djcelery	intervalschedule
12	djcelery	periodictask
13	djcelery	periodictasks
14	djcelery	taskmeta
15	djcelery	tasksetmeta
16	djcelery	taskstate
17	djcelery	workerstate
\.


--
-- Data for Name: django_migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_migrations (id, app, name, applied) FROM stdin;
1	contenttypes	0001_initial	2020-10-21 13:50:57.694948+05:30
2	auth	0001_initial	2020-10-21 13:50:57.811819+05:30
3	admin	0001_initial	2020-10-21 13:50:58.039275+05:30
4	admin	0002_logentry_remove_auto_add	2020-10-21 13:50:58.10065+05:30
5	admin	0003_logentry_add_action_flag_choices	2020-10-21 13:50:58.159995+05:30
6	contenttypes	0002_remove_content_type_name	2020-10-21 13:50:58.255932+05:30
7	auth	0002_alter_permission_name_max_length	2020-10-21 13:50:58.298845+05:30
8	auth	0003_alter_user_email_max_length	2020-10-21 13:50:58.33366+05:30
9	auth	0004_alter_user_username_opts	2020-10-21 13:50:58.369865+05:30
10	auth	0005_alter_user_last_login_null	2020-10-21 13:50:58.412056+05:30
11	auth	0006_require_contenttypes_0002	2020-10-21 13:50:58.419671+05:30
12	auth	0007_alter_validators_add_error_messages	2020-10-21 13:50:58.468955+05:30
13	auth	0008_alter_user_username_max_length	2020-10-21 13:50:58.535833+05:30
14	auth	0009_alter_user_last_name_max_length	2020-10-21 13:50:58.56796+05:30
15	auth	0010_alter_group_name_max_length	2020-10-21 13:50:58.616982+05:30
16	auth	0011_update_proxy_permissions	2020-10-21 13:50:58.655451+05:30
17	auth	0012_alter_user_first_name_max_length	2020-10-21 13:50:58.702404+05:30
18	sessions	0001_initial	2020-10-21 13:50:58.721455+05:30
19	main	0001_initial	2020-10-22 09:48:49.708364+05:30
20	djcelery	0001_initial	2020-10-22 16:53:47.278062+05:30
21	main	0002_auto_20201022_1123	2020-10-22 16:53:47.523232+05:30
22	main	0003_auto_20201024_0522	2020-10-24 10:53:11.806657+05:30
23	main	0004_auto_20201025_1026	2020-10-25 15:58:54.725789+05:30
24	main	0005_remove_userhierarchy_level	2020-10-25 15:58:54.862018+05:30
25	main	0006_userprofile_hr_tree	2020-10-26 10:27:12.438288+05:30
26	main	0007_auto_20201026_0457	2020-10-26 10:27:12.600398+05:30
27	main	0008_auto_20201026_0832	2020-10-26 14:02:11.037197+05:30
\.


--
-- Data for Name: django_session; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_session (session_key, session_data, expire_date) FROM stdin;
5snfj9q77t0bn4baq8cxumoj08bzwsst	e30:1kVCij:C0vo_M8lVQoy55WiDE617JHTie8J5eVfOUCnGI3TxSg	2020-11-04 17:25:57.953332+05:30
wij0jmcv3dzmvm9kcepz9hitg4t0eyp6	.eJxVi8sKwjAQAP8lZyltnhuPgt8RNrsrKdoKpjmJ_24qHnSOM8xTJWxbSa3KI82sjsqqw6_LSFdZ97DgvA7U6nZfPn04d3M7ffvfVLCWfoABcRiNZ_KdCQJBEM1WW9ABc3SEYiDbyB4iCPoLaBShKDy5kdTrDQIDM54:1kX06E:byCJLPYkeeqrrylsx9ZKZ6lmD8830kSpGjgWdgrCQBQ	2020-11-09 16:21:38.402095+05:30
\.


--
-- Data for Name: djcelery_crontabschedule; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.djcelery_crontabschedule (id, minute, hour, day_of_week, day_of_month, month_of_year) FROM stdin;
\.


--
-- Data for Name: djcelery_intervalschedule; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.djcelery_intervalschedule (id, every, period) FROM stdin;
\.


--
-- Data for Name: djcelery_periodictask; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.djcelery_periodictask (id, name, task, args, kwargs, queue, exchange, routing_key, expires, enabled, last_run_at, total_run_count, date_changed, description, crontab_id, interval_id) FROM stdin;
\.


--
-- Data for Name: djcelery_periodictasks; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.djcelery_periodictasks (ident, last_update) FROM stdin;
\.


--
-- Data for Name: djcelery_taskstate; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.djcelery_taskstate (id, state, task_id, name, tstamp, args, kwargs, eta, expires, result, traceback, runtime, retries, hidden, worker_id) FROM stdin;
\.


--
-- Data for Name: djcelery_workerstate; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.djcelery_workerstate (id, hostname, last_heartbeat) FROM stdin;
\.


--
-- Data for Name: mlm_invite; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.mlm_invite (id, created_on, last_updated_on, created_by, last_updated_by, status, email, user_id) FROM stdin;
12	2020-10-24 14:54:51.889501+05:30	\N	kannan p	\N	accepted	ananthakannan14@gmail.com	4
13	2020-10-24 15:20:53.953126+05:30	\N	kannan p	\N	accepted	kannanp240696@gmail.com	4
\.


--
-- Data for Name: mlm_user_hierarchy; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.mlm_user_hierarchy (id, created_on, last_updated_on, created_by, last_updated_by, parent_user_id, user_id, course) FROM stdin;
1	\N	\N	\N	\N	4	5	0
2	\N	\N	\N	\N	4	6	0
3	\N	\N	\N	\N	5	7	0
4	\N	\N	\N	\N	5	8	0
5	\N	\N	\N	\N	6	9	0
6	\N	\N	\N	\N	6	10	0
7	\N	\N	\N	\N	7	11	0
8	\N	\N	\N	\N	7	12	0
9	\N	\N	\N	\N	8	13	0
10	\N	\N	\N	\N	8	14	0
11	\N	\N	\N	\N	9	15	0
12	\N	\N	\N	\N	9	16	0
13	\N	\N	\N	\N	10	17	0
14	\N	\N	\N	\N	10	18	0
15	\N	\N	\N	\N	11	19	0
16	\N	\N	\N	\N	11	20	0
18	\N	\N	\N	\N	12	21	0
19	\N	\N	\N	\N	12	22	0
20	\N	\N	\N	\N	13	23	0
21	\N	\N	\N	\N	13	24	0
22	\N	\N	\N	\N	14	25	0
23	\N	\N	\N	\N	14	26	0
\.


--
-- Data for Name: mlm_user_profile; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.mlm_user_profile (id, created_on, last_updated_on, created_by, last_updated_by, mobile, picture, designation, prefix, payment_status, user_id, course, "group", hr_tree) FROM stdin;
18	\N	\N	\N	\N	\N		student	\N	paid	21	0	0	\N
19	\N	\N	\N	\N	\N		student	\N	paid	22	0	0	\N
20	\N	\N	\N	\N	\N		student	\N	paid	23	0	0	\N
21	\N	\N	\N	\N	\N		student	\N	paid	24	0	0	\N
22	\N	\N	\N	\N	\N		student	\N	paid	25	0	0	\N
23	\N	\N	\N	\N	\N		student	\N	paid	26	0	0	\N
2	\N	\N	\N	\N	\N		student	\N	paid	5	1	0	\N
1	\N	\N	\N	\N	+12332323232	user_profile/1_Penguins.jpg	student	Mr.	paid	4	1	0	\N
11	\N	\N	\N	\N	\N		student	\N	paid	14	0	0	\N
12	\N	\N	\N	\N	\N		student	\N	paid	15	0	0	\N
13	\N	\N	\N	\N	\N		student	\N	paid	16	0	0	\N
14	\N	\N	\N	\N	\N		student	\N	paid	17	0	0	\N
15	\N	\N	\N	\N	\N		student	\N	paid	18	0	0	\N
3	\N	\N	\N	\N	\N		student	\N	paid	6	0	0	\N
4	\N	\N	\N	\N	\N		student	\N	paid	7	0	0	\N
5	\N	\N	\N	\N	\N		student	\N	paid	8	0	0	\N
6	\N	\N	\N	\N	\N		student	\N	paid	9	0	0	\N
7	\N	\N	\N	\N	\N		student	\N	paid	10	0	0	\N
8	\N	\N	\N	\N	\N		student	\N	paid	11	0	0	\N
9	\N	\N	\N	\N	\N		student	\N	paid	12	0	0	\N
10	\N	\N	\N	\N	\N		student	\N	paid	13	0	0	\N
16	\N	\N	\N	\N	\N		student	\N	paid	19	0	0	\N
17	\N	\N	\N	\N	\N		student	\N	paid	20	0	0	\N
\.


--
-- Data for Name: spatial_ref_sys; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.spatial_ref_sys (srid, auth_name, auth_srid, srtext, proj4text) FROM stdin;
\.


--
-- Name: auth_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_group_id_seq', 1, false);


--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_group_permissions_id_seq', 1, false);


--
-- Name: auth_permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_permission_id_seq', 68, true);


--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_user_groups_id_seq', 1, false);


--
-- Name: auth_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_user_id_seq', 28, true);


--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_user_user_permissions_id_seq', 1, false);


--
-- Name: celery_taskmeta_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.celery_taskmeta_id_seq', 1, false);


--
-- Name: celery_tasksetmeta_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.celery_tasksetmeta_id_seq', 1, false);


--
-- Name: django_admin_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.django_admin_log_id_seq', 10, true);


--
-- Name: django_content_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.django_content_type_id_seq', 17, true);


--
-- Name: django_migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.django_migrations_id_seq', 27, true);


--
-- Name: djcelery_crontabschedule_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.djcelery_crontabschedule_id_seq', 1, false);


--
-- Name: djcelery_intervalschedule_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.djcelery_intervalschedule_id_seq', 1, false);


--
-- Name: djcelery_periodictask_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.djcelery_periodictask_id_seq', 1, false);


--
-- Name: djcelery_taskstate_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.djcelery_taskstate_id_seq', 1, false);


--
-- Name: djcelery_workerstate_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.djcelery_workerstate_id_seq', 1, false);


--
-- Name: mlm_invite_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.mlm_invite_id_seq', 13, true);


--
-- Name: mlm_user_hierarchy_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.mlm_user_hierarchy_id_seq', 23, true);


--
-- Name: mlm_user_profile_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.mlm_user_profile_id_seq', 23, true);


--
-- Name: auth_group auth_group_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_name_key UNIQUE (name);


--
-- Name: auth_group_permissions auth_group_permissions_group_id_permission_id_0cd325b0_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_permission_id_0cd325b0_uniq UNIQUE (group_id, permission_id);


--
-- Name: auth_group_permissions auth_group_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_group auth_group_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_pkey PRIMARY KEY (id);


--
-- Name: auth_permission auth_permission_content_type_id_codename_01ab375a_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_codename_01ab375a_uniq UNIQUE (content_type_id, codename);


--
-- Name: auth_permission auth_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_pkey PRIMARY KEY (id);


--
-- Name: auth_user_groups auth_user_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_pkey PRIMARY KEY (id);


--
-- Name: auth_user_groups auth_user_groups_user_id_group_id_94350c0c_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_group_id_94350c0c_uniq UNIQUE (user_id, group_id);


--
-- Name: auth_user auth_user_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user
    ADD CONSTRAINT auth_user_pkey PRIMARY KEY (id);


--
-- Name: auth_user_user_permissions auth_user_user_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_user_user_permissions auth_user_user_permissions_user_id_permission_id_14a6b632_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_user_id_permission_id_14a6b632_uniq UNIQUE (user_id, permission_id);


--
-- Name: auth_user auth_user_username_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user
    ADD CONSTRAINT auth_user_username_key UNIQUE (username);


--
-- Name: celery_taskmeta celery_taskmeta_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.celery_taskmeta
    ADD CONSTRAINT celery_taskmeta_pkey PRIMARY KEY (id);


--
-- Name: celery_taskmeta celery_taskmeta_task_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.celery_taskmeta
    ADD CONSTRAINT celery_taskmeta_task_id_key UNIQUE (task_id);


--
-- Name: celery_tasksetmeta celery_tasksetmeta_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.celery_tasksetmeta
    ADD CONSTRAINT celery_tasksetmeta_pkey PRIMARY KEY (id);


--
-- Name: celery_tasksetmeta celery_tasksetmeta_taskset_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.celery_tasksetmeta
    ADD CONSTRAINT celery_tasksetmeta_taskset_id_key UNIQUE (taskset_id);


--
-- Name: django_admin_log django_admin_log_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_pkey PRIMARY KEY (id);


--
-- Name: django_content_type django_content_type_app_label_model_76bd3d3b_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_app_label_model_76bd3d3b_uniq UNIQUE (app_label, model);


--
-- Name: django_content_type django_content_type_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_pkey PRIMARY KEY (id);


--
-- Name: django_migrations django_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_migrations
    ADD CONSTRAINT django_migrations_pkey PRIMARY KEY (id);


--
-- Name: django_session django_session_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_session
    ADD CONSTRAINT django_session_pkey PRIMARY KEY (session_key);


--
-- Name: djcelery_crontabschedule djcelery_crontabschedule_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.djcelery_crontabschedule
    ADD CONSTRAINT djcelery_crontabschedule_pkey PRIMARY KEY (id);


--
-- Name: djcelery_intervalschedule djcelery_intervalschedule_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.djcelery_intervalschedule
    ADD CONSTRAINT djcelery_intervalschedule_pkey PRIMARY KEY (id);


--
-- Name: djcelery_periodictask djcelery_periodictask_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.djcelery_periodictask
    ADD CONSTRAINT djcelery_periodictask_name_key UNIQUE (name);


--
-- Name: djcelery_periodictask djcelery_periodictask_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.djcelery_periodictask
    ADD CONSTRAINT djcelery_periodictask_pkey PRIMARY KEY (id);


--
-- Name: djcelery_periodictasks djcelery_periodictasks_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.djcelery_periodictasks
    ADD CONSTRAINT djcelery_periodictasks_pkey PRIMARY KEY (ident);


--
-- Name: djcelery_taskstate djcelery_taskstate_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.djcelery_taskstate
    ADD CONSTRAINT djcelery_taskstate_pkey PRIMARY KEY (id);


--
-- Name: djcelery_taskstate djcelery_taskstate_task_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.djcelery_taskstate
    ADD CONSTRAINT djcelery_taskstate_task_id_key UNIQUE (task_id);


--
-- Name: djcelery_workerstate djcelery_workerstate_hostname_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.djcelery_workerstate
    ADD CONSTRAINT djcelery_workerstate_hostname_key UNIQUE (hostname);


--
-- Name: djcelery_workerstate djcelery_workerstate_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.djcelery_workerstate
    ADD CONSTRAINT djcelery_workerstate_pkey PRIMARY KEY (id);


--
-- Name: mlm_invite mlm_invite_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mlm_invite
    ADD CONSTRAINT mlm_invite_pkey PRIMARY KEY (id);


--
-- Name: mlm_user_hierarchy mlm_user_hierarchy_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mlm_user_hierarchy
    ADD CONSTRAINT mlm_user_hierarchy_pkey PRIMARY KEY (id);


--
-- Name: mlm_user_profile mlm_user_profile_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mlm_user_profile
    ADD CONSTRAINT mlm_user_profile_pkey PRIMARY KEY (id);


--
-- Name: mlm_user_profile mlm_user_profile_user_id_7b1a5136_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mlm_user_profile
    ADD CONSTRAINT mlm_user_profile_user_id_7b1a5136_uniq UNIQUE (user_id);


--
-- Name: auth_group_name_a6ea08ec_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_group_name_a6ea08ec_like ON public.auth_group USING btree (name varchar_pattern_ops);


--
-- Name: auth_group_permissions_group_id_b120cbf9; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_group_permissions_group_id_b120cbf9 ON public.auth_group_permissions USING btree (group_id);


--
-- Name: auth_group_permissions_permission_id_84c5c92e; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_group_permissions_permission_id_84c5c92e ON public.auth_group_permissions USING btree (permission_id);


--
-- Name: auth_permission_content_type_id_2f476e4b; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_permission_content_type_id_2f476e4b ON public.auth_permission USING btree (content_type_id);


--
-- Name: auth_user_groups_group_id_97559544; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_user_groups_group_id_97559544 ON public.auth_user_groups USING btree (group_id);


--
-- Name: auth_user_groups_user_id_6a12ed8b; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_user_groups_user_id_6a12ed8b ON public.auth_user_groups USING btree (user_id);


--
-- Name: auth_user_user_permissions_permission_id_1fbb5f2c; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_user_user_permissions_permission_id_1fbb5f2c ON public.auth_user_user_permissions USING btree (permission_id);


--
-- Name: auth_user_user_permissions_user_id_a95ead1b; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_user_user_permissions_user_id_a95ead1b ON public.auth_user_user_permissions USING btree (user_id);


--
-- Name: auth_user_username_6821ab7c_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_user_username_6821ab7c_like ON public.auth_user USING btree (username varchar_pattern_ops);


--
-- Name: celery_taskmeta_hidden_23fd02dc; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX celery_taskmeta_hidden_23fd02dc ON public.celery_taskmeta USING btree (hidden);


--
-- Name: celery_taskmeta_task_id_9558b198_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX celery_taskmeta_task_id_9558b198_like ON public.celery_taskmeta USING btree (task_id varchar_pattern_ops);


--
-- Name: celery_tasksetmeta_hidden_593cfc24; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX celery_tasksetmeta_hidden_593cfc24 ON public.celery_tasksetmeta USING btree (hidden);


--
-- Name: celery_tasksetmeta_taskset_id_a5a1d4ae_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX celery_tasksetmeta_taskset_id_a5a1d4ae_like ON public.celery_tasksetmeta USING btree (taskset_id varchar_pattern_ops);


--
-- Name: django_admin_log_content_type_id_c4bce8eb; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_admin_log_content_type_id_c4bce8eb ON public.django_admin_log USING btree (content_type_id);


--
-- Name: django_admin_log_user_id_c564eba6; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_admin_log_user_id_c564eba6 ON public.django_admin_log USING btree (user_id);


--
-- Name: django_session_expire_date_a5c62663; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_session_expire_date_a5c62663 ON public.django_session USING btree (expire_date);


--
-- Name: django_session_session_key_c0390e0f_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_session_session_key_c0390e0f_like ON public.django_session USING btree (session_key varchar_pattern_ops);


--
-- Name: djcelery_periodictask_crontab_id_75609bab; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX djcelery_periodictask_crontab_id_75609bab ON public.djcelery_periodictask USING btree (crontab_id);


--
-- Name: djcelery_periodictask_interval_id_b426ab02; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX djcelery_periodictask_interval_id_b426ab02 ON public.djcelery_periodictask USING btree (interval_id);


--
-- Name: djcelery_periodictask_name_cb62cda9_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX djcelery_periodictask_name_cb62cda9_like ON public.djcelery_periodictask USING btree (name varchar_pattern_ops);


--
-- Name: djcelery_taskstate_hidden_c3905e57; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX djcelery_taskstate_hidden_c3905e57 ON public.djcelery_taskstate USING btree (hidden);


--
-- Name: djcelery_taskstate_name_8af9eded; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX djcelery_taskstate_name_8af9eded ON public.djcelery_taskstate USING btree (name);


--
-- Name: djcelery_taskstate_name_8af9eded_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX djcelery_taskstate_name_8af9eded_like ON public.djcelery_taskstate USING btree (name varchar_pattern_ops);


--
-- Name: djcelery_taskstate_state_53543be4; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX djcelery_taskstate_state_53543be4 ON public.djcelery_taskstate USING btree (state);


--
-- Name: djcelery_taskstate_state_53543be4_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX djcelery_taskstate_state_53543be4_like ON public.djcelery_taskstate USING btree (state varchar_pattern_ops);


--
-- Name: djcelery_taskstate_task_id_9d2efdb5_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX djcelery_taskstate_task_id_9d2efdb5_like ON public.djcelery_taskstate USING btree (task_id varchar_pattern_ops);


--
-- Name: djcelery_taskstate_tstamp_4c3f93a1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX djcelery_taskstate_tstamp_4c3f93a1 ON public.djcelery_taskstate USING btree (tstamp);


--
-- Name: djcelery_taskstate_worker_id_f7f57a05; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX djcelery_taskstate_worker_id_f7f57a05 ON public.djcelery_taskstate USING btree (worker_id);


--
-- Name: djcelery_workerstate_hostname_b31c7fab_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX djcelery_workerstate_hostname_b31c7fab_like ON public.djcelery_workerstate USING btree (hostname varchar_pattern_ops);


--
-- Name: djcelery_workerstate_last_heartbeat_4539b544; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX djcelery_workerstate_last_heartbeat_4539b544 ON public.djcelery_workerstate USING btree (last_heartbeat);


--
-- Name: mlm_invite_user_id_f6ade5fc; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX mlm_invite_user_id_f6ade5fc ON public.mlm_invite USING btree (user_id);


--
-- Name: mlm_user_hierarchy_parent_user_id_e3223107; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX mlm_user_hierarchy_parent_user_id_e3223107 ON public.mlm_user_hierarchy USING btree (parent_user_id);


--
-- Name: mlm_user_hierarchy_user_id_960bbaa8; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX mlm_user_hierarchy_user_id_960bbaa8 ON public.mlm_user_hierarchy USING btree (user_id);


--
-- Name: auth_group_permissions auth_group_permissio_permission_id_84c5c92e_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissio_permission_id_84c5c92e_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_group_permissions auth_group_permissions_group_id_b120cbf9_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_b120cbf9_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_permission auth_permission_content_type_id_2f476e4b_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_2f476e4b_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_groups auth_user_groups_group_id_97559544_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_group_id_97559544_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_groups auth_user_groups_user_id_6a12ed8b_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_6a12ed8b_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_user_permissions auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_user_permissions auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_content_type_id_c4bce8eb_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_content_type_id_c4bce8eb_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_user_id_c564eba6_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_user_id_c564eba6_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: djcelery_periodictask djcelery_periodictas_crontab_id_75609bab_fk_djcelery_; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.djcelery_periodictask
    ADD CONSTRAINT djcelery_periodictas_crontab_id_75609bab_fk_djcelery_ FOREIGN KEY (crontab_id) REFERENCES public.djcelery_crontabschedule(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: djcelery_periodictask djcelery_periodictas_interval_id_b426ab02_fk_djcelery_; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.djcelery_periodictask
    ADD CONSTRAINT djcelery_periodictas_interval_id_b426ab02_fk_djcelery_ FOREIGN KEY (interval_id) REFERENCES public.djcelery_intervalschedule(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: djcelery_taskstate djcelery_taskstate_worker_id_f7f57a05_fk_djcelery_; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.djcelery_taskstate
    ADD CONSTRAINT djcelery_taskstate_worker_id_f7f57a05_fk_djcelery_ FOREIGN KEY (worker_id) REFERENCES public.djcelery_workerstate(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: mlm_invite mlm_invite_user_id_f6ade5fc_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mlm_invite
    ADD CONSTRAINT mlm_invite_user_id_f6ade5fc_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: mlm_user_hierarchy mlm_user_hierarchy_parent_user_id_e3223107_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mlm_user_hierarchy
    ADD CONSTRAINT mlm_user_hierarchy_parent_user_id_e3223107_fk_auth_user_id FOREIGN KEY (parent_user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: mlm_user_hierarchy mlm_user_hierarchy_user_id_960bbaa8_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mlm_user_hierarchy
    ADD CONSTRAINT mlm_user_hierarchy_user_id_960bbaa8_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: mlm_user_profile mlm_user_profile_user_id_7b1a5136_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mlm_user_profile
    ADD CONSTRAINT mlm_user_profile_user_id_7b1a5136_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- PostgreSQL database dump complete
--

