--
-- PostgreSQL database dump
--

-- Dumped from database version 11.9
-- Dumped by pg_dump version 14.2

-- Started on 2023-07-31 18:00:08

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
    "time" bigint,
    "authorId" bigint NOT NULL
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

INSERT INTO public.newscomments VALUES (21, 123015, 'coment eeewer123123', NULL, 5556522222, 1121);
INSERT INTO public.newscomments VALUES (22, 123015, 'coment eeewer1231232', 21, 5556522222, 1121);
INSERT INTO public.newscomments VALUES (23, 123015, 'coment eeewer1231232', 22, 5556522222, 1121);
INSERT INTO public.newscomments VALUES (24, 123015, 'coment eeewer1231232', 22, 5556522222, 1121);
INSERT INTO public.newscomments VALUES (10, 22490, 'coment', NULL, 55555, 111);
INSERT INTO public.newscomments VALUES (11, 22490, 'coment2', NULL, 55565, 112);
INSERT INTO public.newscomments VALUES (12, 22490, 'coment eeewer1', NULL, 555657, 112);
INSERT INTO public.newscomments VALUES (13, 22490, 'coment eeewer2', 10, 8, 112);
INSERT INTO public.newscomments VALUES (14, 22490, 'coment eeewer3', 10, 555565, 112);
INSERT INTO public.newscomments VALUES (15, 22490, 'coment eeewer4', 14, 455565, 112);
INSERT INTO public.newscomments VALUES (16, 22490, 'coment eeewer5', 15, 255565, 112);
INSERT INTO public.newscomments VALUES (17, 22490, 'coment eeewer7', 13, 155565, 112);
INSERT INTO public.newscomments VALUES (18, 22490, 'coment eeewer9', 16, 55565421, 112);
INSERT INTO public.newscomments VALUES (19, 22490, 'coment eeewer0', 14, 55565998, 112);
INSERT INTO public.newscomments VALUES (20, 22490, 'coment eeewer123123', 11, 5556522222, 1121);
INSERT INTO public.newscomments VALUES (27, 65222, 'Ghbrjkmyj', NULL, 5556522222, 1121);
INSERT INTO public.newscomments VALUES (28, 65222, 'Ghbrjkmyj', 27, 5556522222, 1121);
INSERT INTO public.newscomments VALUES (29, 65222, 'Ghbrjkmyj111', NULL, 5556522222, 0);
INSERT INTO public.newscomments VALUES (30, 65222, 'Ghbrjkmyj111', NULL, 5556522222, 0);
INSERT INTO public.newscomments VALUES (31, 65222, 'Ghbrjkmyj111', 30, 5556522222, 1121);
INSERT INTO public.newscomments VALUES (32, 65222, 'Ghbrjkmyj1112', 30, 5556522222, 1121);
INSERT INTO public.newscomments VALUES (33, 65222, 'Ghbrjkmyj1112', 32, 5556522222, 1121);
INSERT INTO public.newscomments VALUES (35, 65222, 'Ghbrjkmyj1112', 34, 5556522222, 1121);
INSERT INTO public.newscomments VALUES (36, 65222, 'Ghbrjkmyj1112', 34, 5556522222, 1121);
INSERT INTO public.newscomments VALUES (37, 65222, 'Ghbrjkmyj1112', 36, 5556522222, 1121);
INSERT INTO public.newscomments VALUES (38, 65222, 'Ghbrjkmyj1112', 36, 5556522222, 1121);
INSERT INTO public.newscomments VALUES (39, 65222, 'Ghbrjkmyj1112', 36, 5556522222, 1121);
INSERT INTO public.newscomments VALUES (40, 65222, 'Ghbrjkmyj1112', 36, 5556522222, 1121);
INSERT INTO public.newscomments VALUES (41, 65222, 'Ghbrjkmyj1112', 40, 5556522222, 1121);
INSERT INTO public.newscomments VALUES (42, 65222, 'Ghbrjkmyj1112', 41, 5556522222, 1121);
INSERT INTO public.newscomments VALUES (43, 65222, 'Ghbrjkmyj1112', 42, 5556522222, 1121);
INSERT INTO public.newscomments VALUES (44, 65222, 'Ghbrjkmyj1112', 42, 5556522222, 1121);
INSERT INTO public.newscomments VALUES (45, 65222, 'Ghbrjkmyj1112', 42, 5556522222, 1121);
INSERT INTO public.newscomments VALUES (46, 65222, 'Ghbrjkmyj1112', 42, 5556522222, 1121);
INSERT INTO public.newscomments VALUES (47, 65222, 'Ghbrjkmyj1112', 46, 5556522222, 1121);
INSERT INTO public.newscomments VALUES (48, 65222, 'Ghbrjkmyj1112', 46, 5556522222, 1121);
INSERT INTO public.newscomments VALUES (34, 65222, 'Ghbrjkmyj1112', 32, 5556522222, 1121);
INSERT INTO public.newscomments VALUES (49, 65222, 'Ghbrjkmyj1112', 46, 5556522222, 1121);
INSERT INTO public.newscomments VALUES (50, 65222, 'Ghbrjkmyj1112', 46, 5556522222, 1121);
INSERT INTO public.newscomments VALUES (51, 65222, 'Ghbrjkmyj1112 qwerty', 46, 5556522222, 1121);
INSERT INTO public.newscomments VALUES (52, 65222, 'Ghbrjkmyj1112 qwerty', 46, 5556522222, 1121);
INSERT INTO public.newscomments VALUES (53, 65222, 'Ghbrjkmyj1112 qwerty', 46, 5556522222, 1121);
INSERT INTO public.newscomments VALUES (54, 65222, 'Ghbrjkmyj1112 qwerty', 46, 5556522222, 1121);
INSERT INTO public.newscomments VALUES (55, 65222, 'Ghbrjkmyj1112 qwerty', 46, 5556522222, 1121);
INSERT INTO public.newscomments VALUES (56, 65222, 'Ghbrjkmyj1112 asdasdqertyasdasd', 46, 5556522222, 1121);


--
-- TOC entry 2186 (class 0 OID 0)
-- Dependencies: 196
-- Name: newscomments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.newscomments_id_seq', 56, true);


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


-- Completed on 2023-07-31 18:00:11

--
-- PostgreSQL database dump complete
--

