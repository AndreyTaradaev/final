--
-- PostgreSQL database dump
--

-- Dumped from database version 11.9
-- Dumped by pg_dump version 14.2

-- Started on 2023-07-18 14:25:01

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = off;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET escape_string_warning = off;
SET row_security = off;

DROP DATABASE gonews;
--
-- TOC entry 2180 (class 1262 OID 332256437)
-- Name: gonews; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE gonews WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'ru_RU.UTF-8' TABLESPACE = archive;


ALTER DATABASE gonews OWNER TO postgres;

\connect gonews

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = off;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET escape_string_warning = off;
SET row_security = off;

--
-- TOC entry 3 (class 2615 OID 2200)
-- Name: public; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA public;


ALTER SCHEMA public OWNER TO postgres;

--
-- TOC entry 2181 (class 0 OID 0)
-- Dependencies: 3
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA public IS 'standard public schema';


SET default_tablespace = '';

--
-- TOC entry 197 (class 1259 OID 332258818)
-- Name: NewsRss; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."NewsRss" (
    id bigint NOT NULL,
    title character varying NOT NULL,
    description character varying,
    "time" bigint NOT NULL,
    url character varying NOT NULL,
    hashrss bigint NOT NULL
);


ALTER TABLE public."NewsRss" OWNER TO postgres;

--
-- TOC entry 2182 (class 0 OID 0)
-- Dependencies: 197
-- Name: COLUMN "NewsRss".id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public."NewsRss".id IS 'id rss';


--
-- TOC entry 2183 (class 0 OID 0)
-- Dependencies: 197
-- Name: COLUMN "NewsRss".title; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public."NewsRss".title IS 'title rss';


--
-- TOC entry 2184 (class 0 OID 0)
-- Dependencies: 197
-- Name: COLUMN "NewsRss".description; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public."NewsRss".description IS 'тело новости';


--
-- TOC entry 2185 (class 0 OID 0)
-- Dependencies: 197
-- Name: COLUMN "NewsRss"."time"; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public."NewsRss"."time" IS 'время новости';


--
-- TOC entry 2186 (class 0 OID 0)
-- Dependencies: 197
-- Name: COLUMN "NewsRss".url; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public."NewsRss".url IS 'ссылка  на новость';


--
-- TOC entry 2187 (class 0 OID 0)
-- Dependencies: 197
-- Name: COLUMN "NewsRss".hashrss; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public."NewsRss".hashrss IS 'crc64 расчитывается по ИД новости для того чтобы исключить дублирование загрузки одинаковых новостей';


--
-- TOC entry 196 (class 1259 OID 332258816)
-- Name: NewsRss_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."NewsRss_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."NewsRss_id_seq" OWNER TO postgres;

--
-- TOC entry 2188 (class 0 OID 0)
-- Dependencies: 196
-- Name: NewsRss_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."NewsRss_id_seq" OWNED BY public."NewsRss".id;


--
-- TOC entry 2051 (class 2604 OID 332258821)
-- Name: NewsRss id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."NewsRss" ALTER COLUMN id SET DEFAULT nextval('public."NewsRss_id_seq"'::regclass);


--
-- TOC entry 2174 (class 0 OID 332258818)
-- Dependencies: 197
-- Data for Name: NewsRss; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2189 (class 0 OID 0)
-- Dependencies: 196
-- Name: NewsRss_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."NewsRss_id_seq"', 1, false);


-- Completed on 2023-07-18 14:25:03

--
-- PostgreSQL database dump complete
--

