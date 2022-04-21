--
-- PostgreSQL database dump
--

-- Dumped from database version 14.2
-- Dumped by pg_dump version 14.2

-- Started on 2022-04-21 20:40:43

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
-- TOC entry 211 (class 1259 OID 16411)
-- Name: account; Type: TABLE; Schema: public; Owner: blog
--

CREATE TABLE public.account (
    id bigint NOT NULL,
    email character varying(100) NOT NULL,
    name character varying(30) NOT NULL,
    avatar character varying(255),
    created timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.account OWNER TO blog;

--
-- TOC entry 213 (class 1259 OID 16425)
-- Name: account_seq; Type: SEQUENCE; Schema: public; Owner: blog
--

CREATE SEQUENCE public.account_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.account_seq OWNER TO blog;

--
-- TOC entry 3348 (class 0 OID 0)
-- Dependencies: 213
-- Name: account_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: blog
--

ALTER SEQUENCE public.account_seq OWNED BY public.account.id;


--
-- TOC entry 210 (class 1259 OID 16401)
-- Name: article; Type: TABLE; Schema: public; Owner: blog
--

CREATE TABLE public.article (
    id bigint NOT NULL,
    title character varying(255) NOT NULL,
    url character varying(255) NOT NULL,
    logo character varying(255) NOT NULL,
    "desc" character varying(255) NOT NULL,
    content text NOT NULL,
    id_category integer NOT NULL,
    created timestamp with time zone DEFAULT now() NOT NULL,
    views bigint DEFAULT 0 NOT NULL,
    comments integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.article OWNER TO blog;

--
-- TOC entry 209 (class 1259 OID 16396)
-- Name: category; Type: TABLE; Schema: public; Owner: blog
--

CREATE TABLE public.category (
    id integer NOT NULL,
    name character varying(30) NOT NULL,
    url character varying(20) NOT NULL,
    articles integer NOT NULL
);


ALTER TABLE public.category OWNER TO blog;

--
-- TOC entry 212 (class 1259 OID 16417)
-- Name: comment; Type: TABLE; Schema: public; Owner: blog
--

CREATE TABLE public.comment (
    id bigint NOT NULL,
    id_account bigint NOT NULL,
    id_article bigint NOT NULL,
    content text NOT NULL,
    created timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.comment OWNER TO blog;

--
-- TOC entry 214 (class 1259 OID 16426)
-- Name: comment_seq; Type: SEQUENCE; Schema: public; Owner: blog
--

CREATE SEQUENCE public.comment_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.comment_seq OWNER TO blog;

--
-- TOC entry 3349 (class 0 OID 0)
-- Dependencies: 214
-- Name: comment_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: blog
--

ALTER SEQUENCE public.comment_seq OWNED BY public.comment.id;


--
-- TOC entry 3339 (class 0 OID 16411)
-- Dependencies: 211
-- Data for Name: account; Type: TABLE DATA; Schema: public; Owner: blog
--

COPY public.account (id, email, name, avatar, created) FROM stdin;
\.


--
-- TOC entry 3338 (class 0 OID 16401)
-- Dependencies: 210
-- Data for Name: article; Type: TABLE DATA; Schema: public; Owner: blog
--

COPY public.article (id, title, url, logo, "desc", content, id_category, created, views, comments) FROM stdin;
\.


--
-- TOC entry 3337 (class 0 OID 16396)
-- Dependencies: 209
-- Data for Name: category; Type: TABLE DATA; Schema: public; Owner: blog
--

COPY public.category (id, name, url, articles) FROM stdin;
\.


--
-- TOC entry 3340 (class 0 OID 16417)
-- Dependencies: 212
-- Data for Name: comment; Type: TABLE DATA; Schema: public; Owner: blog
--

COPY public.comment (id, id_account, id_article, content, created) FROM stdin;
\.


--
-- TOC entry 3350 (class 0 OID 0)
-- Dependencies: 213
-- Name: account_seq; Type: SEQUENCE SET; Schema: public; Owner: blog
--

SELECT pg_catalog.setval('public.account_seq', 1, false);


--
-- TOC entry 3351 (class 0 OID 0)
-- Dependencies: 214
-- Name: comment_seq; Type: SEQUENCE SET; Schema: public; Owner: blog
--

SELECT pg_catalog.setval('public.comment_seq', 1, false);


--
-- TOC entry 3190 (class 2606 OID 16416)
-- Name: account account_pkey; Type: CONSTRAINT; Schema: public; Owner: blog
--

ALTER TABLE ONLY public.account
    ADD CONSTRAINT account_pkey PRIMARY KEY (id);


--
-- TOC entry 3183 (class 2606 OID 16400)
-- Name: category category_pkey; Type: CONSTRAINT; Schema: public; Owner: blog
--

ALTER TABLE ONLY public.category
    ADD CONSTRAINT category_pkey PRIMARY KEY (id);


--
-- TOC entry 3194 (class 2606 OID 16452)
-- Name: comment comment_pkey; Type: CONSTRAINT; Schema: public; Owner: blog
--

ALTER TABLE ONLY public.comment
    ADD CONSTRAINT comment_pkey PRIMARY KEY (id) INCLUDE (id);


--
-- TOC entry 3186 (class 2606 OID 16445)
-- Name: article id; Type: CONSTRAINT; Schema: public; Owner: blog
--

ALTER TABLE ONLY public.article
    ADD CONSTRAINT id PRIMARY KEY (id) INCLUDE (id);


--
-- TOC entry 3188 (class 2606 OID 16441)
-- Name: article unique; Type: CONSTRAINT; Schema: public; Owner: blog
--

ALTER TABLE ONLY public.article
    ADD CONSTRAINT "unique" UNIQUE (id, id_category);


--
-- TOC entry 3184 (class 1259 OID 16454)
-- Name: article_idx; Type: INDEX; Schema: public; Owner: blog
--

CREATE INDEX article_idx ON public.article USING btree (id_category);


--
-- TOC entry 3191 (class 1259 OID 16453)
-- Name: comment_idx; Type: INDEX; Schema: public; Owner: blog
--

CREATE INDEX comment_idx ON public.comment USING btree (id_article);


--
-- TOC entry 3192 (class 1259 OID 16455)
-- Name: comment_idx1; Type: INDEX; Schema: public; Owner: blog
--

CREATE INDEX comment_idx1 ON public.comment USING btree (id_account);


--
-- TOC entry 3195 (class 2606 OID 16428)
-- Name: article article_fk; Type: FK CONSTRAINT; Schema: public; Owner: blog
--

ALTER TABLE ONLY public.article
    ADD CONSTRAINT article_fk FOREIGN KEY (id_category) REFERENCES public.category(id) ON UPDATE CASCADE ON DELETE RESTRICT NOT VALID;


--
-- TOC entry 3196 (class 2606 OID 16433)
-- Name: comment comment_fk; Type: FK CONSTRAINT; Schema: public; Owner: blog
--

ALTER TABLE ONLY public.comment
    ADD CONSTRAINT comment_fk FOREIGN KEY (id_account) REFERENCES public.account(id) ON UPDATE CASCADE ON DELETE RESTRICT NOT VALID;


--
-- TOC entry 3197 (class 2606 OID 16446)
-- Name: comment comment_fk1; Type: FK CONSTRAINT; Schema: public; Owner: blog
--

ALTER TABLE ONLY public.comment
    ADD CONSTRAINT comment_fk1 FOREIGN KEY (id_article) REFERENCES public.article(id) ON UPDATE CASCADE ON DELETE RESTRICT NOT VALID;


-- Completed on 2022-04-21 20:40:43

--
-- PostgreSQL database dump complete
--

