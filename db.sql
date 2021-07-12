--
-- PostgreSQL database dump
--

-- Dumped from database version 12.5
-- Dumped by pg_dump version 13.2

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: appraisals_appraisal; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.appraisals_appraisal (
    id bigint NOT NULL,
    status integer NOT NULL,
    stage1_employee_comment text,
    stage1_manager_comment text,
    stage2_employee_comment text,
    stage2_manager_comment text,
    core_value_employee_comment text,
    core_value_hod_comment text,
    stage1_rejection_comment text,
    stage2_rejection_comment text,
    core_value_manager_comment text,
    other_properties jsonb,
    overall_appraisal_id bigint NOT NULL,
    employee_id bigint,
    hod_comment text,
    hod_rating integer,
    core_value_employee_rating integer,
    core_value_hod_rating integer,
    core_value_manager_rating integer,
    stage0_employee_comment text,
    stage0_manager_comment text,
    stage0_rejection_comment text
);


ALTER TABLE public.appraisals_appraisal OWNER TO postgres;

--
-- Name: appraisals_appraisal_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.appraisals_appraisal_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.appraisals_appraisal_id_seq OWNER TO postgres;

--
-- Name: appraisals_appraisal_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.appraisals_appraisal_id_seq OWNED BY public.appraisals_appraisal.id;


--
-- Name: appraisals_overallappraisal; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.appraisals_overallappraisal (
    id bigint NOT NULL,
    name character varying(50) NOT NULL,
    stage integer NOT NULL,
    goal_weightage integer NOT NULL,
    core_value_weightage integer NOT NULL,
    skill_weightage integer NOT NULL,
    stage1_start_date date NOT NULL,
    stage1_end_date date NOT NULL,
    stage2_start_date date NOT NULL,
    stage2_end_date date NOT NULL,
    stage3_start_date date NOT NULL,
    stage3_end_date date NOT NULL,
    reports_end_date date NOT NULL,
    calibration_end_date date NOT NULL,
    company_id bigint NOT NULL
);


ALTER TABLE public.appraisals_overallappraisal OWNER TO postgres;

--
-- Name: appraisals_overallappraisal_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.appraisals_overallappraisal_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.appraisals_overallappraisal_id_seq OWNER TO postgres;

--
-- Name: appraisals_overallappraisal_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.appraisals_overallappraisal_id_seq OWNED BY public.appraisals_overallappraisal.id;


--
-- Name: auth_access_token; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_access_token (
    id bigint NOT NULL,
    token character varying(128) NOT NULL,
    expires timestamp with time zone NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    user_id bigint
);


ALTER TABLE public.auth_access_token OWNER TO postgres;

--
-- Name: auth_access_token_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.auth_access_token_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_access_token_id_seq OWNER TO postgres;

--
-- Name: auth_access_token_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.auth_access_token_id_seq OWNED BY public.auth_access_token.id;


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
-- Name: auth_refresh_token; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_refresh_token (
    id bigint NOT NULL,
    token character varying(255) NOT NULL,
    created timestamp with time zone NOT NULL,
    updated timestamp with time zone NOT NULL,
    revoked timestamp with time zone,
    access_token_id bigint NOT NULL,
    user_id bigint
);


ALTER TABLE public.auth_refresh_token OWNER TO postgres;

--
-- Name: auth_refresh_token_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.auth_refresh_token_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_refresh_token_id_seq OWNER TO postgres;

--
-- Name: auth_refresh_token_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.auth_refresh_token_id_seq OWNED BY public.auth_refresh_token.id;


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
    user_id bigint NOT NULL,
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
-- Name: django_site; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_site (
    id integer NOT NULL,
    domain character varying(100) NOT NULL,
    name character varying(50) NOT NULL
);


ALTER TABLE public.django_site OWNER TO postgres;

--
-- Name: django_site_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.django_site_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_site_id_seq OWNER TO postgres;

--
-- Name: django_site_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.django_site_id_seq OWNED BY public.django_site.id;


--
-- Name: training_corevalue; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.training_corevalue (
    id bigint NOT NULL,
    summary text,
    description text,
    due date NOT NULL,
    weightage integer NOT NULL,
    appraisal_id bigint NOT NULL,
    category_id bigint
);


ALTER TABLE public.training_corevalue OWNER TO postgres;

--
-- Name: training_corevalue_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.training_corevalue_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.training_corevalue_id_seq OWNER TO postgres;

--
-- Name: training_corevalue_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.training_corevalue_id_seq OWNED BY public.training_corevalue.id;


--
-- Name: training_corevaluecategory; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.training_corevaluecategory (
    id bigint NOT NULL,
    name character varying(70) NOT NULL,
    company_id bigint NOT NULL
);


ALTER TABLE public.training_corevaluecategory OWNER TO postgres;

--
-- Name: training_corevaluecategory_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.training_corevaluecategory_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.training_corevaluecategory_id_seq OWNER TO postgres;

--
-- Name: training_corevaluecategory_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.training_corevaluecategory_id_seq OWNED BY public.training_corevaluecategory.id;


--
-- Name: training_departmentalcorevalue; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.training_departmentalcorevalue (
    id bigint NOT NULL,
    summary character varying(150) NOT NULL,
    due date,
    description character varying(150),
    appraisal_id bigint NOT NULL,
    category_id bigint,
    manager_id bigint
);


ALTER TABLE public.training_departmentalcorevalue OWNER TO postgres;

--
-- Name: training_departmentalcorevalue_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.training_departmentalcorevalue_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.training_departmentalcorevalue_id_seq OWNER TO postgres;

--
-- Name: training_departmentalcorevalue_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.training_departmentalcorevalue_id_seq OWNED BY public.training_departmentalcorevalue.id;


--
-- Name: training_departmentalgoal; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.training_departmentalgoal (
    id bigint NOT NULL,
    summary character varying(150) NOT NULL,
    due date,
    description character varying(150),
    appraisal_id bigint NOT NULL,
    category_id bigint,
    manager_id bigint
);


ALTER TABLE public.training_departmentalgoal OWNER TO postgres;

--
-- Name: training_departmentalgoal_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.training_departmentalgoal_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.training_departmentalgoal_id_seq OWNER TO postgres;

--
-- Name: training_departmentalgoal_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.training_departmentalgoal_id_seq OWNED BY public.training_departmentalgoal.id;


--
-- Name: training_goal; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.training_goal (
    id bigint NOT NULL,
    summary text,
    description text,
    due date NOT NULL,
    weightage integer NOT NULL,
    status integer NOT NULL,
    stage1_employee_comment text,
    stage1_manager_comment text,
    stage2_employee_comment text,
    tracking_status character varying(50),
    stage2_manager_comment text,
    stage0_employee_comment text,
    stage0_manager_comment text,
    appraisal_id bigint NOT NULL,
    category_id bigint,
    employee_rating integer,
    manager_rating integer
);


ALTER TABLE public.training_goal OWNER TO postgres;

--
-- Name: training_goal_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.training_goal_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.training_goal_id_seq OWNER TO postgres;

--
-- Name: training_goal_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.training_goal_id_seq OWNED BY public.training_goal.id;


--
-- Name: training_goalcategory; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.training_goalcategory (
    id bigint NOT NULL,
    name character varying(70) NOT NULL,
    company_id bigint NOT NULL
);


ALTER TABLE public.training_goalcategory OWNER TO postgres;

--
-- Name: training_goalcategory_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.training_goalcategory_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.training_goalcategory_id_seq OWNER TO postgres;

--
-- Name: training_goalcategory_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.training_goalcategory_id_seq OWNED BY public.training_goalcategory.id;


--
-- Name: training_kpi; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.training_kpi (
    id bigint NOT NULL,
    summary text,
    due date,
    date_created date,
    progress character varying(20) NOT NULL,
    goal_id bigint NOT NULL
);


ALTER TABLE public.training_kpi OWNER TO postgres;

--
-- Name: training_kpi_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.training_kpi_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.training_kpi_id_seq OWNER TO postgres;

--
-- Name: training_kpi_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.training_kpi_id_seq OWNED BY public.training_kpi.id;


--
-- Name: training_skill; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.training_skill (
    id bigint NOT NULL,
    summary text,
    description text,
    due date NOT NULL,
    weightage integer NOT NULL,
    appraisal_id bigint NOT NULL,
    category_id bigint
);


ALTER TABLE public.training_skill OWNER TO postgres;

--
-- Name: training_skill_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.training_skill_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.training_skill_id_seq OWNER TO postgres;

--
-- Name: training_skill_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.training_skill_id_seq OWNED BY public.training_skill.id;


--
-- Name: training_skillscategory; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.training_skillscategory (
    id bigint NOT NULL,
    name character varying(70) NOT NULL,
    company_id bigint NOT NULL
);


ALTER TABLE public.training_skillscategory OWNER TO postgres;

--
-- Name: training_skillscategory_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.training_skillscategory_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.training_skillscategory_id_seq OWNER TO postgres;

--
-- Name: training_skillscategory_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.training_skillscategory_id_seq OWNED BY public.training_skillscategory.id;


