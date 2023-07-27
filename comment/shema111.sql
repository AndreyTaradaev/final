--
-- PostgreSQL database dump
--

-- Dumped from database version 11.9
-- Dumped by pg_dump version 14.2

-- Started on 2023-07-26 23:39:00

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

DROP DATABASE gocomments;
--
-- TOC entry 2183 (class 1262 OID 335615690)
-- Name: gocomments; Type: DATABASE; Schema: -; Owner: -
--

CREATE DATABASE gocomments WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'ru_RU.UTF-8' TABLESPACE = archive;


\connect gocomments

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
-- Name: public; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA public;


--
-- TOC entry 2184 (class 0 OID 0)
-- Dependencies: 3
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON SCHEMA public IS 'standard public schema';


SET default_tablespace = '';

--
-- TOC entry 197 (class 1259 OID 335617507)
-- Name: newscomments; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.newscomments (
    id bigint NOT NULL,
    id_news bigint NOT NULL,
    "Content" character varying,
    parent bigint,
    "time" bigint
);


--
-- TOC entry 196 (class 1259 OID 335617505)
-- Name: newscomments_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.newscomments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2185 (class 0 OID 0)
-- Dependencies: 196
-- Name: newscomments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.newscomments_id_seq OWNED BY public.newscomments.id;


--
-- TOC entry 2051 (class 2604 OID 335617510)
-- Name: newscomments id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.newscomments ALTER COLUMN id SET DEFAULT nextval('public.newscomments_id_seq'::regclass);


--
-- TOC entry 2177 (class 0 OID 335617507)
-- Dependencies: 197
-- Data for Name: newscomments; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.newscomments (id, id_news, "Content", parent, "time") FROM stdin;
1	111	sdfsdfsfd	\N	123123
2	3333	sdfsfzx	2	434123
3	444	\N	\N	\N
\.


--
-- TOC entry 2186 (class 0 OID 0)
-- Dependencies: 196
-- Name: newscomments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.newscomments_id_seq', 4, true);


--
-- TOC entry 2053 (class 2606 OID 335617515)
-- Name: newscomments newscomments_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.newscomments
    ADD CONSTRAINT newscomments_pkey PRIMARY KEY (id);


--
-- TOC entry 2054 (class 2606 OID 335617516)
-- Name: newscomments newscomments_parent_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.newscomments
    ADD CONSTRAINT newscomments_parent_fkey FOREIGN KEY (parent) REFERENCES public.newscomments(id);


-- Completed on 2023-07-26 23:39:03

--
-- PostgreSQL database dump complete
--

