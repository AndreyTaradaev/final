

CREATE DATABASE gocensor WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'ru_RU.UTF-8';


\connect gocensor


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
-- TOC entry 197 (class 1259 OID 336640505)
-- Name: censor; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.censor (
    "Id" integer NOT NULL,
    "Banned" character varying NOT NULL
);


--
-- TOC entry 196 (class 1259 OID 336640503)
-- Name: NewTable_Id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public."NewTable_Id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2185 (class 0 OID 0)
-- Dependencies: 196
-- Name: NewTable_Id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public."NewTable_Id_seq" OWNED BY public.censor."Id";


--
-- TOC entry 2051 (class 2604 OID 336640508)
-- Name: censor Id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.censor ALTER COLUMN "Id" SET DEFAULT nextval('public."NewTable_Id_seq"'::regclass);


--
-- TOC entry 2177 (class 0 OID 336640505)
-- Dependencies: 197
-- Data for Name: censor; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.censor VALUES (1, 'qwerty');
INSERT INTO public.censor VALUES (2, 'йцукен');
INSERT INTO public.censor VALUES (3, 'zxvbnm');
INSERT INTO public.censor VALUES (4, 'asdf');
INSERT INTO public.censor VALUES (5, 'мат');


--
-- TOC entry 2186 (class 0 OID 0)
-- Dependencies: 196
-- Name: NewTable_Id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public."NewTable_Id_seq"', 5, true);


--
-- TOC entry 2054 (class 2606 OID 336741576)
-- Name: censor censor_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.censor
    ADD CONSTRAINT censor_pk PRIMARY KEY ("Id");


--
-- TOC entry 2052 (class 1259 OID 336741574)
-- Name: censor_Banned_IDX; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "censor_Banned_IDX" ON public.censor USING btree ("Banned");


-- Completed on 2023-07-31 17:57:21

--
-- PostgreSQL database dump complete
--

