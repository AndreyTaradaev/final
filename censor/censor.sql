
--CREATE database   gocensor WITH TEMPLATE = template0 ;


CREATE TABLE IF NOT EXISTS    public.censor (
    "Id" integer NOT NULL,
    "Banned" character varying NOT NULL
);

CREATE SEQUENCE  IF NOT EXISTS  public."NewTable_Id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE  public."NewTable_Id_seq" OWNED BY public.censor."Id";

ALTER TABLE ONLY public.censor ALTER COLUMN "Id" SET DEFAULT nextval('public."NewTable_Id_seq"'::regclass);
ALTER TABLE ONLY public.censor
    ADD CONSTRAINT censor_pk PRIMARY KEY ("Id");
CREATE UNIQUE INDEX "censor_Banned_IDX" ON public.censor USING btree ("Banned");

INSERT INTO public.censor VALUES (1, 'qwerty');
INSERT INTO public.censor VALUES (2, 'йцукен');
INSERT INTO public.censor VALUES (3, 'zxvbnm');
INSERT INTO public.censor VALUES (4, 'asdf');
INSERT INTO public.censor VALUES (5, 'мат');
INSERT INTO public.censor VALUES (6, 'мат11');
INSERT INTO public.censor VALUES (7, 'кенг');

SELECT pg_catalog.setval('public."NewTable_Id_seq"', 7, true);