--
-- Name: users_company; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users_company (
    id bigint NOT NULL,
    name character varying(20) NOT NULL,
    logo character varying(100),
    login_logo character varying(100),
    domain character varying(50) NOT NULL,
    setting jsonb,
    is_active boolean NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


ALTER TABLE public.users_company OWNER TO postgres;

--
-- Name: users_company_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_company_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_company_id_seq OWNER TO postgres;

--
-- Name: users_company_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_company_id_seq OWNED BY public.users_company.id;


--
-- Name: users_department; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users_department (
    id bigint NOT NULL,
    name character varying(100) NOT NULL,
    logo character varying(100),
    company_id bigint NOT NULL,
    manager_id bigint
);


ALTER TABLE public.users_department OWNER TO postgres;

--
-- Name: users_department_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_department_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_department_id_seq OWNER TO postgres;

--
-- Name: users_department_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_department_id_seq OWNED BY public.users_department.id;


--
-- Name: users_logs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users_logs (
    id bigint NOT NULL,
    title character varying(250) NOT NULL,
    color character varying(100) NOT NULL,
    user_id bigint NOT NULL,
    created_at timestamp with time zone NOT NULL
);


ALTER TABLE public.users_logs OWNER TO postgres;

--
-- Name: users_logs_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_logs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_logs_id_seq OWNER TO postgres;

--
-- Name: users_logs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_logs_id_seq OWNED BY public.users_logs.id;


--
-- Name: users_notification; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users_notification (
    logs_ptr_id bigint NOT NULL,
    is_read boolean NOT NULL,
    description text
);


ALTER TABLE public.users_notification OWNER TO postgres;

--
-- Name: users_permission; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users_permission (
    id bigint NOT NULL,
    name character varying(100) NOT NULL,
    company_id bigint
);


ALTER TABLE public.users_permission OWNER TO postgres;

--
-- Name: users_permission_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_permission_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_permission_id_seq OWNER TO postgres;

--
-- Name: users_permission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_permission_id_seq OWNED BY public.users_permission.id;


--
-- Name: users_profile; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users_profile (
    id bigint NOT NULL,
    avatar character varying(100),
    gender character varying(6),
    martial_status character varying(50),
    date_of_hire date NOT NULL,
    employee_id character varying(50),
    employment_type character varying(50),
    job_title character varying(100),
    resign_date date,
    address_1 character varying(250),
    address_2 character varying(250),
    skill1 character varying(50),
    skill2 character varying(50),
    skill3 character varying(50),
    department_id bigint,
    first_reporting_manager_id bigint,
    second_reporting_manager_id bigint,
    user_id bigint NOT NULL
);


ALTER TABLE public.users_profile OWNER TO postgres;

--
-- Name: users_profile_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_profile_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_profile_id_seq OWNER TO postgres;

--
-- Name: users_profile_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_profile_id_seq OWNED BY public.users_profile.id;


--
-- Name: users_resetpasswordtoken; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users_resetpasswordtoken (
    id bigint NOT NULL,
    token character varying(10) NOT NULL,
    created_at timestamp with time zone NOT NULL,
    user_id bigint NOT NULL
);


ALTER TABLE public.users_resetpasswordtoken OWNER TO postgres;

--
-- Name: users_resetpasswordtoken_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_resetpasswordtoken_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_resetpasswordtoken_id_seq OWNER TO postgres;

--
-- Name: users_resetpasswordtoken_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_resetpasswordtoken_id_seq OWNED BY public.users_resetpasswordtoken.id;


--
-- Name: users_role; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users_role (
    id bigint NOT NULL,
    name character varying(20) NOT NULL,
    company_id bigint
);


ALTER TABLE public.users_role OWNER TO postgres;

--
-- Name: users_role_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_role_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_role_id_seq OWNER TO postgres;

--
-- Name: users_role_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_role_id_seq OWNED BY public.users_role.id;


--
-- Name: users_role_permissions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users_role_permissions (
    id integer NOT NULL,
    role_id bigint NOT NULL,
    permission_id bigint NOT NULL
);


ALTER TABLE public.users_role_permissions OWNER TO postgres;

--
-- Name: users_role_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_role_permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_role_permissions_id_seq OWNER TO postgres;

--
-- Name: users_role_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_role_permissions_id_seq OWNED BY public.users_role_permissions.id;


--
-- Name: users_user; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users_user (
    id bigint NOT NULL,
    password character varying(128) NOT NULL,
    last_login timestamp with time zone,
    first_name character varying(50),
    username character varying(50) NOT NULL,
    last_name character varying(50),
    email character varying(254) NOT NULL,
    is_active boolean NOT NULL,
    is_admin boolean NOT NULL,
    is_superuser boolean NOT NULL,
    is_email_verified boolean,
    date_joined timestamp with time zone NOT NULL,
    dummy_password character varying(10),
    contact_number character varying(20),
    company_id bigint,
    role_id bigint
);


ALTER TABLE public.users_user OWNER TO postgres;

--
-- Name: users_user_groups; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users_user_groups (
    id integer NOT NULL,
    user_id bigint NOT NULL,
    group_id integer NOT NULL
);


ALTER TABLE public.users_user_groups OWNER TO postgres;

--
-- Name: users_user_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_user_groups_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_user_groups_id_seq OWNER TO postgres;

--
-- Name: users_user_groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_user_groups_id_seq OWNED BY public.users_user_groups.id;


--
-- Name: users_user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_user_id_seq OWNER TO postgres;

--
-- Name: users_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_user_id_seq OWNED BY public.users_user.id;


--
-- Name: users_user_user_permissions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users_user_user_permissions (
    id integer NOT NULL,
    user_id bigint NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.users_user_user_permissions OWNER TO postgres;

--
-- Name: users_user_user_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_user_user_permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_user_user_permissions_id_seq OWNER TO postgres;

--
-- Name: users_user_user_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_user_user_permissions_id_seq OWNED BY public.users_user_user_permissions.id;


--
-- Name: appraisals_appraisal id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.appraisals_appraisal ALTER COLUMN id SET DEFAULT nextval('public.appraisals_appraisal_id_seq'::regclass);


--
-- Name: appraisals_overallappraisal id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.appraisals_overallappraisal ALTER COLUMN id SET DEFAULT nextval('public.appraisals_overallappraisal_id_seq'::regclass);


--
-- Name: auth_access_token id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_access_token ALTER COLUMN id SET DEFAULT nextval('public.auth_access_token_id_seq'::regclass);


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
-- Name: auth_refresh_token id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_refresh_token ALTER COLUMN id SET DEFAULT nextval('public.auth_refresh_token_id_seq'::regclass);


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
-- Name: django_site id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_site ALTER COLUMN id SET DEFAULT nextval('public.django_site_id_seq'::regclass);


--
-- Name: training_corevalue id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.training_corevalue ALTER COLUMN id SET DEFAULT nextval('public.training_corevalue_id_seq'::regclass);


--
-- Name: training_corevaluecategory id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.training_corevaluecategory ALTER COLUMN id SET DEFAULT nextval('public.training_corevaluecategory_id_seq'::regclass);


--
-- Name: training_departmentalcorevalue id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.training_departmentalcorevalue ALTER COLUMN id SET DEFAULT nextval('public.training_departmentalcorevalue_id_seq'::regclass);


--
-- Name: training_departmentalgoal id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.training_departmentalgoal ALTER COLUMN id SET DEFAULT nextval('public.training_departmentalgoal_id_seq'::regclass);


--
-- Name: training_goal id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.training_goal ALTER COLUMN id SET DEFAULT nextval('public.training_goal_id_seq'::regclass);


--
-- Name: training_goalcategory id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.training_goalcategory ALTER COLUMN id SET DEFAULT nextval('public.training_goalcategory_id_seq'::regclass);


--
-- Name: training_kpi id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.training_kpi ALTER COLUMN id SET DEFAULT nextval('public.training_kpi_id_seq'::regclass);


--
-- Name: training_skill id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.training_skill ALTER COLUMN id SET DEFAULT nextval('public.training_skill_id_seq'::regclass);


--
-- Name: training_skillscategory id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.training_skillscategory ALTER COLUMN id SET DEFAULT nextval('public.training_skillscategory_id_seq'::regclass);


--
-- Name: users_company id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users_company ALTER COLUMN id SET DEFAULT nextval('public.users_company_id_seq'::regclass);


--
-- Name: users_department id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users_department ALTER COLUMN id SET DEFAULT nextval('public.users_department_id_seq'::regclass);


--
-- Name: users_logs id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users_logs ALTER COLUMN id SET DEFAULT nextval('public.users_logs_id_seq'::regclass);


--
-- Name: users_permission id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users_permission ALTER COLUMN id SET DEFAULT nextval('public.users_permission_id_seq'::regclass);


--
-- Name: users_profile id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users_profile ALTER COLUMN id SET DEFAULT nextval('public.users_profile_id_seq'::regclass);


--
-- Name: users_resetpasswordtoken id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users_resetpasswordtoken ALTER COLUMN id SET DEFAULT nextval('public.users_resetpasswordtoken_id_seq'::regclass);


--
-- Name: users_role id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users_role ALTER COLUMN id SET DEFAULT nextval('public.users_role_id_seq'::regclass);


--
-- Name: users_role_permissions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users_role_permissions ALTER COLUMN id SET DEFAULT nextval('public.users_role_permissions_id_seq'::regclass);


--
-- Name: users_user id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users_user ALTER COLUMN id SET DEFAULT nextval('public.users_user_id_seq'::regclass);


--
-- Name: users_user_groups id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users_user_groups ALTER COLUMN id SET DEFAULT nextval('public.users_user_groups_id_seq'::regclass);


--
-- Name: users_user_user_permissions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users_user_user_permissions ALTER COLUMN id SET DEFAULT nextval('public.users_user_user_permissions_id_seq'::regclass);


--
-- Data for Name: appraisals_appraisal; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.appraisals_appraisal (id, status, stage1_employee_comment, stage1_manager_comment, stage2_employee_comment, stage2_manager_comment, core_value_employee_comment, core_value_hod_comment, stage1_rejection_comment, stage2_rejection_comment, core_value_manager_comment, other_properties, overall_appraisal_id, employee_id, hod_comment, hod_rating, core_value_employee_rating, core_value_hod_rating, core_value_manager_rating, stage0_employee_comment, stage0_manager_comment, stage0_rejection_comment) FROM stdin;
13	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	13	21	\N	\N	\N	\N	\N	\N	\N	\N
14	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	13	20	\N	\N	\N	\N	\N	\N	\N	\N
15	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	14	21	\N	\N	\N	\N	\N	\N	\N	\N
16	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	14	20	\N	\N	\N	\N	\N	\N	\N	\N
54	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	17	21	\N	\N	\N	\N	\N	\N	\N	\N
55	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	17	20	\N	\N	\N	\N	\N	\N	\N	\N
56	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	17	22	\N	\N	\N	\N	\N	\N	\N	\N
57	10	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	17	23	\N	\N	\N	\N	\N	\N	\N	\N
\.


--
-- Data for Name: appraisals_overallappraisal; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.appraisals_overallappraisal (id, name, stage, goal_weightage, core_value_weightage, skill_weightage, stage1_start_date, stage1_end_date, stage2_start_date, stage2_end_date, stage3_start_date, stage3_end_date, reports_end_date, calibration_end_date, company_id) FROM stdin;
13	jjjjjj	2	0	0	0	2021-06-09	2021-06-17	2021-06-22	2021-06-24	2021-06-22	2021-06-23	2021-06-15	2021-06-17	3
14	skskkskskskkskskkskskskkskss	2	0	0	0	2021-06-09	2021-06-17	2021-06-30	2021-06-24	2021-06-24	2021-06-23	2021-06-23	2021-06-23	3
17	2021 test appraisal	1	0	0	0	2021-07-17	2021-07-28	2021-07-22	2021-07-23	2021-07-23	2021-07-31	2021-07-30	2021-07-23	25
\.


--
-- Data for Name: auth_access_token; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_access_token (id, token, expires, created_at, updated_at, user_id) FROM stdin;
5	I148cYXYDNFm6Z5ebUA-NXiq9jUnIdpzvKEYvAHDnx8	2021-05-25 22:19:57.531764+05:30	2021-05-23 22:19:57.539638+05:30	2021-05-23 22:19:57.539843+05:30	3
6	kA7i-V9B88iOTTCjxAYxJzUUhzGrenXk9of8pGk12L4	2021-05-26 04:26:04.770807+05:30	2021-05-24 04:26:04.776038+05:30	2021-05-24 04:26:04.776082+05:30	3
7	UYVqbaimWF4j5h7IfU8jtj3uvTa7NbbHEPVvldiVMCo	2021-05-26 04:27:06.362155+05:30	2021-05-24 04:27:06.364765+05:30	2021-05-24 04:27:06.36492+05:30	3
8	_SVy2tYIENN_c8EFD1k4m6C--70qq-7KqIsODMzNCUQ	2021-05-26 04:28:59.60687+05:30	2021-05-24 04:28:59.609514+05:30	2021-05-24 04:28:59.609566+05:30	3
9	DsmCtyzNOK01mj-5cEzEU519P30M6CaiCDx0a38_z3s	2021-05-26 04:31:36.482423+05:30	2021-05-24 04:31:36.484102+05:30	2021-05-24 04:31:36.484139+05:30	3
10	ARHEXi_AXhNBsVF9eF6chrLJUDdKhMIc7U9pcjWuLj0	2021-05-26 04:32:06.615443+05:30	2021-05-24 04:32:06.620113+05:30	2021-05-24 04:32:06.620175+05:30	3
11	rW-z8_g6pry7Dbi1e-M0zKlE5e_8SO-Dte240487c9U	2021-05-26 04:33:39.172914+05:30	2021-05-24 04:33:39.173713+05:30	2021-05-24 04:33:39.173751+05:30	3
12	bmsG5nB_YF6XZe5DVko2G78EkAIHZbMQQRbi6dBHL7M	2021-05-26 04:34:04.666906+05:30	2021-05-24 04:34:04.670346+05:30	2021-05-24 04:34:04.670407+05:30	3
13	eIyZJcTj36PnEyWpQZzy8G0WUgrleqdelfSqIHkSLGQ	2021-05-26 04:36:57.343724+05:30	2021-05-24 04:36:57.346207+05:30	2021-05-24 04:36:57.346263+05:30	3
14	xrTLCLRRZyhac4yHIowcdQn6uzS7R-mVI9og3dwzI3g	2021-05-26 04:37:10.307883+05:30	2021-05-24 04:37:10.308746+05:30	2021-05-24 04:37:10.308792+05:30	3
15	SaQ4DrZ4AaXj4qlAulLZclnLZ5mbeeSTWab5ioUK1l8	2021-05-26 05:15:02.360328+05:30	2021-05-24 05:15:02.364862+05:30	2021-05-24 05:15:02.364923+05:30	3
16	RnnEDfYduYx-VztvVt6-kaCEOB_cdwLvHcJYKb4d3-E	2021-05-26 05:19:54.073962+05:30	2021-05-24 05:19:54.076014+05:30	2021-05-24 05:19:54.076075+05:30	3
17	sPc9X65B6Pr06FFs3B70gNYnlAHvvCT6HQ_mJCls6fo	2021-05-26 05:20:48.608565+05:30	2021-05-24 05:20:48.609664+05:30	2021-05-24 05:20:48.609708+05:30	3
18	Z-Fl7CGqqUFYgaGxhsoHbrU9x_NE0ttMn5nkA65cTrQ	2021-05-26 05:22:15.782354+05:30	2021-05-24 05:22:15.784372+05:30	2021-05-24 05:22:15.784413+05:30	3
19	9bSwRrOKpzE9kmjfkfXBjuJY10t0SjsuyAMSW5pQEEA	2021-05-26 05:26:30.219549+05:30	2021-05-24 05:26:30.221419+05:30	2021-05-24 05:26:30.221458+05:30	3
20	QE3UMvOlOXQKyQG9gCpil4JYZPO1Bva6FssJOAQ3SRc	2021-05-26 05:26:44.21264+05:30	2021-05-24 05:26:44.213413+05:30	2021-05-24 05:26:44.213448+05:30	3
21	pP301eiRwXkqa5gmBAhpAELhUD-_HY4Sppm800xxptw	2021-05-26 05:30:51.488646+05:30	2021-05-24 05:30:51.49376+05:30	2021-05-24 05:30:51.49384+05:30	3
22	A4YMx9MXpvOo0WcVhR_uhomi0TN-j0AmS-FVBLR2ve4	2021-05-26 05:33:49.843712+05:30	2021-05-24 05:33:49.851046+05:30	2021-05-24 05:33:49.851094+05:30	3
23	8aadXvYID1o8plrfG-V2EoFNU_JxTFAKKNzLWh7ldvk	2021-05-26 05:33:55.302377+05:30	2021-05-24 05:33:55.303627+05:30	2021-05-24 05:33:55.30369+05:30	3
24	l64CYyh7WZ2-zeeEnQznsNzOSzDMyzm7XxqQBc7qijg	2021-05-26 19:26:28.845985+05:30	2021-05-24 19:26:28.854116+05:30	2021-05-24 19:26:28.85416+05:30	3
25	9PNPl54_9ircDeufcnjuwuu4PRpy3oQcw_SH1lbnCuI	2021-05-26 22:22:26.431848+05:30	2021-05-24 22:22:26.44217+05:30	2021-05-24 22:22:26.442214+05:30	3
26	7blkA9lgUKyTtplU-5YAYKgiifFnAeRf3fQqD_wTvWs	2021-05-26 22:23:22.142546+05:30	2021-05-24 22:23:22.143348+05:30	2021-05-24 22:23:22.143383+05:30	3
27	VswB1HtA8rSw_VDNaiJy7cjZ7Ssbwp4VD2MJ3Q8N8Pw	2021-05-26 22:25:27.856608+05:30	2021-05-24 22:25:27.858564+05:30	2021-05-24 22:25:27.858608+05:30	3
28	dJefOnE25PjIDCFiSomG9ctOXtDpDK0n4aXq1FHWndw	2021-05-26 22:26:06.164442+05:30	2021-05-24 22:26:06.16545+05:30	2021-05-24 22:26:06.165524+05:30	3
29	shj1NK7TVQhbbXy0RcVLPdGIYszkDP9U4rMG-JgOXeY	2021-05-26 22:26:19.668441+05:30	2021-05-24 22:26:19.66946+05:30	2021-05-24 22:26:19.669516+05:30	3
30	55LbW87H2swRrhrOn9_SmkwzQwbT6XYkXB0b0lc55PY	2021-05-26 22:27:52.993977+05:30	2021-05-24 22:27:52.995401+05:30	2021-05-24 22:27:52.995465+05:30	3
31	1Vn4qzRtBn_G8EIIrxuqzZEUx8kQmB9551Pkz-LoGrA	2021-05-26 22:27:58.905623+05:30	2021-05-24 22:27:58.906938+05:30	2021-05-24 22:27:58.906985+05:30	3
32	7IiZwfy3Kk5L3eA6v6IopSdnurEMhaCYKhn9wt_ZR_c	2021-05-26 22:27:59.378819+05:30	2021-05-24 22:27:59.379745+05:30	2021-05-24 22:27:59.379858+05:30	3
33	W1I9UoHNz9encE1EHtYjCsDQQWKST-S9nEIfUCfKffU	2021-05-26 22:27:59.554342+05:30	2021-05-24 22:27:59.555448+05:30	2021-05-24 22:27:59.555496+05:30	3
34	pgrl8vbqyTzcWm45fHN_MD09xs-w8w3FjpOf8W78vJo	2021-05-26 22:27:59.700149+05:30	2021-05-24 22:27:59.700994+05:30	2021-05-24 22:27:59.701029+05:30	3
35	LBLxQ3VAKpwZrPOfgxEngWq1ar3w_uA2pCJYRLfQ2d8	2021-05-26 22:29:58.100299+05:30	2021-05-24 22:29:58.121676+05:30	2021-05-24 22:29:58.121782+05:30	3
36	omaoYoiu2OiioaE1sMuMnu_4Bld1eyhtGJ1dPfrgaM0	2021-05-26 22:29:58.149799+05:30	2021-05-24 22:29:58.164145+05:30	2021-05-24 22:29:58.164205+05:30	3
37	UPz2Osqzz0ZH_cuzqF_IXU3oyeWFw3LbRwp-uZ6D4Vk	2021-05-26 22:29:58.205138+05:30	2021-05-24 22:29:58.206345+05:30	2021-05-24 22:29:58.206407+05:30	3
38	Jr_dD5Pk0JbVc0Rq35Wr2ccfNIGRKP14_U7_4gMU9EM	2021-05-26 23:02:44.019121+05:30	2021-05-24 23:02:44.022858+05:30	2021-05-24 23:02:44.022902+05:30	3
39	n8TpCXbrj_QU7_mW-T55chlQ5v_r1LEfpIqhrvOYDUA	2021-05-26 23:03:00.122156+05:30	2021-05-24 23:03:00.123025+05:30	2021-05-24 23:03:00.123063+05:30	3
40	-0oC1M3uLOW4ZCLpZLommq3Rc6lB8knETZoiiNzNU7U	2021-05-26 23:04:22.376577+05:30	2021-05-24 23:04:22.378581+05:30	2021-05-24 23:04:22.378631+05:30	3
41	-5Okxyg1EaXpJfVj5H7jxKcAGTBCVf_v4L9WLWoFCkg	2021-05-26 23:10:07.604875+05:30	2021-05-24 23:10:07.609865+05:30	2021-05-24 23:10:07.609924+05:30	3
42	OCKh_RQS4WObOxh9utMBMXKVFybVi1Fq-MlvoDdzkwA	2021-05-26 23:10:23.560075+05:30	2021-05-24 23:10:23.561598+05:30	2021-05-24 23:10:23.56166+05:30	3
43	t263G40vMaHLFTh1v5Q8VjMVAyZ9eZU4A8xyFNf41-A	2021-05-28 12:25:53.390582+05:30	2021-05-26 12:25:53.3928+05:30	2021-05-26 12:25:53.392848+05:30	3
44	legK2E_1q1xCca-h2agqc8anUrer0aUgC_iSakQ9rsY	2021-05-28 12:43:15.81309+05:30	2021-05-26 12:43:15.814869+05:30	2021-05-26 12:43:15.814906+05:30	3
45	BZzj4jvIAB5qNwmGRjw3Dw_J7zxdJoxLjbCSxYvUDkc	2021-05-28 12:43:42.744185+05:30	2021-05-26 12:43:42.745774+05:30	2021-05-26 12:43:42.745849+05:30	3
46	vDzKOKF492GnTQ6O3il938i7MzLEHh9KE4eF7jAyFe8	2021-05-28 12:45:49.286744+05:30	2021-05-26 12:45:49.288211+05:30	2021-05-26 12:45:49.288252+05:30	3
47	nKFAY3U3xnbqwjA2mxqHBZPsc2qJ5ORPTcg8j-TIK7o	2021-05-29 23:43:38.892756+05:30	2021-05-27 23:43:38.900488+05:30	2021-05-27 23:43:38.90056+05:30	3
48	o6ZI6NBuFUTDXKHvgv3xIYaSAYPD9DNgn_4BojACx44	2021-05-29 23:44:28.634783+05:30	2021-05-27 23:44:28.637192+05:30	2021-05-27 23:44:28.637231+05:30	3
49	d_xv0-hEKWDnsdIMbpjeSs54znSMpnUcwWSQXTfvYwY	2021-06-01 21:07:31.455958+05:30	2021-05-30 21:07:31.46045+05:30	2021-05-30 21:07:31.460575+05:30	3
50	3UyYJDU6n9zmBWF5BsUFcXgD7qHK0LmEvyEKe1nfNX8	2021-06-01 21:13:01.507549+05:30	2021-05-30 21:13:01.508408+05:30	2021-05-30 21:13:01.50845+05:30	34
51	AZa77MTXB05uNhiKwmwOlNtBSAuyjH6TFapeyyliz4E	2021-06-01 23:00:13.945197+05:30	2021-05-30 23:00:13.947125+05:30	2021-05-30 23:00:13.947173+05:30	3
52	fWkujAwhBLBUOiRmA-rvow0OaDvBdyNN5ZpQLi2vDUk	2021-06-07 23:41:40.817026+05:30	2021-06-05 23:41:40.820725+05:30	2021-06-05 23:41:40.820767+05:30	34
53	LQvTfMYmtWCNyyBZlhSb4p9kguJGbUa80FrUQK_rfo0	2021-06-09 04:21:55.369416+05:30	2021-06-07 04:21:55.376294+05:30	2021-06-07 04:21:55.376387+05:30	34
54	SWvRqaOaRO5KlInLJcAPtDGU0DwZ_4yD9d24a_6F3j8	2021-06-10 00:50:15.408299+05:30	2021-06-08 00:50:15.409297+05:30	2021-06-08 00:50:15.409318+05:30	34
55	l7GFILZUi7NXfbX-jwvOZccf5xA7PgvC-3ORw2cr6-Q	2021-06-10 00:51:00.43071+05:30	2021-06-08 00:51:00.431314+05:30	2021-06-08 00:51:00.431334+05:30	3
56	sdsUBIhRVe874N3NlMKI--EA1npLE4WhqTlLA1TYpWI	2021-06-11 03:07:18.306214+05:30	2021-06-09 03:07:18.308317+05:30	2021-06-09 03:07:18.308355+05:30	34
57	Hl_GaOAG94B9Jn7NfQ3BmFkWfVZOptp9LYgMyEwwthw	2021-06-11 05:02:36.827796+05:30	2021-06-09 05:02:36.829551+05:30	2021-06-09 05:02:36.829606+05:30	3
58	Wjvr_aCCuxJu4hDIOyzsp6gWy1k1XVy2OJD6k_nF1bw	2021-06-16 07:26:01.765641+05:30	2021-06-14 07:26:01.772289+05:30	2021-06-14 07:26:01.772348+05:30	34
59	6FrUwsK7zCmbGrFdeqeTE4o3q_fo_73ooe42Gag6YkU	2021-06-20 18:35:02.578863+05:30	2021-06-18 18:35:02.581595+05:30	2021-06-18 18:35:02.581635+05:30	34
60	qDmytbc_6wg8SgJ3KRq8uSc6GcO0zzBF6dMQUqYHFRg	2021-06-23 19:28:01.304628+05:30	2021-06-21 19:28:01.31294+05:30	2021-06-21 19:28:01.313047+05:30	34
61	DaCWPWotebvxFrEIBdaan_21Ou_5BoJdv0_0SCry3nw	2021-06-25 12:10:17.098073+05:30	2021-06-23 12:10:17.10038+05:30	2021-06-23 12:10:17.10042+05:30	34
62	npv7zTgxGJwl8WRAAcoqR63AdyvuaqjJmKKzDKB5kLU	2021-07-03 22:50:45.038251+05:30	2021-07-01 22:50:45.044702+05:30	2021-07-01 22:50:45.044752+05:30	34
63	daTJAIRB4esWUoku5kMoSJ9-4a2fy0dSjpI2SDQZwiA	2021-07-04 22:35:33.153048+05:30	2021-07-02 22:35:33.155404+05:30	2021-07-02 22:35:33.155449+05:30	34
64	Iabgr8taviLlA_CvUGNHhZmsgcFBKso0u5RUTeArHls	2021-07-06 13:24:53.229284+05:30	2021-07-04 13:24:53.246422+05:30	2021-07-04 13:24:53.246522+05:30	34
65	ECzG-yhVjXFSYErqds9Bav9vf0S2q9AytVTg3ycvaMU	2021-07-06 13:38:51.734373+05:30	2021-07-04 13:38:51.737338+05:30	2021-07-04 13:38:51.737383+05:30	34
66	FcJoFkuTem8wx0vc4Fi-ZDLKSBEORStROfN1qdq-Jpg	2021-07-06 14:50:29.513327+05:30	2021-07-04 14:50:29.515995+05:30	2021-07-04 14:50:29.516078+05:30	37
67	ejalE4asjiCaxxfW_aXa5EN6ATb01CzHApWXYIEpk8U	2021-07-06 14:58:37.381951+05:30	2021-07-04 14:58:37.383085+05:30	2021-07-04 14:58:37.383128+05:30	36
68	P4A6DfK1fmsHNchKZTwE4muxKEpEyS95Zmn5ryUL2iw	2021-07-07 22:28:58.52074+05:30	2021-07-05 22:28:58.524332+05:30	2021-07-05 22:28:58.524375+05:30	34
69	7q2e9YP47B6y_-g4OAaNvQIpwIucsSqstg7wzlbcMpo	2021-07-07 22:29:14.177253+05:30	2021-07-05 22:29:14.178532+05:30	2021-07-05 22:29:14.178586+05:30	36
70	4gGrCoJfvwm3xlVhse54E0KuoblvI9bmsE02eWDC3rM	2021-07-07 22:29:40.139217+05:30	2021-07-05 22:29:40.1402+05:30	2021-07-05 22:29:40.140243+05:30	37
71	7RvIDAQ4U6NxZh86E8RYfXLuaKbLVo9qVyKDwWOKLSk	2021-07-08 01:00:48.08411+05:30	2021-07-06 01:00:48.085595+05:30	2021-07-06 01:00:48.085636+05:30	34
72	aIlnlrd84r0wa5Xsk2lm-dOo0AZcTC_lbV2zpRETSZI	2021-07-08 02:12:24.232332+05:30	2021-07-06 02:12:24.234916+05:30	2021-07-06 02:12:24.235003+05:30	36
73	T2IcT0VV9L3cIjtW5eW5C4ruLUnF8rI7BHTFYzWgCOs	2021-07-08 17:09:20.161469+05:30	2021-07-06 17:09:20.164216+05:30	2021-07-06 17:09:20.164258+05:30	34
74	hhWMLKLMBV_25pv5ZMmF_mWNuSrtUUWxl2I8mZM8NpY	2021-07-08 17:13:02.281831+05:30	2021-07-06 17:13:02.28283+05:30	2021-07-06 17:13:02.282888+05:30	37
75	LFk1ydzIZcn9GGUCNC8Ffk2_EJf_G8PkbPBzdDopEDQ	2021-07-08 17:34:39.461697+05:30	2021-07-06 17:34:39.463077+05:30	2021-07-06 17:34:39.463129+05:30	36
76	2cqe0CYOmNmajsjHBvHSeEUtb8dZCx73quOzPhxkQSk	2021-07-08 22:26:39.46614+05:30	2021-07-06 22:26:39.47606+05:30	2021-07-06 22:26:39.476118+05:30	37
77	NTeVNSeZ5ovbUmq_vdmNwmrmiHImZHai_s3UagFKPms	2021-07-13 04:29:28.201778+05:30	2021-07-11 04:29:28.20554+05:30	2021-07-11 04:29:28.205598+05:30	36
78	32X-k7Y0mD2Fw-DtTVJ8Mmgopd2jRdHZOWDbavfRl3g	2021-07-13 04:31:40.392275+05:30	2021-07-11 04:31:40.393336+05:30	2021-07-11 04:31:40.393383+05:30	37
79	_WCmECOvSK0YB-uF3BOCDLPfRBSCSBZ6fAUJb1yjk3E	2021-07-14 05:42:38.378119+05:30	2021-07-12 05:42:38.381347+05:30	2021-07-12 05:42:38.381386+05:30	34
\.


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
1	Can add permission	1	add_permission
2	Can change permission	1	change_permission
3	Can delete permission	1	delete_permission
4	Can view permission	1	view_permission
5	Can add group	2	add_group
6	Can change group	2	change_group
7	Can delete group	2	delete_group
8	Can view group	2	view_group
9	Can add content type	3	add_contenttype
10	Can change content type	3	change_contenttype
11	Can delete content type	3	delete_contenttype
12	Can view content type	3	view_contenttype
13	Can add session	4	add_session
14	Can change session	4	change_session
15	Can delete session	4	delete_session
16	Can view session	4	view_session
17	Can add user	5	add_user
18	Can change user	5	change_user
19	Can delete user	5	delete_user
20	Can view user	5	view_user
21	Can add site	6	add_site
22	Can change site	6	change_site
23	Can delete site	6	delete_site
24	Can view site	6	view_site
25	Can add log entry	7	add_logentry
26	Can change log entry	7	change_logentry
27	Can delete log entry	7	delete_logentry
28	Can view log entry	7	view_logentry
29	Can add company	8	add_company
30	Can change company	8	change_company
31	Can delete company	8	delete_company
32	Can view company	8	view_company
33	Can add department	9	add_department
34	Can change department	9	change_department
35	Can delete department	9	delete_department
36	Can view department	9	view_department
37	Can add permission	10	add_permission
38	Can change permission	10	change_permission
39	Can delete permission	10	delete_permission
40	Can view permission	10	view_permission
41	Can add role	11	add_role
42	Can change role	11	change_role
43	Can delete role	11	delete_role
44	Can view role	11	view_role
45	Can add reset password token	12	add_resetpasswordtoken
46	Can change reset password token	12	change_resetpasswordtoken
47	Can delete reset password token	12	delete_resetpasswordtoken
48	Can view reset password token	12	view_resetpasswordtoken
49	Can add profile	13	add_profile
50	Can change profile	13	change_profile
51	Can delete profile	13	delete_profile
52	Can view profile	13	view_profile
53	Can add access token	14	add_accesstoken
54	Can change access token	14	change_accesstoken
55	Can delete access token	14	delete_accesstoken
56	Can view access token	14	view_accesstoken
57	Can add refresh token	15	add_refreshtoken
58	Can change refresh token	15	change_refreshtoken
59	Can delete refresh token	15	delete_refreshtoken
60	Can view refresh token	15	view_refreshtoken
61	Can add over all appraisal	16	add_overallappraisal
62	Can change over all appraisal	16	change_overallappraisal
63	Can delete over all appraisal	16	delete_overallappraisal
64	Can view over all appraisal	16	view_overallappraisal
65	Can add appraisal	17	add_appraisal
66	Can change appraisal	17	change_appraisal
67	Can delete appraisal	17	delete_appraisal
68	Can view appraisal	17	view_appraisal
69	Can add goal category	18	add_goalcategory
70	Can change goal category	18	change_goalcategory
71	Can delete goal category	18	delete_goalcategory
72	Can view goal category	18	view_goalcategory
73	Can add goal	19	add_goal
74	Can change goal	19	change_goal
75	Can delete goal	19	delete_goal
76	Can view goal	19	view_goal
77	Can add skills category	20	add_skillscategory
78	Can change skills category	20	change_skillscategory
79	Can delete skills category	20	delete_skillscategory
80	Can view skills category	20	view_skillscategory
81	Can add core value	21	add_corevalue
82	Can change core value	21	change_corevalue
83	Can delete core value	21	delete_corevalue
84	Can view core value	21	view_corevalue
85	Can add skill	22	add_skill
86	Can change skill	22	change_skill
87	Can delete skill	22	delete_skill
88	Can view skill	22	view_skill
89	Can add kpi	23	add_kpi
90	Can change kpi	23	change_kpi
91	Can delete kpi	23	delete_kpi
92	Can view kpi	23	view_kpi
93	Can add core value category	24	add_corevaluecategory
94	Can change core value category	24	change_corevaluecategory
95	Can delete core value category	24	delete_corevaluecategory
96	Can view core value category	24	view_corevaluecategory
97	Can add logs	25	add_logs
98	Can change logs	25	change_logs
99	Can delete logs	25	delete_logs
100	Can view logs	25	view_logs
101	Can add departmental goal	26	add_departmentalgoal
102	Can change departmental goal	26	change_departmentalgoal
103	Can delete departmental goal	26	delete_departmentalgoal
104	Can view departmental goal	26	view_departmentalgoal
105	Can add departmental core value	27	add_departmentalcorevalue
106	Can change departmental core value	27	change_departmentalcorevalue
107	Can delete departmental core value	27	delete_departmentalcorevalue
108	Can view departmental core value	27	view_departmentalcorevalue
109	Can add notification	28	add_notification
110	Can change notification	28	change_notification
111	Can delete notification	28	delete_notification
112	Can view notification	28	view_notification
\.


--
-- Data for Name: auth_refresh_token; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_refresh_token (id, token, created, updated, revoked, access_token_id, user_id) FROM stdin;
5	Abp0tcWVEVcywV7Gg9l9NgpAgf4-zEspgXqbXP9s5oQ	2021-05-23 22:19:57.609477+05:30	2021-05-23 22:19:57.60954+05:30	\N	5	3
6	aCfsiGNrMg0RMDg5mmYN7kgLKrGesBUL311HB4rHDsY	2021-05-24 04:26:04.826916+05:30	2021-05-24 04:26:04.826967+05:30	\N	6	3
7	Skya6bFEhzTrU40OtuWkvmx2DHVgOLj9jahmLhzmPTU	2021-05-24 04:27:06.409799+05:30	2021-05-24 04:27:06.409847+05:30	\N	7	3
8	u09zs9OghmTxD5fijcnmysMOGi7CtbEMqcCEZOfG-7Q	2021-05-24 04:28:59.658346+05:30	2021-05-24 04:28:59.65843+05:30	\N	8	3
9	ZjUj9SE66EC5ykUsebRNiqu_XmnUK9kxawoOXiu03s8	2021-05-24 04:31:36.517563+05:30	2021-05-24 04:31:36.517608+05:30	\N	9	3
10	tNcGVf3Qksfbouk9fIAxho37UC2Z3RVM947-GRC1D9M	2021-05-24 04:32:06.681565+05:30	2021-05-24 04:32:06.681648+05:30	\N	10	3
11	izfNTL1tHll0KQaWt8Snm_MWbxSHl_U8GjupiIcD4Ho	2021-05-24 04:33:39.209689+05:30	2021-05-24 04:33:39.209786+05:30	\N	11	3
12	AEwYSfwmyRHj8JcPndgg9ADtqxDBtMXXYsoi7tS2da4	2021-05-24 04:34:04.726264+05:30	2021-05-24 04:34:04.726317+05:30	\N	12	3
13	DM-qrirkTGUoKWYdxkQGfeA70nVPa3lL1NhVTB5bcD0	2021-05-24 04:36:57.385538+05:30	2021-05-24 04:36:57.385615+05:30	\N	13	3
14	n8Qu_x8OfJljBlGnJ5h21cytI5oMTAr0XYiHDNMfSUM	2021-05-24 04:37:10.339939+05:30	2021-05-24 04:37:10.339984+05:30	\N	14	3
15	txJXfdvEcQ0KX7pzeRIgJ81BfS89hs2CfH4ilzL5LYM	2021-05-24 05:15:02.427784+05:30	2021-05-24 05:15:02.427827+05:30	\N	15	3
16	QPb185Tuy7z9IWTzLyTVVXTjiDJ0nQ1w7zobjFgYSN0	2021-05-24 05:19:54.117571+05:30	2021-05-24 05:19:54.117618+05:30	\N	16	3
17	zgVHmOWN517vf-iToHz4dJkT9qpPowYP-Nb-IlWVNGc	2021-05-24 05:20:48.645088+05:30	2021-05-24 05:20:48.645132+05:30	\N	17	3
18	dQx5GVlu_xqvMUJzraGAPTq4XFCNVPdszTzffiQNXH0	2021-05-24 05:22:15.819812+05:30	2021-05-24 05:22:15.819857+05:30	\N	18	3
19	TXnhSHuytF-YrIYGfiUEZLYgjHP4jxAdLHYMwmlwc98	2021-05-24 05:26:30.283474+05:30	2021-05-24 05:26:30.28357+05:30	\N	19	3
20	Es1zjxZEzVP2-8RK2pW5_xmP93c2xe3Q5TTey1O0FOM	2021-05-24 05:26:44.246149+05:30	2021-05-24 05:26:44.246193+05:30	\N	20	3
21	8tnon8fyLSSE2ipP3uemKnRahNjM7EBxocKfwQ8TJn0	2021-05-24 05:30:51.530188+05:30	2021-05-24 05:30:51.530233+05:30	\N	21	3
22	SOqVfi5G8d6Pw4u2kEIjuyuwdRnKmS1CJFBqs0ltaIs	2021-05-24 05:33:49.921917+05:30	2021-05-24 05:33:49.921986+05:30	\N	22	3
23	wYH_2dXVd6Mkh6lSVsPmrPcydHpMHkko2VO6Z2WYZis	2021-05-24 05:33:55.342391+05:30	2021-05-24 05:33:55.342438+05:30	\N	23	3
24	v2havAoYfg19F9FIbZE4tmA6-MktbxMymgwPNMrhxJw	2021-05-24 19:26:28.939213+05:30	2021-05-24 19:26:28.939258+05:30	\N	24	3
25	5oFhcj9vVvK7K-MsRccMt-r9sbPgcTTm6xcnkU1OeiM	2021-05-24 22:22:26.542839+05:30	2021-05-24 22:22:26.542913+05:30	\N	25	3
26	U9T8RgRYMzIjm6OUwmB1EBNjsDY3DHJzNFQelvtG0iM	2021-05-24 22:23:22.175843+05:30	2021-05-24 22:23:22.175888+05:30	\N	26	3
27	Zd43VLi79qAQikSTSKvfRhZVz-4yQrWE0v8FLHDOGX8	2021-05-24 22:25:27.917264+05:30	2021-05-24 22:25:27.917314+05:30	\N	27	3
28	vjwflMLRkMvOCR9F2NJP_8tCvJ4EHxHEv3JZl6Js0qY	2021-05-24 22:26:06.198912+05:30	2021-05-24 22:26:06.199033+05:30	\N	28	3
29	mNOLM6bV-knKnZVR2mKt1obuPinPc1aFGkvIaVABdsY	2021-05-24 22:26:19.721177+05:30	2021-05-24 22:26:19.721222+05:30	\N	29	3
30	YaBX9ny0ArNYPA1Z53pD45ce8s55o3AxCaf4nO7Pd64	2021-05-24 22:27:53.030237+05:30	2021-05-24 22:27:53.030283+05:30	\N	30	3
31	VQs7vKjBm295WSvzaSVzAjfL1OmVxP8fbgI8zg_RIQU	2021-05-24 22:27:58.942188+05:30	2021-05-24 22:27:58.942232+05:30	\N	31	3
32	LEbuFsXnYgoJfj9-Z9Pz82EQg7ryZwfG2GrReKD_6fM	2021-05-24 22:27:59.508356+05:30	2021-05-24 22:27:59.508405+05:30	\N	32	3
33	Bku68-vta0km_t-wyjyh_IS5ifjhCPbQe0rT3LZaiyQ	2021-05-24 22:27:59.719267+05:30	2021-05-24 22:27:59.719311+05:30	\N	33	3
34	HwpqR7RcCCEXMhewXTeq2hWtqUqc2oPuT7vPg6JNpEk	2021-05-24 22:28:00.200698+05:30	2021-05-24 22:28:00.200742+05:30	\N	34	3
35	cBQOKhIh9x1fYdty-Q4_H2PlaTnhjHVH4q3xF52l7Qk	2021-05-24 22:29:58.357252+05:30	2021-05-24 22:29:58.357323+05:30	\N	35	3
36	72s7c9HMXCNwvt3GWSFxSathdXkGnNJNEaO7Yct7IDg	2021-05-24 22:29:58.362827+05:30	2021-05-24 22:29:58.362902+05:30	\N	36	3
37	_31jcTxkba4T-OQNnjq4sePo7cyxAF_PPMd0yAFiAgA	2021-05-24 22:29:58.393591+05:30	2021-05-24 22:29:58.393684+05:30	\N	37	3
38	G3IB_wRJGF990xBJCX63A1EkRye9FRr0Ml5q82jm-mk	2021-05-24 23:02:44.070478+05:30	2021-05-24 23:02:44.070548+05:30	\N	38	3
39	l4uPDANdZUSSUFb6lOjGnYc_WcGkP5vrHPqxji3NHzo	2021-05-24 23:03:00.162002+05:30	2021-05-24 23:03:00.162049+05:30	\N	39	3
40	g_T4N05IeTOmlTQ8PUFWwPDuRs__9_5GsWsaapHs8Z4	2021-05-24 23:04:22.460214+05:30	2021-05-24 23:04:22.460261+05:30	\N	40	3
41	B3NwOirRGT5HPpjo7zkrUC7kLqqM_u1X1byTKUX6HbE	2021-05-24 23:10:07.661542+05:30	2021-05-24 23:10:07.661591+05:30	\N	41	3
42	nuVDVJFPZBi-SHv-Q27OzD3aNT2tEq06cJ8zV6_QqVM	2021-05-24 23:10:23.610563+05:30	2021-05-24 23:10:23.610619+05:30	\N	42	3
43	UT-3keZe7N13U2IsbwNZCBO8IGI8793v17IRwrjO10Y	2021-05-26 12:25:53.4644+05:30	2021-05-26 12:25:53.464446+05:30	\N	43	3
44	mDlQeSGw1lP7l256PtmuKlg2x6qeaol--Z0NTP1CqOE	2021-05-26 12:43:15.849085+05:30	2021-05-26 12:43:15.849132+05:30	\N	44	3
45	QaD4DO0uzN5ZdzMs20AY_EvbApVDTaTIpDkE78dpgas	2021-05-26 12:43:42.789611+05:30	2021-05-26 12:43:42.789682+05:30	\N	45	3
47	_yCs-QIOgOy_jKvnteWphkbWEHm8vLSji-_JEv0UwKc	2021-05-27 23:43:39.014935+05:30	2021-05-27 23:43:39.015005+05:30	\N	47	3
48	s8O3eYmHbkwW-s5KJLa5Mpi7lJVzIW3ZjOf9omFephk	2021-05-27 23:44:28.70261+05:30	2021-05-27 23:44:28.702655+05:30	\N	48	3
49	ffQKhgl32U8U7Or6M0_7UDb5MUcIYfpYoIc4prJLiI0	2021-05-30 21:07:31.540061+05:30	2021-05-30 21:07:31.54011+05:30	\N	49	3
50	oJTYUlyksxaWWHaSLSwHixIDBuYAwICkRZxr8OaXho0	2021-05-30 21:13:01.548824+05:30	2021-05-30 21:13:01.548871+05:30	\N	50	34
51	LrXDs1OtbFgJy_wKZctCYw6NgTq__WeGvMQvtmMLzLs	2021-05-30 23:00:14.030669+05:30	2021-05-30 23:00:14.030716+05:30	\N	51	3
52	m2Lw62n-TlaEA9pJA5uYyGPFhiJCQ60k7MNGiRJh5CU	2021-06-05 23:41:40.910065+05:30	2021-06-05 23:41:40.910114+05:30	\N	52	34
53	vLXp6ATo6fVweWVSFnLf_AggXnnLk5GwxIzZE0-1sMI	2021-06-07 04:21:55.505606+05:30	2021-06-07 04:21:55.505679+05:30	\N	53	34
54	YEXVsYR6gp4ykXjQKFGoITq4wGp6uMuo6wrxIG8fGSg	2021-06-08 00:50:15.455095+05:30	2021-06-08 00:50:15.455119+05:30	\N	54	34
55	jspj8XWrr8X0gMv4nNnizE8TfG1PbLnoDmvsfvuoUz8	2021-06-08 00:51:00.461646+05:30	2021-06-08 00:51:00.461686+05:30	\N	55	3
56	XfyZGw2pOemqsslq23JQHHnfTL3UshEm4pZx0dBmD9g	2021-06-09 03:07:18.383501+05:30	2021-06-09 03:07:18.38355+05:30	\N	56	34
57	baisTeXelht_tTomYh2jpCqXwd8qX40J21l2p1AHglc	2021-06-09 05:02:36.884904+05:30	2021-06-09 05:02:36.884959+05:30	\N	57	3
58	p6OkmGxY4K0RRiipt_aJ7trpl4LZdp7Ht0JXtaPLYfw	2021-06-14 07:26:01.83738+05:30	2021-06-14 07:26:01.83743+05:30	\N	58	34
59	NOv1C8Y8likLXqCTzYYzkWE5YgpnJGiyUtNHnlg41Ns	2021-06-18 18:35:02.653723+05:30	2021-06-18 18:35:02.653774+05:30	\N	59	34
60	13ox8Ia8eA699O7CP2Z-ul3rcs3kWSKJyxgkPRi4xMU	2021-06-21 19:28:01.413295+05:30	2021-06-21 19:28:01.413368+05:30	\N	60	34
61	LZ4CDAuXSwW5ieRt_sGSBhqeep978FxqxVSWrdL-sMk	2021-06-23 12:10:17.16626+05:30	2021-06-23 12:10:17.166303+05:30	\N	61	34
62	OLDROMjFfuuGuCfvQGGfTCq4Xick6o87-Ktl8rX5pVg	2021-07-01 22:50:45.127618+05:30	2021-07-01 22:50:45.127665+05:30	\N	62	34
63	i_YlNoWhfJOtmkEM_CmAAyF7ONgikzjw-t1RHJ2YqfE	2021-07-02 22:35:33.198898+05:30	2021-07-02 22:35:33.198974+05:30	\N	63	34
64	wx4240Jece36TcfnIKdnv_5JwoHFrpqD93cUlZ6RngY	2021-07-04 13:24:53.317738+05:30	2021-07-04 13:24:53.317788+05:30	\N	64	34
65	irKyrBpfjz_Uac7E14se2mixLV6HnijcoqajFvU0FjM	2021-07-04 13:38:51.77474+05:30	2021-07-04 13:38:51.774786+05:30	\N	65	34
66	iR_5vYYsiDF9zNAMpRBuityh0T1zSQspqQ6L8Vp087g	2021-07-04 14:50:29.555457+05:30	2021-07-04 14:50:29.555503+05:30	\N	66	37
67	_m7Kc-w0SJnbCaOot55I4mbfqqG9AC_GyiLU7oTDoOU	2021-07-04 14:58:37.419924+05:30	2021-07-04 14:58:37.419971+05:30	\N	67	36
68	wkmsqumk3ZMPRWQYDSA0bl4zp2JQCbGnsCTkXREimJc	2021-07-05 22:28:58.605796+05:30	2021-07-05 22:28:58.605851+05:30	\N	68	34
69	S_y93Y0SknN15EB6ZPe7PIQXm6SfJoL5Jb2L1U5WFqY	2021-07-05 22:29:14.211673+05:30	2021-07-05 22:29:14.211724+05:30	\N	69	36
70	lKpwj95ot8USLlC9PQLiATBk62FWDk2JLa9Pueyd5xQ	2021-07-05 22:29:40.174795+05:30	2021-07-05 22:29:40.174857+05:30	\N	70	37
71	xI0mtOl3Yij1Zv9tCKYWWisKIIvkr2eu52zCwlJcfBI	2021-07-06 01:00:48.130688+05:30	2021-07-06 01:00:48.13074+05:30	\N	71	34
72	D9N-BE14RGWGNt537Lf4DKftQPAXBdTlV3JjDoqN4d4	2021-07-06 02:12:24.360713+05:30	2021-07-06 02:12:24.360763+05:30	\N	72	36
73	150b4C2MExN5zNZC6_3G0WRaRkxUphpiD6IR8fWG8jU	2021-07-06 17:09:20.227447+05:30	2021-07-06 17:09:20.227496+05:30	\N	73	34
74	bWuDf5davxB5vOzL4ObbwRj7605gAoDYEsqLLWsZCuA	2021-07-06 17:13:02.316721+05:30	2021-07-06 17:13:02.316776+05:30	\N	74	37
75	wMJztgSh4VXneJbxcTxnW00DCkwK3mXbSOU1X85xIYw	2021-07-06 17:34:39.505149+05:30	2021-07-06 17:34:39.505196+05:30	\N	75	36
76	YahPkRiQ7glaNDgK3yyNMlCebjMDg7og_AuHIWMaPHc	2021-07-06 22:26:39.538008+05:30	2021-07-06 22:26:39.538124+05:30	\N	76	37
77	zmZ85N8xnoGQqr9_eqvXlm0GK4BMX-g9DJ0qhkDdTt4	2021-07-11 04:29:28.301098+05:30	2021-07-11 04:29:28.301161+05:30	\N	77	36
78	jedsW5-NIjJNHk6ih-9gilU--JH9O_mTO-w0E9eZlVI	2021-07-11 04:31:40.451868+05:30	2021-07-11 04:31:40.451927+05:30	\N	78	37
79	v53uEA-l8hy8hqLzcP2wgrC8Ah8X0NSZcsHeUXPkJWw	2021-07-12 05:42:38.438039+05:30	2021-07-12 05:42:38.438084+05:30	\N	79	34
\.


--
-- Data for Name: django_admin_log; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) FROM stdin;
\.


--
-- Data for Name: django_content_type; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_content_type (id, app_label, model) FROM stdin;
1	auth	permission
2	auth	group
3	contenttypes	contenttype
4	sessions	session
5	users	user
6	sites	site
7	admin	logentry
8	users	company
9	users	department
10	users	permission
11	users	role
12	users	resetpasswordtoken
13	users	profile
14	users	accesstoken
15	users	refreshtoken
16	appraisals	overallappraisal
17	appraisals	appraisal
18	training	goalcategory
19	training	goal
20	training	skillscategory
21	training	corevalue
22	training	skill
23	training	kpi
24	training	corevaluecategory
25	users	logs
26	training	departmentalgoal
27	training	departmentalcorevalue
28	users	notification
\.


--
-- Data for Name: django_migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_migrations (id, app, name, applied) FROM stdin;
1	contenttypes	0001_initial	2021-05-23 00:12:25.014437+05:30
2	contenttypes	0002_remove_content_type_name	2021-05-23 00:12:25.026855+05:30
3	auth	0001_initial	2021-05-23 00:12:25.075167+05:30
4	auth	0002_alter_permission_name_max_length	2021-05-23 00:12:25.083698+05:30
5	auth	0003_alter_user_email_max_length	2021-05-23 00:12:25.0909+05:30
6	auth	0004_alter_user_username_opts	2021-05-23 00:12:25.100196+05:30
7	auth	0005_alter_user_last_login_null	2021-05-23 00:12:25.106447+05:30
8	auth	0006_require_contenttypes_0002	2021-05-23 00:12:25.109064+05:30
9	auth	0007_alter_validators_add_error_messages	2021-05-23 00:12:25.122051+05:30
10	auth	0008_alter_user_username_max_length	2021-05-23 00:12:25.137729+05:30
11	auth	0009_alter_user_last_name_max_length	2021-05-23 00:12:25.153733+05:30
12	auth	0010_alter_group_name_max_length	2021-05-23 00:12:25.166419+05:30
13	auth	0011_update_proxy_permissions	2021-05-23 00:12:25.179755+05:30
14	auth	0012_alter_user_first_name_max_length	2021-05-23 00:12:25.201154+05:30
15	users	0001_initial	2021-05-23 00:12:25.296733+05:30
16	admin	0001_initial	2021-05-23 00:12:25.325177+05:30
17	admin	0002_logentry_remove_auto_add	2021-05-23 00:12:25.3372+05:30
18	admin	0003_logentry_add_action_flag_choices	2021-05-23 00:12:25.3543+05:30
19	sessions	0001_initial	2021-05-23 00:12:25.366408+05:30
20	sites	0001_initial	2021-05-23 00:12:25.373778+05:30
21	sites	0002_alter_domain_unique	2021-05-23 00:12:25.381448+05:30
22	users	0002_auto_20210523_2158	2021-05-23 21:58:14.320418+05:30
23	users	0003_alter_company_setting	2021-05-23 22:08:36.141975+05:30
24	appraisals	0001_initial	2021-05-25 00:33:37.810394+05:30
25	users	0004_auto_20210525_0216	2021-05-25 02:17:01.917441+05:30
26	users	0005_alter_permission_name	2021-05-25 02:47:08.111602+05:30
27	training	0001_initial	2021-05-25 16:20:18.947904+05:30
28	users	0006_alter_company_domain	2021-05-26 12:40:54.447855+05:30
29	users	0007_alter_user_contact_number	2021-05-26 12:40:54.566588+05:30
30	users	0008_logs	2021-06-05 23:56:47.799946+05:30
31	appraisals	0002_appraisal_employee	2021-06-05 23:56:47.830938+05:30
32	appraisals	0003_alter_appraisal_status	2021-06-14 08:07:13.060599+05:30
33	training	0002_auto_20210614_0807	2021-06-14 08:07:13.204674+05:30
34	appraisals	0004_alter_appraisal_status	2021-06-30 16:37:05.30583+05:30
35	training	0003_departmentalcorevalue_departmentalgoal	2021-06-30 16:37:05.505438+05:30
36	training	0004_auto_20210630_1642	2021-06-30 16:42:08.599534+05:30
37	appraisals	0005_auto_20210702_2227	2021-07-02 22:27:44.813722+05:30
38	training	0005_auto_20210702_2227	2021-07-02 22:27:44.933787+05:30
39	appraisals	0006_alter_appraisal_status	2021-07-05 00:20:58.944886+05:30
40	training	0006_alter_goal_status	2021-07-05 00:20:58.990626+05:30
41	appraisals	0007_auto_20210706_0129	2021-07-06 01:29:27.885685+05:30
42	training	0007_auto_20210706_0129	2021-07-06 01:29:27.92575+05:30
43	users	0009_notification	2021-07-12 06:16:06.663093+05:30
44	users	0010_auto_20210712_0831	2021-07-12 08:31:35.1772+05:30
\.


--
-- Data for Name: django_session; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_session (session_key, session_data, expire_date) FROM stdin;
\.


--
-- Data for Name: django_site; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_site (id, domain, name) FROM stdin;
1	example.com	example.com
\.


--
-- Data for Name: training_corevalue; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.training_corevalue (id, summary, description, due, weightage, appraisal_id, category_id) FROM stdin;
3	core value 1	<ol><li>ddkdkd</li><li>dldlld</li></ol>	2021-07-14	1	57	1
\.


--
-- Data for Name: training_corevaluecategory; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.training_corevaluecategory (id, name, company_id) FROM stdin;
1	skskkss	25
\.


--
-- Data for Name: training_departmentalcorevalue; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.training_departmentalcorevalue (id, summary, due, description, appraisal_id, category_id, manager_id) FROM stdin;
\.


--
-- Data for Name: training_departmentalgoal; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.training_departmentalgoal (id, summary, due, description, appraisal_id, category_id, manager_id) FROM stdin;
\.


--
-- Data for Name: training_goal; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.training_goal (id, summary, description, due, weightage, status, stage1_employee_comment, stage1_manager_comment, stage2_employee_comment, tracking_status, stage2_manager_comment, stage0_employee_comment, stage0_manager_comment, appraisal_id, category_id, employee_rating, manager_rating) FROM stdin;
6	goal 1	<ol><li><i>hello this</i> &nbsp;is goal descrition 1</li></ol>	2021-07-22	100	1	<ol><li>edit mid year review</li><li>comment</li></ol>	<ol><li>mid yeare manager review edit</li><li>skksks</li></ol>	<ol><li>end year employee review</li><li>s,ss</li></ol>	On Track	<ol><li>manager comment edits</li></ol><p>sksks</p>	\N	\N	57	1	\N	\N
7	goal1	<p>allsls</p>	2021-07-14	100	0	\N	\N	\N	On Track	\N	\N	\N	55	1	\N	\N
\.


--
-- Data for Name: training_goalcategory; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.training_goalcategory (id, name, company_id) FROM stdin;
1	updated goal2 with patch	25
\.


--
-- Data for Name: training_kpi; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.training_kpi (id, summary, due, date_created, progress, goal_id) FROM stdin;
6	kpi1	2021-07-13	2021-07-05	Working	6
7	kpi1	2021-07-14	2021-07-06	Working	7
\.


--
-- Data for Name: training_skill; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.training_skill (id, summary, description, due, weightage, appraisal_id, category_id) FROM stdin;
3	skill1	<ol><li><i>skill summay</i></li></ol>	2021-07-14	1	57	1
\.


--
-- Data for Name: training_skillscategory; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.training_skillscategory (id, name, company_id) FROM stdin;
1	updated skill with patch	25
\.


--
-- Data for Name: users_company; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users_company (id, name, logo, login_logo, domain, setting, is_active, created_at, updated_at) FROM stdin;
3	admin			localhost:3000	\N	t	2021-05-23 22:08:55.381814+05:30	2021-05-23 22:08:55.381894+05:30
25	company1			http://localhost:3001	\N	t	2021-05-30 21:12:40.373668+05:30	2021-05-30 21:12:40.373773+05:30
\.


--
-- Data for Name: users_department; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users_department (id, name, logo, company_id, manager_id) FROM stdin;
3	test		3	\N
7	admin		25	20
\.


--
-- Data for Name: users_logs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users_logs (id, title, color, user_id, created_at) FROM stdin;
1	test appraisal appraisal created	info	21	2021-07-12 08:31:35.150043+05:30
2	test appraisal appraisal created	info	20	2021-07-12 08:31:35.150043+05:30
3	skkkskkss appraisal created	info	21	2021-07-12 08:31:35.150043+05:30
4	skkkskkss appraisal created	info	20	2021-07-12 08:31:35.150043+05:30
5	kkkkk appraisal created	info	21	2021-07-12 08:31:35.150043+05:30
6	kkkkk appraisal created	info	20	2021-07-12 08:31:35.150043+05:30
7	zzkzkzkz appraisal created	info	21	2021-07-12 08:31:35.150043+05:30
8	zzkzkzkz appraisal created	info	20	2021-07-12 08:31:35.150043+05:30
9	skksks appraisal created	info	21	2021-07-12 08:31:35.150043+05:30
10	skksks appraisal created	info	20	2021-07-12 08:31:35.150043+05:30
11	lkkss appraisal created	info	21	2021-07-12 08:31:35.150043+05:30
12	lkkss appraisal created	info	20	2021-07-12 08:31:35.150043+05:30
13	jjjjjj appraisal created	info	21	2021-07-12 08:31:35.150043+05:30
14	jjjjjj appraisal created	info	20	2021-07-12 08:31:35.150043+05:30
15	skskkskskskkskskkskskskkskss appraisal created	info	21	2021-07-12 08:31:35.150043+05:30
16	skskkskskskkskskkskskskkskss appraisal created	info	20	2021-07-12 08:31:35.150043+05:30
17	kkskksks appraisal created	info	21	2021-07-12 08:31:35.150043+05:30
18	kkskksks appraisal created	info	20	2021-07-12 08:31:35.150043+05:30
50	2021 test appraisal appraisal created	info	21	2021-07-12 08:31:35.150043+05:30
51	2021 test appraisal appraisal created	info	20	2021-07-12 08:31:35.150043+05:30
52	2021 test appraisal appraisal created	info	22	2021-07-12 08:31:35.150043+05:30
53	2021 test appraisal appraisal created	info	23	2021-07-12 08:31:35.150043+05:30
54	2021 test appraisal appraisal created	info	21	2021-07-12 08:31:35.150043+05:30
55	2021 test appraisal appraisal created	info	20	2021-07-12 08:31:35.150043+05:30
56	2021 test appraisal appraisal created	info	22	2021-07-12 08:31:35.150043+05:30
57	2021 test appraisal appraisal created	info	23	2021-07-12 08:31:35.150043+05:30
\.


--
-- Data for Name: users_notification; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users_notification (logs_ptr_id, is_read, description) FROM stdin;
\.


--
-- Data for Name: users_permission; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users_permission (id, name, company_id) FROM stdin;
68	CAN_SUBMIT_APPRAISAL	25
69	CAN_APPROVE_APPRAISAL	25
70	CAN_MANAGE_EMPLOYEE	25
71	CAN_MANAGE_APPRAISAL	25
72	CAN_MANAGE_COMPANY	25
\.


--
-- Data for Name: users_profile; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users_profile (id, avatar, gender, martial_status, date_of_hire, employee_id, employment_type, job_title, resign_date, address_1, address_2, skill1, skill2, skill3, department_id, first_reporting_manager_id, second_reporting_manager_id, user_id) FROM stdin;
1		\N	Single	2021-05-23	\N	Full-Time	\N	\N	\N	\N	\N	\N	\N	\N	1	1	3
20		\N	Single	2021-05-30	\N	Full-Time	\N	\N	\N	\N	\N	\N	\N	7	20	20	34
21		\N	Single	2021-06-05	\N	Full-Time	user	\N			\N	\N	\N	\N	\N	\N	35
22		Male	Single	2021-07-04	9399393	Full-Time		\N			\N	\N	\N	\N	1	1	36
23		Male	Single	2021-07-04		Full-Time	usertest	\N			\N	\N	\N	\N	22	22	37
\.


--
-- Data for Name: users_resetpasswordtoken; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users_resetpasswordtoken (id, token, created_at, user_id) FROM stdin;
\.


--
-- Data for Name: users_role; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users_role (id, name, company_id) FROM stdin;
36	employee	25
37	manager	25
38	hr	25
39	hrmanager	25
40	admin	25
41	test	25
\.


--
-- Data for Name: users_role_permissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users_role_permissions (id, role_id, permission_id) FROM stdin;
45	36	68
46	37	68
47	37	69
48	38	68
49	38	69
50	38	70
51	39	68
52	39	69
53	39	70
54	39	71
55	40	72
56	41	68
57	41	70
\.


--
-- Data for Name: users_user; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users_user (id, password, last_login, first_name, username, last_name, email, is_active, is_admin, is_superuser, is_email_verified, date_joined, dummy_password, contact_number, company_id, role_id) FROM stdin;
3	argon2$argon2id$v=19$m=102400,t=2,p=8$QTVyQVRXaGNhdTNPQWp3Y2VhY0tvTg$uZFRSrf/TBuOOp4iGhxdSg	2021-05-24 22:49:49.759734+05:30	\N	superadmin	\N	admin@pms.com	t	t	t	f	2021-05-23 22:08:54.613109+05:30	\N		3	\N
35	argon2$argon2id$v=19$m=102400,t=2,p=8$WmpKRUVOTE1CN3lLdURWUFBVTXNiWQ$gxqBJ8VW/kasCuOhNGeUGw	\N	tejpratap	tejpratap545	singh	ssjsjjsj@gmail.com	t	f	f	f	2021-06-05 23:43:45.524071+05:30	\N		25	\N
34	argon2$argon2id$v=19$m=102400,t=2,p=8$VUdxcjViWkNWRGc5WHl1NVhHRUhOYQ$dklMpqWibzUY3JXDcQhKrA	2021-06-05 23:46:18.503523+05:30	\N	company1admin	\N	dkdkk@email.com	t	t	f	f	2021-05-30 21:12:40.617251+05:30	\N		25	40
36	argon2$argon2id$v=19$m=102400,t=2,p=8$ZEU2OXlFdDB0UEFJbG9LWFdGbTdmNw$o9rA0FGoaSKhu5Vm86hYpw	\N	managertes	managertest		managertest@email.com	t	f	f	f	2021-07-04 13:48:34.740303+05:30	\N		25	37
37	argon2$argon2id$v=19$m=102400,t=2,p=8$SEpQVlh1UFpuQXJ2eHhyTWN1TDFWSg$VXgiZpbGwk9p5b3JHCS30w	\N	usertest	usertest		usertest@email.com	t	f	f	f	2021-07-04 14:19:43.381335+05:30	\N		25	36
\.


--
-- Data for Name: users_user_groups; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users_user_groups (id, user_id, group_id) FROM stdin;
\.


--
-- Data for Name: users_user_user_permissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users_user_user_permissions (id, user_id, permission_id) FROM stdin;
\.


--
-- Name: appraisals_appraisal_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.appraisals_appraisal_id_seq', 57, true);


--
-- Name: appraisals_overallappraisal_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.appraisals_overallappraisal_id_seq', 17, true);


--
-- Name: auth_access_token_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_access_token_id_seq', 79, true);


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

SELECT pg_catalog.setval('public.auth_permission_id_seq', 112, true);


--
-- Name: auth_refresh_token_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_refresh_token_id_seq', 79, true);


--
-- Name: django_admin_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.django_admin_log_id_seq', 1, false);


--
-- Name: django_content_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.django_content_type_id_seq', 28, true);


--
-- Name: django_migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.django_migrations_id_seq', 44, true);


--
-- Name: django_site_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.django_site_id_seq', 1, true);


--
-- Name: training_corevalue_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.training_corevalue_id_seq', 3, true);


--
-- Name: training_corevaluecategory_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.training_corevaluecategory_id_seq', 1, true);


--
-- Name: training_departmentalcorevalue_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.training_departmentalcorevalue_id_seq', 1, false);


--
-- Name: training_departmentalgoal_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.training_departmentalgoal_id_seq', 1, false);


--
-- Name: training_goal_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.training_goal_id_seq', 7, true);


--
-- Name: training_goalcategory_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.training_goalcategory_id_seq', 1, true);


--
-- Name: training_kpi_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.training_kpi_id_seq', 7, true);


--
-- Name: training_skill_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.training_skill_id_seq', 3, true);


--
-- Name: training_skillscategory_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.training_skillscategory_id_seq', 1, true);


--
-- Name: users_company_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_company_id_seq', 25, true);


--
-- Name: users_department_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_department_id_seq', 7, true);


--
-- Name: users_logs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_logs_id_seq', 57, true);


--
-- Name: users_permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_permission_id_seq', 72, true);


--
-- Name: users_profile_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_profile_id_seq', 23, true);


--
-- Name: users_resetpasswordtoken_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_resetpasswordtoken_id_seq', 1, false);


--
-- Name: users_role_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_role_id_seq', 41, true);


--
-- Name: users_role_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_role_permissions_id_seq', 57, true);


--
-- Name: users_user_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_user_groups_id_seq', 1, false);


--
-- Name: users_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_user_id_seq', 37, true);


--
-- Name: users_user_user_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_user_user_permissions_id_seq', 1, false);


--
-- Name: appraisals_appraisal appraisals_appraisal_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.appraisals_appraisal
    ADD CONSTRAINT appraisals_appraisal_pkey PRIMARY KEY (id);


--
-- Name: appraisals_overallappraisal appraisals_overallappraisal_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.appraisals_overallappraisal
    ADD CONSTRAINT appraisals_overallappraisal_pkey PRIMARY KEY (id);


--
-- Name: auth_access_token auth_access_token_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_access_token
    ADD CONSTRAINT auth_access_token_pkey PRIMARY KEY (id);


--
-- Name: auth_access_token auth_access_token_token_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_access_token
    ADD CONSTRAINT auth_access_token_token_key UNIQUE (token);


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
-- Name: auth_refresh_token auth_refresh_token_access_token_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_refresh_token
    ADD CONSTRAINT auth_refresh_token_access_token_id_key UNIQUE (access_token_id);


--
-- Name: auth_refresh_token auth_refresh_token_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_refresh_token
    ADD CONSTRAINT auth_refresh_token_pkey PRIMARY KEY (id);


--
-- Name: auth_refresh_token auth_refresh_token_token_revoked_8be04cf3_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_refresh_token
    ADD CONSTRAINT auth_refresh_token_token_revoked_8be04cf3_uniq UNIQUE (token, revoked);


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
-- Name: django_site django_site_domain_a2e37b91_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_site
    ADD CONSTRAINT django_site_domain_a2e37b91_uniq UNIQUE (domain);


--
-- Name: django_site django_site_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_site
    ADD CONSTRAINT django_site_pkey PRIMARY KEY (id);


--
-- Name: training_corevalue training_corevalue_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.training_corevalue
    ADD CONSTRAINT training_corevalue_pkey PRIMARY KEY (id);


--
-- Name: training_corevaluecategory training_corevaluecategory_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.training_corevaluecategory
    ADD CONSTRAINT training_corevaluecategory_pkey PRIMARY KEY (id);


--
-- Name: training_departmentalcorevalue training_departmentalcorevalue_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.training_departmentalcorevalue
    ADD CONSTRAINT training_departmentalcorevalue_pkey PRIMARY KEY (id);


--
-- Name: training_departmentalgoal training_departmentalgoal_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.training_departmentalgoal
    ADD CONSTRAINT training_departmentalgoal_pkey PRIMARY KEY (id);


--
-- Name: training_goal training_goal_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.training_goal
    ADD CONSTRAINT training_goal_pkey PRIMARY KEY (id);


--
-- Name: training_goalcategory training_goalcategory_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.training_goalcategory
    ADD CONSTRAINT training_goalcategory_pkey PRIMARY KEY (id);


--
-- Name: training_kpi training_kpi_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.training_kpi
    ADD CONSTRAINT training_kpi_pkey PRIMARY KEY (id);


--
-- Name: training_skill training_skill_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.training_skill
    ADD CONSTRAINT training_skill_pkey PRIMARY KEY (id);


--
-- Name: training_skillscategory training_skillscategory_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.training_skillscategory
    ADD CONSTRAINT training_skillscategory_pkey PRIMARY KEY (id);


--
-- Name: users_company users_company_domain_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users_company
    ADD CONSTRAINT users_company_domain_key UNIQUE (domain);


--
-- Name: users_company users_company_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users_company
    ADD CONSTRAINT users_company_name_key UNIQUE (name);


--
-- Name: users_company users_company_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users_company
    ADD CONSTRAINT users_company_pkey PRIMARY KEY (id);


--
-- Name: users_department users_department_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users_department
    ADD CONSTRAINT users_department_pkey PRIMARY KEY (id);


--
-- Name: users_logs users_logs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users_logs
    ADD CONSTRAINT users_logs_pkey PRIMARY KEY (id);


--
-- Name: users_notification users_notification_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users_notification
    ADD CONSTRAINT users_notification_pkey PRIMARY KEY (logs_ptr_id);


--
-- Name: users_permission users_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users_permission
    ADD CONSTRAINT users_permission_pkey PRIMARY KEY (id);


--
-- Name: users_profile users_profile_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users_profile
    ADD CONSTRAINT users_profile_pkey PRIMARY KEY (id);


--
-- Name: users_profile users_profile_user_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users_profile
    ADD CONSTRAINT users_profile_user_id_key UNIQUE (user_id);


--
-- Name: users_resetpasswordtoken users_resetpasswordtoken_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users_resetpasswordtoken
    ADD CONSTRAINT users_resetpasswordtoken_pkey PRIMARY KEY (id);


--
-- Name: users_role_permissions users_role_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users_role_permissions
    ADD CONSTRAINT users_role_permissions_pkey PRIMARY KEY (id);


--
-- Name: users_role_permissions users_role_permissions_role_id_permission_id_a9833844_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users_role_permissions
    ADD CONSTRAINT users_role_permissions_role_id_permission_id_a9833844_uniq UNIQUE (role_id, permission_id);


--
-- Name: users_role users_role_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users_role
    ADD CONSTRAINT users_role_pkey PRIMARY KEY (id);


--
-- Name: users_user users_user_email_243f6e77_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users_user
    ADD CONSTRAINT users_user_email_243f6e77_uniq UNIQUE (email);


--
-- Name: users_user_groups users_user_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users_user_groups
    ADD CONSTRAINT users_user_groups_pkey PRIMARY KEY (id);


--
-- Name: users_user_groups users_user_groups_user_id_group_id_b88eab82_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users_user_groups
    ADD CONSTRAINT users_user_groups_user_id_group_id_b88eab82_uniq UNIQUE (user_id, group_id);


--
-- Name: users_user users_user_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users_user
    ADD CONSTRAINT users_user_pkey PRIMARY KEY (id);


--
-- Name: users_user_user_permissions users_user_user_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users_user_user_permissions
    ADD CONSTRAINT users_user_user_permissions_pkey PRIMARY KEY (id);


--
-- Name: users_user_user_permissions users_user_user_permissions_user_id_permission_id_43338c45_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users_user_user_permissions
    ADD CONSTRAINT users_user_user_permissions_user_id_permission_id_43338c45_uniq UNIQUE (user_id, permission_id);


--
-- Name: users_user users_user_username_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users_user
    ADD CONSTRAINT users_user_username_key UNIQUE (username);


--
-- Name: appraisals_appraisal_employee_id_8c2333ce; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX appraisals_appraisal_employee_id_8c2333ce ON public.appraisals_appraisal USING btree (employee_id);


--
-- Name: appraisals_appraisal_overall_appraisal_id_ee7fb5c7; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX appraisals_appraisal_overall_appraisal_id_ee7fb5c7 ON public.appraisals_appraisal USING btree (overall_appraisal_id);


--
-- Name: appraisals_overallappraisal_company_id_41253a5c; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX appraisals_overallappraisal_company_id_41253a5c ON public.appraisals_overallappraisal USING btree (company_id);


--
-- Name: auth_access_token_token_031da619_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_access_token_token_031da619_like ON public.auth_access_token USING btree (token varchar_pattern_ops);


--
-- Name: auth_access_token_user_id_c480a680; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_access_token_user_id_c480a680 ON public.auth_access_token USING btree (user_id);


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
-- Name: auth_refresh_token_user_id_1e6f4813; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_refresh_token_user_id_1e6f4813 ON public.auth_refresh_token USING btree (user_id);


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
-- Name: django_site_domain_a2e37b91_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_site_domain_a2e37b91_like ON public.django_site USING btree (domain varchar_pattern_ops);


--
-- Name: training_corevalue_appraisal_id_5097b0a0; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX training_corevalue_appraisal_id_5097b0a0 ON public.training_corevalue USING btree (appraisal_id);


--
-- Name: training_corevalue_core_value_category_id_d2bb2851; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX training_corevalue_core_value_category_id_d2bb2851 ON public.training_corevalue USING btree (category_id);


--
-- Name: training_corevaluecategory_company_id_c3368e0d; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX training_corevaluecategory_company_id_c3368e0d ON public.training_corevaluecategory USING btree (company_id);


--
-- Name: training_departmentalcorevalue_appraisal_id_380be36e; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX training_departmentalcorevalue_appraisal_id_380be36e ON public.training_departmentalcorevalue USING btree (appraisal_id);


--
-- Name: training_departmentalcorevalue_category_id_931a8dde; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX training_departmentalcorevalue_category_id_931a8dde ON public.training_departmentalcorevalue USING btree (category_id);


--
-- Name: training_departmentalcorevalue_manager_id_8755ad3f; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX training_departmentalcorevalue_manager_id_8755ad3f ON public.training_departmentalcorevalue USING btree (manager_id);


--
-- Name: training_departmentalgoal_appraisal_id_5517853e; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX training_departmentalgoal_appraisal_id_5517853e ON public.training_departmentalgoal USING btree (appraisal_id);


--
-- Name: training_departmentalgoal_category_id_d546ef97; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX training_departmentalgoal_category_id_d546ef97 ON public.training_departmentalgoal USING btree (category_id);


--
-- Name: training_departmentalgoal_manager_id_f97d13e4; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX training_departmentalgoal_manager_id_f97d13e4 ON public.training_departmentalgoal USING btree (manager_id);


--
-- Name: training_goal_appraisal_id_378fcfb9; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX training_goal_appraisal_id_378fcfb9 ON public.training_goal USING btree (appraisal_id);


--
-- Name: training_goal_goal_category_id_6d6319f0; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX training_goal_goal_category_id_6d6319f0 ON public.training_goal USING btree (category_id);


--
-- Name: training_goalcategory_company_id_ca0d9b5f; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX training_goalcategory_company_id_ca0d9b5f ON public.training_goalcategory USING btree (company_id);


--
-- Name: training_kpi_goal_id_60a197e9; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX training_kpi_goal_id_60a197e9 ON public.training_kpi USING btree (goal_id);


--
-- Name: training_skill_appraisal_id_393caa28; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX training_skill_appraisal_id_393caa28 ON public.training_skill USING btree (appraisal_id);


--
-- Name: training_skill_skill_category_id_41bddf0b; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX training_skill_skill_category_id_41bddf0b ON public.training_skill USING btree (category_id);


--
-- Name: training_skillscategory_company_id_1a8344e8; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX training_skillscategory_company_id_1a8344e8 ON public.training_skillscategory USING btree (company_id);


--
-- Name: users_company_domain_5b7359f9_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX users_company_domain_5b7359f9_like ON public.users_company USING btree (domain varchar_pattern_ops);


--
-- Name: users_company_name_d7dc344c_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX users_company_name_d7dc344c_like ON public.users_company USING btree (name varchar_pattern_ops);


--
-- Name: users_department_company_id_d0ccd26d; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX users_department_company_id_d0ccd26d ON public.users_department USING btree (company_id);


--
-- Name: users_department_manager_id_003419d1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX users_department_manager_id_003419d1 ON public.users_department USING btree (manager_id);


--
-- Name: users_logs_user_id_fc052871; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX users_logs_user_id_fc052871 ON public.users_logs USING btree (user_id);


--
-- Name: users_permission_company_id_5d523d86; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX users_permission_company_id_5d523d86 ON public.users_permission USING btree (company_id);


--
-- Name: users_profile_department_id_c65780ab; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX users_profile_department_id_c65780ab ON public.users_profile USING btree (department_id);


--
-- Name: users_profile_first_reporting_manager_id_1eca270e; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX users_profile_first_reporting_manager_id_1eca270e ON public.users_profile USING btree (first_reporting_manager_id);


--
-- Name: users_profile_second_reporting_manager_id_ed27819e; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX users_profile_second_reporting_manager_id_ed27819e ON public.users_profile USING btree (second_reporting_manager_id);


--
-- Name: users_resetpasswordtoken_user_id_fa988b34; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX users_resetpasswordtoken_user_id_fa988b34 ON public.users_resetpasswordtoken USING btree (user_id);


--
-- Name: users_role_company_id_cbd116bb; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX users_role_company_id_cbd116bb ON public.users_role USING btree (company_id);


--
-- Name: users_role_permissions_permission_id_5313a8eb; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX users_role_permissions_permission_id_5313a8eb ON public.users_role_permissions USING btree (permission_id);


--
-- Name: users_role_permissions_role_id_b99e9f6e; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX users_role_permissions_role_id_b99e9f6e ON public.users_role_permissions USING btree (role_id);


--
-- Name: users_user_company_id_14799323; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX users_user_company_id_14799323 ON public.users_user USING btree (company_id);


--
-- Name: users_user_email_243f6e77_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX users_user_email_243f6e77_like ON public.users_user USING btree (email varchar_pattern_ops);


--
-- Name: users_user_groups_group_id_9afc8d0e; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX users_user_groups_group_id_9afc8d0e ON public.users_user_groups USING btree (group_id);


--
-- Name: users_user_groups_user_id_5f6f5a90; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX users_user_groups_user_id_5f6f5a90 ON public.users_user_groups USING btree (user_id);


--
-- Name: users_user_role_id_854f2687; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX users_user_role_id_854f2687 ON public.users_user USING btree (role_id);


--
-- Name: users_user_user_permissions_permission_id_0b93982e; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX users_user_user_permissions_permission_id_0b93982e ON public.users_user_user_permissions USING btree (permission_id);


--
-- Name: users_user_user_permissions_user_id_20aca447; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX users_user_user_permissions_user_id_20aca447 ON public.users_user_user_permissions USING btree (user_id);


--
-- Name: users_user_username_06e46fe6_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX users_user_username_06e46fe6_like ON public.users_user USING btree (username varchar_pattern_ops);


--
-- Name: appraisals_appraisal appraisals_appraisal_employee_id_8c2333ce_fk_users_profile_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.appraisals_appraisal
    ADD CONSTRAINT appraisals_appraisal_employee_id_8c2333ce_fk_users_profile_id FOREIGN KEY (employee_id) REFERENCES public.users_profile(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: appraisals_appraisal appraisals_appraisal_overall_appraisal_id_ee7fb5c7_fk_appraisal; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.appraisals_appraisal
    ADD CONSTRAINT appraisals_appraisal_overall_appraisal_id_ee7fb5c7_fk_appraisal FOREIGN KEY (overall_appraisal_id) REFERENCES public.appraisals_overallappraisal(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: appraisals_overallappraisal appraisals_overallap_company_id_41253a5c_fk_users_com; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.appraisals_overallappraisal
    ADD CONSTRAINT appraisals_overallap_company_id_41253a5c_fk_users_com FOREIGN KEY (company_id) REFERENCES public.users_company(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_access_token auth_access_token_user_id_c480a680_fk_users_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_access_token
    ADD CONSTRAINT auth_access_token_user_id_c480a680_fk_users_user_id FOREIGN KEY (user_id) REFERENCES public.users_user(id) DEFERRABLE INITIALLY DEFERRED;


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
-- Name: auth_refresh_token auth_refresh_token_access_token_id_4eee381f_fk_auth_acce; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_refresh_token
    ADD CONSTRAINT auth_refresh_token_access_token_id_4eee381f_fk_auth_acce FOREIGN KEY (access_token_id) REFERENCES public.auth_access_token(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_refresh_token auth_refresh_token_user_id_1e6f4813_fk_users_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_refresh_token
    ADD CONSTRAINT auth_refresh_token_user_id_1e6f4813_fk_users_user_id FOREIGN KEY (user_id) REFERENCES public.users_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_content_type_id_c4bce8eb_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_content_type_id_c4bce8eb_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_user_id_c564eba6_fk_users_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_user_id_c564eba6_fk_users_user_id FOREIGN KEY (user_id) REFERENCES public.users_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: training_corevalue training_corevalue_appraisal_id_5097b0a0_fk_appraisal; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.training_corevalue
    ADD CONSTRAINT training_corevalue_appraisal_id_5097b0a0_fk_appraisal FOREIGN KEY (appraisal_id) REFERENCES public.appraisals_appraisal(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: training_corevalue training_corevalue_category_id_d29d1d09_fk_training_; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.training_corevalue
    ADD CONSTRAINT training_corevalue_category_id_d29d1d09_fk_training_ FOREIGN KEY (category_id) REFERENCES public.training_corevaluecategory(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: training_corevaluecategory training_corevalueca_company_id_c3368e0d_fk_users_com; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.training_corevaluecategory
    ADD CONSTRAINT training_corevalueca_company_id_c3368e0d_fk_users_com FOREIGN KEY (company_id) REFERENCES public.users_company(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: training_departmentalcorevalue training_departmenta_appraisal_id_380be36e_fk_appraisal; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.training_departmentalcorevalue
    ADD CONSTRAINT training_departmenta_appraisal_id_380be36e_fk_appraisal FOREIGN KEY (appraisal_id) REFERENCES public.appraisals_overallappraisal(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: training_departmentalgoal training_departmenta_appraisal_id_5517853e_fk_appraisal; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.training_departmentalgoal
    ADD CONSTRAINT training_departmenta_appraisal_id_5517853e_fk_appraisal FOREIGN KEY (appraisal_id) REFERENCES public.appraisals_overallappraisal(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: training_departmentalcorevalue training_departmenta_category_id_931a8dde_fk_training_; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.training_departmentalcorevalue
    ADD CONSTRAINT training_departmenta_category_id_931a8dde_fk_training_ FOREIGN KEY (category_id) REFERENCES public.training_corevaluecategory(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: training_departmentalgoal training_departmenta_category_id_d546ef97_fk_training_; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.training_departmentalgoal
    ADD CONSTRAINT training_departmenta_category_id_d546ef97_fk_training_ FOREIGN KEY (category_id) REFERENCES public.training_goalcategory(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: training_departmentalcorevalue training_departmenta_manager_id_8755ad3f_fk_users_pro; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.training_departmentalcorevalue
    ADD CONSTRAINT training_departmenta_manager_id_8755ad3f_fk_users_pro FOREIGN KEY (manager_id) REFERENCES public.users_profile(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: training_departmentalgoal training_departmenta_manager_id_f97d13e4_fk_users_pro; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.training_departmentalgoal
    ADD CONSTRAINT training_departmenta_manager_id_f97d13e4_fk_users_pro FOREIGN KEY (manager_id) REFERENCES public.users_profile(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: training_goal training_goal_appraisal_id_378fcfb9_fk_appraisals_appraisal_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.training_goal
    ADD CONSTRAINT training_goal_appraisal_id_378fcfb9_fk_appraisals_appraisal_id FOREIGN KEY (appraisal_id) REFERENCES public.appraisals_appraisal(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: training_goal training_goal_category_id_d1b12f58_fk_training_goalcategory_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.training_goal
    ADD CONSTRAINT training_goal_category_id_d1b12f58_fk_training_goalcategory_id FOREIGN KEY (category_id) REFERENCES public.training_goalcategory(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: training_goalcategory training_goalcategory_company_id_ca0d9b5f_fk_users_company_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.training_goalcategory
    ADD CONSTRAINT training_goalcategory_company_id_ca0d9b5f_fk_users_company_id FOREIGN KEY (company_id) REFERENCES public.users_company(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: training_kpi training_kpi_goal_id_60a197e9_fk_training_goal_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.training_kpi
    ADD CONSTRAINT training_kpi_goal_id_60a197e9_fk_training_goal_id FOREIGN KEY (goal_id) REFERENCES public.training_goal(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: training_skill training_skill_appraisal_id_393caa28_fk_appraisals_appraisal_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.training_skill
    ADD CONSTRAINT training_skill_appraisal_id_393caa28_fk_appraisals_appraisal_id FOREIGN KEY (appraisal_id) REFERENCES public.appraisals_appraisal(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: training_skill training_skill_category_id_8836d8e0_fk_training_; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.training_skill
    ADD CONSTRAINT training_skill_category_id_8836d8e0_fk_training_ FOREIGN KEY (category_id) REFERENCES public.training_skillscategory(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: training_skillscategory training_skillscategory_company_id_1a8344e8_fk_users_company_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.training_skillscategory
    ADD CONSTRAINT training_skillscategory_company_id_1a8344e8_fk_users_company_id FOREIGN KEY (company_id) REFERENCES public.users_company(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: users_department users_department_company_id_d0ccd26d_fk_users_company_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users_department
    ADD CONSTRAINT users_department_company_id_d0ccd26d_fk_users_company_id FOREIGN KEY (company_id) REFERENCES public.users_company(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: users_department users_department_manager_id_003419d1_fk_users_profile_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users_department
    ADD CONSTRAINT users_department_manager_id_003419d1_fk_users_profile_id FOREIGN KEY (manager_id) REFERENCES public.users_profile(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: users_logs users_logs_user_id_fc052871_fk_users_profile_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users_logs
    ADD CONSTRAINT users_logs_user_id_fc052871_fk_users_profile_id FOREIGN KEY (user_id) REFERENCES public.users_profile(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: users_notification users_notification_logs_ptr_id_843acc01_fk_users_logs_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users_notification
    ADD CONSTRAINT users_notification_logs_ptr_id_843acc01_fk_users_logs_id FOREIGN KEY (logs_ptr_id) REFERENCES public.users_logs(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: users_permission users_permission_company_id_5d523d86_fk_users_company_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users_permission
    ADD CONSTRAINT users_permission_company_id_5d523d86_fk_users_company_id FOREIGN KEY (company_id) REFERENCES public.users_company(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: users_profile users_profile_department_id_c65780ab_fk_users_department_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users_profile
    ADD CONSTRAINT users_profile_department_id_c65780ab_fk_users_department_id FOREIGN KEY (department_id) REFERENCES public.users_department(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: users_profile users_profile_first_reporting_mana_1eca270e_fk_users_pro; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users_profile
    ADD CONSTRAINT users_profile_first_reporting_mana_1eca270e_fk_users_pro FOREIGN KEY (first_reporting_manager_id) REFERENCES public.users_profile(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: users_profile users_profile_second_reporting_man_ed27819e_fk_users_pro; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users_profile
    ADD CONSTRAINT users_profile_second_reporting_man_ed27819e_fk_users_pro FOREIGN KEY (second_reporting_manager_id) REFERENCES public.users_profile(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: users_profile users_profile_user_id_2112e78d_fk_users_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users_profile
    ADD CONSTRAINT users_profile_user_id_2112e78d_fk_users_user_id FOREIGN KEY (user_id) REFERENCES public.users_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: users_resetpasswordtoken users_resetpasswordtoken_user_id_fa988b34_fk_users_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users_resetpasswordtoken
    ADD CONSTRAINT users_resetpasswordtoken_user_id_fa988b34_fk_users_user_id FOREIGN KEY (user_id) REFERENCES public.users_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: users_role users_role_company_id_cbd116bb_fk_users_company_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users_role
    ADD CONSTRAINT users_role_company_id_cbd116bb_fk_users_company_id FOREIGN KEY (company_id) REFERENCES public.users_company(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: users_role_permissions users_role_permissio_permission_id_5313a8eb_fk_users_per; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users_role_permissions
    ADD CONSTRAINT users_role_permissio_permission_id_5313a8eb_fk_users_per FOREIGN KEY (permission_id) REFERENCES public.users_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: users_role_permissions users_role_permissions_role_id_b99e9f6e_fk_users_role_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users_role_permissions
    ADD CONSTRAINT users_role_permissions_role_id_b99e9f6e_fk_users_role_id FOREIGN KEY (role_id) REFERENCES public.users_role(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: users_user users_user_company_id_14799323_fk_users_company_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users_user
    ADD CONSTRAINT users_user_company_id_14799323_fk_users_company_id FOREIGN KEY (company_id) REFERENCES public.users_company(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: users_user_groups users_user_groups_group_id_9afc8d0e_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users_user_groups
    ADD CONSTRAINT users_user_groups_group_id_9afc8d0e_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: users_user_groups users_user_groups_user_id_5f6f5a90_fk_users_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users_user_groups
    ADD CONSTRAINT users_user_groups_user_id_5f6f5a90_fk_users_user_id FOREIGN KEY (user_id) REFERENCES public.users_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: users_user users_user_role_id_854f2687_fk_users_role_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users_user
    ADD CONSTRAINT users_user_role_id_854f2687_fk_users_role_id FOREIGN KEY (role_id) REFERENCES public.users_role(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: users_user_user_permissions users_user_user_perm_permission_id_0b93982e_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users_user_user_permissions
    ADD CONSTRAINT users_user_user_perm_permission_id_0b93982e_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: users_user_user_permissions users_user_user_permissions_user_id_20aca447_fk_users_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users_user_user_permissions
    ADD CONSTRAINT users_user_user_permissions_user_id_20aca447_fk_users_user_id FOREIGN KEY (user_id) REFERENCES public.users_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- PostgreSQL database dump complete
--

