
--CREATE DATABASE gocomments WITH TEMPLATE = template0 ;


CREATE TABLE public.newscomments (
    id bigint NOT NULL,
    id_news bigint NOT NULL,
    "Content" character varying,
    parent bigint,
    "time" bigint,
    "authorId" bigint NOT NULL,
    deleted boolean DEFAULT false NOT NULL
);

CREATE SEQUENCE public.newscomments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE public.newscomments_id_seq OWNED BY public.newscomments.id;

ALTER TABLE ONLY public.newscomments ALTER COLUMN id SET DEFAULT nextval('public.newscomments_id_seq'::regclass);

INSERT INTO public.newscomments VALUES (55, 65222, 'Ghbrjkmyj1112 qwerty', 46, 5556522222, 1121, true);
INSERT INTO public.newscomments VALUES (54, 65222, 'Ghbrjkmyj1112 qwerty', 46, 5556522222, 1121, true);
INSERT INTO public.newscomments VALUES (57, 65222, 'Ghbrjkmyj1112 asdasdqertyasdQWEYasd', 46, 5556522222, 1121, false);
INSERT INTO public.newscomments VALUES (58, 65222, 'Ghbrjkmyj1112 asdasdqertyasdQWEYasd', 46, 5556522222, 1121, false);
INSERT INTO public.newscomments VALUES (21, 123015, 'coment eeewer123123', NULL, 5556522222, 1121, false);
INSERT INTO public.newscomments VALUES (22, 123015, 'coment eeewer1231232', 21, 5556522222, 1121, false);
INSERT INTO public.newscomments VALUES (23, 123015, 'coment eeewer1231232', 22, 5556522222, 1121, false);
INSERT INTO public.newscomments VALUES (24, 123015, 'coment eeewer1231232', 22, 5556522222, 1121, false);
INSERT INTO public.newscomments VALUES (10, 22490, 'coment', NULL, 55555, 111, false);
INSERT INTO public.newscomments VALUES (11, 22490, 'coment2', NULL, 55565, 112, false);
INSERT INTO public.newscomments VALUES (12, 22490, 'coment eeewer1', NULL, 555657, 112, false);
INSERT INTO public.newscomments VALUES (13, 22490, 'coment eeewer2', 10, 8, 112, false);
INSERT INTO public.newscomments VALUES (14, 22490, 'coment eeewer3', 10, 555565, 112, false);
INSERT INTO public.newscomments VALUES (15, 22490, 'coment eeewer4', 14, 455565, 112, false);
INSERT INTO public.newscomments VALUES (16, 22490, 'coment eeewer5', 15, 255565, 112, false);
INSERT INTO public.newscomments VALUES (17, 22490, 'coment eeewer7', 13, 155565, 112, false);
INSERT INTO public.newscomments VALUES (18, 22490, 'coment eeewer9', 16, 55565421, 112, false);
INSERT INTO public.newscomments VALUES (19, 22490, 'coment eeewer0', 14, 55565998, 112, false);
INSERT INTO public.newscomments VALUES (20, 22490, 'coment eeewer123123', 11, 5556522222, 1121, false);
INSERT INTO public.newscomments VALUES (27, 65222, 'Ghbrjkmyj', NULL, 5556522222, 1121, false);
INSERT INTO public.newscomments VALUES (28, 65222, 'Ghbrjkmyj', 27, 5556522222, 1121, false);
INSERT INTO public.newscomments VALUES (29, 65222, 'Ghbrjkmyj111', NULL, 5556522222, 0, false);
INSERT INTO public.newscomments VALUES (30, 65222, 'Ghbrjkmyj111', NULL, 5556522222, 0, false);
INSERT INTO public.newscomments VALUES (31, 65222, 'Ghbrjkmyj111', 30, 5556522222, 1121, false);
INSERT INTO public.newscomments VALUES (32, 65222, 'Ghbrjkmyj1112', 30, 5556522222, 1121, false);
INSERT INTO public.newscomments VALUES (33, 65222, 'Ghbrjkmyj1112', 32, 5556522222, 1121, false);
INSERT INTO public.newscomments VALUES (35, 65222, 'Ghbrjkmyj1112', 34, 5556522222, 1121, false);
INSERT INTO public.newscomments VALUES (36, 65222, 'Ghbrjkmyj1112', 34, 5556522222, 1121, false);
INSERT INTO public.newscomments VALUES (37, 65222, 'Ghbrjkmyj1112', 36, 5556522222, 1121, false);
INSERT INTO public.newscomments VALUES (38, 65222, 'Ghbrjkmyj1112', 36, 5556522222, 1121, false);
INSERT INTO public.newscomments VALUES (39, 65222, 'Ghbrjkmyj1112', 36, 5556522222, 1121, false);
INSERT INTO public.newscomments VALUES (40, 65222, 'Ghbrjkmyj1112', 36, 5556522222, 1121, false);
INSERT INTO public.newscomments VALUES (41, 65222, 'Ghbrjkmyj1112', 40, 5556522222, 1121, false);
INSERT INTO public.newscomments VALUES (42, 65222, 'Ghbrjkmyj1112', 41, 5556522222, 1121, false);
INSERT INTO public.newscomments VALUES (43, 65222, 'Ghbrjkmyj1112', 42, 5556522222, 1121, false);
INSERT INTO public.newscomments VALUES (44, 65222, 'Ghbrjkmyj1112', 42, 5556522222, 1121, false);
INSERT INTO public.newscomments VALUES (45, 65222, 'Ghbrjkmyj1112', 42, 5556522222, 1121, false);
INSERT INTO public.newscomments VALUES (46, 65222, 'Ghbrjkmyj1112', 42, 5556522222, 1121, false);
INSERT INTO public.newscomments VALUES (47, 65222, 'Ghbrjkmyj1112', 46, 5556522222, 1121, false);
INSERT INTO public.newscomments VALUES (48, 65222, 'Ghbrjkmyj1112', 46, 5556522222, 1121, false);
INSERT INTO public.newscomments VALUES (34, 65222, 'Ghbrjkmyj1112', 32, 5556522222, 1121, false);
INSERT INTO public.newscomments VALUES (49, 65222, 'Ghbrjkmyj1112', 46, 5556522222, 1121, false);
INSERT INTO public.newscomments VALUES (50, 65222, 'Ghbrjkmyj1112', 46, 5556522222, 1121, false);
INSERT INTO public.newscomments VALUES (51, 65222, 'Ghbrjkmyj1112 qwerty', 46, 5556522222, 1121, false);
INSERT INTO public.newscomments VALUES (52, 65222, 'Ghbrjkmyj1112 qwerty', 46, 5556522222, 1121, false);
INSERT INTO public.newscomments VALUES (53, 65222, 'Ghbrjkmyj1112 qwerty', 46, 5556522222, 1121, false);
INSERT INTO public.newscomments VALUES (56, 65222, 'Ghbrjkmyj1112 asdasdqertyasdasd', 46, 5556522222, 1121, false);

SELECT pg_catalog.setval('public.newscomments_id_seq', 58, true);

ALTER TABLE ONLY public.newscomments
    ADD CONSTRAINT newscomments_pkey PRIMARY KEY (id);

ALTER TABLE ONLY public.newscomments
    ADD CONSTRAINT newscomments_parent_fkey FOREIGN KEY (parent) REFERENCES public.newscomments(id);

