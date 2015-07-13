--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: application; Type: TABLE; Schema: public; Owner: sultano; Tablespace: 
--

CREATE TABLE application (
    id integer NOT NULL,
    nom character varying(50) NOT NULL,
    prix integer NOT NULL,
    abonnement boolean DEFAULT false,
    num_telechargements integer NOT NULL,
    droits integer,
    categorie character varying(20) NOT NULL,
    mela integer NOT NULL,
    version integer,
    id_developpeur integer,
    CONSTRAINT application_version_check CHECK ((version >= 0))
);


ALTER TABLE public.application OWNER TO sultano;

--
-- Name: application_id_application_seq; Type: SEQUENCE; Schema: public; Owner: sultano
--

CREATE SEQUENCE application_id_application_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.application_id_application_seq OWNER TO sultano;

--
-- Name: application_id_application_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sultano
--

ALTER SEQUENCE application_id_application_seq OWNED BY application.id;


--
-- Name: avis; Type: TABLE; Schema: public; Owner: sultano; Tablespace: 
--

CREATE TABLE avis (
    elstar integer,
    commentaire character varying(100),
    id_avis integer NOT NULL,
    id_user integer,
    id_application integer,
    CONSTRAINT avis_elstar_check CHECK (((elstar >= 0) AND (elstar <= 5))),
    CONSTRAINT avis_id_avis_check CHECK ((id_avis >= 0))
);


ALTER TABLE public.avis OWNER TO sultano;

--
-- Name: average_commentaires; Type: VIEW; Schema: public; Owner: sultano
--

CREATE VIEW average_commentaires AS
    SELECT avis.id_application, avg(avis.elstar) AS elstar_avg FROM avis GROUP BY avis.id_application;


ALTER TABLE public.average_commentaires OWNER TO sultano;

--
-- Name: avg_app_dev; Type: TABLE; Schema: public; Owner: sultano; Tablespace: 
--

CREATE TABLE avg_app_dev (
    id_application integer,
    avg numeric,
    id_developpeur integer
);


ALTER TABLE public.avg_app_dev OWNER TO sultano;

--
-- Name: avg_elstar_app; Type: VIEW; Schema: public; Owner: sultano
--

CREATE VIEW avg_elstar_app AS
    SELECT avis.id_application, avg(avis.elstar) AS avg FROM avis GROUP BY avis.id_application;


ALTER TABLE public.avg_elstar_app OWNER TO sultano;

--
-- Name: avg_elstar_dev; Type: VIEW; Schema: public; Owner: sultano
--

CREATE VIEW avg_elstar_dev AS
    SELECT avg_app_dev.id_developpeur, avg(avg_app_dev.avg) AS avg FROM avg_app_dev GROUP BY avg_app_dev.id_developpeur, avg_app_dev.avg;


ALTER TABLE public.avg_elstar_dev OWNER TO sultano;

--
-- Name: avis_id_avis_seq; Type: SEQUENCE; Schema: public; Owner: sultano
--

CREATE SEQUENCE avis_id_avis_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.avis_id_avis_seq OWNER TO sultano;

--
-- Name: avis_id_avis_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sultano
--

ALTER SEQUENCE avis_id_avis_seq OWNED BY avis.id_avis;


--
-- Name: info_payement; Type: TABLE; Schema: public; Owner: sultano; Tablespace: 
--

CREATE TABLE info_payement (
    type character varying(20) NOT NULL,
    id integer NOT NULL,
    num_compte bigint,
    id_user integer,
    CONSTRAINT info_payement_id_compte_check CHECK ((id >= 0)),
    CONSTRAINT num_compte_constraint CHECK ((num_compte > 1000000))
);


ALTER TABLE public.info_payement OWNER TO sultano;

--
-- Name: info_payement_id_compte_seq; Type: SEQUENCE; Schema: public; Owner: sultano
--

CREATE SEQUENCE info_payement_id_compte_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.info_payement_id_compte_seq OWNER TO sultano;

--
-- Name: info_payement_id_compte_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sultano
--

ALTER SEQUENCE info_payement_id_compte_seq OWNED BY info_payement.id;


--
-- Name: liste_applications; Type: TABLE; Schema: public; Owner: sultano; Tablespace: 
--

CREATE TABLE liste_applications (
    id_application integer,
    id_user integer
);


ALTER TABLE public.liste_applications OWNER TO sultano;

--
-- Name: mot_cle; Type: TABLE; Schema: public; Owner: sultano; Tablespace: 
--

CREATE TABLE mot_cle (
    type character varying(100) NOT NULL,
    id integer NOT NULL,
    id_application integer
);


ALTER TABLE public.mot_cle OWNER TO sultano;

--
-- Name: mot_cle_id_seq; Type: SEQUENCE; Schema: public; Owner: sultano
--

CREATE SEQUENCE mot_cle_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.mot_cle_id_seq OWNER TO sultano;

--
-- Name: mot_cle_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sultano
--

ALTER SEQUENCE mot_cle_id_seq OWNED BY mot_cle.id;


--
-- Name: num_app_developpee; Type: VIEW; Schema: public; Owner: sultano
--

CREATE VIEW num_app_developpee AS
    SELECT application.id_developpeur, count(application.id) AS count FROM application GROUP BY application.id_developpeur;


ALTER TABLE public.num_app_developpee OWNER TO sultano;

--
-- Name: peripherique; Type: TABLE; Schema: public; Owner: sultano; Tablespace: 
--

CREATE TABLE peripherique (
    id integer NOT NULL,
    nom character varying(20) NOT NULL,
    id_se integer NOT NULL,
    nom_fabriquant character varying(20) NOT NULL,
    id_user integer,
    CONSTRAINT peripherique_id_peripherique_check CHECK ((id >= 0)),
    CONSTRAINT peripherique_id_se_check CHECK ((id_se >= 0))
);


ALTER TABLE public.peripherique OWNER TO sultano;

--
-- Name: peripherique_id_peripherique_seq; Type: SEQUENCE; Schema: public; Owner: sultano
--

CREATE SEQUENCE peripherique_id_peripherique_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.peripherique_id_peripherique_seq OWNER TO sultano;

--
-- Name: peripherique_id_peripherique_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sultano
--

ALTER SEQUENCE peripherique_id_peripherique_seq OWNED BY peripherique.id;


--
-- Name: peripherique_id_se_seq; Type: SEQUENCE; Schema: public; Owner: sultano
--

CREATE SEQUENCE peripherique_id_se_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.peripherique_id_se_seq OWNER TO sultano;

--
-- Name: peripherique_id_se_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sultano
--

ALTER SEQUENCE peripherique_id_se_seq OWNED BY peripherique.id_se;


--
-- Name: profit_dev; Type: VIEW; Schema: public; Owner: sultano
--

CREATE VIEW profit_dev AS
    SELECT application.id_developpeur, sum((application.num_telechargements * application.prix)) AS profit FROM application GROUP BY application.id_developpeur;


ALTER TABLE public.profit_dev OWNER TO sultano;

--
-- Name: systeme_exploitation; Type: TABLE; Schema: public; Owner: sultano; Tablespace: 
--

CREATE TABLE systeme_exploitation (
    id integer NOT NULL,
    nom character varying(20) NOT NULL,
    version real NOT NULL,
    CONSTRAINT systeme_exploitation_id_se_check CHECK ((id >= 0)),
    CONSTRAINT systeme_exploitation_version_check CHECK ((version >= (0)::double precision))
);


ALTER TABLE public.systeme_exploitation OWNER TO sultano;

--
-- Name: systeme_exploitation_id_se_seq; Type: SEQUENCE; Schema: public; Owner: sultano
--

CREATE SEQUENCE systeme_exploitation_id_se_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.systeme_exploitation_id_se_seq OWNER TO sultano;

--
-- Name: systeme_exploitation_id_se_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sultano
--

ALTER SEQUENCE systeme_exploitation_id_se_seq OWNED BY systeme_exploitation.id;


--
-- Name: telechargement; Type: TABLE; Schema: public; Owner: sultano; Tablespace: 
--

CREATE TABLE telechargement (
    id_user integer,
    id_application integer,
    id_peripherique integer,
    date date NOT NULL,
    id integer NOT NULL
);


ALTER TABLE public.telechargement OWNER TO sultano;

--
-- Name: telechargement_id_seq; Type: SEQUENCE; Schema: public; Owner: sultano
--

CREATE SEQUENCE telechargement_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.telechargement_id_seq OWNER TO sultano;

--
-- Name: telechargement_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sultano
--

ALTER SEQUENCE telechargement_id_seq OWNED BY telechargement.id;


--
-- Name: utilisateur; Type: TABLE; Schema: public; Owner: sultano; Tablespace: 
--

CREATE TABLE utilisateur (
    id integer NOT NULL,
    mail character varying(50) NOT NULL,
    mot_de_passe character varying(50) NOT NULL,
    num_install integer DEFAULT 0,
    type integer,
    nom character varying(50) NOT NULL,
    prenom character varying(50) NOT NULL,
    CONSTRAINT user_id_user_check CHECK ((id >= 0)),
    CONSTRAINT user_num_install_check CHECK ((num_install >= 0)),
    CONSTRAINT utilisateur_type_check CHECK (((type >= 0) AND (type <= 3)))
);


ALTER TABLE public.utilisateur OWNER TO sultano;

--
-- Name: user_id_user_seq; Type: SEQUENCE; Schema: public; Owner: sultano
--

CREATE SEQUENCE user_id_user_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.user_id_user_seq OWNER TO sultano;

--
-- Name: user_id_user_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sultano
--

ALTER SEQUENCE user_id_user_seq OWNED BY utilisateur.id;


--
-- Name: v_per_app; Type: VIEW; Schema: public; Owner: sultano
--

CREATE VIEW v_per_app AS
    SELECT telechargement.id_peripherique, telechargement.id_application, peripherique.nom AS nom_peripherique, application.nom AS nom_application FROM ((telechargement JOIN peripherique ON ((telechargement.id_peripherique = peripherique.id))) RIGHT JOIN application ON ((telechargement.id_application = application.id)));


ALTER TABLE public.v_per_app OWNER TO sultano;

--
-- Name: id; Type: DEFAULT; Schema: public; Owner: sultano
--

ALTER TABLE ONLY application ALTER COLUMN id SET DEFAULT nextval('application_id_application_seq'::regclass);


--
-- Name: id_avis; Type: DEFAULT; Schema: public; Owner: sultano
--

ALTER TABLE ONLY avis ALTER COLUMN id_avis SET DEFAULT nextval('avis_id_avis_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: sultano
--

ALTER TABLE ONLY info_payement ALTER COLUMN id SET DEFAULT nextval('info_payement_id_compte_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: sultano
--

ALTER TABLE ONLY mot_cle ALTER COLUMN id SET DEFAULT nextval('mot_cle_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: sultano
--

ALTER TABLE ONLY peripherique ALTER COLUMN id SET DEFAULT nextval('peripherique_id_peripherique_seq'::regclass);


--
-- Name: id_se; Type: DEFAULT; Schema: public; Owner: sultano
--

ALTER TABLE ONLY peripherique ALTER COLUMN id_se SET DEFAULT nextval('peripherique_id_se_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: sultano
--

ALTER TABLE ONLY systeme_exploitation ALTER COLUMN id SET DEFAULT nextval('systeme_exploitation_id_se_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: sultano
--

ALTER TABLE ONLY telechargement ALTER COLUMN id SET DEFAULT nextval('telechargement_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: sultano
--

ALTER TABLE ONLY utilisateur ALTER COLUMN id SET DEFAULT nextval('user_id_user_seq'::regclass);


--
-- Data for Name: application; Type: TABLE DATA; Schema: public; Owner: sultano
--

COPY application (id, nom, prix, abonnement, num_telechargements, droits, categorie, mela, version, id_developpeur) FROM stdin;
1	Sed nec metus	107	t	107	5	jeux	9	4	129
2	pede nec	665	t	665	5	info	111	5	113
3	tristique pharetra. Quisque ac	232	t	232	6	jeux	441	1	241
4	Vestibulum ante ipsum	370	f	370	13	info	51	8	185
5	congue turpis. In condimentum.	543	f	543	15	autre	744	3	68
6	euismod urna. Nullam lobortis	321	f	321	14	utilitaire	917	10	274
7	tristique pellentesque, tellus	375	f	375	9	utilitaire	931	6	21
8	sodales. Mauris blandit	168	f	168	4	jeux	875	2	54
9	Phasellus dapibus quam	242	f	242	9	autre	97	6	134
10	risus.	478	f	478	1	info	820	2	155
11	pede sagittis	295	f	295	14	autre	678	8	60
12	ullamcorper	58	f	58	6	info	521	5	152
13	Integer sem elit, pharetra	148	f	148	10	utilitaire	188	3	134
14	auctor, nunc nulla	771	f	771	2	info	189	7	152
15	tristique pharetra. Quisque ac	232	t	232	6	jeux	441	4	241
16	augue scelerisque mollis.	918	f	918	11	jeux	567	8	146
17	mauris eu elit. Nulla	583	f	583	7	utilitaire	111	4	262
18	ut nisi a odio	556	f	556	0	jeux	335	2	143
19	nibh enim,	670	t	670	4	utilitaire	259	2	188
20	Pellentesque tincidunt tempus risus.	44	f	44	11	jeux	144	3	181
21	nunc nulla vulputate dui,	8	t	8	6	jeux	413	6	61
22	risus.	478	f	478	1	info	820	9	155
23	vulputate,	301	f	301	2	jeux	220	10	19
24	arcu. Vestibulum ut	106	t	106	11	jeux	721	2	143
25	tristique pellentesque, tellus	375	f	375	9	utilitaire	931	5	21
26	arcu. Curabitur ut odio	569	f	569	15	autre	397	10	260
27	ligula	593	f	593	10	jeux	905	1	239
28	arcu. Curabitur ut odio	569	f	569	15	autre	397	10	260
29	odio semper cursus. Integer	466	f	466	10	utilitaire	315	1	22
30	nibh. Phasellus nulla.	894	f	894	6	utilitaire	225	9	226
31	auctor, nunc nulla	771	f	771	2	info	189	1	152
32	pede nec	665	t	665	5	info	111	6	113
33	nibh enim,	670	t	670	4	utilitaire	259	2	188
34	sociis natoque penatibus et	61	f	61	6	utilitaire	557	2	247
35	quis massa.	791	f	791	6	info	280	7	297
36	semper, dui	14	f	14	6	info	616	6	174
37	eros non	505	f	505	3	utilitaire	986	1	196
38	eros non	505	f	505	3	utilitaire	986	1	196
39	dignissim lacus. Aliquam	663	f	663	0	jeux	669	10	260
40	dui. Fusce aliquam,	677	f	677	10	autre	259	6	277
41	Suspendisse commodo	94	f	94	2	jeux	670	8	105
42	metus sit amet	155	f	155	3	autre	806	4	107
43	Vestibulum ante ipsum	370	f	370	13	info	51	3	185
44	Pellentesque tincidunt tempus risus.	44	f	44	11	jeux	144	5	181
45	orci quis	895	t	895	12	autre	614	5	176
46	at pede.	666	f	666	1	autre	417	8	11
47	ut nisi a odio	556	f	556	0	jeux	335	2	143
48	eleifend egestas. Sed	465	f	465	14	jeux	956	5	267
49	in, cursus et, eros.	559	f	559	2	autre	398	2	276
50	auctor, nunc nulla	771	f	771	2	info	189	1	152
51	auctor, nunc nulla	771	f	771	2	info	189	1	152
52	orci quis	895	t	895	12	autre	614	8	176
53	in, cursus et, eros.	559	f	559	2	autre	398	8	276
54	urna. Ut tincidunt vehicula	530	f	530	9	info	187	4	271
55	Suspendisse	935	t	935	8	info	97	9	228
56	arcu. Vestibulum ut	106	t	106	11	jeux	721	9	143
57	ullamcorper	58	f	58	6	info	521	10	152
58	eros non	505	f	505	3	utilitaire	986	6	196
59	sociis natoque penatibus et	61	f	61	6	utilitaire	557	2	247
60	mollis nec, cursus	165	t	165	8	utilitaire	862	3	297
61	auctor, nunc nulla	771	f	771	2	info	189	2	152
62	risus.	478	f	478	1	info	820	2	155
63	in faucibus orci luctus	759	f	759	0	utilitaire	850	9	207
64	Pellentesque tincidunt tempus risus.	44	f	44	11	jeux	144	3	181
65	enim	754	f	754	13	utilitaire	571	4	115
66	augue id ante dictum	291	t	291	4	info	216	4	17
67	augue ac ipsum.	559	f	559	12	utilitaire	424	7	174
68	sociis natoque penatibus et	61	f	61	6	utilitaire	557	2	247
69	bibendum. Donec	577	t	577	12	utilitaire	314	6	46
70	vel pede	242	f	242	12	info	559	10	240
71	in faucibus orci luctus	759	f	759	0	utilitaire	850	10	207
72	dolor elit, pellentesque	881	f	881	11	autre	423	6	189
73	rutrum lorem ac	695	f	695	10	jeux	533	2	279
74	bibendum. Donec	577	t	577	12	utilitaire	314	4	46
75	molestie	911	f	911	3	utilitaire	121	10	77
76	sociis natoque penatibus	713	f	713	11	autre	873	9	45
77	dolor dolor, tempus	345	f	345	1	info	943	4	266
78	sociis natoque penatibus et	61	f	61	6	utilitaire	557	10	247
79	sociosqu ad	461	f	461	14	utilitaire	116	8	155
80	sociis natoque penatibus	713	f	713	11	autre	873	9	45
81	Sed nec metus	107	t	107	5	jeux	9	3	129
82	malesuada	814	f	814	5	info	489	6	164
83	euismod et, commodo at,	344	f	344	10	jeux	920	8	142
84	arcu. Curabitur ut odio	569	f	569	15	autre	397	10	260
85	sociis natoque penatibus	713	f	713	11	autre	873	9	45
86	auctor, nunc nulla	771	f	771	2	info	189	2	152
87	augue id ante dictum	291	t	291	4	info	216	5	17
88	rutrum lorem ac	695	f	695	10	jeux	533	4	279
89	non lorem	840	f	840	7	jeux	517	3	116
90	mauris eu elit. Nulla	583	f	583	7	utilitaire	111	4	262
91	ut, molestie in,	174	f	174	15	utilitaire	187	5	251
92	gravida nunc sed pede.	179	f	179	11	jeux	629	5	7
93	turpis non enim.	884	t	884	12	info	51	3	239
94	arcu.	215	t	215	7	jeux	1	5	190
95	orci tincidunt adipiscing.	710	f	710	12	utilitaire	920	5	173
96	risus.	478	f	478	1	info	820	2	155
97	risus.	478	f	478	1	info	820	9	155
98	Aliquam erat	164	f	164	0	jeux	10	2	291
99	Duis	546	f	546	4	info	377	8	231
100	nibh enim, gravida sit	214	t	214	10	jeux	624	1	206
101	penatibus et	388	f	388	14	jeux	329	2	269
102	in, cursus et, eros.	559	f	559	2	autre	398	8	276
103	congue turpis. In condimentum.	543	f	543	15	autre	744	3	68
104	turpis non enim.	884	t	884	12	info	51	3	239
105	bibendum. Donec	577	t	577	12	utilitaire	314	4	46
106	scelerisque mollis. Phasellus libero	658	t	658	12	jeux	694	5	282
107	dolor dolor, tempus	345	f	345	1	info	943	1	266
108	augue ac ipsum.	559	f	559	12	utilitaire	424	7	174
109	congue	18	f	18	5	autre	214	7	163
110	eros non	505	f	505	3	utilitaire	986	6	196
111	euismod urna. Nullam lobortis	321	f	321	14	utilitaire	917	10	274
112	orci tincidunt adipiscing.	710	f	710	12	utilitaire	920	3	173
113	augue ac ipsum.	559	f	559	12	utilitaire	424	7	174
114	bibendum. Donec	577	t	577	12	utilitaire	314	3	46
115	lorem, vehicula et,	598	f	598	1	autre	116	9	24
116	Integer sem elit, pharetra	148	f	148	10	utilitaire	188	9	134
117	augue malesuada malesuada. Integer	893	f	893	13	utilitaire	405	3	139
118	orci tincidunt adipiscing.	710	f	710	12	utilitaire	920	5	173
119	sodales. Mauris blandit	168	f	168	4	jeux	875	6	54
120	enim	754	f	754	13	utilitaire	571	4	115
121	mollis nec, cursus	165	t	165	8	utilitaire	862	3	297
122	tristique pellentesque, tellus	375	f	375	9	utilitaire	931	6	21
123	Donec feugiat metus sit	302	f	302	14	utilitaire	252	1	82
124	enim	754	f	754	13	utilitaire	571	4	115
125	nisi	497	f	497	3	info	658	8	145
126	sociis natoque penatibus	713	f	713	11	autre	873	7	45
127	Suspendisse	935	t	935	8	info	97	9	228
128	Phasellus dapibus quam	242	f	242	9	autre	97	7	134
129	augue scelerisque mollis.	918	f	918	11	jeux	567	10	146
130	nibh. Phasellus nulla.	894	f	894	6	utilitaire	225	10	226
131	odio semper cursus. Integer	466	f	466	10	utilitaire	315	1	22
132	Duis	546	f	546	4	info	377	10	231
133	ullamcorper	58	f	58	6	info	521	5	152
134	Suspendisse	935	t	935	8	info	97	9	228
135	tristique pharetra. Quisque ac	232	t	232	6	jeux	441	3	241
136	amet, dapibus	452	f	452	4	utilitaire	244	2	67
137	enim	754	f	754	13	utilitaire	571	6	115
138	et malesuada	2	f	2	1	utilitaire	941	8	35
139	eleifend egestas. Sed	465	f	465	14	jeux	956	6	267
140	at pede.	666	f	666	1	autre	417	8	11
141	Phasellus dapibus quam	242	f	242	9	autre	97	6	134
142	arcu. Vestibulum ut	106	t	106	11	jeux	721	5	143
143	urna. Ut tincidunt vehicula	530	f	530	9	info	187	4	271
144	molestie	911	f	911	3	utilitaire	121	10	77
145	enim	754	f	754	13	utilitaire	571	6	115
146	ornare. Fusce mollis. Duis	39	f	39	2	jeux	283	7	209
147	nibh. Phasellus nulla.	894	f	894	6	utilitaire	225	10	226
148	nec, mollis	863	f	863	10	info	24	9	197
149	non lorem	840	f	840	7	jeux	517	3	116
150	arcu.	215	t	215	7	jeux	1	5	190
151	augue scelerisque mollis.	918	f	918	11	jeux	567	10	146
152	arcu.	865	f	865	9	utilitaire	279	4	50
153	et ultrices posuere cubilia	697	f	697	7	utilitaire	983	7	169
154	ullamcorper	58	f	58	6	info	521	10	152
155	arcu.	215	t	215	7	jeux	1	5	190
156	Aliquam erat	164	f	164	0	jeux	10	4	291
157	ornare. Fusce mollis. Duis	39	f	39	2	jeux	283	1	209
158	semper, dui	14	f	14	6	info	616	6	174
159	Donec feugiat metus sit	302	f	302	14	utilitaire	252	1	82
160	orci quis	895	t	895	12	autre	614	5	176
161	Duis	546	f	546	4	info	377	8	231
162	orci quis	895	t	895	12	autre	614	8	176
163	risus.	478	f	478	1	info	820	2	155
164	pede nec	665	t	665	5	info	111	6	113
248	pede sagittis	295	f	295	14	autre	678	8	60
165	nibh. Phasellus nulla.	894	f	894	6	utilitaire	225	10	226
166	eleifend egestas.	301	f	301	13	info	173	4	274
167	Pellentesque tincidunt tempus risus.	44	f	44	11	jeux	144	5	181
168	in, cursus et, eros.	559	f	559	2	autre	398	2	276
169	habitant morbi tristique senectus	155	f	155	11	autre	210	2	12
170	bibendum. Donec	577	t	577	12	utilitaire	314	4	46
171	Donec feugiat metus sit	302	f	302	14	utilitaire	252	1	82
172	habitant morbi tristique senectus	155	f	155	11	autre	210	2	12
173	in, cursus et, eros.	559	f	559	2	autre	398	8	276
174	vitae	769	f	769	7	jeux	416	10	298
175	ut ipsum	505	f	505	2	jeux	640	8	205
176	ut, molestie in,	174	f	174	15	utilitaire	187	8	251
177	Aliquam erat	164	f	164	0	jeux	10	4	291
178	orci tincidunt adipiscing.	710	f	710	12	utilitaire	920	8	173
179	Duis	546	f	546	4	info	377	10	231
180	lorem, vehicula et,	598	f	598	1	autre	116	9	24
181	Vestibulum ante ipsum	370	f	370	13	info	51	3	185
182	Phasellus dapibus quam	242	f	242	9	autre	97	3	134
183	Duis	546	f	546	4	info	377	10	231
184	urna. Ut tincidunt vehicula	530	f	530	9	info	187	3	271
185	pede nec	665	t	665	5	info	111	4	113
186	eros non	505	f	505	3	utilitaire	986	6	196
187	rutrum lorem ac	695	f	695	10	jeux	533	4	279
188	arcu.	865	f	865	9	utilitaire	279	6	50
189	nibh. Phasellus nulla.	894	f	894	6	utilitaire	225	10	226
190	congue	18	f	18	5	autre	214	7	163
191	tristique pharetra. Quisque ac	232	t	232	6	jeux	441	8	241
192	lorem, vehicula et,	598	f	598	1	autre	116	9	24
193	molestie	911	f	911	3	utilitaire	121	10	77
194	penatibus et	388	f	388	14	jeux	329	4	269
195	orci tincidunt adipiscing.	710	f	710	12	utilitaire	920	5	173
196	et malesuada	2	f	2	1	utilitaire	941	8	35
197	bibendum	278	t	278	11	utilitaire	505	2	214
198	turpis non enim.	884	t	884	12	info	51	3	239
199	ante, iaculis nec, eleifend	332	t	332	2	autre	748	10	120
200	augue ac ipsum.	559	f	559	12	utilitaire	424	6	174
201	arcu.	215	t	215	7	jeux	1	5	190
202	Suspendisse commodo	94	f	94	2	jeux	670	2	105
203	risus.	478	f	478	1	info	820	9	155
204	ut ipsum	505	f	505	2	jeux	640	1	205
205	pede nec	665	t	665	5	info	111	5	113
206	bibendum	278	t	278	11	utilitaire	505	2	214
207	lorem, vehicula et,	598	f	598	1	autre	116	6	24
208	augue id ante dictum	291	t	291	4	info	216	4	17
209	risus.	478	f	478	1	info	820	10	155
210	rutrum lorem ac	695	f	695	10	jeux	533	4	279
211	rutrum lorem ac	695	f	695	10	jeux	533	2	279
212	eleifend egestas.	301	f	301	13	info	173	4	274
213	enim	754	f	754	13	utilitaire	571	5	115
214	mauris eu elit. Nulla	583	f	583	7	utilitaire	111	4	262
215	enim	754	f	754	13	utilitaire	571	5	115
216	vitae	769	f	769	7	jeux	416	10	298
217	pede nec	665	t	665	5	info	111	6	113
218	euismod et, commodo at,	344	f	344	10	jeux	920	8	142
219	quis massa.	791	f	791	6	info	280	9	297
220	congue turpis. In condimentum.	543	f	543	15	autre	744	8	68
221	malesuada	814	f	814	5	info	489	5	164
222	dolor dolor, tempus	345	f	345	1	info	943	1	266
223	ut, molestie in,	174	f	174	15	utilitaire	187	5	251
224	ipsum	194	f	194	14	info	779	6	188
225	ante, iaculis nec, eleifend	332	t	332	2	autre	748	7	120
226	eleifend egestas. Sed	465	f	465	14	jeux	956	5	267
227	risus.	478	f	478	1	info	820	6	155
228	Integer sem elit, pharetra	148	f	148	10	utilitaire	188	8	134
229	tristique pellentesque, tellus	375	f	375	9	utilitaire	931	8	21
230	arcu. Vestibulum ut	106	t	106	11	jeux	721	5	143
231	auctor, nunc nulla	771	f	771	2	info	189	1	152
232	euismod urna. Nullam lobortis	321	f	321	14	utilitaire	917	10	274
233	orci tincidunt adipiscing.	710	f	710	12	utilitaire	920	8	173
234	enim	754	f	754	13	utilitaire	571	10	115
235	arcu. Curabitur ut odio	569	f	569	15	autre	397	10	260
236	ut, molestie in,	174	f	174	15	utilitaire	187	7	251
237	arcu. Curabitur ut odio	569	f	569	15	autre	397	9	260
238	ornare. Fusce mollis. Duis	39	f	39	2	jeux	283	7	209
239	ad	742	f	742	4	utilitaire	774	9	221
240	sociosqu ad	461	f	461	14	utilitaire	116	8	155
241	malesuada	814	f	814	5	info	489	5	164
242	enim	754	f	754	13	utilitaire	571	6	115
243	imperdiet, erat nonummy ultricies	702	t	702	9	info	357	4	179
244	augue id ante dictum	291	t	291	4	info	216	5	17
245	arcu. Vestibulum ut	106	t	106	11	jeux	721	5	143
246	Suspendisse commodo	94	f	94	2	jeux	670	8	105
247	risus.	478	f	478	1	info	820	2	155
249	nibh enim,	670	t	670	4	utilitaire	259	8	188
250	vel pede	242	f	242	12	info	559	10	240
251	Sed nec metus	107	t	107	5	jeux	9	4	129
252	nibh enim, gravida sit	214	t	214	10	jeux	624	1	206
253	urna. Ut tincidunt vehicula	530	f	530	9	info	187	10	271
254	euismod urna. Nullam lobortis	321	f	321	14	utilitaire	917	10	274
255	Phasellus dapibus quam	242	f	242	9	autre	97	3	134
256	Integer sem elit, pharetra	148	f	148	10	utilitaire	188	4	134
257	nibh enim, gravida sit	214	t	214	10	jeux	624	1	206
258	orci tincidunt adipiscing.	710	f	710	12	utilitaire	920	1	173
259	euismod urna. Nullam lobortis	321	f	321	14	utilitaire	917	10	274
260	nibh enim,	670	t	670	4	utilitaire	259	2	188
261	gravida nunc sed pede.	179	f	179	11	jeux	629	4	7
262	tristique pharetra. Quisque ac	232	t	232	6	jeux	441	1	241
263	dolor elit, pellentesque	881	f	881	11	autre	423	6	189
264	bibendum. Donec	577	t	577	12	utilitaire	314	8	46
265	nisi	497	f	497	3	info	658	8	145
266	in, cursus et, eros.	559	f	559	2	autre	398	2	276
267	quis massa.	791	f	791	6	info	280	9	297
268	bibendum. Donec	577	t	577	12	utilitaire	314	6	46
269	rutrum lorem ac	695	f	695	10	jeux	533	4	279
270	eleifend egestas. Sed	465	f	465	14	jeux	956	6	267
271	Suspendisse commodo	94	f	94	2	jeux	670	8	105
272	nibh enim, gravida sit	214	t	214	10	jeux	624	1	206
273	nibh enim,	670	t	670	4	utilitaire	259	8	188
274	molestie	911	f	911	3	utilitaire	121	3	77
275	sodales. Mauris blandit	168	f	168	4	jeux	875	6	54
276	luctus	191	f	191	8	autre	632	10	261
277	eleifend egestas. Sed	465	f	465	14	jeux	956	5	267
278	ligula	593	f	593	10	jeux	905	5	239
279	nibh enim, gravida sit	214	t	214	10	jeux	624	1	206
280	augue ac ipsum.	559	f	559	12	utilitaire	424	7	174
281	ipsum	194	f	194	14	info	779	6	188
282	congue turpis. In condimentum.	543	f	543	15	autre	744	8	68
283	ut, molestie in,	174	f	174	15	utilitaire	187	8	251
284	arcu. Curabitur ut odio	569	f	569	15	autre	397	9	260
285	sodales. Mauris blandit	168	f	168	4	jeux	875	6	54
286	in faucibus orci luctus	759	f	759	0	utilitaire	850	3	207
287	in faucibus orci luctus	759	f	759	0	utilitaire	850	4	207
288	et malesuada	2	f	2	1	utilitaire	941	8	35
289	augue ac ipsum.	559	f	559	12	utilitaire	424	6	174
290	auctor, nunc nulla	771	f	771	2	info	189	4	152
291	sodales. Mauris blandit	168	f	168	4	jeux	875	6	54
292	Duis	546	f	546	4	info	377	10	231
293	Duis	546	f	546	4	info	377	8	231
294	bibendum. Donec	577	t	577	12	utilitaire	314	4	46
295	scelerisque mollis. Phasellus libero	658	t	658	12	jeux	694	8	282
296	congue turpis. In condimentum.	543	f	543	15	autre	744	8	68
297	pede nec	665	t	665	5	info	111	4	113
298	vestibulum. Mauris magna.	538	t	538	5	info	352	4	134
299	penatibus et	388	f	388	14	jeux	329	10	269
300	amet, dapibus	452	f	452	4	utilitaire	244	2	67
301	mauris eu elit. Nulla	583	f	583	7	utilitaire	111	2	262
302	pede nec	665	t	665	5	info	111	5	113
303	ligula	593	f	593	10	jeux	905	6	239
304	gravida mauris	426	f	426	6	jeux	798	9	294
305	luctus	191	f	191	8	autre	632	7	261
306	bibendum	278	t	278	11	utilitaire	505	2	214
307	dui. Fusce aliquam,	677	f	677	10	autre	259	6	277
308	imperdiet, erat nonummy ultricies	702	t	702	9	info	357	1	179
309	Donec	188	t	188	10	utilitaire	237	8	154
310	in faucibus orci luctus	759	f	759	0	utilitaire	850	10	207
311	ligula	593	f	593	10	jeux	905	6	239
312	ante, iaculis nec, eleifend	332	t	332	2	autre	748	10	120
313	sociis natoque penatibus	713	f	713	11	autre	873	7	45
314	Donec	188	t	188	10	utilitaire	237	4	154
315	vitae	769	f	769	7	jeux	416	9	298
316	nec, mollis	863	f	863	10	info	24	9	197
317	sociis natoque penatibus	713	f	713	11	autre	873	9	45
318	eros non	505	f	505	3	utilitaire	986	6	196
319	arcu. Vestibulum ut	106	t	106	11	jeux	721	5	143
320	nibh enim,	670	t	670	4	utilitaire	259	2	188
321	quis massa.	791	f	791	6	info	280	7	297
322	auctor, nunc nulla	771	f	771	2	info	189	6	152
323	nibh enim,	670	t	670	4	utilitaire	259	8	188
324	orci tincidunt adipiscing.	710	f	710	12	utilitaire	920	5	173
325	arcu.	215	t	215	7	jeux	1	6	190
326	urna. Ut tincidunt vehicula	530	f	530	9	info	187	6	271
327	gravida nunc sed pede.	179	f	179	11	jeux	629	1	7
328	enim	754	f	754	13	utilitaire	571	9	115
329	arcu.	865	f	865	9	utilitaire	279	4	50
330	arcu.	215	t	215	7	jeux	1	5	190
331	risus.	478	f	478	1	info	820	10	155
332	nisi	497	f	497	3	info	658	8	145
333	tristique pellentesque, tellus	375	f	375	9	utilitaire	931	8	21
334	pede nec	665	t	665	5	info	111	5	113
335	mollis nec, cursus	165	t	165	8	utilitaire	862	2	297
336	eleifend egestas. Sed	465	f	465	14	jeux	956	6	267
337	rutrum lorem ac	695	f	695	10	jeux	533	8	279
338	nec, mollis	863	f	863	10	info	24	8	197
339	ut, molestie in,	174	f	174	15	utilitaire	187	8	251
340	tristique pellentesque, tellus	375	f	375	9	utilitaire	931	5	21
341	eleifend egestas.	301	f	301	13	info	173	7	274
342	Duis	546	f	546	4	info	377	10	231
343	ornare. Fusce mollis. Duis	39	f	39	2	jeux	283	7	209
344	Suspendisse commodo	94	f	94	2	jeux	670	8	105
345	orci quis	895	t	895	12	autre	614	8	176
346	nibh enim,	670	t	670	4	utilitaire	259	5	188
347	augue malesuada malesuada. Integer	893	f	893	13	utilitaire	405	3	139
348	Pellentesque tincidunt tempus risus.	44	f	44	11	jeux	144	3	181
349	augue ac ipsum.	559	f	559	12	utilitaire	424	6	174
350	arcu. Vestibulum ut	106	t	106	11	jeux	721	2	143
351	vestibulum. Mauris magna.	538	t	538	5	info	352	4	134
352	Donec	188	t	188	10	utilitaire	237	8	154
353	nibh enim, gravida sit	214	t	214	10	jeux	624	1	206
354	nibh enim, gravida sit	214	t	214	10	jeux	624	4	206
355	metus sit amet	155	f	155	3	autre	806	4	107
356	turpis non enim.	884	t	884	12	info	51	1	239
357	in faucibus orci luctus	759	f	759	0	utilitaire	850	10	207
358	mauris eu elit. Nulla	583	f	583	7	utilitaire	111	4	262
359	vestibulum nec,	368	f	368	0	info	99	1	271
360	eleifend egestas.	301	f	301	13	info	173	3	274
361	turpis non enim.	884	t	884	12	info	51	1	239
362	auctor, nunc nulla	771	f	771	2	info	189	7	152
363	urna. Ut tincidunt vehicula	530	f	530	9	info	187	3	271
364	orci tincidunt adipiscing.	710	f	710	12	utilitaire	920	6	173
365	risus.	478	f	478	1	info	820	10	155
366	tristique pellentesque, tellus	375	f	375	9	utilitaire	931	6	21
367	tristique pellentesque, tellus	375	f	375	9	utilitaire	931	6	21
368	euismod et, commodo at,	344	f	344	10	jeux	920	8	142
369	auctor, nunc nulla	771	f	771	2	info	189	1	152
370	mollis nec, cursus	165	t	165	8	utilitaire	862	6	297
371	scelerisque mollis. Phasellus libero	658	t	658	12	jeux	694	8	282
372	nec, mollis	863	f	863	10	info	24	9	197
373	ut nisi a odio	556	f	556	0	jeux	335	2	143
374	auctor, nunc nulla	771	f	771	2	info	189	2	152
375	bibendum. Donec	577	t	577	12	utilitaire	314	4	46
376	augue ac ipsum.	559	f	559	12	utilitaire	424	6	174
377	arcu.	865	f	865	9	utilitaire	279	4	50
378	orci tincidunt adipiscing.	710	f	710	12	utilitaire	920	3	173
379	arcu. Curabitur ut odio	569	f	569	15	autre	397	4	260
380	metus sit amet	155	f	155	3	autre	806	4	107
381	mauris eu elit. Nulla	583	f	583	7	utilitaire	111	4	262
382	mollis nec, cursus	165	t	165	8	utilitaire	862	3	297
383	euismod et, commodo at,	344	f	344	10	jeux	920	8	142
384	arcu.	215	t	215	7	jeux	1	6	190
385	dolor dolor, tempus	345	f	345	1	info	943	6	266
386	arcu.	865	f	865	9	utilitaire	279	6	50
387	tristique pellentesque, tellus	375	f	375	9	utilitaire	931	8	21
388	congue turpis. In condimentum.	543	f	543	15	autre	744	3	68
389	eleifend egestas. Sed	465	f	465	14	jeux	956	6	267
390	Integer sem elit, pharetra	148	f	148	10	utilitaire	188	3	134
391	Integer sem elit, pharetra	148	f	148	10	utilitaire	188	8	134
392	augue id ante dictum	291	t	291	4	info	216	5	17
393	Donec	188	t	188	10	utilitaire	237	4	154
394	nonummy	86	t	86	7	info	170	4	142
395	eleifend egestas.	301	f	301	13	info	173	7	274
396	Phasellus dapibus quam	242	f	242	9	autre	97	5	134
397	et malesuada	2	f	2	1	utilitaire	941	4	35
398	euismod urna. Nullam lobortis	321	f	321	14	utilitaire	917	10	274
399	ipsum	194	f	194	14	info	779	7	188
400	mollis nec, cursus	165	t	165	8	utilitaire	862	6	297
401	ante, iaculis nec, eleifend	332	t	332	2	autre	748	7	120
402	malesuada	814	f	814	5	info	489	6	164
403	in faucibus orci luctus	759	f	759	0	utilitaire	850	4	207
404	ipsum	194	f	194	14	info	779	5	188
405	nibh enim,	670	t	670	4	utilitaire	259	4	188
406	rutrum lorem ac	695	f	695	10	jeux	533	2	279
407	In scelerisque scelerisque dui.	872	f	872	1	autre	729	2	196
408	Phasellus dapibus quam	242	f	242	9	autre	97	7	134
409	orci tincidunt adipiscing.	710	f	710	12	utilitaire	920	3	173
410	eleifend egestas. Sed	465	f	465	14	jeux	956	5	267
411	tristique pellentesque, tellus	375	f	375	9	utilitaire	931	7	21
412	nibh. Phasellus nulla.	894	f	894	6	utilitaire	225	9	226
413	Vestibulum ante ipsum	370	f	370	13	info	51	8	185
414	semper, dui	14	f	14	6	info	616	6	174
415	arcu.	215	t	215	7	jeux	1	6	190
416	rutrum lorem ac	695	f	695	10	jeux	533	4	279
417	et malesuada	2	f	2	1	utilitaire	941	4	35
418	turpis non enim.	884	t	884	12	info	51	1	239
419	nec, mollis	863	f	863	10	info	24	9	197
420	malesuada	814	f	814	5	info	489	7	164
421	In scelerisque scelerisque dui.	872	f	872	1	autre	729	4	196
422	Integer sem elit, pharetra	148	f	148	10	utilitaire	188	8	134
423	ante, iaculis nec, eleifend	332	t	332	2	autre	748	7	120
424	semper, dui	14	f	14	6	info	616	6	174
425	malesuada	814	f	814	5	info	489	7	164
426	Duis	546	f	546	4	info	377	8	231
427	vel pede	242	f	242	12	info	559	10	240
428	in faucibus orci luctus	759	f	759	0	utilitaire	850	10	207
429	augue ac ipsum.	559	f	559	12	utilitaire	424	7	174
430	Sed nec metus	107	t	107	5	jeux	9	3	129
431	vitae	769	f	769	7	jeux	416	9	298
432	risus.	478	f	478	1	info	820	6	155
433	velit. Quisque varius. Nam	605	f	605	12	jeux	594	5	55
434	bibendum. Donec	577	t	577	12	utilitaire	314	3	46
435	Aliquam erat	164	f	164	0	jeux	10	2	291
436	auctor, nunc nulla	771	f	771	2	info	189	1	152
437	dolor dolor, tempus	345	f	345	1	info	943	4	266
438	habitant morbi tristique senectus	155	f	155	11	autre	210	2	12
439	vestibulum. Mauris magna.	538	t	538	5	info	352	4	134
440	turpis non enim.	884	t	884	12	info	51	8	239
441	vulputate,	301	f	301	2	jeux	220	5	19
442	ut ipsum	505	f	505	2	jeux	640	8	205
443	ligula	593	f	593	10	jeux	905	1	239
444	nonummy	86	t	86	7	info	170	4	142
445	ornare. Fusce mollis. Duis	39	f	39	2	jeux	283	7	209
446	eros non	505	f	505	3	utilitaire	986	10	196
447	ut ipsum	505	f	505	2	jeux	640	1	205
448	euismod urna. Nullam lobortis	321	f	321	14	utilitaire	917	10	274
449	Pellentesque tincidunt tempus risus.	44	f	44	11	jeux	144	3	181
450	nunc nulla vulputate dui,	8	t	8	6	jeux	413	4	61
451	risus.	478	f	478	1	info	820	2	155
452	molestie	911	f	911	3	utilitaire	121	10	77
453	sodales. Mauris blandit	168	f	168	4	jeux	875	6	54
454	arcu. Vestibulum ut	106	t	106	11	jeux	721	10	143
455	pede nec	665	t	665	5	info	111	4	113
456	Integer sem elit, pharetra	148	f	148	10	utilitaire	188	3	134
457	augue id ante dictum	291	t	291	4	info	216	5	17
458	augue ac ipsum.	559	f	559	12	utilitaire	424	7	174
459	tristique pellentesque, tellus	375	f	375	9	utilitaire	931	6	21
460	augue ac ipsum.	559	f	559	12	utilitaire	424	7	174
461	pede sagittis	295	f	295	14	autre	678	8	60
462	risus.	478	f	478	1	info	820	10	155
463	Phasellus	622	f	622	2	utilitaire	7	5	127
464	Integer sem elit, pharetra	148	f	148	10	utilitaire	188	4	134
465	euismod urna. Nullam lobortis	321	f	321	14	utilitaire	917	10	274
466	orci tincidunt adipiscing.	710	f	710	12	utilitaire	920	8	173
467	Phasellus dapibus quam	242	f	242	9	autre	97	6	134
468	gravida nunc sed pede.	179	f	179	11	jeux	629	8	7
469	Suspendisse commodo	94	f	94	2	jeux	670	8	105
470	turpis non enim.	884	t	884	12	info	51	8	239
471	rutrum lorem ac	695	f	695	10	jeux	533	4	279
472	auctor, nunc nulla	771	f	771	2	info	189	6	152
473	auctor, nunc nulla	771	f	771	2	info	189	2	152
474	luctus	191	f	191	8	autre	632	1	261
475	arcu.	865	f	865	9	utilitaire	279	4	50
476	Pellentesque tincidunt tempus risus.	44	f	44	11	jeux	144	5	181
477	dignissim lacus. Aliquam	663	f	663	0	jeux	669	10	260
478	amet, dapibus	452	f	452	4	utilitaire	244	6	67
479	sociis natoque penatibus et	61	f	61	6	utilitaire	557	10	247
480	Sed nec metus	107	t	107	5	jeux	9	4	129
481	Suspendisse	935	t	935	8	info	97	9	228
482	orci tincidunt adipiscing.	710	f	710	12	utilitaire	920	8	173
483	turpis non enim.	884	t	884	12	info	51	3	239
484	ut ipsum	505	f	505	2	jeux	640	1	205
485	vulputate,	301	f	301	2	jeux	220	2	19
486	Proin	809	f	809	11	info	681	3	9
487	urna. Ut tincidunt vehicula	530	f	530	9	info	187	6	271
488	eleifend egestas. Sed	465	f	465	14	jeux	956	6	267
489	in faucibus orci luctus	759	f	759	0	utilitaire	850	9	207
490	Duis	546	f	546	4	info	377	8	231
491	in, cursus et, eros.	559	f	559	2	autre	398	2	276
492	eleifend egestas. Sed	465	f	465	14	jeux	956	10	267
493	orci quis	895	t	895	12	autre	614	5	176
494	Duis	546	f	546	4	info	377	8	231
495	nibh. Phasellus nulla.	894	f	894	6	utilitaire	225	10	226
496	nisi	497	f	497	3	info	658	8	145
497	orci quis	895	t	895	12	autre	614	1	176
498	Integer sem elit, pharetra	148	f	148	10	utilitaire	188	4	134
499	Duis	546	f	546	4	info	377	8	231
500	vestibulum. Mauris magna.	538	t	538	5	info	352	7	134
501	est. Mauris	836	f	836	8	utilitaire	886	1	22
502	Duis a mi fringilla	741	f	741	12	jeux	496	1	126
503	scelerisque mollis. Phasellus libero	658	t	658	12	jeux	694	3	282
504	vel pede	242	f	242	12	info	559	8	240
505	Integer sem elit, pharetra	148	f	148	10	utilitaire	188	1	134
506	Donec feugiat metus sit	302	f	302	14	utilitaire	252	5	82
507	eros non	505	f	505	3	utilitaire	986	4	196
508	semper, dui	14	f	14	6	info	616	9	174
509	arcu. Vestibulum ut	106	t	106	11	jeux	721	10	143
510	nibh enim,	670	t	670	4	utilitaire	259	6	188
511	pede sagittis	295	f	295	14	autre	678	3	60
512	orci tincidunt adipiscing.	710	f	710	12	utilitaire	920	8	173
513	ullamcorper	58	f	58	6	info	521	5	152
514	In scelerisque scelerisque dui.	872	f	872	1	autre	729	4	196
515	dolor elit, pellentesque	881	f	881	11	autre	423	8	189
516	Proin	809	f	809	11	info	681	3	9
517	orci tincidunt adipiscing.	710	f	710	12	utilitaire	920	4	173
518	sodales. Mauris blandit	168	f	168	4	jeux	875	2	54
519	arcu. Curabitur ut odio	569	f	569	15	autre	397	1	260
520	sociis natoque penatibus	713	f	713	11	autre	873	9	45
521	arcu.	865	f	865	9	utilitaire	279	6	50
522	arcu. Vestibulum ut	106	t	106	11	jeux	721	9	143
523	quis massa.	791	f	791	6	info	280	4	297
524	in faucibus orci luctus	759	f	759	0	utilitaire	850	3	207
525	gravida nunc sed pede.	179	f	179	11	jeux	629	1	7
526	velit. Quisque varius. Nam	605	f	605	12	jeux	594	4	55
527	Phasellus	622	f	622	2	utilitaire	7	2	127
528	ligula	593	f	593	10	jeux	905	5	239
529	sociosqu ad	461	f	461	14	utilitaire	116	8	155
530	dui. Fusce aliquam,	677	f	677	10	autre	259	7	277
531	pede sagittis	295	f	295	14	autre	678	4	60
532	lorem, vehicula et,	598	f	598	1	autre	116	9	24
533	ultrices	764	f	764	10	autre	39	8	202
534	est.	912	f	912	8	utilitaire	527	9	14
535	sodales. Mauris blandit	168	f	168	4	jeux	875	2	54
536	molestie	911	f	911	3	utilitaire	121	7	77
537	nec, mollis	863	f	863	10	info	24	7	197
538	augue id ante dictum	291	t	291	4	info	216	4	17
539	nonummy	86	t	86	7	info	170	2	142
540	Donec	188	t	188	10	utilitaire	237	10	154
541	Suspendisse	935	t	935	8	info	97	9	228
542	ut, molestie in,	174	f	174	15	utilitaire	187	3	251
543	dignissim lacus. Aliquam	663	f	663	0	jeux	669	1	260
544	nunc nulla vulputate dui,	8	t	8	6	jeux	413	1	61
545	penatibus et	388	f	388	14	jeux	329	4	269
546	dignissim lacus. Aliquam	663	f	663	0	jeux	669	1	260
547	augue scelerisque mollis.	918	f	918	11	jeux	567	3	146
548	pede nec	665	t	665	5	info	111	4	113
549	ad	742	f	742	4	utilitaire	774	8	221
550	pede nec	665	t	665	5	info	111	5	113
551	bibendum. Donec	577	t	577	12	utilitaire	314	1	46
552	augue id ante dictum	291	t	291	4	info	216	3	17
553	Phasellus dapibus quam	242	f	242	9	autre	97	3	134
554	eleifend egestas.	301	f	301	13	info	173	1	274
555	sodales. Mauris blandit	168	f	168	4	jeux	875	9	54
556	odio semper cursus. Integer	466	f	466	10	utilitaire	315	7	22
557	et malesuada	2	f	2	1	utilitaire	941	1	35
558	euismod et, commodo at,	344	f	344	10	jeux	920	8	142
559	Donec feugiat metus sit	302	f	302	14	utilitaire	252	4	82
560	est.	912	f	912	8	utilitaire	527	1	14
\.


--
-- Name: application_id_application_seq; Type: SEQUENCE SET; Schema: public; Owner: sultano
--

SELECT pg_catalog.setval('application_id_application_seq', 560, true);


--
-- Data for Name: avis; Type: TABLE DATA; Schema: public; Owner: sultano
--

COPY avis (elstar, commentaire, id_avis, id_user, id_application) FROM stdin;
5	ligula. Aenean gravida nunc sed pede. Cum sociis natoque	1	1	252
2	Vivamus nibh dolor,	2	2	401
5	vel,	3	3	93
0	ante blandit	4	4	430
1	sagittis.	5	5	354
4	Morbi metus.	6	6	344
2	parturient montes, nascetur ridiculus mus.	7	7	244
1	et	8	8	453
0	nulla. Integer vulputate, risus a ultricies adipiscing, enim mi	9	9	429
2	primis in	10	10	125
0	arcu. Aliquam ultrices iaculis odio. Nam	11	11	174
1	pulvinar arcu et	12	12	34
3	litora torquent per	13	13	397
4	vel turpis. Aliquam	14	14	188
5	vel,	15	15	292
4	et tristique pellentesque, tellus sem mollis dui, in sodales	16	16	184
5	eu erat semper rutrum.	17	17	357
5	Ut sagittis lobortis	18	18	472
1	Etiam bibendum fermentum metus. Aenean sed pede nec	19	19	6
4	in sodales elit erat vitae	20	20	511
1	non, egestas a, dui. Cras pellentesque. Sed	21	21	12
1	primis in	22	22	475
1	mauris. Suspendisse aliquet molestie tellus.	23	23	269
2	Praesent luctus. Curabitur egestas nunc sed libero. Proin sed	24	24	123
3	parturient montes, nascetur ridiculus mus.	25	25	522
1	nunc id enim. Curabitur massa.	26	26	169
0	nunc	27	27	128
4	nunc id enim. Curabitur massa.	28	28	456
1	posuere vulputate, lacus. Cras interdum. Nunc sollicitudin commodo ipsum. Suspendisse	29	29	149
5	luctus. Curabitur egestas nunc sed	30	30	65
3	vel turpis. Aliquam	31	31	158
4	Vivamus nibh dolor,	32	32	351
1	Etiam bibendum fermentum metus. Aenean sed pede nec	33	33	208
5	conubia nostra, per inceptos hymenaeos. Mauris ut	34	34	192
3	Aenean massa. Integer vitae nibh. Donec est mauris, rhoncus id,	35	35	25
1	aliquam iaculis, lacus pede sagittis	36	36	13
0	nec, euismod in, dolor. Fusce	37	37	555
1	nec, euismod in, dolor. Fusce	38	38	213
5	nisi sem semper erat, in consectetuer ipsum nunc id	39	39	476
3	fermentum arcu. Vestibulum	40	40	485
2	sed pede. Cum sociis natoque penatibus	41	41	478
5	quam, elementum at, egestas a, scelerisque sed, sapien. Nunc pulvinar	42	42	41
2	ante blandit	43	43	129
4	in sodales elit erat vitae	44	44	118
3	dignissim pharetra. Nam ac nulla.	45	45	33
4	In lorem. Donec elementum, lorem ut aliquam	46	46	31
5	Ut sagittis lobortis	47	47	286
5	elit. Aliquam auctor, velit eget laoreet posuere,	48	48	508
3	Duis	49	49	375
1	vel turpis. Aliquam	50	50	164
1	vel turpis. Aliquam	51	51	171
2	dignissim pharetra. Nam ac nulla.	52	52	316
5	Duis	53	53	172
2	nec, mollis vitae, posuere at, velit. Cras lorem	54	54	243
4	orci quis lectus.	55	55	130
1	Praesent luctus. Curabitur egestas nunc sed libero. Proin sed	56	56	360
2	pulvinar arcu et	57	57	112
2	nec, euismod in, dolor. Fusce	58	58	397
3	conubia nostra, per inceptos hymenaeos. Mauris ut	59	59	163
4	tellus sem	60	60	383
1	vel turpis. Aliquam	61	61	298
3	primis in	62	62	34
0	Aenean massa. Integer	63	63	128
4	in sodales elit erat vitae	64	64	154
1	quam a felis ullamcorper viverra. Maecenas iaculis aliquet diam. Sed	65	65	439
1	pede. Nunc	66	66	424
1	malesuada. Integer id magna et ipsum cursus vestibulum. Mauris	67	67	154
0	conubia nostra, per inceptos hymenaeos. Mauris ut	68	68	419
1	enim. Mauris quis turpis vitae purus gravida	69	69	482
3	nec tempus scelerisque, lorem ipsum sodales purus, in	70	70	475
2	Aenean massa. Integer	71	71	405
1	sapien. Cras dolor dolor, tempus non, lacinia at,	72	72	403
3	eu tellus. Phasellus elit	73	73	184
5	enim. Mauris quis turpis vitae purus gravida	74	74	278
5	Mauris blandit enim consequat purus. Maecenas libero est, congue	75	75	238
0	iaculis, lacus	76	76	281
3	Donec nibh enim, gravida sit	77	77	255
5	conubia nostra, per inceptos hymenaeos. Mauris ut	78	78	47
0	aliquam	79	79	52
4	iaculis, lacus	80	80	45
1	ligula. Aenean gravida nunc sed pede. Cum sociis natoque	81	81	55
2	sit	82	82	85
3	magna. Nam ligula elit,	83	83	384
1	nunc id enim. Curabitur massa.	84	84	243
1	iaculis, lacus	85	85	187
1	vel turpis. Aliquam	86	86	260
4	pede. Nunc	87	87	373
3	eu tellus. Phasellus elit	88	88	488
3	cursus et, eros. Proin ultrices. Duis	89	89	348
3	eu erat semper rutrum.	90	90	17
1	libero et tristique	91	91	47
4	Sed congue,	92	92	512
1	Donec tempor, est ac mattis semper, dui	93	93	388
1	id sapien. Cras dolor	94	94	267
3	egestas	95	95	213
0	primis in	96	96	293
2	primis in	97	97	517
0	cursus non, egestas a, dui.	98	98	315
5	Quisque libero lacus, varius et, euismod et,	99	99	254
0	mi tempor	100	100	148
1	nibh vulputate mauris sagittis	101	101	250
4	Duis	102	102	533
2	sagittis.	103	103	235
3	Donec tempor, est ac mattis semper, dui	104	104	473
1	enim. Mauris quis turpis vitae purus gravida	105	105	412
0	Integer urna. Vivamus	106	106	456
5	Donec nibh enim, gravida sit	107	107	502
2	malesuada. Integer id magna et ipsum cursus vestibulum. Mauris	108	108	175
2	Proin dolor.	109	109	460
3	nec, euismod in, dolor. Fusce	110	110	28
3	Morbi metus.	111	111	464
4	egestas	112	112	394
2	malesuada. Integer id magna et ipsum cursus vestibulum. Mauris	113	113	456
5	enim. Mauris quis turpis vitae purus gravida	114	114	500
5	Fusce mollis. Duis sit amet	115	115	379
1	litora torquent per	116	116	539
5	vestibulum	117	117	532
4	egestas	118	118	542
0	et	119	119	86
4	quam a felis ullamcorper viverra. Maecenas iaculis aliquet diam. Sed	120	120	441
1	tellus sem	121	121	372
0	parturient montes, nascetur ridiculus mus.	122	122	69
4	sapien, gravida non, sollicitudin a, malesuada id,	123	123	286
1	quam a felis ullamcorper viverra. Maecenas iaculis aliquet diam. Sed	124	124	226
5	amet luctus vulputate, nisi sem semper erat, in	125	125	340
4	iaculis, lacus	126	126	397
5	orci quis lectus.	127	127	211
1	nulla. Integer vulputate, risus a ultricies adipiscing, enim mi	128	128	550
1	et tristique pellentesque, tellus sem mollis dui, in sodales	129	129	76
1	luctus. Curabitur egestas nunc sed	130	130	156
4	posuere vulputate, lacus. Cras interdum. Nunc sollicitudin commodo ipsum. Suspendisse	131	131	357
0	Quisque libero lacus, varius et, euismod et,	132	132	134
1	pulvinar arcu et	133	133	168
0	orci quis lectus.	134	134	13
3	vel,	135	135	411
0	eleifend, nunc risus varius	136	136	81
3	quam a felis ullamcorper viverra. Maecenas iaculis aliquet diam. Sed	137	137	515
1	ac turpis egestas. Aliquam fringilla cursus purus. Nullam	138	138	131
2	elit. Aliquam auctor, velit eget laoreet posuere,	139	139	479
2	In lorem. Donec elementum, lorem ut aliquam	140	140	502
2	nulla. Integer vulputate, risus a ultricies adipiscing, enim mi	141	141	450
4	Praesent luctus. Curabitur egestas nunc sed libero. Proin sed	142	142	261
0	nec, mollis vitae, posuere at, velit. Cras lorem	143	143	31
0	Mauris blandit enim consequat purus. Maecenas libero est, congue	144	144	195
3	quam a felis ullamcorper viverra. Maecenas iaculis aliquet diam. Sed	145	145	334
4	non, sollicitudin	146	146	14
0	luctus. Curabitur egestas nunc sed	147	147	81
1	dolor sit amet, consectetuer adipiscing elit.	148	148	469
4	cursus et, eros. Proin ultrices. Duis	149	149	28
5	id sapien. Cras dolor	150	150	109
5	et tristique pellentesque, tellus sem mollis dui, in sodales	151	151	239
0	vestibulum	152	152	358
1	dolor	153	153	95
1	pulvinar arcu et	154	154	254
3	id sapien. Cras dolor	155	155	242
2	cursus non, egestas a, dui.	156	156	326
5	non, sollicitudin	157	157	288
4	aliquam iaculis, lacus pede sagittis	158	158	512
5	sapien, gravida non, sollicitudin a, malesuada id,	159	159	312
5	dignissim pharetra. Nam ac nulla.	160	160	415
3	Quisque libero lacus, varius et, euismod et,	161	161	118
0	dignissim pharetra. Nam ac nulla.	162	162	342
2	primis in	163	163	18
2	Vivamus nibh dolor,	164	164	467
4	luctus. Curabitur egestas nunc sed	165	165	542
3	ipsum. Suspendisse non leo. Vivamus nibh dolor, nonummy	166	166	69
3	in sodales elit erat vitae	167	167	50
4	Duis	168	168	294
0	justo. Proin non massa non ante bibendum ullamcorper.	169	169	348
5	enim. Mauris quis turpis vitae purus gravida	170	170	524
5	sapien, gravida non, sollicitudin a, malesuada id,	171	171	403
3	justo. Proin non massa non ante bibendum ullamcorper.	172	172	436
1	Duis	173	173	25
5	Donec vitae erat vel pede blandit congue. In scelerisque	174	174	127
2	sem elit, pharetra ut, pharetra sed, hendrerit a, arcu.	175	175	447
0	libero et tristique	176	176	305
3	cursus non, egestas a, dui.	177	177	98
4	egestas	178	178	376
3	Quisque libero lacus, varius et, euismod et,	179	179	246
3	Fusce mollis. Duis sit amet	180	180	522
4	ante blandit	181	181	300
5	nulla. Integer vulputate, risus a ultricies adipiscing, enim mi	182	182	24
0	Quisque libero lacus, varius et, euismod et,	183	183	388
0	nec, mollis vitae, posuere at, velit. Cras lorem	184	184	50
0	Vivamus nibh dolor,	185	185	539
1	nec, euismod in, dolor. Fusce	186	186	288
3	eu tellus. Phasellus elit	187	187	375
2	vestibulum	188	188	558
3	luctus. Curabitur egestas nunc sed	189	189	503
5	Proin dolor.	190	190	341
1	vel,	191	191	345
4	Fusce mollis. Duis sit amet	192	192	316
3	Mauris blandit enim consequat purus. Maecenas libero est, congue	193	193	332
1	nibh vulputate mauris sagittis	194	194	156
0	egestas	195	195	71
5	ac turpis egestas. Aliquam fringilla cursus purus. Nullam	196	196	120
2	ac, feugiat	197	197	315
1	Donec tempor, est ac mattis semper, dui	198	198	533
2	eu arcu. Morbi	199	199	243
4	malesuada. Integer id magna et ipsum cursus vestibulum. Mauris	200	200	176
3	id sapien. Cras dolor	201	201	116
1	sed pede. Cum sociis natoque penatibus	202	202	1
5	primis in	203	203	178
3	sem elit, pharetra ut, pharetra sed, hendrerit a, arcu.	204	204	142
0	Vivamus nibh dolor,	205	205	362
0	ac, feugiat	206	206	145
3	Fusce mollis. Duis sit amet	207	207	537
2	pede. Nunc	208	208	56
1	primis in	209	209	304
4	eu tellus. Phasellus elit	210	210	426
4	eu tellus. Phasellus elit	211	211	273
1	ipsum. Suspendisse non leo. Vivamus nibh dolor, nonummy	212	212	490
5	quam a felis ullamcorper viverra. Maecenas iaculis aliquet diam. Sed	213	213	158
3	eu erat semper rutrum.	214	214	44
4	quam a felis ullamcorper viverra. Maecenas iaculis aliquet diam. Sed	215	215	314
0	Donec vitae erat vel pede blandit congue. In scelerisque	216	216	149
0	Vivamus nibh dolor,	217	217	118
1	magna. Nam ligula elit,	218	218	308
3	Aenean massa. Integer vitae nibh. Donec est mauris, rhoncus id,	219	219	380
1	sagittis.	220	220	9
4	sit	221	221	268
2	Donec nibh enim, gravida sit	222	222	526
5	libero et tristique	223	223	453
4	ornare, libero	224	224	9
2	eu arcu. Morbi	225	225	57
4	elit. Aliquam auctor, velit eget laoreet posuere,	226	226	497
3	primis in	227	227	481
5	litora torquent per	228	228	10
1	parturient montes, nascetur ridiculus mus.	229	229	516
2	Praesent luctus. Curabitur egestas nunc sed libero. Proin sed	230	230	120
0	vel turpis. Aliquam	231	231	194
3	Morbi metus.	232	232	526
1	egestas	233	233	414
5	quam a felis ullamcorper viverra. Maecenas iaculis aliquet diam. Sed	234	234	308
1	nunc id enim. Curabitur massa.	235	235	329
4	libero et tristique	236	236	123
5	nunc id enim. Curabitur massa.	237	237	235
0	non, sollicitudin	238	238	102
5	diam luctus lobortis. Class aptent taciti	239	239	173
1	aliquam	240	240	240
4	sit	241	241	232
0	quam a felis ullamcorper viverra. Maecenas iaculis aliquet diam. Sed	242	242	72
1	congue. In scelerisque scelerisque dui. Suspendisse ac metus vitae velit	243	243	12
3	pede. Nunc	244	244	268
2	Praesent luctus. Curabitur egestas nunc sed libero. Proin sed	245	245	476
0	sed pede. Cum sociis natoque penatibus	246	246	26
0	primis in	247	247	276
4	arcu. Aliquam ultrices iaculis odio. Nam	248	248	95
5	Etiam bibendum fermentum metus. Aenean sed pede nec	249	249	369
0	nec tempus scelerisque, lorem ipsum sodales purus, in	250	250	4
5	ligula. Aenean gravida nunc sed pede. Cum sociis natoque	251	251	224
5	mi tempor	252	252	135
3	nec, mollis vitae, posuere at, velit. Cras lorem	253	253	96
0	Morbi metus.	254	254	176
3	nulla. Integer vulputate, risus a ultricies adipiscing, enim mi	255	255	367
1	litora torquent per	256	256	161
2	mi tempor	257	257	246
4	egestas	258	258	79
2	Morbi metus.	259	259	347
3	Etiam bibendum fermentum metus. Aenean sed pede nec	260	260	487
5	Sed congue,	261	261	15
5	vel,	262	262	84
5	sapien. Cras dolor dolor, tempus non, lacinia at,	263	263	124
2	enim. Mauris quis turpis vitae purus gravida	264	264	126
2	amet luctus vulputate, nisi sem semper erat, in	265	265	70
5	Duis	266	266	332
4	Aenean massa. Integer vitae nibh. Donec est mauris, rhoncus id,	267	267	69
0	enim. Mauris quis turpis vitae purus gravida	268	268	18
0	eu tellus. Phasellus elit	269	269	428
1	elit. Aliquam auctor, velit eget laoreet posuere,	270	270	152
2	sed pede. Cum sociis natoque penatibus	271	271	402
2	mi tempor	272	272	508
4	Etiam bibendum fermentum metus. Aenean sed pede nec	273	273	487
0	Mauris blandit enim consequat purus. Maecenas libero est, congue	274	274	215
0	et	275	275	243
2	neque et nunc. Quisque ornare	276	276	197
0	elit. Aliquam auctor, velit eget laoreet posuere,	277	277	143
3	nunc	278	278	259
2	mi tempor	279	279	307
3	malesuada. Integer id magna et ipsum cursus vestibulum. Mauris	280	280	548
4	ornare, libero	281	281	489
3	sagittis.	282	282	398
0	libero et tristique	283	283	343
5	nunc id enim. Curabitur massa.	284	284	169
2	et	285	285	216
2	Aenean massa. Integer	286	286	89
5	Aenean massa. Integer	287	287	24
4	ac turpis egestas. Aliquam fringilla cursus purus. Nullam	288	288	287
0	malesuada. Integer id magna et ipsum cursus vestibulum. Mauris	289	289	344
4	vel turpis. Aliquam	290	290	177
4	et	291	291	495
5	Quisque libero lacus, varius et, euismod et,	292	292	363
0	Quisque libero lacus, varius et, euismod et,	293	293	253
0	enim. Mauris quis turpis vitae purus gravida	294	294	338
3	Integer urna. Vivamus	295	295	524
3	sagittis.	296	296	108
2	Vivamus nibh dolor,	297	297	441
3	lobortis tellus	298	298	528
5	nibh vulputate mauris sagittis	299	299	533
5	eleifend, nunc risus varius	300	300	402
5	eu erat semper rutrum.	301	125	543
2	Vivamus nibh dolor,	302	68	192
3	nunc	303	258	203
1	erat. Etiam vestibulum massa	304	50	160
1	neque et nunc. Quisque ornare	305	157	191
5	ac, feugiat	306	240	489
3	fermentum arcu. Vestibulum	307	85	159
5	congue. In scelerisque scelerisque dui. Suspendisse ac metus vitae velit	308	275	405
1	enim. Suspendisse aliquet, sem ut cursus	309	2	63
1	Aenean massa. Integer	310	233	459
5	nunc	311	217	13
3	eu arcu. Morbi	312	13	236
4	iaculis, lacus	313	247	205
0	enim. Suspendisse aliquet, sem ut cursus	314	19	452
1	Donec vitae erat vel pede blandit congue. In scelerisque	315	93	101
5	dolor sit amet, consectetuer adipiscing elit.	316	122	227
0	iaculis, lacus	317	23	397
4	nec, euismod in, dolor. Fusce	318	41	81
3	Praesent luctus. Curabitur egestas nunc sed libero. Proin sed	319	242	400
0	Etiam bibendum fermentum metus. Aenean sed pede nec	320	34	154
2	Aenean massa. Integer vitae nibh. Donec est mauris, rhoncus id,	321	264	375
3	vel turpis. Aliquam	322	290	86
0	Etiam bibendum fermentum metus. Aenean sed pede nec	323	70	58
2	egestas	324	206	36
3	id sapien. Cras dolor	325	41	218
5	nec, mollis vitae, posuere at, velit. Cras lorem	326	48	241
1	Sed congue,	327	81	326
5	quam a felis ullamcorper viverra. Maecenas iaculis aliquet diam. Sed	328	209	88
2	vestibulum	329	197	463
3	id sapien. Cras dolor	330	112	395
4	primis in	331	235	96
2	amet luctus vulputate, nisi sem semper erat, in	332	128	62
0	parturient montes, nascetur ridiculus mus.	333	17	519
4	Vivamus nibh dolor,	334	45	73
2	tellus sem	335	250	50
0	elit. Aliquam auctor, velit eget laoreet posuere,	336	189	5
4	eu tellus. Phasellus elit	337	53	497
3	dolor sit amet, consectetuer adipiscing elit.	338	76	61
0	libero et tristique	339	241	414
1	parturient montes, nascetur ridiculus mus.	340	29	332
4	ipsum. Suspendisse non leo. Vivamus nibh dolor, nonummy	341	110	518
4	Quisque libero lacus, varius et, euismod et,	342	20	26
0	non, sollicitudin	343	25	348
1	sed pede. Cum sociis natoque penatibus	344	243	147
2	dignissim pharetra. Nam ac nulla.	345	289	231
3	Etiam bibendum fermentum metus. Aenean sed pede nec	346	246	7
1	vestibulum	347	156	396
3	in sodales elit erat vitae	348	130	40
5	malesuada. Integer id magna et ipsum cursus vestibulum. Mauris	349	127	448
0	Praesent luctus. Curabitur egestas nunc sed libero. Proin sed	350	51	422
4	lobortis tellus	351	188	339
2	enim. Suspendisse aliquet, sem ut cursus	352	275	343
4	mi tempor	353	108	524
3	mi tempor	354	172	124
2	quam, elementum at, egestas a, scelerisque sed, sapien. Nunc pulvinar	355	36	261
0	Donec tempor, est ac mattis semper, dui	356	45	45
5	Aenean massa. Integer	357	176	140
0	eu erat semper rutrum.	358	94	518
0	ridiculus mus. Proin vel nisl. Quisque fringilla euismod enim.	359	110	273
1	ipsum. Suspendisse non leo. Vivamus nibh dolor, nonummy	360	230	338
5	Donec tempor, est ac mattis semper, dui	361	126	96
2	vel turpis. Aliquam	362	189	82
0	nec, mollis vitae, posuere at, velit. Cras lorem	363	140	209
5	egestas	364	56	209
2	primis in	365	139	274
0	parturient montes, nascetur ridiculus mus.	366	42	268
0	parturient montes, nascetur ridiculus mus.	367	28	516
2	magna. Nam ligula elit,	368	41	152
4	vel turpis. Aliquam	369	94	188
5	tellus sem	370	221	452
0	Integer urna. Vivamus	371	166	14
2	dolor sit amet, consectetuer adipiscing elit.	372	180	371
3	Ut sagittis lobortis	373	9	58
5	vel turpis. Aliquam	374	270	537
3	enim. Mauris quis turpis vitae purus gravida	375	187	152
4	malesuada. Integer id magna et ipsum cursus vestibulum. Mauris	376	93	312
4	vestibulum	377	145	142
0	egestas	378	7	545
0	nunc id enim. Curabitur massa.	379	4	203
2	quam, elementum at, egestas a, scelerisque sed, sapien. Nunc pulvinar	380	128	42
5	eu erat semper rutrum.	381	232	187
3	tellus sem	382	240	418
0	magna. Nam ligula elit,	383	174	477
2	id sapien. Cras dolor	384	277	245
2	Donec nibh enim, gravida sit	385	204	221
1	vestibulum	386	198	214
1	parturient montes, nascetur ridiculus mus.	387	291	227
3	sagittis.	388	94	3
4	elit. Aliquam auctor, velit eget laoreet posuere,	389	291	425
2	litora torquent per	390	192	95
3	litora torquent per	391	211	558
0	pede. Nunc	392	78	71
4	enim. Suspendisse aliquet, sem ut cursus	393	222	550
0	porttitor scelerisque neque. Nullam	394	248	432
3	ipsum. Suspendisse non leo. Vivamus nibh dolor, nonummy	395	196	214
3	nulla. Integer vulputate, risus a ultricies adipiscing, enim mi	396	98	346
1	ac turpis egestas. Aliquam fringilla cursus purus. Nullam	397	33	86
5	Morbi metus.	398	69	245
1	ornare, libero	399	237	484
5	tellus sem	400	86	131
1	eu arcu. Morbi	401	267	366
4	sit	402	171	159
1	Aenean massa. Integer	403	234	377
5	ornare, libero	404	19	346
2	Etiam bibendum fermentum metus. Aenean sed pede nec	405	2	60
4	eu tellus. Phasellus elit	406	110	460
4	egestas blandit. Nam nulla magna, malesuada vel, convallis	407	39	559
5	nulla. Integer vulputate, risus a ultricies adipiscing, enim mi	408	13	496
1	egestas	409	74	390
3	elit. Aliquam auctor, velit eget laoreet posuere,	410	67	166
4	parturient montes, nascetur ridiculus mus.	411	221	170
3	luctus. Curabitur egestas nunc sed	412	163	98
2	ante blandit	413	273	387
0	aliquam iaculis, lacus pede sagittis	414	141	247
4	id sapien. Cras dolor	415	274	528
5	eu tellus. Phasellus elit	416	42	69
0	ac turpis egestas. Aliquam fringilla cursus purus. Nullam	417	258	393
1	Donec tempor, est ac mattis semper, dui	418	35	511
3	dolor sit amet, consectetuer adipiscing elit.	419	257	82
4	sit	420	21	417
1	egestas blandit. Nam nulla magna, malesuada vel, convallis	421	255	275
5	litora torquent per	422	89	493
3	eu arcu. Morbi	423	209	380
2	aliquam iaculis, lacus pede sagittis	424	3	368
0	sit	425	230	57
3	Quisque libero lacus, varius et, euismod et,	426	85	449
2	nec tempus scelerisque, lorem ipsum sodales purus, in	427	277	21
4	Aenean massa. Integer	428	19	238
0	malesuada. Integer id magna et ipsum cursus vestibulum. Mauris	429	76	288
1	ligula. Aenean gravida nunc sed pede. Cum sociis natoque	430	164	531
4	Donec vitae erat vel pede blandit congue. In scelerisque	431	165	424
3	primis in	432	97	220
5	at augue id ante	433	230	180
3	enim. Mauris quis turpis vitae purus gravida	434	64	23
3	cursus non, egestas a, dui.	435	21	298
2	vel turpis. Aliquam	436	294	78
2	Donec nibh enim, gravida sit	437	194	383
0	justo. Proin non massa non ante bibendum ullamcorper.	438	220	91
3	lobortis tellus	439	281	10
5	Donec tempor, est ac mattis semper, dui	440	296	161
2	mauris. Suspendisse aliquet molestie tellus.	441	177	71
2	sem elit, pharetra ut, pharetra sed, hendrerit a, arcu.	442	131	336
5	nunc	443	168	68
0	porttitor scelerisque neque. Nullam	444	202	199
4	non, sollicitudin	445	183	14
2	nec, euismod in, dolor. Fusce	446	78	553
4	sem elit, pharetra ut, pharetra sed, hendrerit a, arcu.	447	257	201
4	Morbi metus.	448	245	51
5	in sodales elit erat vitae	449	150	82
3	non, egestas a, dui. Cras pellentesque. Sed	450	36	350
4	primis in	451	37	342
2	Mauris blandit enim consequat purus. Maecenas libero est, congue	452	10	522
2	et	453	97	265
1	Praesent luctus. Curabitur egestas nunc sed libero. Proin sed	454	270	417
1	Vivamus nibh dolor,	455	220	329
3	litora torquent per	456	1	411
3	pede. Nunc	457	19	137
0	malesuada. Integer id magna et ipsum cursus vestibulum. Mauris	458	25	417
0	parturient montes, nascetur ridiculus mus.	459	82	2
3	malesuada. Integer id magna et ipsum cursus vestibulum. Mauris	460	57	409
0	arcu. Aliquam ultrices iaculis odio. Nam	461	143	77
4	primis in	462	224	323
4	Nunc mauris. Morbi non sapien molestie orci tincidunt adipiscing.	463	106	79
1	litora torquent per	464	60	525
4	Morbi metus.	465	20	404
0	egestas	466	98	321
3	nulla. Integer vulputate, risus a ultricies adipiscing, enim mi	467	13	478
5	Sed congue,	468	74	165
0	sed pede. Cum sociis natoque penatibus	469	126	290
3	Donec tempor, est ac mattis semper, dui	470	175	61
5	eu tellus. Phasellus elit	471	13	264
5	vel turpis. Aliquam	472	255	98
5	vel turpis. Aliquam	473	151	366
3	neque et nunc. Quisque ornare	474	298	111
5	vestibulum	475	152	146
0	in sodales elit erat vitae	476	94	395
1	nisi sem semper erat, in consectetuer ipsum nunc id	477	155	149
1	eleifend, nunc risus varius	478	239	555
2	conubia nostra, per inceptos hymenaeos. Mauris ut	479	251	252
4	ligula. Aenean gravida nunc sed pede. Cum sociis natoque	480	294	31
4	orci quis lectus.	481	7	379
3	egestas	482	272	461
0	Donec tempor, est ac mattis semper, dui	483	149	472
5	sem elit, pharetra ut, pharetra sed, hendrerit a, arcu.	484	229	135
5	mauris. Suspendisse aliquet molestie tellus.	485	85	395
3	malesuada fringilla est.	486	268	482
0	nec, mollis vitae, posuere at, velit. Cras lorem	487	195	225
4	elit. Aliquam auctor, velit eget laoreet posuere,	488	132	156
3	Aenean massa. Integer	489	40	271
5	Quisque libero lacus, varius et, euismod et,	490	111	504
1	Duis	491	47	449
1	elit. Aliquam auctor, velit eget laoreet posuere,	492	144	392
2	dignissim pharetra. Nam ac nulla.	493	29	39
4	Quisque libero lacus, varius et, euismod et,	494	77	33
1	luctus. Curabitur egestas nunc sed	495	269	350
1	amet luctus vulputate, nisi sem semper erat, in	496	154	63
3	dignissim pharetra. Nam ac nulla.	497	213	431
0	litora torquent per	498	157	360
1	Quisque libero lacus, varius et, euismod et,	499	284	504
0	lobortis tellus	500	212	286
5	Nunc ullamcorper,	501	9	184
3	enim. Etiam gravida molestie arcu. Sed eu nibh vulputate	502	189	346
0	Integer urna. Vivamus	503	41	72
5	nec tempus scelerisque, lorem ipsum sodales purus, in	504	167	394
5	litora torquent per	505	110	169
0	sapien, gravida non, sollicitudin a, malesuada id,	506	196	266
4	nec, euismod in, dolor. Fusce	507	59	494
4	aliquam iaculis, lacus pede sagittis	508	205	240
0	Praesent luctus. Curabitur egestas nunc sed libero. Proin sed	509	205	186
4	Etiam bibendum fermentum metus. Aenean sed pede nec	510	176	368
5	arcu. Aliquam ultrices iaculis odio. Nam	511	19	278
2	egestas	512	243	292
4	pulvinar arcu et	513	54	496
5	egestas blandit. Nam nulla magna, malesuada vel, convallis	514	265	70
3	sapien. Cras dolor dolor, tempus non, lacinia at,	515	124	238
5	malesuada fringilla est.	516	94	95
4	egestas	517	282	318
5	et	518	201	202
2	nunc id enim. Curabitur massa.	519	39	420
4	iaculis, lacus	520	206	67
3	vestibulum	521	28	441
1	Praesent luctus. Curabitur egestas nunc sed libero. Proin sed	522	229	319
1	Aenean massa. Integer vitae nibh. Donec est mauris, rhoncus id,	523	33	23
2	Aenean massa. Integer	524	244	373
2	Sed congue,	525	131	294
5	at augue id ante	526	212	250
0	Nunc mauris. Morbi non sapien molestie orci tincidunt adipiscing.	527	44	14
3	nunc	528	154	339
3	aliquam	529	119	198
2	fermentum arcu. Vestibulum	530	180	370
3	arcu. Aliquam ultrices iaculis odio. Nam	531	247	29
2	Fusce mollis. Duis sit amet	532	9	31
5	Cras	533	91	364
2	Sed diam lorem, auctor quis, tristique ac,	534	266	370
4	et	535	115	149
5	Mauris blandit enim consequat purus. Maecenas libero est, congue	536	229	450
1	dolor sit amet, consectetuer adipiscing elit.	537	37	445
4	pede. Nunc	538	211	122
0	porttitor scelerisque neque. Nullam	539	266	92
0	enim. Suspendisse aliquet, sem ut cursus	540	183	532
2	orci quis lectus.	541	91	239
0	libero et tristique	542	220	355
3	nisi sem semper erat, in consectetuer ipsum nunc id	543	40	538
3	non, egestas a, dui. Cras pellentesque. Sed	544	289	429
0	nibh vulputate mauris sagittis	545	248	191
1	nisi sem semper erat, in consectetuer ipsum nunc id	546	279	173
1	et tristique pellentesque, tellus sem mollis dui, in sodales	547	59	90
5	Vivamus nibh dolor,	548	35	354
3	diam luctus lobortis. Class aptent taciti	549	293	140
1	Vivamus nibh dolor,	550	58	407
1	enim. Mauris quis turpis vitae purus gravida	551	264	330
4	pede. Nunc	552	28	173
3	nulla. Integer vulputate, risus a ultricies adipiscing, enim mi	553	68	200
2	ipsum. Suspendisse non leo. Vivamus nibh dolor, nonummy	554	192	378
3	et	555	34	323
3	posuere vulputate, lacus. Cras interdum. Nunc sollicitudin commodo ipsum. Suspendisse	556	268	284
4	ac turpis egestas. Aliquam fringilla cursus purus. Nullam	557	253	3
5	magna. Nam ligula elit,	558	79	357
2	sapien, gravida non, sollicitudin a, malesuada id,	559	103	281
1	Sed diam lorem, auctor quis, tristique ac,	560	84	68
\.


--
-- Name: avis_id_avis_seq; Type: SEQUENCE SET; Schema: public; Owner: sultano
--

SELECT pg_catalog.setval('avis_id_avis_seq', 560, true);


--
-- Data for Name: info_payement; Type: TABLE DATA; Schema: public; Owner: sultano
--

COPY info_payement (type, id, num_compte, id_user) FROM stdin;
cb	2	3470079773381736	244
cb	3	327765938510625	143
cb	4	4901502048383326	37
cb	5	2685547619167657	253
cb	6	8496995412704563	162
cb	7	3617883535156632	100
cb	8	2980945421872455	257
cb	9	4302906945312511	200
cb	10	1596037389459984	228
cb	11	5163208527620777	155
cb	12	9757987297075681	283
cb	13	3705141575498284	273
cb	14	372514974079440	279
cb	15	4012561480875803	35
cb	16	4561069903909301	180
cb	17	7706793374681147	92
cb	18	3420889903737151	195
cb	19	6265704187869231	244
cb	20	9478254287461424	176
cb	21	6414151304767405	282
cb	22	4472619601854501	122
cb	23	3534619179210708	24
cb	24	5382304474288202	275
cb	25	8860862926536313	132
cb	26	2197833903682468	170
cb	27	5848401142480609	138
cb	28	2873141498353838	192
cb	29	9793041112050338	203
cb	30	3892628001979849	40
cb	31	3364570614470869	30
cb	32	2411452611101902	219
cb	33	4261586438281453	175
cb	34	4637465611972252	230
cb	35	7670933233917257	243
cb	36	4417809535216825	221
cb	37	1568201901841346	89
cb	38	8259343578209004	288
cb	39	755173296101037	298
cb	40	1338259159657623	82
cb	41	5897347866249708	148
cb	42	3728078276357006	96
cb	43	4611257958680584	127
cb	44	7667238726505976	40
cb	45	443194691301591	66
cb	46	8731148232008153	157
cb	47	3932162311537410	172
cb	48	9681835577530077	271
cb	49	8870541650700821	34
cb	50	7968915043731528	181
cb	51	2738718801917704	183
cb	52	8538730500061582	197
paypal	53	7089684718832993	140
cb	54	184643182744335	169
cb	55	5549173409571184	182
cb	56	4398419819929101	223
cb	57	618440484161601	137
cb	58	2334326246412483	104
cb	59	5690232570813741	119
cb	60	5133225690733716	65
cb	61	450423804427680	235
cb	62	1089994221774861	75
cb	63	1663068707803001	287
cb	64	8579359669850904	75
cb	65	5274096635804752	192
cb	66	7554539639056583	2
cb	67	3646236702961726	40
cb	68	143149708107461	50
cb	69	5865052225843957	98
cb	70	2232142899018594	44
cb	71	7677679439949983	101
cb	72	4105400337676443	60
cb	73	5529661738890203	265
cb	74	3099252681920583	143
cb	75	4630876459723169	132
cb	76	9595922619327881	252
cb	77	8514486703750600	60
cb	78	2353628788709956	111
cb	79	2621502498139931	201
cb	80	8176992531526889	20
cb	81	1035187876780710	203
cb	82	5085823492313213	245
cb	83	254836927533132	196
cb	84	9040740252204614	55
cb	85	2250022585666130	66
cb	86	6035964715067545	297
cb	87	9095493374140854	115
cb	88	821327172670589	40
cb	89	6313627275560718	154
cb	90	9901260707183815	50
paypal	91	3166817930442251	40
paypal	92	9590474663914221	272
paypal	93	2616650875086946	20
paypal	94	48594276005352	129
paypal	95	8113942384994263	256
paypal	96	8589505260041963	82
paypal	97	3140245331767516	50
paypal	98	5756037493844158	53
paypal	99	5084369784602964	197
paypal	100	2006512275409017	155
paypal	101	4422992189554854	154
paypal	102	5733384285930483	205
paypal	103	5258335681179500	265
paypal	104	8387405455445505	57
paypal	105	8947882871353281	4
paypal	106	1577121672293097	251
paypal	107	1764536514363339	47
paypal	108	7956664222313590	7
paypal	109	4235535575732403	15
paypal	110	4171744085494736	237
paypal	111	4715088803065582	218
paypal	112	621027586752479	5
paypal	113	6385060218113161	1
paypal	114	2933855271370911	134
paypal	115	7568934785375579	285
paypal	116	5873410968964412	192
paypal	117	9146032473640094	128
paypal	118	6253628727164792	5
paypal	119	3471809720010636	11
paypal	120	8870687157350707	251
paypal	121	2933020005010356	265
paypal	122	4965413499301595	274
paypal	123	7918419554245631	58
paypal	124	4709223796814166	108
paypal	125	1562683873148518	140
paypal	126	1711402919559616	283
paypal	127	3895740711309836	3
paypal	128	7808949933532096	244
paypal	129	3305592818091772	191
paypal	130	6098898075333090	38
paypal	131	5513147456566917	231
paypal	132	8752274866437099	98
paypal	133	4059716318188954	57
paypal	134	8949857753171238	29
paypal	135	570281385182225	46
paypal	1	638506021811316	117
paypal	136	1067022895129286	102
paypal	137	4443051283897903	204
paypal	138	6986408436167611	275
paypal	139	6044324124495183	234
paypal	140	4687394056247852	117
paypal	141	7943567352591071	241
paypal	142	6592127197941736	4
paypal	143	9038832906605987	248
paypal	144	1807665724171837	201
paypal	145	4468678583940233	127
paypal	146	4703197111456424	186
paypal	147	8155919926611181	143
paypal	148	212368000460386	273
paypal	149	5100584646503877	210
paypal	150	4754032707660	168
paypal	151	3594691859022032	164
paypal	152	8012293959014473	274
paypal	153	3029921234595396	186
paypal	154	5911923360755067	300
paypal	155	7864930546242351	219
paypal	156	5034218752205092	145
paypal	157	6481701311560015	20
paypal	158	2473320548000658	217
paypal	159	9960026137630987	83
paypal	160	374275230103090	31
paypal	161	2715589587319347	254
paypal	162	8376883044199432	277
paypal	163	9734154007393952	282
paypal	164	1631360756954567	286
paypal	165	7893488945734789	227
paypal	166	1112664322304193	129
paypal	167	2236700189152364	154
paypal	168	1963204713057380	2
paypal	169	433600197226382	202
paypal	170	433917212049272	136
paypal	171	1154049048376887	121
paypal	172	8461129863184299	213
paypal	173	3608435014757593	213
paypal	174	5602910440310771	163
paypal	175	4126501351623293	140
paypal	176	9513492522819128	29
paypal	177	4302405453708750	14
paypal	178	252544466370701	298
paypal	179	1596866732743879	32
paypal	180	3579106286381530	64
paypal	181	7891175552465723	220
paypal	182	4362001254276966	22
paypal	183	2474416295372233	200
paypal	184	7027564787155480	247
paypal	185	9399212106375182	247
paypal	186	1951589107486699	64
paypal	187	8996674746710906	33
paypal	188	5054395617094020	154
paypal	189	3105868272444049	142
paypal	190	1028373777725630	217
paypal	191	5730060422942054	288
paypal	192	6299583799287512	160
paypal	193	5874340054088718	208
paypal	194	9467981067402584	211
paypal	195	6434791859862719	158
paypal	196	7714465623096649	32
paypal	197	9294271552504386	239
paypal	198	3385784359260190	189
paypal	199	8784035463145473	297
paypal	200	2487303423585463	248
\.


--
-- Name: info_payement_id_compte_seq; Type: SEQUENCE SET; Schema: public; Owner: sultano
--

SELECT pg_catalog.setval('info_payement_id_compte_seq', 200, true);


--
-- Data for Name: liste_applications; Type: TABLE DATA; Schema: public; Owner: sultano
--

COPY liste_applications (id_application, id_user) FROM stdin;
252	1
401	2
430	4
354	5
344	6
244	7
453	8
429	9
125	10
174	11
34	12
397	13
188	14
292	15
184	16
357	17
472	18
6	19
511	20
12	21
475	22
269	23
123	24
522	25
169	26
128	27
456	28
149	29
65	30
158	31
351	32
208	33
192	34
25	35
13	36
555	37
213	38
476	39
485	40
478	41
41	42
129	43
118	44
33	45
31	46
286	47
508	48
375	49
164	50
171	51
316	52
172	53
243	54
130	55
360	56
112	57
397	58
163	59
383	60
298	61
34	62
128	63
154	64
439	65
424	66
154	67
419	68
482	69
475	70
405	71
403	72
184	73
278	74
238	75
281	76
255	77
47	78
52	79
45	80
55	81
85	82
384	83
243	84
187	85
260	86
373	87
488	88
348	89
17	90
47	91
512	92
388	93
267	94
213	95
293	96
517	97
315	98
254	99
148	100
250	101
533	102
235	103
473	104
412	105
456	106
502	107
175	108
460	109
28	110
464	111
394	112
456	113
500	114
379	115
539	116
532	117
542	118
86	119
441	120
372	121
69	122
286	123
226	124
340	125
397	126
211	127
550	128
76	129
156	130
357	131
134	132
168	133
13	134
411	135
81	136
515	137
131	138
479	139
502	140
450	141
261	142
31	143
195	144
334	145
14	146
81	147
469	148
28	149
109	150
239	151
358	152
95	153
254	154
242	155
326	156
288	157
512	158
312	159
415	160
118	161
342	162
18	163
467	164
542	165
69	166
50	167
294	168
348	169
524	170
403	171
436	172
25	173
127	174
447	175
305	176
98	177
376	178
246	179
522	180
300	181
24	182
388	183
50	184
539	185
288	186
375	187
558	188
503	189
341	190
345	191
316	192
332	193
156	194
71	195
120	196
315	197
533	198
243	199
176	200
116	201
1	202
178	203
142	204
362	205
145	206
537	207
56	208
304	209
426	210
273	211
490	212
158	213
44	214
314	215
149	216
118	217
308	218
380	219
9	220
268	221
526	222
453	223
9	224
57	225
497	226
481	227
10	228
516	229
120	230
194	231
526	232
414	233
308	234
329	235
123	236
235	237
102	238
173	239
240	240
232	241
72	242
12	243
268	244
476	245
26	246
276	247
95	248
369	249
4	250
224	251
135	252
96	253
176	254
367	255
161	256
246	257
79	258
347	259
487	260
15	261
84	262
124	263
126	264
70	265
332	266
69	267
18	268
428	269
152	270
402	271
508	272
487	273
215	274
243	275
197	276
143	277
259	278
307	279
548	280
489	281
398	282
343	283
169	284
216	285
89	286
24	287
287	288
344	289
177	290
495	291
363	292
253	293
338	294
524	295
108	296
441	297
528	298
533	299
402	300
543	125
192	68
203	258
160	50
191	157
489	240
159	85
405	275
63	2
459	233
13	217
236	13
205	247
452	19
101	93
227	122
397	23
81	41
400	242
154	34
375	264
86	290
58	70
36	206
218	41
241	48
326	81
88	209
463	197
395	112
96	235
62	128
519	17
73	45
50	250
5	189
497	53
61	76
414	241
332	29
518	110
26	20
348	25
147	243
231	289
7	246
396	156
40	130
448	127
422	51
339	188
343	275
524	108
124	172
261	36
45	45
140	176
518	94
273	110
338	230
96	126
82	189
209	140
209	56
274	139
268	42
516	28
152	41
188	94
452	221
14	166
371	180
58	9
537	270
152	187
312	93
142	145
545	7
203	4
42	128
187	232
418	240
477	174
245	277
221	204
214	198
227	291
3	94
425	291
95	192
558	211
71	78
550	222
432	248
214	196
346	98
86	33
245	69
484	237
131	86
366	267
159	171
377	234
346	19
60	2
460	110
559	39
496	13
390	74
166	67
170	221
98	163
387	273
247	141
528	274
69	42
393	258
511	35
82	257
417	21
275	255
493	89
380	209
368	3
57	230
449	85
21	277
238	19
288	76
531	164
424	165
220	97
180	230
23	64
298	21
78	294
383	194
91	220
10	281
161	296
71	177
336	131
68	168
199	202
14	183
553	78
201	257
51	245
82	150
350	36
342	37
522	10
265	97
417	270
329	220
137	19
417	25
2	82
409	57
77	143
323	224
79	106
525	60
404	20
321	98
478	13
165	74
290	126
61	175
264	13
98	255
366	151
111	298
146	152
395	94
149	155
555	239
252	251
31	294
379	7
461	272
472	149
135	229
395	85
482	268
225	195
156	132
271	40
504	111
449	47
392	144
39	29
33	77
350	269
63	154
431	213
360	157
504	284
286	212
184	9
346	189
72	41
394	167
169	110
266	196
494	59
240	205
186	205
368	176
278	19
292	243
496	54
70	265
238	124
95	94
318	282
202	201
420	39
67	206
441	28
319	229
23	33
373	244
294	131
250	212
14	44
339	154
198	119
370	180
29	247
31	9
364	91
370	266
149	115
450	229
445	37
122	211
92	266
532	183
239	91
355	220
538	40
429	289
191	248
173	279
90	59
354	35
140	293
407	58
330	264
173	28
200	68
378	192
323	34
284	268
3	253
357	79
281	103
68	84
538	83
454	159
45	258
532	278
361	290
480	178
157	84
399	101
39	166
438	94
221	299
215	18
60	10
226	163
64	58
401	66
522	141
259	193
295	30
197	276
16	197
83	234
396	207
144	28
327	140
229	124
290	246
543	168
552	37
337	204
489	45
376	260
543	150
436	247
73	4
394	265
314	23
284	201
376	277
411	1
\.


--
-- Data for Name: mot_cle; Type: TABLE DATA; Schema: public; Owner: sultano
--

COPY mot_cle (type, id, id_application) FROM stdin;
ligula. Aenean gravida nunc sed pede. Cum sociis natoque	31	1
Vivamus nibh dolor,	32	2
vel,	33	3
ante blandit	34	4
sagittis.	35	5
Morbi metus.	36	6
parturient montes, nascetur ridiculus mus.	37	7
et	38	8
nulla. Integer vulputate, risus a ultricies adipiscing, enim mi	39	9
primis in	40	10
arcu. Aliquam ultrices iaculis odio. Nam	41	11
pulvinar arcu et	42	12
litora torquent per	43	13
vel turpis. Aliquam	44	14
vel,	45	15
et tristique pellentesque, tellus sem mollis dui, in sodales	46	16
eu erat semper rutrum.	47	17
Ut sagittis lobortis	48	18
Etiam bibendum fermentum metus. Aenean sed pede nec	49	19
in sodales elit erat vitae	50	20
non, egestas a, dui. Cras pellentesque. Sed	51	21
primis in	52	22
mauris. Suspendisse aliquet molestie tellus.	53	23
Praesent luctus. Curabitur egestas nunc sed libero. Proin sed	54	24
parturient montes, nascetur ridiculus mus.	55	25
nunc id enim. Curabitur massa.	56	26
nunc	57	27
nunc id enim. Curabitur massa.	58	28
posuere vulputate, lacus. Cras interdum. Nunc sollicitudin commodo ipsum. Suspendisse	59	29
luctus. Curabitur egestas nunc sed	60	30
vel turpis. Aliquam	61	31
Vivamus nibh dolor,	62	32
Etiam bibendum fermentum metus. Aenean sed pede nec	63	33
conubia nostra, per inceptos hymenaeos. Mauris ut	64	34
Aenean massa. Integer vitae nibh. Donec est mauris, rhoncus id,	65	35
aliquam iaculis, lacus pede sagittis	66	36
nec, euismod in, dolor. Fusce	67	37
nec, euismod in, dolor. Fusce	68	38
nisi sem semper erat, in consectetuer ipsum nunc id	69	39
fermentum arcu. Vestibulum	70	40
sed pede. Cum sociis natoque penatibus	71	41
quam, elementum at, egestas a, scelerisque sed, sapien. Nunc pulvinar	72	42
ante blandit	73	43
in sodales elit erat vitae	74	44
dignissim pharetra. Nam ac nulla.	75	45
In lorem. Donec elementum, lorem ut aliquam	76	46
Ut sagittis lobortis	77	47
elit. Aliquam auctor, velit eget laoreet posuere,	78	48
Duis	79	49
vel turpis. Aliquam	80	50
vel turpis. Aliquam	81	51
dignissim pharetra. Nam ac nulla.	82	52
Duis	83	53
nec, mollis vitae, posuere at, velit. Cras lorem	84	54
orci quis lectus.	85	55
Praesent luctus. Curabitur egestas nunc sed libero. Proin sed	86	56
pulvinar arcu et	87	57
nec, euismod in, dolor. Fusce	88	58
conubia nostra, per inceptos hymenaeos. Mauris ut	89	59
tellus sem	90	60
vel turpis. Aliquam	91	61
primis in	92	62
Aenean massa. Integer	93	63
in sodales elit erat vitae	94	64
quam a felis ullamcorper viverra. Maecenas iaculis aliquet diam. Sed	95	65
pede. Nunc	96	66
malesuada. Integer id magna et ipsum cursus vestibulum. Mauris	97	67
conubia nostra, per inceptos hymenaeos. Mauris ut	98	68
enim. Mauris quis turpis vitae purus gravida	99	69
nec tempus scelerisque, lorem ipsum sodales purus, in	100	70
Aenean massa. Integer	101	71
sapien. Cras dolor dolor, tempus non, lacinia at,	102	72
eu tellus. Phasellus elit	103	73
enim. Mauris quis turpis vitae purus gravida	104	74
Mauris blandit enim consequat purus. Maecenas libero est, congue	105	75
iaculis, lacus	106	76
Donec nibh enim, gravida sit	107	77
conubia nostra, per inceptos hymenaeos. Mauris ut	108	78
aliquam	109	79
iaculis, lacus	110	80
ligula. Aenean gravida nunc sed pede. Cum sociis natoque	111	81
sit	112	82
magna. Nam ligula elit,	113	83
nunc id enim. Curabitur massa.	114	84
iaculis, lacus	115	85
vel turpis. Aliquam	116	86
pede. Nunc	117	87
eu tellus. Phasellus elit	118	88
cursus et, eros. Proin ultrices. Duis	119	89
eu erat semper rutrum.	120	90
libero et tristique	121	91
Sed congue,	122	92
Donec tempor, est ac mattis semper, dui	123	93
id sapien. Cras dolor	124	94
egestas	125	95
primis in	126	96
primis in	127	97
cursus non, egestas a, dui.	128	98
Quisque libero lacus, varius et, euismod et,	129	99
mi tempor	130	100
nibh vulputate mauris sagittis	131	101
Duis	132	102
sagittis.	133	103
Donec tempor, est ac mattis semper, dui	134	104
enim. Mauris quis turpis vitae purus gravida	135	105
Integer urna. Vivamus	136	106
Donec nibh enim, gravida sit	137	107
malesuada. Integer id magna et ipsum cursus vestibulum. Mauris	138	108
Proin dolor.	139	109
nec, euismod in, dolor. Fusce	140	110
Morbi metus.	141	111
egestas	142	112
malesuada. Integer id magna et ipsum cursus vestibulum. Mauris	143	113
enim. Mauris quis turpis vitae purus gravida	144	114
Fusce mollis. Duis sit amet	145	115
litora torquent per	146	116
vestibulum	147	117
egestas	148	118
et	149	119
quam a felis ullamcorper viverra. Maecenas iaculis aliquet diam. Sed	150	120
tellus sem	151	121
parturient montes, nascetur ridiculus mus.	152	122
sapien, gravida non, sollicitudin a, malesuada id,	153	123
quam a felis ullamcorper viverra. Maecenas iaculis aliquet diam. Sed	154	124
amet luctus vulputate, nisi sem semper erat, in	155	125
iaculis, lacus	156	126
orci quis lectus.	157	127
nulla. Integer vulputate, risus a ultricies adipiscing, enim mi	158	128
et tristique pellentesque, tellus sem mollis dui, in sodales	159	129
luctus. Curabitur egestas nunc sed	160	130
posuere vulputate, lacus. Cras interdum. Nunc sollicitudin commodo ipsum. Suspendisse	161	131
Quisque libero lacus, varius et, euismod et,	162	132
pulvinar arcu et	163	133
orci quis lectus.	164	134
vel,	165	135
eleifend, nunc risus varius	166	136
quam a felis ullamcorper viverra. Maecenas iaculis aliquet diam. Sed	167	137
ac turpis egestas. Aliquam fringilla cursus purus. Nullam	168	138
elit. Aliquam auctor, velit eget laoreet posuere,	169	139
In lorem. Donec elementum, lorem ut aliquam	170	140
nulla. Integer vulputate, risus a ultricies adipiscing, enim mi	171	141
Praesent luctus. Curabitur egestas nunc sed libero. Proin sed	172	142
nec, mollis vitae, posuere at, velit. Cras lorem	173	143
Mauris blandit enim consequat purus. Maecenas libero est, congue	174	144
quam a felis ullamcorper viverra. Maecenas iaculis aliquet diam. Sed	175	145
non, sollicitudin	176	146
luctus. Curabitur egestas nunc sed	177	147
dolor sit amet, consectetuer adipiscing elit.	178	148
cursus et, eros. Proin ultrices. Duis	179	149
id sapien. Cras dolor	180	150
et tristique pellentesque, tellus sem mollis dui, in sodales	181	151
vestibulum	182	152
dolor	183	153
pulvinar arcu et	184	154
id sapien. Cras dolor	185	155
cursus non, egestas a, dui.	186	156
non, sollicitudin	187	157
aliquam iaculis, lacus pede sagittis	188	158
sapien, gravida non, sollicitudin a, malesuada id,	189	159
dignissim pharetra. Nam ac nulla.	190	160
Quisque libero lacus, varius et, euismod et,	191	161
dignissim pharetra. Nam ac nulla.	192	162
primis in	193	163
Vivamus nibh dolor,	194	164
luctus. Curabitur egestas nunc sed	195	165
ipsum. Suspendisse non leo. Vivamus nibh dolor, nonummy	196	166
in sodales elit erat vitae	197	167
Duis	198	168
justo. Proin non massa non ante bibendum ullamcorper.	199	169
enim. Mauris quis turpis vitae purus gravida	200	170
sapien, gravida non, sollicitudin a, malesuada id,	201	171
justo. Proin non massa non ante bibendum ullamcorper.	202	172
Duis	203	173
Donec vitae erat vel pede blandit congue. In scelerisque	204	174
sem elit, pharetra ut, pharetra sed, hendrerit a, arcu.	205	175
libero et tristique	206	176
cursus non, egestas a, dui.	207	177
egestas	208	178
Quisque libero lacus, varius et, euismod et,	209	179
Fusce mollis. Duis sit amet	210	180
ante blandit	211	181
nulla. Integer vulputate, risus a ultricies adipiscing, enim mi	212	182
Quisque libero lacus, varius et, euismod et,	213	183
nec, mollis vitae, posuere at, velit. Cras lorem	214	184
Vivamus nibh dolor,	215	185
nec, euismod in, dolor. Fusce	216	186
eu tellus. Phasellus elit	217	187
vestibulum	218	188
luctus. Curabitur egestas nunc sed	219	189
Proin dolor.	220	190
vel,	221	191
Fusce mollis. Duis sit amet	222	192
Mauris blandit enim consequat purus. Maecenas libero est, congue	223	193
nibh vulputate mauris sagittis	224	194
egestas	225	195
ac turpis egestas. Aliquam fringilla cursus purus. Nullam	226	196
ac, feugiat	227	197
Donec tempor, est ac mattis semper, dui	228	198
eu arcu. Morbi	229	199
malesuada. Integer id magna et ipsum cursus vestibulum. Mauris	230	200
id sapien. Cras dolor	231	201
sed pede. Cum sociis natoque penatibus	232	202
primis in	233	203
sem elit, pharetra ut, pharetra sed, hendrerit a, arcu.	234	204
Vivamus nibh dolor,	235	205
ac, feugiat	236	206
Fusce mollis. Duis sit amet	237	207
pede. Nunc	238	208
primis in	239	209
eu tellus. Phasellus elit	240	210
eu tellus. Phasellus elit	241	211
ipsum. Suspendisse non leo. Vivamus nibh dolor, nonummy	242	212
quam a felis ullamcorper viverra. Maecenas iaculis aliquet diam. Sed	243	213
eu erat semper rutrum.	244	214
quam a felis ullamcorper viverra. Maecenas iaculis aliquet diam. Sed	245	215
Donec vitae erat vel pede blandit congue. In scelerisque	246	216
Vivamus nibh dolor,	247	217
magna. Nam ligula elit,	248	218
Aenean massa. Integer vitae nibh. Donec est mauris, rhoncus id,	249	219
sagittis.	250	220
sit	251	221
Donec nibh enim, gravida sit	252	222
libero et tristique	253	223
ornare, libero	254	224
eu arcu. Morbi	255	225
elit. Aliquam auctor, velit eget laoreet posuere,	256	226
primis in	257	227
litora torquent per	258	228
parturient montes, nascetur ridiculus mus.	259	229
Praesent luctus. Curabitur egestas nunc sed libero. Proin sed	260	230
vel turpis. Aliquam	261	231
Morbi metus.	262	232
egestas	263	233
quam a felis ullamcorper viverra. Maecenas iaculis aliquet diam. Sed	264	234
nunc id enim. Curabitur massa.	265	235
libero et tristique	266	236
nunc id enim. Curabitur massa.	267	237
non, sollicitudin	268	238
diam luctus lobortis. Class aptent taciti	269	239
aliquam	270	240
sit	271	241
quam a felis ullamcorper viverra. Maecenas iaculis aliquet diam. Sed	272	242
congue. In scelerisque scelerisque dui. Suspendisse ac metus vitae velit	273	243
pede. Nunc	274	244
Praesent luctus. Curabitur egestas nunc sed libero. Proin sed	275	245
sed pede. Cum sociis natoque penatibus	276	246
primis in	277	247
arcu. Aliquam ultrices iaculis odio. Nam	278	248
Etiam bibendum fermentum metus. Aenean sed pede nec	279	249
nec tempus scelerisque, lorem ipsum sodales purus, in	280	250
ligula. Aenean gravida nunc sed pede. Cum sociis natoque	281	251
mi tempor	282	252
nec, mollis vitae, posuere at, velit. Cras lorem	283	253
Morbi metus.	284	254
nulla. Integer vulputate, risus a ultricies adipiscing, enim mi	285	255
litora torquent per	286	256
mi tempor	287	257
egestas	288	258
Morbi metus.	289	259
Etiam bibendum fermentum metus. Aenean sed pede nec	290	260
Sed congue,	291	261
vel,	292	262
sapien. Cras dolor dolor, tempus non, lacinia at,	293	263
enim. Mauris quis turpis vitae purus gravida	294	264
amet luctus vulputate, nisi sem semper erat, in	295	265
Duis	296	266
Aenean massa. Integer vitae nibh. Donec est mauris, rhoncus id,	297	267
enim. Mauris quis turpis vitae purus gravida	298	268
eu tellus. Phasellus elit	299	269
elit. Aliquam auctor, velit eget laoreet posuere,	300	270
sed pede. Cum sociis natoque penatibus	301	271
mi tempor	302	272
Etiam bibendum fermentum metus. Aenean sed pede nec	303	273
Mauris blandit enim consequat purus. Maecenas libero est, congue	304	274
et	305	275
neque et nunc. Quisque ornare	306	276
elit. Aliquam auctor, velit eget laoreet posuere,	307	277
nunc	308	278
mi tempor	309	279
malesuada. Integer id magna et ipsum cursus vestibulum. Mauris	310	280
ornare, libero	311	281
sagittis.	312	282
libero et tristique	313	283
nunc id enim. Curabitur massa.	314	284
et	315	285
Aenean massa. Integer	316	286
Aenean massa. Integer	317	287
ac turpis egestas. Aliquam fringilla cursus purus. Nullam	318	288
malesuada. Integer id magna et ipsum cursus vestibulum. Mauris	319	289
vel turpis. Aliquam	320	290
et	321	291
Quisque libero lacus, varius et, euismod et,	322	292
Quisque libero lacus, varius et, euismod et,	323	293
enim. Mauris quis turpis vitae purus gravida	324	294
Integer urna. Vivamus	325	295
sagittis.	326	296
Vivamus nibh dolor,	327	297
lobortis tellus	328	298
nibh vulputate mauris sagittis	329	299
eleifend, nunc risus varius	330	300
eu erat semper rutrum.	331	301
Vivamus nibh dolor,	332	302
nunc	333	303
erat. Etiam vestibulum massa	334	304
neque et nunc. Quisque ornare	335	305
ac, feugiat	336	306
fermentum arcu. Vestibulum	337	307
congue. In scelerisque scelerisque dui. Suspendisse ac metus vitae velit	338	308
enim. Suspendisse aliquet, sem ut cursus	339	309
Aenean massa. Integer	340	310
nunc	341	311
eu arcu. Morbi	342	312
iaculis, lacus	343	313
enim. Suspendisse aliquet, sem ut cursus	344	314
Donec vitae erat vel pede blandit congue. In scelerisque	345	315
dolor sit amet, consectetuer adipiscing elit.	346	316
iaculis, lacus	347	317
nec, euismod in, dolor. Fusce	348	318
Praesent luctus. Curabitur egestas nunc sed libero. Proin sed	349	319
Etiam bibendum fermentum metus. Aenean sed pede nec	350	320
Aenean massa. Integer vitae nibh. Donec est mauris, rhoncus id,	351	321
vel turpis. Aliquam	352	322
Etiam bibendum fermentum metus. Aenean sed pede nec	353	323
egestas	354	324
id sapien. Cras dolor	355	325
nec, mollis vitae, posuere at, velit. Cras lorem	356	326
Sed congue,	357	327
quam a felis ullamcorper viverra. Maecenas iaculis aliquet diam. Sed	358	328
vestibulum	359	329
id sapien. Cras dolor	360	330
primis in	361	331
amet luctus vulputate, nisi sem semper erat, in	362	332
parturient montes, nascetur ridiculus mus.	363	333
Vivamus nibh dolor,	364	334
tellus sem	365	335
elit. Aliquam auctor, velit eget laoreet posuere,	366	336
eu tellus. Phasellus elit	367	337
dolor sit amet, consectetuer adipiscing elit.	368	338
libero et tristique	369	339
parturient montes, nascetur ridiculus mus.	370	340
ipsum. Suspendisse non leo. Vivamus nibh dolor, nonummy	371	341
Quisque libero lacus, varius et, euismod et,	372	342
non, sollicitudin	373	343
sed pede. Cum sociis natoque penatibus	374	344
dignissim pharetra. Nam ac nulla.	375	345
Etiam bibendum fermentum metus. Aenean sed pede nec	376	346
vestibulum	377	347
in sodales elit erat vitae	378	348
malesuada. Integer id magna et ipsum cursus vestibulum. Mauris	379	349
Praesent luctus. Curabitur egestas nunc sed libero. Proin sed	380	350
lobortis tellus	381	351
enim. Suspendisse aliquet, sem ut cursus	382	352
mi tempor	383	353
mi tempor	384	354
quam, elementum at, egestas a, scelerisque sed, sapien. Nunc pulvinar	385	355
Donec tempor, est ac mattis semper, dui	386	356
Aenean massa. Integer	387	357
eu erat semper rutrum.	388	358
ridiculus mus. Proin vel nisl. Quisque fringilla euismod enim.	389	359
ipsum. Suspendisse non leo. Vivamus nibh dolor, nonummy	390	360
Donec tempor, est ac mattis semper, dui	391	361
vel turpis. Aliquam	392	362
nec, mollis vitae, posuere at, velit. Cras lorem	393	363
egestas	394	364
primis in	395	365
parturient montes, nascetur ridiculus mus.	396	366
parturient montes, nascetur ridiculus mus.	397	367
magna. Nam ligula elit,	398	368
vel turpis. Aliquam	399	369
tellus sem	400	370
Integer urna. Vivamus	401	371
dolor sit amet, consectetuer adipiscing elit.	402	372
Ut sagittis lobortis	403	373
vel turpis. Aliquam	404	374
enim. Mauris quis turpis vitae purus gravida	405	375
malesuada. Integer id magna et ipsum cursus vestibulum. Mauris	406	376
vestibulum	407	377
egestas	408	378
nunc id enim. Curabitur massa.	409	379
quam, elementum at, egestas a, scelerisque sed, sapien. Nunc pulvinar	410	380
eu erat semper rutrum.	411	381
tellus sem	412	382
magna. Nam ligula elit,	413	383
id sapien. Cras dolor	414	384
Donec nibh enim, gravida sit	415	385
vestibulum	416	386
parturient montes, nascetur ridiculus mus.	417	387
sagittis.	418	388
elit. Aliquam auctor, velit eget laoreet posuere,	419	389
litora torquent per	420	390
litora torquent per	421	391
pede. Nunc	422	392
enim. Suspendisse aliquet, sem ut cursus	423	393
porttitor scelerisque neque. Nullam	424	394
ipsum. Suspendisse non leo. Vivamus nibh dolor, nonummy	425	395
nulla. Integer vulputate, risus a ultricies adipiscing, enim mi	426	396
ac turpis egestas. Aliquam fringilla cursus purus. Nullam	427	397
Morbi metus.	428	398
ornare, libero	429	399
tellus sem	430	400
eu arcu. Morbi	431	401
sit	432	402
Aenean massa. Integer	433	403
ornare, libero	434	404
Etiam bibendum fermentum metus. Aenean sed pede nec	435	405
eu tellus. Phasellus elit	436	406
egestas blandit. Nam nulla magna, malesuada vel, convallis	437	407
nulla. Integer vulputate, risus a ultricies adipiscing, enim mi	438	408
egestas	439	409
elit. Aliquam auctor, velit eget laoreet posuere,	440	410
parturient montes, nascetur ridiculus mus.	441	411
luctus. Curabitur egestas nunc sed	442	412
ante blandit	443	413
aliquam iaculis, lacus pede sagittis	444	414
id sapien. Cras dolor	445	415
eu tellus. Phasellus elit	446	416
ac turpis egestas. Aliquam fringilla cursus purus. Nullam	447	417
Donec tempor, est ac mattis semper, dui	448	418
dolor sit amet, consectetuer adipiscing elit.	449	419
sit	450	420
egestas blandit. Nam nulla magna, malesuada vel, convallis	451	421
litora torquent per	452	422
eu arcu. Morbi	453	423
aliquam iaculis, lacus pede sagittis	454	424
sit	455	425
Quisque libero lacus, varius et, euismod et,	456	426
nec tempus scelerisque, lorem ipsum sodales purus, in	457	427
Aenean massa. Integer	458	428
malesuada. Integer id magna et ipsum cursus vestibulum. Mauris	459	429
ligula. Aenean gravida nunc sed pede. Cum sociis natoque	460	430
Donec vitae erat vel pede blandit congue. In scelerisque	461	431
primis in	462	432
at augue id ante	463	433
enim. Mauris quis turpis vitae purus gravida	464	434
cursus non, egestas a, dui.	465	435
vel turpis. Aliquam	466	436
Donec nibh enim, gravida sit	467	437
justo. Proin non massa non ante bibendum ullamcorper.	468	438
lobortis tellus	469	439
Donec tempor, est ac mattis semper, dui	470	440
mauris. Suspendisse aliquet molestie tellus.	471	441
sem elit, pharetra ut, pharetra sed, hendrerit a, arcu.	472	442
nunc	473	443
porttitor scelerisque neque. Nullam	474	444
non, sollicitudin	475	445
nec, euismod in, dolor. Fusce	476	446
sem elit, pharetra ut, pharetra sed, hendrerit a, arcu.	477	447
Morbi metus.	478	448
in sodales elit erat vitae	479	449
non, egestas a, dui. Cras pellentesque. Sed	480	450
primis in	481	451
Mauris blandit enim consequat purus. Maecenas libero est, congue	482	452
et	483	453
Praesent luctus. Curabitur egestas nunc sed libero. Proin sed	484	454
Vivamus nibh dolor,	485	455
litora torquent per	486	456
pede. Nunc	487	457
malesuada. Integer id magna et ipsum cursus vestibulum. Mauris	488	458
parturient montes, nascetur ridiculus mus.	489	459
malesuada. Integer id magna et ipsum cursus vestibulum. Mauris	490	460
arcu. Aliquam ultrices iaculis odio. Nam	491	461
primis in	492	462
Nunc mauris. Morbi non sapien molestie orci tincidunt adipiscing.	493	463
litora torquent per	494	464
Morbi metus.	495	465
egestas	496	466
nulla. Integer vulputate, risus a ultricies adipiscing, enim mi	497	467
Sed congue,	498	468
sed pede. Cum sociis natoque penatibus	499	469
Donec tempor, est ac mattis semper, dui	500	470
eu tellus. Phasellus elit	501	471
vel turpis. Aliquam	502	472
vel turpis. Aliquam	503	473
neque et nunc. Quisque ornare	504	474
vestibulum	505	475
in sodales elit erat vitae	506	476
nisi sem semper erat, in consectetuer ipsum nunc id	507	477
eleifend, nunc risus varius	508	478
conubia nostra, per inceptos hymenaeos. Mauris ut	509	479
ligula. Aenean gravida nunc sed pede. Cum sociis natoque	510	480
orci quis lectus.	511	481
egestas	512	482
Donec tempor, est ac mattis semper, dui	513	483
sem elit, pharetra ut, pharetra sed, hendrerit a, arcu.	514	484
mauris. Suspendisse aliquet molestie tellus.	515	485
malesuada fringilla est.	516	486
nec, mollis vitae, posuere at, velit. Cras lorem	517	487
elit. Aliquam auctor, velit eget laoreet posuere,	518	488
Aenean massa. Integer	519	489
Quisque libero lacus, varius et, euismod et,	520	490
Duis	521	491
elit. Aliquam auctor, velit eget laoreet posuere,	522	492
dignissim pharetra. Nam ac nulla.	523	493
Quisque libero lacus, varius et, euismod et,	524	494
luctus. Curabitur egestas nunc sed	525	495
amet luctus vulputate, nisi sem semper erat, in	526	496
dignissim pharetra. Nam ac nulla.	527	497
litora torquent per	528	498
Quisque libero lacus, varius et, euismod et,	529	499
lobortis tellus	530	500
Nunc ullamcorper,	531	501
enim. Etiam gravida molestie arcu. Sed eu nibh vulputate	532	502
Integer urna. Vivamus	533	503
nec tempus scelerisque, lorem ipsum sodales purus, in	534	504
litora torquent per	535	505
sapien, gravida non, sollicitudin a, malesuada id,	536	506
nec, euismod in, dolor. Fusce	537	507
aliquam iaculis, lacus pede sagittis	538	508
Praesent luctus. Curabitur egestas nunc sed libero. Proin sed	539	509
Etiam bibendum fermentum metus. Aenean sed pede nec	540	510
arcu. Aliquam ultrices iaculis odio. Nam	541	511
egestas	542	512
pulvinar arcu et	543	513
egestas blandit. Nam nulla magna, malesuada vel, convallis	544	514
sapien. Cras dolor dolor, tempus non, lacinia at,	545	515
malesuada fringilla est.	546	516
egestas	547	517
et	548	518
nunc id enim. Curabitur massa.	549	519
iaculis, lacus	550	520
vestibulum	551	521
Praesent luctus. Curabitur egestas nunc sed libero. Proin sed	552	522
Aenean massa. Integer vitae nibh. Donec est mauris, rhoncus id,	553	523
Aenean massa. Integer	554	524
Sed congue,	555	525
at augue id ante	556	526
Nunc mauris. Morbi non sapien molestie orci tincidunt adipiscing.	557	527
nunc	558	528
aliquam	559	529
fermentum arcu. Vestibulum	560	530
arcu. Aliquam ultrices iaculis odio. Nam	561	531
Fusce mollis. Duis sit amet	562	532
Cras	563	533
Sed diam lorem, auctor quis, tristique ac,	564	534
et	565	535
Mauris blandit enim consequat purus. Maecenas libero est, congue	566	536
dolor sit amet, consectetuer adipiscing elit.	567	537
pede. Nunc	568	538
porttitor scelerisque neque. Nullam	569	539
enim. Suspendisse aliquet, sem ut cursus	570	540
orci quis lectus.	571	541
libero et tristique	572	542
nisi sem semper erat, in consectetuer ipsum nunc id	573	543
non, egestas a, dui. Cras pellentesque. Sed	574	544
nibh vulputate mauris sagittis	575	545
nisi sem semper erat, in consectetuer ipsum nunc id	576	546
et tristique pellentesque, tellus sem mollis dui, in sodales	577	547
Vivamus nibh dolor,	578	548
diam luctus lobortis. Class aptent taciti	579	549
Vivamus nibh dolor,	580	550
enim. Mauris quis turpis vitae purus gravida	581	551
pede. Nunc	582	552
nulla. Integer vulputate, risus a ultricies adipiscing, enim mi	583	553
ipsum. Suspendisse non leo. Vivamus nibh dolor, nonummy	584	554
et	585	555
posuere vulputate, lacus. Cras interdum. Nunc sollicitudin commodo ipsum. Suspendisse	586	556
ac turpis egestas. Aliquam fringilla cursus purus. Nullam	587	557
magna. Nam ligula elit,	588	558
sapien, gravida non, sollicitudin a, malesuada id,	589	559
Sed diam lorem, auctor quis, tristique ac,	590	560
\.


--
-- Name: mot_cle_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sultano
--

SELECT pg_catalog.setval('mot_cle_id_seq', 590, true);


--
-- Data for Name: peripherique; Type: TABLE DATA; Schema: public; Owner: sultano
--

COPY peripherique (id, nom, id_se, nom_fabriquant, id_user) FROM stdin;
1	Bird	12	LG	1
2	Rogers	5	Apple	2
3	Golden	11	HTC	3
4	Michael	14	HTC	4
5	Mcpherson	5	BlackBerry	5
6	Puckett	9	BlackBerry	6
7	Byrd	14	LG	7
8	Fox	12	Nokia	8
9	Harmon	0	Nokia	9
10	Price	12	HTC	10
11	Delgado	10	Nokia	11
12	Bray	12	HTC	12
13	Shaffer	10	Apple	13
14	Gilbert	14	Apple	14
15	Kim	12	BlackBerry	15
16	Bernard	7	Samsung	16
17	Mueller	8	HTC	17
18	Lopez	7	Samsung	18
19	Gutierrez	6	BlackBerry	19
20	Morris	13	HTC	20
21	Rich	3	Apple	21
22	Monroe	5	Samsung	22
23	Leon	6	Nokia	23
24	Leon	1	Samsung	24
25	Cunningham	6	Nokia	25
26	Head	9	Samsung	26
27	Olsen	5	LG	27
28	Vang	12	LG	28
29	Cannon	3	LG	29
30	Boyer	4	Apple	30
31	Meyers	6	BlackBerry	31
32	Fisher	6	HTC	32
33	Mueller	9	Apple	33
34	Finley	8	BlackBerry	34
35	Case	0	HTC	35
36	Sweet	11	BlackBerry	36
37	Robertson	11	LG	37
38	Everett	13	BlackBerry	38
39	Cruz	1	Apple	39
40	Mendoza	10	Nokia	40
41	Flynn	13	Nokia	41
42	Terrell	2	BlackBerry	42
43	May	8	BlackBerry	43
44	Thornton	13	Nokia	44
45	Gonzalez	0	Samsung	45
46	Flores	13	BlackBerry	46
47	Horne	14	Apple	47
48	Acosta	0	Nokia	48
49	Jimenez	13	Nokia	49
50	Levy	10	Samsung	50
51	Woods	3	LG	51
52	Gomez	0	Nokia	52
53	Stuart	12	LG	53
54	Monroe	4	BlackBerry	54
55	Swanson	7	Nokia	55
56	Barr	1	Samsung	56
57	Puckett	11	BlackBerry	57
58	Alford	12	HTC	58
59	Rice	8	HTC	59
60	Huffman	3	LG	60
61	Trujillo	1	HTC	61
62	Price	11	Nokia	62
63	Lane	8	BlackBerry	63
64	May	9	HTC	64
65	Acosta	4	Apple	65
66	Walton	12	HTC	66
67	Terrell	13	Samsung	67
68	Dean	3	Samsung	68
69	Flynn	6	Samsung	69
70	Robertson	8	Samsung	70
71	Beasley	11	Nokia	71
72	Snyder	11	Samsung	72
73	Mcneil	6	Nokia	73
74	Rice	12	BlackBerry	74
75	Sharpe	4	HTC	75
76	Diaz	14	Nokia	76
77	Webster	13	LG	77
78	Pennington	11	Nokia	78
79	Herrera	7	LG	79
80	Jimenez	7	HTC	80
81	Norman	10	LG	81
82	Woodward	0	LG	82
83	Brady	5	Nokia	83
84	Swanson	7	Nokia	84
85	Mueller	0	Samsung	85
86	Pacheco	1	HTC	86
87	Lindsay	5	BlackBerry	87
88	Lamb	12	Samsung	88
89	Leon	5	BlackBerry	89
90	Woods	0	LG	90
91	Murray	10	BlackBerry	91
92	Boyle	8	Nokia	92
93	Mendoza	2	LG	93
94	Zamora	13	Apple	94
95	Beach	3	BlackBerry	95
96	Clements	12	LG	96
97	Beasley	11	HTC	97
98	Barr	10	BlackBerry	98
99	Shields	2	LG	99
100	Hensley	7	Samsung	100
101	Blanchard	13	HTC	101
102	Franklin	6	Samsung	102
103	Chambers	13	HTC	103
104	Cantrell	6	Nokia	104
105	Merrill	8	Apple	105
106	Merrill	2	Nokia	106
107	Phillips	6	Nokia	107
108	Colon	5	HTC	108
109	Huffman	6	BlackBerry	109
110	May	1	LG	110
111	Bender	3	Nokia	111
112	Lopez	9	Samsung	112
113	Sawyer	0	LG	113
114	Boyle	13	Apple	114
115	Gutierrez	11	LG	115
116	Cannon	11	Samsung	116
117	Hudson	10	HTC	117
118	Langley	12	Apple	118
119	Head	14	Samsung	119
120	Hooper	12	HTC	120
121	Bender	3	Nokia	121
122	Oconnor	6	Samsung	122
123	Mcdowell	2	HTC	123
124	Flowers	9	BlackBerry	124
125	Boyer	9	BlackBerry	125
126	Vega	3	HTC	126
127	Fox	1	Samsung	127
128	Mcmillan	10	LG	128
129	Fox	6	HTC	129
130	Cannon	0	LG	130
131	Alford	13	Apple	131
132	Sampson	11	Nokia	132
133	Puckett	9	Samsung	133
134	Trujillo	13	BlackBerry	134
135	Sharpe	11	Apple	135
136	Cannon	9	BlackBerry	136
137	Meyer	6	LG	137
138	Wynn	2	Samsung	138
139	Ray	14	Nokia	139
140	Everett	7	BlackBerry	140
141	Orr	3	BlackBerry	141
142	Porter	1	Samsung	142
143	Bowers	3	Apple	143
144	Butler	1	BlackBerry	144
145	Lindsay	10	LG	145
146	Donaldson	12	Apple	146
147	Melton	10	LG	147
148	Padilla	8	Apple	148
149	Pratt	1	BlackBerry	149
150	Wagner	3	Nokia	150
151	Flowers	1	Nokia	151
152	Fernandez	8	Samsung	152
153	Frederick	3	HTC	153
154	Ayers	9	Nokia	154
155	David	8	BlackBerry	155
156	Swanson	2	Apple	156
157	Hensley	4	HTC	157
158	Jimenez	3	Apple	158
159	Blankenship	13	HTC	159
160	Head	1	BlackBerry	160
161	Jimenez	5	Nokia	161
162	Frederick	2	BlackBerry	162
163	Chapman	13	BlackBerry	163
164	Mcneil	4	BlackBerry	164
165	Camacho	1	Nokia	165
166	Howe	7	HTC	166
167	Merrill	5	LG	167
168	Morton	12	BlackBerry	168
169	Diaz	7	Apple	169
170	Waters	12	Apple	170
171	Porter	6	Samsung	171
172	Langley	4	Nokia	172
173	Olsen	3	Samsung	173
174	Vazquez	8	Apple	174
175	Gallagher	13	Apple	175
176	Beach	11	Samsung	176
177	Harmon	5	Samsung	177
178	Aguilar	0	BlackBerry	178
179	Rogers	12	Apple	179
180	David	6	Apple	180
181	Wong	10	BlackBerry	181
182	Booker	6	Nokia	182
183	Rich	9	Nokia	183
184	Schwartz	11	HTC	184
185	Ayers	7	Nokia	185
186	Cline	6	Nokia	186
187	David	8	HTC	187
188	Wong	1	Nokia	188
189	Flynn	11	HTC	189
190	Byrd	3	BlackBerry	190
191	Cruz	0	BlackBerry	191
192	Bishop	12	LG	192
193	Dillard	3	BlackBerry	193
194	Case	9	BlackBerry	194
195	Padilla	3	BlackBerry	195
196	Weiss	14	Apple	196
197	Blankenship	4	Samsung	197
198	Cunningham	13	HTC	198
199	Hensley	2	Samsung	199
200	Hart	5	LG	200
201	Bryan	14	Apple	201
202	Duran	12	Samsung	202
203	Clements	1	HTC	203
204	Frederick	7	Samsung	204
205	Herring	12	Nokia	205
206	Lamb	2	BlackBerry	206
207	Chaney	9	Apple	207
208	David	3	Apple	208
209	Hahn	9	Nokia	209
210	Gill	9	Samsung	210
211	Hooper	14	HTC	211
212	Daniel	10	HTC	212
213	Howe	1	Apple	213
214	Lindsay	11	LG	214
215	Green	3	LG	215
216	Gomez	14	LG	216
217	Villarreal	7	Nokia	217
218	Bartlett	3	HTC	218
219	Flores	1	BlackBerry	219
220	Battle	2	LG	220
221	Patrick	3	BlackBerry	221
222	Phillips	6	Samsung	222
223	Sawyer	5	HTC	223
224	Oneal	10	Apple	224
225	Irwin	5	BlackBerry	225
226	Guerrero	8	Apple	226
227	Oconnor	3	LG	227
228	Sellers	13	Nokia	228
229	Fox	5	Samsung	229
230	Koch	6	LG	230
231	Gould	9	Nokia	231
232	Wilkins	3	Samsung	232
233	Wagner	6	BlackBerry	233
234	Gutierrez	6	HTC	234
235	Barrera	1	LG	235
236	Herrera	2	Samsung	236
237	Aguilar	3	BlackBerry	237
238	Mcneil	3	Samsung	238
239	Murray	1	Samsung	239
240	Lane	9	BlackBerry	240
241	Golden	6	LG	241
242	Fischer	0	BlackBerry	242
243	Aguilar	13	LG	243
244	Paul	1	Nokia	244
245	Rocha	14	Apple	245
246	Merrill	2	Samsung	246
247	Merrill	14	HTC	247
248	Flowers	4	Apple	248
249	Evans	14	Samsung	249
250	Sweet	14	Nokia	250
251	Allen	12	Apple	251
252	Meyers	2	Apple	252
253	Weiss	1	Nokia	253
254	Cline	11	LG	254
255	Keith	3	Apple	255
256	Sharpe	7	Apple	256
257	Navarro	6	Samsung	257
258	Barr	13	HTC	258
259	Buckley	9	HTC	259
260	Maldonado	14	Nokia	260
261	Finley	12	Nokia	261
262	Merrill	6	LG	262
263	Hooper	1	BlackBerry	263
264	Slater	12	HTC	264
265	Frederick	4	HTC	265
266	Prince	3	LG	266
267	Fernandez	0	LG	267
268	Waters	9	BlackBerry	268
269	Bartlett	6	LG	269
270	Harvey	4	Samsung	270
271	Aguilar	5	LG	271
272	Pennington	6	Apple	272
273	Koch	1	Apple	273
274	Chase	8	LG	274
275	Nielsen	14	HTC	275
276	Kirk	13	HTC	276
277	Kirk	7	HTC	277
278	Dunn	6	Nokia	278
279	Chaney	3	Apple	279
280	Good	2	LG	280
281	Phillips	10	LG	281
282	Chambers	4	BlackBerry	282
283	Wiley	2	HTC	283
284	Lopez	8	BlackBerry	284
285	Ingram	8	BlackBerry	285
286	Harmon	11	Nokia	286
287	Kaufman	6	Samsung	287
288	Hensley	10	Nokia	288
289	Lott	13	LG	289
290	Delaney	11	LG	290
291	Gilbert	13	Samsung	291
292	Webster	12	Apple	292
293	Mcdowell	12	LG	293
294	Byrd	3	BlackBerry	294
295	Sampson	3	Apple	295
296	Weiss	7	BlackBerry	296
297	Ochoa	2	BlackBerry	297
298	Salinas	10	Nokia	298
299	Gutierrez	8	Apple	299
300	Clements	3	Samsung	300
301	Chapman	0	HTC	91
302	Martin	0	HTC	178
303	Perez	6	LG	106
304	Kramer	12	BlackBerry	275
305	Fox	5	BlackBerry	16
306	Roberson	9	LG	119
307	Bowers	3	HTC	249
308	Abbott	9	HTC	193
309	Mcguire	4	HTC	34
310	Brown	5	LG	2
311	Woodward	3	Samsung	88
312	Yates	1	Apple	69
313	Frederick	7	LG	286
314	Barker	5	Nokia	21
315	Norman	9	LG	53
316	Anderson	0	HTC	96
317	Cobb	5	Apple	21
318	Ray	10	Samsung	252
319	Mccoy	7	HTC	55
320	Buckley	9	Samsung	98
321	Mueller	4	HTC	201
322	Haynes	3	Samsung	220
323	Kramer	3	Apple	242
324	Underwood	10	Nokia	53
325	Stanley	6	BlackBerry	1
326	Camacho	12	BlackBerry	238
327	Paul	0	Samsung	114
328	Peck	6	LG	178
329	Rojas	6	HTC	237
330	Brown	6	Nokia	248
331	May	13	HTC	259
332	Bartlett	14	LG	40
333	Woodward	14	HTC	51
334	Yates	4	Samsung	23
335	Ratliff	5	Nokia	235
336	Thompson	7	LG	109
337	Chandler	5	HTC	169
338	Fry	4	HTC	76
339	Stanley	6	HTC	99
340	Sykes	7	Nokia	200
341	Bishop	8	HTC	92
342	Kinney	6	Nokia	244
343	Campbell	9	Samsung	92
344	Pacheco	6	Samsung	31
345	Leon	2	HTC	112
346	Clements	7	Samsung	41
347	Trujillo	8	Apple	240
348	Lloyd	13	LG	48
349	Buckley	9	BlackBerry	291
350	Finley	10	BlackBerry	187
351	Ayers	5	Nokia	243
352	Lloyd	6	LG	222
353	Robertson	2	Nokia	20
354	Nichols	2	HTC	109
355	Delgado	13	BlackBerry	288
356	Barrera	3	Samsung	109
357	Fry	5	LG	275
358	Frederick	4	Samsung	112
359	Benson	5	Apple	76
360	Gutierrez	11	HTC	209
361	May	7	LG	255
362	Duran	3	Apple	52
363	Clements	5	LG	156
364	Anderson	13	Nokia	259
365	Norman	2	Samsung	286
366	Nielsen	6	Nokia	8
367	Fry	3	Samsung	172
368	Ashley	14	Apple	119
369	Flowers	9	Apple	79
370	Vega	14	Nokia	196
371	Jordan	1	LG	2
372	Vazquez	9	Samsung	265
373	Burnett	6	Apple	204
374	Gilbert	2	Nokia	76
375	Ratliff	10	BlackBerry	53
376	Bender	4	Samsung	282
377	Mooney	11	LG	79
378	Vega	10	BlackBerry	127
379	Terrell	8	Nokia	16
380	Bender	10	LG	297
381	Byrd	4	Nokia	231
382	Merrill	11	LG	160
383	Green	0	BlackBerry	142
384	Tanner	11	Samsung	106
385	Meyers	0	BlackBerry	267
386	Lloyd	6	Apple	246
387	Duran	3	LG	146
388	Faulkner	3	Samsung	242
389	Ochoa	12	Apple	284
390	Haley	2	Nokia	123
391	Chandler	8	Samsung	60
392	Nichols	13	Apple	2
393	Ayers	9	HTC	111
394	Rich	6	HTC	272
395	Battle	7	BlackBerry	39
396	Atkins	9	Apple	37
397	Koch	8	Apple	186
398	Case	1	Nokia	295
399	Vang	11	Apple	37
400	Baldwin	13	Nokia	1
401	Green	9	LG	277
402	Cline	1	HTC	161
403	Rice	9	Samsung	251
404	Cooley	0	LG	159
405	Franklin	7	Samsung	12
406	Weiss	1	BlackBerry	175
407	Guzman	9	LG	197
408	Watkins	3	Apple	17
409	Hensley	0	HTC	197
410	Sweeney	9	Samsung	57
411	Deleon	10	LG	93
412	Barker	10	BlackBerry	161
413	Flores	1	Nokia	79
414	Head	11	Samsung	190
415	Merrill	5	Samsung	243
416	Pruitt	11	Apple	184
417	Huffman	6	HTC	180
418	Ray	7	HTC	86
419	Cobb	11	Apple	71
420	Hobbs	12	Nokia	54
421	Terrell	5	Samsung	188
422	Salazar	0	LG	24
423	Sweet	8	Apple	215
424	Bishop	12	LG	133
426	Colon	6	BlackBerry	184
427	Beach	13	Samsung	258
428	Koch	12	Apple	59
429	Stanley	5	Apple	231
430	Foreman	11	LG	209
431	Perry	7	HTC	22
432	Perry	14	Nokia	293
433	Aguilar	8	LG	226
434	Green	7	LG	284
435	Paul	8	HTC	188
436	Ashley	13	Nokia	129
437	Kane	10	BlackBerry	159
438	Abbott	2	Samsung	152
439	Bray	7	Samsung	201
440	Daniel	0	Samsung	85
441	Ruiz	6	Apple	27
442	Murray	10	Samsung	72
443	Raymond	2	Nokia	213
444	Wynn	7	BlackBerry	18
445	Flynn	1	Apple	169
446	Gomez	3	Samsung	181
447	Richardson	14	Apple	188
448	Hobbs	4	LG	156
449	Ware	5	Nokia	271
450	Buckley	0	HTC	17
451	Camacho	10	Apple	170
452	Stanley	7	Apple	21
453	Huffman	2	Samsung	58
454	Salazar	6	HTC	90
455	Everett	12	Samsung	284
456	Gomez	14	Nokia	134
457	Campbell	0	LG	45
458	Frederick	13	Samsung	81
459	Mendoza	13	LG	104
460	Rodriquez	9	BlackBerry	165
461	Meyer	6	Apple	115
462	Nelson	9	Nokia	214
463	Zamora	13	Samsung	72
464	Head	14	LG	31
465	Rich	8	HTC	82
466	May	3	BlackBerry	63
467	Fernandez	10	Apple	265
468	Flores	3	Samsung	83
469	Bird	8	LG	216
470	Drake	13	HTC	174
471	Flowers	0	Nokia	211
472	Phelps	5	LG	17
473	Bird	7	LG	58
474	Weiss	6	BlackBerry	64
475	Pickett	13	Nokia	220
476	Terrell	13	LG	102
477	Francis	10	Apple	242
478	Flowers	3	LG	64
479	Chaney	10	HTC	292
480	Robertson	5	LG	123
481	Hahn	10	BlackBerry	83
482	Sweeney	7	LG	299
484	Sampson	5	Nokia	206
485	Puckett	13	BlackBerry	148
486	Wilkinson	13	Nokia	16
487	Paul	9	LG	149
488	Underwood	4	Samsung	293
489	Lloyd	5	LG	117
490	Sharpe	2	Nokia	159
491	Jordan	6	Samsung	10
492	Weiss	1	Samsung	255
493	Boyer	8	HTC	83
494	Sampson	0	Apple	251
495	Drake	4	BlackBerry	246
496	Salinas	12	Apple	105
497	Phelps	12	BlackBerry	159
498	David	12	Samsung	45
499	Horne	4	Nokia	208
500	Vega	1	Nokia	23
501	Klein	7	Nokia	216
502	Francis	8	BlackBerry	261
503	Hudson	7	BlackBerry	250
504	Stanley	11	Nokia	272
505	Wong	9	HTC	225
506	Knox	11	Samsung	281
507	Michael	10	Apple	119
508	Pierce	2	Apple	85
509	Kirk	7	BlackBerry	250
510	Pacheco	6	BlackBerry	93
511	Mcdowell	10	LG	39
512	Pickett	6	Samsung	47
513	Case	8	LG	269
514	Booker	11	HTC	248
515	Vega	11	HTC	6
516	Zamora	12	LG	52
517	Benson	7	HTC	15
518	Bryan	9	Apple	12
519	Lane	9	Apple	290
520	Barrera	4	BlackBerry	130
521	Hart	0	HTC	288
522	Oconnor	2	BlackBerry	144
523	Norman	12	Nokia	293
524	Michael	11	Nokia	42
525	Carver	13	HTC	72
526	Raymond	0	Nokia	84
527	Butler	14	Samsung	55
528	Phillips	2	Nokia	11
529	Hobbs	12	Apple	210
530	Bartlett	12	BlackBerry	247
531	Woods	9	Samsung	25
532	Gordon	9	Nokia	193
533	Ashley	12	BlackBerry	84
534	Sampson	8	Apple	208
535	Gutierrez	14	Samsung	14
536	Walker	4	LG	129
537	Sampson	0	Nokia	222
538	Horne	8	Nokia	223
539	Atkinson	3	Samsung	196
540	Burnett	10	Samsung	287
541	Bowers	8	Apple	140
542	Deleon	12	Samsung	158
543	Lindsay	8	LG	40
544	Barrera	10	LG	186
546	Bartlett	1	HTC	241
547	Fox	3	LG	114
548	Nelson	10	LG	238
549	Hobbs	5	BlackBerry	166
550	Ayers	8	Nokia	67
551	Deleon	4	Apple	265
552	Pacheco	6	Nokia	28
553	Chapman	5	Nokia	291
554	Brown	6	Samsung	243
555	Sharpe	2	Apple	64
556	Trujillo	11	Apple	173
557	Fox	6	Samsung	283
558	Hensley	1	Apple	60
559	Gill	5	BlackBerry	293
560	Mendoza	5	BlackBerry	285
561	Santiago	12	LG	299
562	Jones	14	Samsung	3
563	Evans	13	LG	17
564	Hart	8	BlackBerry	233
565	Fry	3	HTC	63
566	Cannon	7	BlackBerry	94
567	David	14	LG	29
568	Ruiz	3	HTC	269
569	Oneal	2	HTC	119
570	Ashley	6	HTC	32
571	Lloyd	10	LG	171
572	Kim	7	BlackBerry	17
573	Sellers	4	Samsung	185
574	Mcmillan	8	Samsung	50
575	Norris	5	HTC	32
576	Murray	2	Nokia	109
577	Deleon	1	BlackBerry	270
578	Sampson	4	Nokia	63
579	Vega	0	Apple	71
580	Chavez	2	HTC	157
581	Gomez	12	Samsung	85
582	Key	9	Nokia	32
583	Donaldson	6	BlackBerry	264
584	Ware	14	LG	284
585	Levy	13	Samsung	136
586	Haynes	4	HTC	296
587	Hahn	11	BlackBerry	160
588	Flowers	7	HTC	106
589	Flowers	11	Samsung	12
590	Morris	7	HTC	65
591	Leonard	8	Nokia	186
592	Gross	13	Samsung	6
593	Lopez	4	Nokia	21
594	Bender	1	HTC	155
595	Flynn	6	LG	200
596	Flowers	8	Apple	132
597	Pierce	4	BlackBerry	133
598	Gentry	11	Samsung	205
599	Cantrell	0	LG	78
\.


--
-- Name: peripherique_id_peripherique_seq; Type: SEQUENCE SET; Schema: public; Owner: sultano
--

SELECT pg_catalog.setval('peripherique_id_peripherique_seq', 599, true);


--
-- Name: peripherique_id_se_seq; Type: SEQUENCE SET; Schema: public; Owner: sultano
--

SELECT pg_catalog.setval('peripherique_id_se_seq', 1, true);


--
-- Data for Name: systeme_exploitation; Type: TABLE DATA; Schema: public; Owner: sultano
--

COPY systeme_exploitation (id, nom, version) FROM stdin;
2	Cyborg	14
3	Cyborg	15
4	Cyborg	19
5	Bionic	0
6	Cyborg	17
7	Cyborg	3
8	Cyborg	18
9	Cyborg	1
10	Predator	4
11	Bionic	10
12	Predator	12
13	Cyborg	6
14	Bionic	19
15	Bionic	1
16	Bionic	1
17	Cyborg	1
18	Cyborg	18
19	Cyborg	14
20	Cyborg	13
21	Predator	6
22	Predator	13
23	Cyborg	19
24	Predator	0
25	Bionic	1
26	Cyborg	19
27	Predator	2
28	Cyborg	7
29	Bionic	16
30	Bionic	3
31	Bionic	18
32	Bionic	15
33	Cyborg	9
34	Cyborg	7
35	Cyborg	7
36	Cyborg	5
37	Cyborg	5
38	Bionic	4
39	Cyborg	2
40	Cyborg	3
41	Cyborg	9
42	Cyborg	12
43	Predator	15
44	Bionic	13
45	Predator	15
46	Cyborg	8
47	Predator	0
48	Bionic	17
49	Cyborg	10
50	Predator	17
51	Bionic	0
52	Bionic	11
53	Cyborg	3
54	Cyborg	14
55	Bionic	7
56	Bionic	6
57	Cyborg	2
58	Predator	5
59	Predator	8
60	Cyborg	1
61	Cyborg	13
62	Predator	6
63	Cyborg	13
64	Cyborg	11
65	Bionic	18
66	Cyborg	17
67	Cyborg	15
68	Cyborg	4
69	Cyborg	5
70	Cyborg	3
71	Cyborg	7
72	Cyborg	4
73	Bionic	14
74	Cyborg	19
75	Predator	10
76	Cyborg	7
77	Bionic	0
78	Cyborg	8
79	Bionic	1
80	Cyborg	3
81	Cyborg	15
82	Bionic	17
83	Predator	7
84	Cyborg	17
85	Predator	4
86	Predator	12
87	Cyborg	15
88	Predator	11
89	Cyborg	17
90	Predator	4
91	Cyborg	4
92	Predator	1
93	Bionic	2
94	Bionic	7
95	Predator	0
96	Cyborg	13
97	Bionic	0
98	Cyborg	1
99	Predator	17
100	Bionic	6
101	Bionic	9
102	Cyborg	5
103	Cyborg	9
104	Bionic	0
105	Cyborg	7
106	Bionic	9
107	Cyborg	18
108	Cyborg	3
109	Cyborg	10
110	Cyborg	18
111	Cyborg	3
112	Cyborg	16
113	Predator	5
114	Predator	17
115	Bionic	17
116	Cyborg	9
117	Bionic	10
118	Bionic	10
119	Bionic	5
120	Predator	13
121	Cyborg	18
122	Predator	4
123	Predator	19
124	Bionic	18
125	Cyborg	5
126	Bionic	17
127	Bionic	6
128	Cyborg	19
129	Cyborg	13
130	Cyborg	9
131	Cyborg	7
132	Cyborg	11
133	Cyborg	5
134	Cyborg	17
135	Bionic	14
136	Cyborg	14
137	Bionic	1
138	Cyborg	3
139	Bionic	17
140	Predator	5
141	Bionic	1
142	Predator	15
143	Bionic	3
144	Cyborg	3
145	Cyborg	3
146	Predator	16
147	Cyborg	3
148	Cyborg	11
149	Cyborg	11
150	Cyborg	2
151	Bionic	10
152	Cyborg	12
153	Cyborg	16
154	Cyborg	10
155	Cyborg	5
156	Cyborg	10
157	Cyborg	5
158	Predator	18
159	Cyborg	18
160	Cyborg	4
161	Cyborg	10
162	Bionic	19
163	Bionic	1
164	Cyborg	13
165	Predator	16
166	Cyborg	1
167	Cyborg	17
168	Bionic	13
169	Cyborg	6
170	Cyborg	0
171	Predator	9
172	Predator	16
173	Cyborg	8
174	Bionic	12
175	Cyborg	9
176	Predator	7
177	Bionic	1
178	Cyborg	6
179	Cyborg	2
180	Predator	14
181	Bionic	8
182	Cyborg	0
183	Bionic	10
184	Cyborg	14
185	Cyborg	13
186	Cyborg	7
187	Cyborg	15
188	Bionic	15
189	Bionic	0
190	Cyborg	12
191	Predator	5
192	Bionic	1
193	Predator	11
194	Cyborg	8
195	Predator	9
196	Cyborg	0
197	Cyborg	12
198	Cyborg	16
199	Cyborg	18
200	Cyborg	3
201	Cyborg	14
202	Bionic	13
203	Cyborg	18
204	Predator	6
205	Bionic	18
206	Cyborg	17
207	Cyborg	0
208	Cyborg	13
209	Bionic	9
210	Bionic	6
211	Predator	2
212	Cyborg	11
213	Cyborg	4
214	Bionic	13
215	Cyborg	14
216	Cyborg	17
217	Cyborg	17
218	Predator	5
219	Predator	17
220	Predator	12
221	Predator	15
222	Cyborg	14
223	Cyborg	8
224	Cyborg	7
225	Bionic	5
226	Cyborg	0
227	Cyborg	3
228	Bionic	14
229	Predator	7
230	Cyborg	13
231	Predator	13
232	Predator	14
233	Bionic	16
234	Cyborg	9
235	Cyborg	6
236	Cyborg	0
237	Cyborg	6
238	Predator	1
239	Cyborg	6
240	Cyborg	10
241	Cyborg	0
242	Bionic	15
243	Bionic	2
244	Predator	10
245	Bionic	18
246	Predator	3
247	Bionic	6
248	Cyborg	7
249	Predator	2
250	Bionic	9
251	Cyborg	0
252	Predator	17
253	Bionic	9
254	Predator	2
255	Cyborg	1
256	Cyborg	13
257	Predator	11
258	Bionic	5
259	Cyborg	18
260	Cyborg	17
261	Cyborg	17
262	Cyborg	13
263	Predator	17
264	Predator	13
265	Bionic	5
266	Predator	18
267	Cyborg	17
268	Bionic	16
269	Predator	17
270	Bionic	15
271	Bionic	16
272	Bionic	17
273	Cyborg	1
274	Bionic	3
275	Bionic	18
276	Predator	10
277	Cyborg	13
278	Cyborg	2
279	Cyborg	1
280	Cyborg	5
281	Bionic	1
282	Bionic	6
283	Bionic	2
284	Bionic	15
285	Cyborg	3
286	Cyborg	13
287	Bionic	18
288	Cyborg	2
289	Bionic	9
290	Bionic	0
291	Predator	18
292	Bionic	16
293	Predator	13
294	Predator	13
295	Bionic	1
296	Predator	5
297	Bionic	9
298	Predator	12
299	Cyborg	12
300	Cyborg	8
301	Cyborg	8
302	Cyborg	5
303	Cyborg	14
304	Cyborg	4
305	Bionic	0
306	Bionic	9
307	Bionic	6
308	Cyborg	16
309	Cyborg	9
310	Cyborg	15
311	Predator	19
312	Bionic	11
313	Predator	6
314	Cyborg	1
315	Predator	18
316	Predator	10
317	Bionic	19
318	Bionic	2
319	Predator	18
320	Cyborg	9
321	Bionic	5
322	Bionic	16
323	Bionic	9
324	Cyborg	3
325	Bionic	15
326	Predator	4
327	Cyborg	10
328	Predator	11
329	Cyborg	6
330	Cyborg	4
331	Bionic	17
332	Cyborg	7
333	Cyborg	4
334	Bionic	8
335	Predator	12
336	Predator	12
337	Predator	19
338	Predator	16
339	Predator	18
340	Bionic	2
341	Cyborg	1
342	Predator	11
343	Bionic	9
344	Cyborg	16
345	Cyborg	18
346	Cyborg	12
347	Predator	16
348	Bionic	19
349	Cyborg	12
350	Bionic	7
351	Cyborg	18
352	Bionic	14
353	Bionic	6
354	Predator	2
355	Bionic	16
356	Cyborg	4
357	Cyborg	15
358	Bionic	5
359	Predator	12
360	Cyborg	16
361	Bionic	3
362	Bionic	7
363	Cyborg	19
364	Cyborg	10
365	Cyborg	3
366	Predator	13
367	Cyborg	0
368	Predator	3
369	Cyborg	9
370	Bionic	5
371	Cyborg	19
372	Cyborg	6
373	Bionic	10
374	Cyborg	1
375	Bionic	16
376	Cyborg	4
377	Cyborg	4
378	Bionic	18
379	Bionic	8
380	Bionic	7
381	Cyborg	16
382	Bionic	5
383	Cyborg	5
384	Cyborg	6
385	Cyborg	3
386	Predator	16
387	Cyborg	16
388	Cyborg	5
389	Cyborg	3
390	Predator	5
391	Cyborg	19
392	Bionic	18
393	Cyborg	9
394	Cyborg	4
395	Predator	5
396	Cyborg	1
397	Bionic	19
398	Predator	10
399	Cyborg	16
400	Predator	19
401	Cyborg	10
402	Cyborg	13
403	Cyborg	19
404	Cyborg	0
405	Predator	9
406	Cyborg	16
407	Cyborg	16
408	Cyborg	14
409	Bionic	12
410	Bionic	12
411	Cyborg	5
412	Cyborg	9
413	Cyborg	0
414	Bionic	12
415	Bionic	3
416	Cyborg	5
417	Cyborg	12
418	Bionic	3
419	Predator	8
420	Bionic	16
421	Bionic	16
422	Bionic	6
423	Cyborg	11
424	Predator	2
425	Cyborg	9
426	Bionic	15
427	Cyborg	16
428	Predator	6
429	Bionic	13
430	Bionic	7
431	Cyborg	10
432	Cyborg	9
433	Bionic	6
434	Cyborg	12
435	Cyborg	8
436	Cyborg	1
437	Predator	16
438	Cyborg	15
439	Cyborg	4
440	Predator	4
441	Bionic	4
442	Bionic	15
443	Cyborg	11
444	Cyborg	16
445	Cyborg	8
446	Cyborg	0
447	Bionic	9
448	Bionic	13
449	Cyborg	6
450	Cyborg	8
451	Bionic	2
452	Cyborg	4
453	Cyborg	9
454	Bionic	10
455	Bionic	10
456	Cyborg	2
457	Bionic	11
458	Bionic	8
459	Cyborg	9
460	Cyborg	1
461	Bionic	7
462	Bionic	15
463	Predator	14
464	Cyborg	18
465	Cyborg	7
466	Cyborg	1
467	Predator	16
468	Cyborg	9
469	Bionic	13
470	Bionic	16
471	Cyborg	14
472	Cyborg	12
473	Cyborg	12
474	Cyborg	18
475	Bionic	0
476	Cyborg	16
477	Cyborg	17
478	Predator	18
479	Cyborg	17
480	Cyborg	1
481	Bionic	3
482	Cyborg	19
483	Predator	18
484	onic	10
485	Cyborg	0
486	Bionic	6
487	Cyborg	17
488	Predator	12
489	Cyborg	17
490	Predator	8
491	Cyborg	7
492	Cyborg	19
493	Predator	1
494	Cyborg	3
495	Cyborg	14
496	Bionic	3
497	Cyborg	3
498	Cyborg	15
499	Cyborg	19
500	Predator	14
501	Cyborg	10
502	Bionic	0
503	Cyborg	0
504	Cyborg	10
505	Cyborg	5
506	Cyborg	8
507	Predator	13
508	Predator	13
509	Cyborg	5
510	Cyborg	9
511	Bionic	3
512	Cyborg	5
513	Cyborg	0
514	Cyborg	5
515	Predator	19
516	Cyborg	17
517	Predator	4
518	Predator	12
519	Cyborg	9
520	Cyborg	0
521	Predator	1
522	Bionic	4
523	Bionic	10
524	Cyborg	6
525	Bionic	5
526	Cyborg	9
527	Predator	18
528	Cyborg	13
529	Predator	14
530	Cyborg	13
531	Cyborg	1
532	Predator	0
533	Cyborg	18
534	Cyborg	15
535	Bionic	16
536	Cyborg	0
537	Cyborg	1
538	Cyborg	13
539	Predator	18
540	Cyborg	1
541	Bionic	0
542	Cyborg	7
543	Cyborg	4
544	Cyborg	4
545	Cyborg	13
546	Predator	7
547	Predator	9
548	Cyborg	14
549	Cyborg	14
550	Bionic	13
551	Cyborg	14
552	Cyborg	2
553	Cyborg	16
554	Predator	9
555	Cyborg	18
556	Predator	9
557	Predator	19
558	Cyborg	9
559	Cyborg	2
560	Predator	9
561	Bionic	14
562	Cyborg	1
563	Bionic	17
564	Cyborg	1
565	Predator	2
566	Cyborg	12
567	Predator	0
568	Cyborg	18
569	Cyborg	0
570	Predator	5
571	Cyborg	0
572	Cyborg	8
573	Bionic	10
574	Cyborg	11
575	Cyborg	5
576	Cyborg	7
577	Predator	8
578	Cyborg	13
579	Bionic	12
580	Cyborg	1
581	Cyborg	8
582	Cyborg	14
583	Cyborg	11
584	Predator	4
585	Predator	3
586	Cyborg	11
587	Cyborg	4
588	Bionic	4
589	Cyborg	9
590	Cyborg	2
591	Cyborg	1
592	Predator	16
593	Cyborg	18
594	Predator	11
595	Predator	9
596	Cyborg	0
597	Cyborg	1
598	Predator	11
1	Predator	1
0	Cyborg	15
\.


--
-- Name: systeme_exploitation_id_se_seq; Type: SEQUENCE SET; Schema: public; Owner: sultano
--

SELECT pg_catalog.setval('systeme_exploitation_id_se_seq', 598, true);


--
-- Data for Name: telechargement; Type: TABLE DATA; Schema: public; Owner: sultano
--

COPY telechargement (id_user, id_application, id_peripherique, date, id) FROM stdin;
1	430	1	2013-03-04	600
2	68	2	2013-03-09	601
3	67	3	2013-11-15	602
4	441	4	2013-10-28	603
5	319	5	2014-03-19	604
6	23	6	2012-05-03	605
7	373	7	2013-03-07	606
8	294	8	2012-12-20	607
9	250	9	2013-01-27	608
10	14	10	2012-09-07	609
11	339	11	2013-04-05	610
12	198	12	2013-12-29	611
13	370	13	2014-01-09	612
14	29	14	2012-06-25	613
15	31	15	2013-07-20	614
16	364	16	2013-02-10	615
17	370	17	2013-03-25	616
18	149	18	2014-02-23	617
19	450	19	2013-05-25	618
20	445	20	2013-03-08	619
21	122	21	2012-12-02	620
22	92	22	2013-06-13	621
23	532	23	2013-09-06	622
24	239	24	2013-03-10	623
25	355	25	2013-09-25	624
26	538	26	2013-01-30	625
27	429	27	2012-09-21	626
28	191	28	2013-06-27	627
29	173	29	2013-09-11	628
30	90	30	2013-09-15	629
31	354	31	2012-08-01	630
32	140	32	2013-01-06	631
33	407	33	2012-11-04	632
34	330	34	2012-11-06	633
35	173	35	2012-10-24	634
36	200	36	2012-10-18	635
37	378	37	2012-07-24	636
38	323	38	2012-12-26	637
39	284	39	2013-10-03	638
40	3	40	2013-02-12	639
41	357	41	2013-10-23	640
42	281	42	2013-10-04	641
43	68	43	2012-10-10	642
44	354	44	2012-06-03	643
45	344	45	2013-06-17	644
46	244	46	2013-01-17	645
47	453	47	2012-05-15	646
48	429	48	2012-10-18	647
49	125	49	2013-03-27	648
50	174	50	2013-12-19	649
51	34	51	2013-05-01	650
52	397	52	2014-01-25	651
53	188	53	2012-11-28	652
54	292	54	2012-12-22	653
55	184	55	2013-12-06	654
56	357	56	2014-03-03	655
57	472	57	2013-07-13	656
58	6	58	2012-07-25	657
59	511	59	2013-03-14	658
60	12	60	2014-02-18	659
61	475	61	2014-03-04	660
62	269	62	2013-12-12	661
63	123	63	2013-09-16	662
64	522	64	2014-04-07	663
65	169	65	2012-05-06	664
66	128	66	2014-03-23	665
67	456	67	2014-02-01	666
68	149	68	2012-05-28	667
69	65	69	2013-01-12	668
70	158	70	2013-12-05	669
71	351	71	2013-10-04	670
72	208	72	2013-06-27	671
73	192	73	2014-03-25	672
74	25	74	2013-07-02	673
75	13	75	2014-01-28	674
76	555	76	2013-05-11	675
77	213	77	2012-09-13	676
78	476	78	2013-12-14	677
79	485	79	2013-08-18	678
80	478	80	2013-11-19	679
81	41	81	2013-10-02	680
82	129	82	2012-06-24	681
83	118	83	2013-02-18	682
84	33	84	2013-07-20	683
85	31	85	2013-09-19	684
86	286	86	2013-02-11	685
87	508	87	2013-05-24	686
88	375	88	2012-08-07	687
89	164	89	2013-07-28	688
90	171	90	2013-03-04	689
91	316	91	2013-03-09	690
92	172	92	2013-11-15	691
93	243	93	2013-10-28	692
94	130	94	2014-03-19	693
95	360	95	2012-05-03	694
96	112	96	2013-03-07	695
97	397	97	2012-12-20	696
98	163	98	2013-01-27	697
99	383	99	2012-09-07	698
100	298	100	2013-04-05	699
101	34	101	2013-12-29	700
102	128	102	2014-01-09	701
103	154	103	2012-06-25	702
104	439	104	2013-07-20	703
105	424	105	2013-02-10	704
106	154	106	2013-03-25	705
107	419	107	2014-02-23	706
108	482	108	2013-05-25	707
109	475	109	2013-03-08	708
110	405	110	2012-12-02	709
111	403	111	2013-06-13	710
112	184	112	2013-09-06	711
113	278	113	2013-03-10	712
114	238	114	2013-09-25	713
115	281	115	2013-01-30	714
116	255	116	2012-09-21	715
117	47	117	2013-06-27	716
118	52	118	2013-09-11	717
119	45	119	2013-09-15	718
120	55	120	2012-08-01	719
121	85	121	2013-01-06	720
122	384	122	2012-11-04	721
123	243	123	2012-11-06	722
124	187	124	2012-10-24	723
125	260	125	2012-10-18	724
126	373	126	2012-07-24	725
127	488	127	2012-12-26	726
128	348	128	2013-10-03	727
129	17	129	2013-02-12	728
130	47	130	2013-10-23	729
131	512	131	2013-10-04	730
132	388	132	2012-10-10	731
133	267	133	2012-06-03	732
134	213	134	2013-06-17	733
135	293	135	2013-01-17	734
136	517	136	2012-05-15	735
137	315	137	2012-10-18	736
138	254	138	2013-03-27	737
139	148	139	2013-12-19	738
140	250	140	2013-05-01	739
141	533	141	2014-01-25	740
142	235	142	2012-11-28	741
143	473	143	2012-12-22	742
144	412	144	2013-12-06	743
145	456	145	2014-03-03	744
146	502	146	2013-07-13	745
147	175	147	2012-07-25	746
148	460	148	2013-03-14	747
149	28	149	2014-02-18	748
150	464	150	2014-03-04	749
151	394	151	2013-12-12	750
152	456	152	2013-09-16	751
153	500	153	2014-04-07	752
154	379	154	2012-05-06	753
155	539	155	2014-03-23	754
156	532	156	2014-02-01	755
157	542	157	2012-05-28	756
158	86	158	2013-01-12	757
159	441	159	2013-12-05	758
160	372	160	2013-10-04	759
161	69	161	2013-06-27	760
162	286	162	2014-03-25	761
163	226	163	2013-07-02	762
164	340	164	2014-01-28	763
165	397	165	2013-05-11	764
166	211	166	2012-09-13	765
167	550	167	2013-12-14	766
168	76	168	2013-08-18	767
169	156	169	2013-11-19	768
170	357	170	2013-10-02	769
171	134	171	2012-06-24	770
172	168	172	2013-02-18	771
173	13	173	2013-07-20	772
174	411	174	2013-09-19	773
175	81	175	2013-02-11	774
176	515	176	2013-05-24	775
177	131	177	2012-08-07	776
178	479	178	2013-07-28	777
179	502	179	2013-03-04	778
180	450	180	2013-03-09	779
181	261	181	2013-11-15	780
182	31	182	2013-10-28	781
183	195	183	2014-03-19	782
184	334	184	2012-05-03	783
185	14	185	2013-03-07	784
186	81	186	2012-12-20	785
187	469	187	2013-01-27	786
188	28	188	2012-09-07	787
189	109	189	2013-04-05	788
190	239	190	2013-12-29	789
191	358	191	2014-01-09	790
192	95	192	2012-06-25	791
193	254	193	2013-07-20	792
194	242	194	2013-02-10	793
195	326	195	2013-03-25	794
196	288	196	2014-02-23	795
197	512	197	2013-05-25	796
198	312	198	2013-03-08	797
199	415	199	2012-12-02	798
200	118	200	2013-06-13	799
201	342	201	2013-09-06	800
202	18	202	2013-03-10	801
203	467	203	2013-09-25	802
204	542	204	2013-01-30	803
205	69	205	2012-09-21	804
206	50	206	2013-06-27	805
207	294	207	2013-09-11	806
208	348	208	2013-09-15	807
209	524	209	2012-08-01	808
210	403	210	2013-01-06	809
211	436	211	2012-11-04	810
212	25	212	2012-11-06	811
213	127	213	2012-10-24	812
214	447	214	2012-10-18	813
215	305	215	2012-07-24	814
216	98	216	2012-12-26	815
217	376	217	2013-10-03	816
218	246	218	2013-02-12	817
219	522	219	2013-10-23	818
220	300	220	2013-10-04	819
221	24	221	2012-10-10	820
222	388	222	2012-06-03	821
223	50	223	2013-06-17	822
224	539	224	2013-01-17	823
225	288	225	2012-05-15	824
226	375	226	2012-10-18	825
227	558	227	2013-03-27	826
228	503	228	2013-12-19	827
229	341	229	2013-05-01	828
230	345	230	2014-01-25	829
231	316	231	2012-11-28	830
232	332	232	2012-12-22	831
233	156	233	2013-12-06	832
234	71	234	2014-03-03	833
235	120	235	2013-07-13	834
236	315	236	2012-07-25	835
237	533	237	2013-03-14	836
238	243	238	2014-02-18	837
239	176	239	2014-03-04	838
240	116	240	2013-12-12	839
241	1	241	2013-09-16	840
242	178	242	2014-04-07	841
243	142	243	2012-05-06	842
244	362	244	2014-03-23	843
245	145	245	2014-02-01	844
246	537	246	2012-05-28	845
247	56	247	2013-01-12	846
248	304	248	2013-12-05	847
249	426	249	2013-10-04	848
250	273	250	2013-06-27	849
251	490	251	2014-03-25	850
252	158	252	2013-07-02	851
253	44	253	2014-01-28	852
254	314	254	2013-05-11	853
255	149	255	2012-09-13	854
256	118	256	2013-12-14	855
257	308	257	2013-08-18	856
258	380	258	2013-11-19	857
259	9	259	2013-10-02	858
260	268	260	2012-06-24	859
261	526	261	2013-02-18	860
262	453	262	2013-07-20	861
263	9	263	2013-09-19	862
264	57	264	2013-02-11	863
265	497	265	2013-05-24	864
266	481	266	2012-08-07	865
267	10	267	2013-07-28	866
268	516	268	2013-03-04	867
269	120	269	2013-03-09	868
270	194	270	2013-11-15	869
271	526	271	2013-10-28	870
272	414	272	2014-03-19	871
273	308	273	2012-05-03	872
274	329	274	2013-03-07	873
275	123	275	2012-12-20	874
276	235	276	2013-01-27	875
277	102	277	2012-09-07	876
278	173	278	2013-04-05	877
279	240	279	2013-12-29	878
280	232	280	2014-01-09	879
281	72	281	2012-06-25	880
282	12	282	2013-07-20	881
283	268	283	2013-02-10	882
284	476	284	2013-03-25	883
285	26	285	2014-02-23	884
286	276	286	2013-05-25	885
287	95	287	2013-03-08	886
288	369	288	2012-12-02	887
289	4	289	2013-06-13	888
290	224	290	2013-09-06	889
291	135	291	2013-03-10	890
292	96	292	2013-09-25	891
293	176	293	2013-01-30	892
294	367	294	2012-09-21	893
295	161	295	2013-06-27	894
296	246	296	2013-09-11	895
297	79	297	2013-09-15	896
298	347	298	2012-08-01	897
299	487	299	2013-01-06	898
300	15	300	2012-11-04	899
125	84	301	2012-11-06	900
68	124	302	2012-10-24	901
258	126	303	2012-10-18	902
50	70	304	2012-07-24	903
157	332	305	2012-12-26	904
240	69	306	2013-10-03	905
85	18	307	2013-02-12	906
275	428	308	2013-10-23	907
2	152	309	2013-10-04	908
233	402	310	2012-10-10	909
217	508	311	2012-06-03	910
13	487	312	2013-06-17	911
247	215	313	2013-01-17	912
19	243	314	2012-05-15	913
93	197	315	2012-10-18	914
122	143	316	2013-03-27	915
23	259	317	2013-12-19	916
41	307	318	2013-05-01	917
242	548	319	2014-01-25	918
34	489	320	2012-11-28	919
264	398	321	2012-12-22	920
290	343	322	2013-12-06	921
70	169	323	2014-03-03	922
206	216	324	2013-07-13	923
41	89	325	2012-07-25	924
48	24	326	2013-03-14	925
81	287	327	2014-02-18	926
209	344	328	2014-03-04	927
197	177	329	2013-12-12	928
112	495	330	2013-09-16	929
235	363	331	2014-04-07	930
128	253	332	2012-05-06	931
17	338	333	2014-03-23	932
45	524	334	2014-02-01	933
250	108	335	2012-05-28	934
189	441	336	2013-01-12	935
53	528	337	2013-12-05	936
76	533	338	2013-10-04	937
241	402	339	2013-06-27	938
29	543	340	2014-03-25	939
110	192	341	2013-07-02	940
20	203	342	2014-01-28	941
25	160	343	2013-05-11	942
243	191	344	2012-09-13	943
289	489	345	2013-12-14	944
246	159	346	2013-08-18	945
156	405	347	2013-11-19	946
130	63	348	2013-10-02	947
127	459	349	2012-06-24	948
51	13	350	2013-02-18	949
188	236	351	2013-07-20	950
275	205	352	2013-09-19	951
108	452	353	2013-02-11	952
172	101	354	2013-05-24	953
36	227	355	2012-08-07	954
45	397	356	2013-07-28	955
176	81	357	2013-03-04	956
94	400	358	2013-03-09	957
110	154	359	2013-11-15	958
230	375	360	2013-10-28	959
126	86	361	2014-03-19	960
189	58	362	2012-05-03	961
140	36	363	2013-03-07	962
56	218	364	2012-12-20	963
139	241	365	2013-01-27	964
42	326	366	2012-09-07	965
28	88	367	2013-04-05	966
41	463	368	2013-12-29	967
94	395	369	2014-01-09	968
221	96	370	2012-06-25	969
166	62	371	2013-07-20	970
180	519	372	2014-03-23	971
9	73	373	2014-02-01	972
270	50	374	2012-05-28	973
187	5	375	2013-01-12	974
93	497	376	2013-12-05	975
145	61	377	2013-10-04	976
7	414	378	2013-06-27	977
4	332	379	2014-03-25	978
128	518	380	2013-07-02	979
232	26	381	2014-01-28	980
240	348	382	2013-05-11	981
174	147	383	2012-09-13	982
277	231	384	2013-12-14	983
204	7	385	2013-08-18	984
198	396	386	2013-11-19	985
291	40	387	2013-10-02	986
94	448	388	2012-06-24	987
291	422	389	2013-02-18	988
192	339	390	2013-07-20	989
211	343	391	2013-09-19	990
78	524	392	2013-02-11	991
222	124	393	2013-05-24	992
248	261	394	2012-08-07	993
196	45	395	2013-07-28	994
98	140	396	2013-03-04	995
33	518	397	2013-03-09	996
69	273	398	2013-11-15	997
237	338	399	2013-10-28	998
86	96	400	2014-03-19	999
267	82	401	2012-05-03	1000
171	209	402	2013-03-07	1001
234	209	403	2012-12-20	1002
19	274	404	2013-01-27	1003
2	268	405	2012-09-07	1004
110	516	406	2013-04-05	1005
39	152	407	2013-12-29	1006
13	188	408	2014-01-09	1007
74	452	409	2012-06-25	1008
67	14	410	2013-07-20	1009
221	371	411	2013-02-10	1010
163	58	412	2013-03-25	1011
273	537	413	2014-02-23	1012
141	152	414	2013-05-25	1013
274	312	415	2013-03-08	1014
42	142	416	2012-12-02	1015
258	545	417	2013-06-13	1016
35	203	418	2013-09-06	1017
257	42	419	2013-03-10	1018
21	187	420	2013-09-25	1019
255	418	421	2013-01-30	1020
89	477	422	2012-09-21	1021
209	245	423	2013-06-27	1022
3	221	424	2013-09-11	1023
85	227	426	2012-08-01	1025
277	3	427	2013-01-06	1026
19	425	428	2012-11-04	1027
76	95	429	2012-11-06	1028
164	558	430	2012-10-24	1029
165	71	431	2012-10-18	1030
97	550	432	2012-07-24	1031
230	432	433	2012-12-26	1032
64	214	434	2013-10-03	1033
21	346	435	2013-02-12	1034
294	86	436	2013-10-23	1035
194	245	437	2013-10-04	1036
220	484	438	2012-10-10	1037
281	131	439	2012-06-03	1038
296	366	440	2013-06-17	1039
177	159	441	2013-01-17	1040
131	377	442	2012-05-15	1041
168	346	443	2012-10-18	1042
202	60	444	2013-03-27	1043
183	460	445	2013-12-19	1044
78	559	446	2013-05-01	1045
257	496	447	2014-01-25	1046
245	390	448	2012-11-28	1047
150	166	449	2012-12-22	1048
36	170	450	2013-12-06	1049
37	98	451	2014-03-03	1050
10	387	452	2013-07-13	1051
97	247	453	2012-07-25	1052
270	528	454	2013-03-14	1053
220	69	455	2014-02-18	1054
1	393	456	2014-03-04	1055
19	511	457	2013-12-12	1056
25	82	458	2013-09-16	1057
82	417	459	2014-04-07	1058
57	275	460	2012-05-06	1059
143	493	461	2013-02-10	1060
224	380	462	2013-03-25	1061
106	368	463	2014-02-23	1062
60	57	464	2013-05-25	1063
20	449	465	2013-03-08	1064
98	21	466	2012-12-02	1065
13	238	467	2013-06-13	1066
74	288	468	2013-09-06	1067
126	531	469	2013-03-10	1068
175	424	470	2013-09-25	1069
13	220	471	2013-01-30	1070
255	180	472	2012-09-21	1071
151	23	473	2013-06-27	1072
298	298	474	2013-09-11	1073
152	78	475	2013-09-15	1074
94	383	476	2012-08-01	1075
155	91	477	2013-01-06	1076
239	10	478	2012-11-04	1077
251	161	479	2012-11-06	1078
294	71	480	2012-10-24	1079
7	336	481	2012-10-18	1080
272	68	482	2012-07-24	1081
229	14	484	2013-10-03	1083
85	553	485	2013-02-12	1084
268	201	486	2013-10-23	1085
195	51	487	2013-10-04	1086
132	82	488	2012-10-10	1087
40	350	489	2012-06-03	1088
111	342	490	2013-06-17	1089
47	522	491	2013-01-17	1090
144	265	492	2012-05-15	1091
29	417	493	2012-10-18	1092
77	329	494	2013-03-27	1093
269	411	495	2013-12-19	1094
154	137	496	2013-05-01	1095
213	417	497	2014-01-25	1096
157	2	498	2012-11-28	1097
284	409	499	2012-12-22	1098
212	77	500	2013-12-06	1099
9	323	501	2014-03-03	1100
189	79	502	2013-07-13	1101
41	525	503	2012-07-25	1102
167	404	504	2013-03-14	1103
110	321	505	2014-02-18	1104
196	478	506	2014-03-04	1105
59	165	507	2013-12-12	1106
205	290	508	2013-09-16	1107
205	61	509	2014-04-07	1108
176	264	510	2012-05-06	1109
19	98	511	2014-03-23	1110
243	366	512	2014-02-01	1111
54	111	513	2012-05-28	1112
265	146	514	2013-01-12	1113
124	395	515	2013-12-05	1114
94	149	516	2013-10-04	1115
282	555	517	2013-06-27	1116
201	252	518	2014-03-25	1117
39	31	519	2013-07-02	1118
206	379	520	2014-01-28	1119
28	461	521	2013-05-11	1120
229	472	522	2012-09-13	1121
33	135	523	2013-12-14	1122
244	395	524	2013-08-18	1123
131	482	525	2013-11-19	1124
212	225	526	2013-10-02	1125
44	156	527	2012-06-24	1126
154	271	528	2013-02-18	1127
119	504	529	2013-07-20	1128
180	449	530	2013-09-19	1129
247	392	531	2013-02-11	1130
9	39	532	2013-05-24	1131
91	33	533	2012-08-07	1132
266	350	534	2013-07-28	1133
115	63	535	2013-03-04	1134
229	431	536	2013-03-09	1135
37	360	537	2013-11-15	1136
211	504	538	2013-10-28	1137
266	286	539	2014-03-19	1138
183	184	540	2012-05-03	1139
91	346	541	2013-03-07	1140
220	72	542	2012-12-20	1141
40	394	543	2013-01-27	1142
289	169	544	2012-09-07	1143
279	494	546	2013-12-29	1145
59	240	547	2014-01-09	1146
35	186	548	2012-06-25	1147
293	368	549	2013-07-20	1148
58	278	550	2013-02-10	1149
264	292	551	2013-03-25	1150
28	496	552	2014-02-23	1151
68	70	553	2013-05-25	1152
192	238	554	2013-03-08	1153
34	95	555	2012-12-02	1154
268	318	556	2013-06-13	1155
253	202	557	2013-09-06	1156
79	420	558	2013-03-10	1157
103	67	559	2013-09-25	1158
84	441	560	2013-01-30	1159
83	319	561	2012-09-21	1160
159	23	562	2013-06-27	1161
258	373	563	2013-09-11	1162
278	294	564	2013-09-15	1163
290	250	565	2012-08-01	1164
178	14	566	2013-01-06	1165
84	339	567	2012-11-04	1166
101	198	568	2012-11-06	1167
166	370	569	2012-10-24	1168
94	29	570	2012-10-18	1169
299	31	571	2012-07-24	1170
18	364	572	2012-12-26	1171
10	370	573	2013-10-03	1172
163	149	574	2013-02-12	1173
58	450	575	2013-10-23	1174
66	445	576	2013-10-04	1175
141	122	577	2012-10-10	1176
193	92	578	2012-06-03	1177
30	532	579	2013-06-17	1178
276	239	580	2013-01-17	1179
197	355	581	2012-05-15	1180
234	538	582	2012-10-18	1181
207	429	583	2013-03-27	1182
28	191	584	2013-12-19	1183
140	173	585	2013-05-01	1184
124	90	586	2014-01-25	1185
246	354	587	2012-11-28	1186
168	140	588	2012-12-22	1187
37	407	589	2013-12-06	1188
204	330	590	2014-03-03	1189
45	173	591	2013-07-13	1190
260	200	592	2012-07-25	1191
150	378	593	2013-03-14	1192
247	323	594	2014-02-18	1193
4	284	595	2014-03-04	1194
265	3	596	2013-12-12	1195
23	357	597	2013-09-16	1196
201	281	598	2014-04-07	1197
277	68	599	2012-05-06	1198
\.


--
-- Name: telechargement_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sultano
--

SELECT pg_catalog.setval('telechargement_id_seq', 1198, true);


--
-- Name: user_id_user_seq; Type: SEQUENCE SET; Schema: public; Owner: sultano
--

SELECT pg_catalog.setval('user_id_user_seq', 300, true);


--
-- Data for Name: utilisateur; Type: TABLE DATA; Schema: public; Owner: sultano
--

COPY utilisateur (id, mail, mot_de_passe, num_install, type, nom, prenom) FROM stdin;
4	ac.turpis.egestas@elitelitfermentum.edu	Vestibulum ante ipsum	67	0	Michael	Justina
5	ut.pellentesque.eget@semperauctorMauris.com	congue turpis. In condimentum.	68	0	Mcpherson	Brady
6	lobortis@SednequeSed.org	euismod urna. Nullam lobortis	89	0	Puckett	Maite
7	dui.in@semperduilectus.com	tristique pellentesque, tellus	56	0	Byrd	Wilma
8	neque.In.ornare@enimnonnisi.ca	sodales. Mauris blandit	16	0	Fox	Indigo
9	faucibus.id.libero@elit.com	Phasellus dapibus quam	82	0	Harmon	Yardley
10	at.velit@liberoProinmi.ca	risus.	98	0	Price	Basil
11	lacus.Mauris@sem.org	pede sagittis	57	0	Delgado	Christian
12	risus.at@Nullamenim.ca	ullamcorper	87	0	Bray	Janna
13	tincidunt.Donec.vitae@arcuvel.edu	Integer sem elit, pharetra	20	0	Shaffer	Bree
14	aliquam@molestie.ca	auctor, nunc nulla	14	0	Gilbert	Alea
15	augue.scelerisque.mollis@vellectus.edu	tristique pharetra. Quisque ac	64	1	Kim	Tashya
16	penatibus@Etiamgravidamolestie.edu	augue scelerisque mollis.	30	0	Bernard	Pearl
17	Nunc.sed.orci@magnaSuspendissetristique.com	mauris eu elit. Nulla	70	0	Mueller	Fredericka
18	mattis.Cras.eget@id.com	ut nisi a odio	10	0	Lopez	Shannon
19	magna@eratsemperrutrum.com	nibh enim,	71	1	Gutierrez	Laith
20	adipiscing@liberoestcongue.org	Pellentesque tincidunt tempus risus.	69	0	Morris	Bree
21	nunc.ac@tinciduntnibh.com	nunc nulla vulputate dui,	58	1	Rich	Perry
22	Nunc@infelisNulla.org	risus.	66	0	Monroe	Daniel
23	interdum.feugiat.Sed@vestibulum.ca	vulputate,	70	0	Leon	Logan
24	convallis.dolor.Quisque@vehiculaaliquetlibero.org	arcu. Vestibulum ut	55	1	Leon	Logan
25	ligula.Aliquam@pede.edu	tristique pellentesque, tellus	67	0	Cunningham	Echo
26	Nunc.pulvinar.arcu@maurissagittis.edu	arcu. Curabitur ut odio	31	0	Head	Genevieve
27	molestie.arcu@feugiattellus.edu	ligula	71	0	Olsen	Blaine
28	gravida.Aliquam@pellentesqueSed.com	arcu. Curabitur ut odio	11	0	Vang	Curran
29	In.nec@Quisquetinciduntpede.ca	odio semper cursus. Integer	33	0	Cannon	Bree
30	Nulla.semper.tellus@turpis.edu	nibh. Phasellus nulla.	75	0	Boyer	Jade
31	dolor@sedconsequatauctor.edu	auctor, nunc nulla	92	0	Meyers	Leilani
32	convallis@dolorQuisquetincidunt.com	pede nec	9	1	Fisher	Lunea
33	sed@penatibuset.edu	nibh enim,	34	1	Mueller	Fredericka
34	in@sociosquadlitora.edu	sociis natoque penatibus et	46	0	Finley	Lareina
35	Donec.elementum@Integer.org	quis massa.	0	0	Case	Ivan
36	gravida.molestie@acsemut.com	semper, dui	93	0	Sweet	Judith
37	ipsum.leo@interdumCurabitur.com	eros non	76	0	Robertson	Lacota
38	ullamcorper.Duis@sapienNuncpulvinar.edu	eros non	82	0	Everett	Bruce
39	cursus@pharetraNam.ca	dignissim lacus. Aliquam	62	0	Cruz	Ross
40	ligula.Aenean@nonante.org	dui. Fusce aliquam,	81	0	Mendoza	Rhoda
41	lacus.Aliquam@accumsan.org	Suspendisse commodo	73	0	Flynn	Jessamine
42	a@sapien.ca	metus sit amet	69	0	Terrell	Amena
43	Sed@ametultricies.ca	Vestibulum ante ipsum	5	0	May	Britanney
44	urna.nec@ipsumnon.org	Pellentesque tincidunt tempus risus.	74	0	Thornton	Keane
45	auctor@hendreritaarcu.com	orci quis	71	1	Gonzalez	Hiroko
46	mauris@atlacusQuisque.edu	at pede.	35	0	Flores	Lee
47	lobortis.ultrices.Vivamus@anteVivamusnon.org	ut nisi a odio	71	0	Horne	Haley
48	euismod@mus.edu	eleifend egestas. Sed	98	0	Acosta	Piper
49	mollis@orcisem.com	in, cursus et, eros.	67	0	Jimenez	Harding
50	molestie.in@nulla.edu	auctor, nunc nulla	13	0	Levy	Medge
51	ac@scelerisque.edu	auctor, nunc nulla	62	0	Woods	Yvonne
52	nec@cursusInteger.com	orci quis	4	1	Gomez	Bernard
53	adipiscing.non.luctus@sapienmolestie.edu	in, cursus et, eros.	61	0	Stuart	Joshua
54	sem.molestie.sodales@cursuset.ca	urna. Ut tincidunt vehicula	7	0	Monroe	Daniel
55	Ut.tincidunt@ultricesposuerecubilia.edu	Suspendisse	67	1	Swanson	Callie
56	est.mauris.rhoncus@acmattis.edu	arcu. Vestibulum ut	20	1	Barr	Medge
57	nibh.dolor.nonummy@elementumpurus.edu	ullamcorper	88	0	Puckett	Maite
58	lobortis.risus@quamelementum.edu	eros non	46	0	Alford	Julian
59	nisl@quispedeSuspendisse.ca	sociis natoque penatibus et	26	0	Rice	Dane
60	Etiam.gravida@acmieleifend.org	mollis nec, cursus	28	1	Huffman	Chaney
61	Curabitur.egestas@Nunclectuspede.org	auctor, nunc nulla	90	0	Trujillo	Lilah
62	quis@Nam.org	risus.	90	0	Price	Basil
63	magna.nec@consectetuer.edu	in faucibus orci luctus	7	0	Lane	Acton
64	ligula.consectetuer.rhoncus@sem.edu	Pellentesque tincidunt tempus risus.	58	0	May	Britanney
65	eget.massa@metus.ca	enim	71	0	Acosta	Abel
66	nunc.id@conubianostraper.org	augue id ante dictum	23	1	Walton	Alisa
67	elit@tortor.ca	augue ac ipsum.	30	0	Terrell	Neville
68	dignissim.tempor@convalliserateget.com	sociis natoque penatibus et	0	0	Dean	Roth
69	Nunc@egetipsumDonec.com	bibendum. Donec	92	1	Flynn	Ursa
70	vel@montesnasceturridiculus.org	vel pede	61	0	Robertson	Lacota
2	b	b	91	2	Rogers	Nasim
1	mattia@yahoo.it	passwd	30	1	Bird	Griffith
3	mattia@yahoo.com	simple	80	0	iuhgf	kjh
71	diam.Sed.diam@Integer.edu	in faucibus orci luctus	29	0	Beasley	Stacey
72	lectus@magnaPraesentinterdum.com	dolor elit, pellentesque	33	0	Snyder	India
73	parturient.montes.nascetur@mifelis.org	rutrum lorem ac	71	0	Mcneil	Evelyn
74	hendrerit@lectusquis.org	bibendum. Donec	32	1	Rice	Dane
75	dictum@lacusvestibulumlorem.org	molestie	47	0	Sharpe	Charles
76	ornare@nibhlaciniaorci.ca	sociis natoque penatibus	0	0	Diaz	Kylie
77	Maecenas.ornare.egestas@eros.ca	dolor dolor, tempus	97	0	Webster	Sopoline
78	Integer.in@hendreritid.edu	sociis natoque penatibus et	65	0	Pennington	Vanna
79	Curabitur.sed@aliquameu.edu	sociosqu ad	24	0	Herrera	Quamar
80	sit.amet@sitametnulla.com	sociis natoque penatibus	64	0	Jimenez	Harding
81	gravida.molestie@feugiatmetus.org	Sed nec metus	52	1	Norman	Rahim
82	diam@arcuVivamus.org	malesuada	63	0	Woodward	Gail
83	Pellentesque.tincidunt@lobortis.ca	euismod et, commodo at,	17	0	Brady	Callie
84	et@nonummyFusce.ca	arcu. Curabitur ut odio	98	0	Swanson	Callie
85	lectus.pede@magnanecquam.ca	sociis natoque penatibus	40	0	Mueller	Fredericka
86	velit@Phasellusfermentumconvallis.edu	auctor, nunc nulla	4	0	Pacheco	Shoshana
87	parturient.montes@duilectusrutrum.ca	augue id ante dictum	61	1	Lindsay	Ina
88	neque.In.ornare@velfaucibusid.edu	rutrum lorem ac	11	0	Lamb	Walter
89	blandit.mattis@quis.com	non lorem	69	0	Leon	Logan
90	Quisque.tincidunt.pede@lectusjusto.org	mauris eu elit. Nulla	0	0	Woods	Yvonne
91	rutrum@lobortisnisi.com	ut, molestie in,	22	0	Murray	Nyssa
92	mollis@Seddictum.ca	gravida nunc sed pede.	23	0	Boyle	Lance
93	nonummy.ipsum.non@Proinsedturpis.ca	turpis non enim.	79	1	Mendoza	Rhoda
94	ipsum.cursus@VivamusrhoncusDonec.org	arcu.	67	1	Zamora	Cameron
95	Sed.nulla.ante@ullamcorper.edu	orci tincidunt adipiscing.	56	0	Beach	Porter
96	consequat.lectus.sit@atlacus.com	risus.	99	0	Clements	Kay
97	lacinia.Sed@sempertellusid.com	risus.	67	0	Beasley	Stacey
98	pharetra.Nam@vulputate.org	Aliquam erat	3	0	Barr	Medge
99	est.congue.a@placeratCrasdictum.ca	Duis	91	0	Shields	Gray
100	lorem@maurissit.com	nibh enim, gravida sit	50	1	Hensley	Kirestin
101	rhoncus.id@temporest.com	penatibus et	31	0	Blanchard	Ryder
102	Mauris.vestibulum.neque@elitpede.com	in, cursus et, eros.	9	0	Franklin	Anika
103	Aliquam.nec@egestasAliquam.com	congue turpis. In condimentum.	30	0	Chambers	Karyn
104	dolor.Fusce@Aliquam.org	turpis non enim.	26	1	Cantrell	Joelle
105	at.pretium.aliquet@fringilla.com	bibendum. Donec	34	1	Merrill	India
106	luctus.aliquet@nullaIntincidunt.edu	scelerisque mollis. Phasellus libero	56	1	Merrill	Alfonso
107	Quisque.purus@elitpede.org	dolor dolor, tempus	25	0	Phillips	Chantale
108	mauris.aliquam@fames.org	augue ac ipsum.	5	0	Colon	Skyler
109	litora.torquent@pede.org	congue	33	0	Huffman	Chaney
110	ante.bibendum@tempus.ca	eros non	31	0	May	Britanney
111	ullamcorper.magna.Sed@et.org	euismod urna. Nullam lobortis	46	0	Bender	Dieter
112	sem@Vivamusnon.ca	orci tincidunt adipiscing.	18	0	Lopez	Shannon
113	per@ante.com	augue ac ipsum.	60	0	Sawyer	Rachel
114	ornare.libero.at@euismod.com	bibendum. Donec	81	1	Boyle	Lance
115	aliquam@euismodenimEtiam.edu	lorem, vehicula et,	44	0	Gutierrez	Tanisha
116	Curabitur.sed.tortor@telluslorem.ca	Integer sem elit, pharetra	40	0	Cannon	Bree
117	lacus.Aliquam.rutrum@blanditNam.ca	augue malesuada malesuada. Integer	74	0	Hudson	Winter
118	dolor@Ut.ca	orci tincidunt adipiscing.	34	0	Langley	Kiona
119	auctor.velit@tincidunt.ca	sodales. Mauris blandit	64	0	Head	Genevieve
120	erat@ornarelectusante.org	enim	65	0	Hooper	Curran
121	Class.aptent@acmieleifend.org	mollis nec, cursus	68	1	Bender	Eden
122	a@nislelementumpurus.org	tristique pellentesque, tellus	74	0	Oconnor	Geoffrey
123	vel.arcu.Curabitur@feugiattelluslorem.org	Donec feugiat metus sit	56	0	Mcdowell	Jordan
124	mattis.velit@duiaugue.edu	enim	81	0	Flowers	Athena
125	nunc.sed.libero@gravida.edu	nisi	95	0	Boyer	Jade
126	fames@mi.ca	sociis natoque penatibus	19	0	Vega	Carol
127	pharetra.Nam.ac@atsemmolestie.org	Suspendisse	24	1	Fox	Thaddeus
128	adipiscing.enim.mi@magnaUt.com	Phasellus dapibus quam	18	0	Mcmillan	Shaeleigh
129	sapien.Cras@estvitaesodales.com	augue scelerisque mollis.	49	0	Fox	Indigo
130	commodo.at@ac.org	nibh. Phasellus nulla.	58	0	Cannon	Bree
131	malesuada.Integer.id@pedeCras.com	odio semper cursus. Integer	57	0	Alford	Carly
132	vel.venenatis.vel@acfermentum.ca	Duis	86	0	Sampson	Arsenio
133	et.commodo@Nullamvelitdui.ca	ullamcorper	41	0	Puckett	Maite
134	nibh@parturientmontes.edu	Suspendisse	47	1	Trujillo	Lilah
135	volutpat.Nulla@mattisvelitjusto.com	tristique pharetra. Quisque ac	41	1	Sharpe	Althea
136	rutrum.urna@eueratsemper.ca	amet, dapibus	43	0	Cannon	Bree
137	ac.eleifend@sed.ca	enim	81	0	Meyer	Macy
138	arcu@etarcuimperdiet.org	et malesuada	46	0	Wynn	Cecilia
139	hendrerit.consectetuer.cursus@suscipitest.edu	eleifend egestas. Sed	33	0	Ray	Cherokee
140	id.mollis@lectussit.com	at pede.	46	0	Everett	Darryl
141	Donec.felis.orci@odio.com	Phasellus dapibus quam	24	0	Orr	Walter
142	pharetra.Nam.ac@tinciduntdui.org	arcu. Vestibulum ut	50	1	Porter	Sydnee
143	enim.sit.amet@tempor.ca	urna. Ut tincidunt vehicula	54	0	Bowers	Whoopi
144	enim@mollisDuissit.ca	molestie	72	0	Butler	Kareem
145	eros.nec@vehicularisus.edu	enim	44	0	Lindsay	Ina
146	lorem.vitae@Maurisnon.org	ornare. Fusce mollis. Duis	7	0	Donaldson	Mia
147	vitae@Donecluctus.edu	nibh. Phasellus nulla.	67	0	Melton	Marcia
148	justo@liberoMorbiaccumsan.com	nec, mollis	8	0	Padilla	Britanney
149	risus.Nulla.eget@posuerevulputatelacus.edu	non lorem	50	0	Pratt	Amaya
150	et.commodo@auctorvelitAliquam.edu	arcu.	34	1	Wagner	Todd
151	orci.lacus@massaQuisqueporttitor.org	augue scelerisque mollis.	58	0	Flowers	Isaac
152	penatibus.et.magnis@laciniaSedcongue.com	arcu.	82	0	Fernandez	Oprah
153	condimentum.eget.volutpat@Nunclectuspede.com	et ultrices posuere cubilia	57	0	Frederick	Derek
154	dis.parturient@ac.ca	ullamcorper	68	0	Ayers	Fuller
155	nec.tellus@Loremipsum.edu	arcu.	67	1	David	Neil
156	euismod.ac@fringillaestMauris.ca	Aliquam erat	16	0	Swanson	Callie
157	congue.elit.sed@consequat.org	ornare. Fusce mollis. Duis	47	0	Hensley	Kirestin
158	egestas.Fusce.aliquet@acurnaUt.edu	semper, dui	61	0	Jimenez	Harding
159	ac.mi.eleifend@nec.edu	Donec feugiat metus sit	22	0	Blankenship	Cassidy
160	Proin@netus.com	orci quis	34	1	Head	Genevieve
161	auctor.velit.Aliquam@nec.edu	Duis	76	0	Jimenez	Harding
162	et.libero@pretium.edu	orci quis	27	1	Frederick	Margaret
163	feugiat.Sed.nec@erat.com	risus.	9	0	Chapman	Odette
164	semper.egestas@Aenean.edu	pede nec	55	1	Mcneil	Evelyn
165	Mauris.magna.Duis@Quisque.edu	nibh. Phasellus nulla.	89	0	Camacho	Jacob
166	aliquet@purussapien.edu	eleifend egestas.	24	0	Howe	Lisandra
167	nibh.enim@sit.edu	Pellentesque tincidunt tempus risus.	19	0	Merrill	Alfonso
168	Mauris.magna.Duis@Donecnibhenim.ca	in, cursus et, eros.	10	0	Morton	Ariel
169	orci.consectetuer.euismod@vitae.edu	habitant morbi tristique senectus	81	0	Diaz	Kylie
170	est@diam.org	bibendum. Donec	41	1	Waters	Hashim
171	Donec.at.arcu@convallisestvitae.com	Donec feugiat metus sit	33	0	Porter	Sydnee
172	tincidunt.pede@interdum.org	habitant morbi tristique senectus	50	0	Langley	Kiona
173	velit.Cras.lorem@enimSednulla.com	in, cursus et, eros.	20	0	Olsen	Blaine
174	eu.ultrices@magnaaneque.ca	vitae	8	0	Vazquez	Summer
175	orci.Phasellus.dapibus@at.org	ut ipsum	2	0	Gallagher	Lamar
176	nec.imperdiet.nec@euerosNam.org	ut, molestie in,	34	0	Beach	Porter
177	adipiscing@quama.org	Aliquam erat	15	0	Harmon	Yardley
178	nisi@eterosProin.edu	orci tincidunt adipiscing.	80	0	Aguilar	Brady
179	Quisque.fringilla@Nullam.edu	Duis	17	0	Rogers	Nasim
180	amet@SuspendissesagittisNullam.org	lorem, vehicula et,	44	0	David	Neil
181	arcu.Vestibulum@tellussem.ca	Vestibulum ante ipsum	85	0	Wong	Joshua
182	Suspendisse.dui.Fusce@estcongue.edu	Phasellus dapibus quam	24	0	Booker	Octavia
183	lobortis.nisi@cursuspurusNullam.com	Duis	0	0	Rich	Perry
184	convallis.ligula@tempor.com	urna. Ut tincidunt vehicula	85	0	Schwartz	Lacey
185	Nunc.mauris.sapien@idrisusquis.com	pede nec	78	1	Ayers	Haviva
186	augue.eu.tempor@augueeu.org	eros non	65	0	Cline	Maryam
187	lacus.Mauris.non@tempuseu.org	rutrum lorem ac	51	0	David	Neil
188	Morbi.neque.tellus@antedictum.ca	arcu.	12	0	Wong	Bevis
189	at@consectetuer.ca	nibh. Phasellus nulla.	24	0	Flynn	Ursa
190	risus.Donec@estMauriseu.org	congue	61	0	Byrd	Wilma
191	arcu.Vestibulum@lectus.edu	tristique pharetra. Quisque ac	27	1	Cruz	Ross
192	sem.molestie@utaliquamiaculis.ca	lorem, vehicula et,	51	0	Bishop	Jin
193	nibh.Donec@Nullamenim.org	molestie	97	0	Dillard	Dalton
194	diam.eu@lorem.com	penatibus et	14	0	Case	Ivan
195	ipsum.primis.in@netus.ca	orci tincidunt adipiscing.	84	0	Padilla	Britanney
196	vitae.diam@sitamet.ca	et malesuada	59	0	Weiss	Kirestin
197	eget@facilisisnonbibendum.com	bibendum	45	1	Blankenship	Cassidy
198	consectetuer@lorem.ca	turpis non enim.	5	1	Cunningham	Echo
199	tristique@dolorDonecfringilla.ca	ante, iaculis nec, eleifend	89	1	Hensley	Juliet
200	vel.convallis@in.edu	augue ac ipsum.	58	0	Hart	Kylan
201	dui.Fusce@turpisnecmauris.ca	arcu.	98	1	Bryan	Amethyst
202	ligula.Aenean@dignissimMaecenas.ca	Suspendisse commodo	25	0	Duran	Stephen
203	per.inceptos@id.com	risus.	90	0	Clements	Kay
204	ipsum@porttitor.com	ut ipsum	0	0	Frederick	Derek
205	non@faucibus.edu	pede nec	16	1	Herring	Larissa
206	vulputate.posuere@elementumlorem.org	bibendum	22	1	Lamb	Walter
207	faucibus@suscipit.org	lorem, vehicula et,	71	0	Chaney	Gail
208	vestibulum@placerat.com	augue id ante dictum	0	1	David	Neil
209	parturient.montes.nascetur@Maecenas.com	risus.	90	0	Hahn	Aaron
210	in.faucibus.orci@urnaNullam.edu	rutrum lorem ac	40	0	Gill	Samuel
211	Nullam@amet.edu	rutrum lorem ac	57	0	Hooper	Curran
212	Cras@sit.edu	eleifend egestas.	12	0	Daniel	Kirestin
213	feugiat.Sed.nec@dui.ca	enim	93	0	Howe	Lisandra
214	tincidunt.adipiscing@et.com	mauris eu elit. Nulla	42	0	Lindsay	Ina
215	erat.nonummy@gravidamolestiearcu.org	enim	37	0	Green	Barrett
216	penatibus@semutdolor.ca	vitae	1	0	Gomez	Bernard
217	ut.pellentesque.eget@Morbivehicula.edu	pede nec	73	1	Villarreal	Jaime
218	ipsum.primis.in@ante.edu	euismod et, commodo at,	75	0	Bartlett	Kristen
219	Nunc.sed.orci@semutcursus.ca	quis massa.	44	0	Flores	Lee
220	Maecenas.malesuada.fringilla@a.edu	congue turpis. In condimentum.	97	0	Battle	Katell
221	Ut.tincidunt.vehicula@sapien.edu	malesuada	87	0	Patrick	Blossom
222	risus.quis@mollisdui.com	dolor dolor, tempus	25	0	Phillips	Chantale
223	et.malesuada@sedconsequat.edu	ut, molestie in,	56	0	Sawyer	Rachel
224	luctus.felis@egestas.org	ipsum	47	0	Oneal	Angela
225	Aliquam@acmetusvitae.com	ante, iaculis nec, eleifend	48	1	Irwin	Lane
226	non.massa@laoreetipsumCurabitur.edu	eleifend egestas. Sed	39	0	Guerrero	Cruz
227	luctus.sit.amet@blandit.com	risus.	31	0	Oconnor	Geoffrey
228	pulvinar.arcu.et@Seddiam.com	Integer sem elit, pharetra	15	0	Sellers	Aurelia
229	arcu.Morbi.sit@nislMaecenas.ca	tristique pellentesque, tellus	64	0	Fox	Vernon
230	dolor.quam.elementum@dapibus.edu	arcu. Vestibulum ut	44	1	Koch	Camden
231	In@Nullaegetmetus.ca	auctor, nunc nulla	12	0	Gould	Hayfa
232	facilisis@erosnonenim.edu	euismod urna. Nullam lobortis	68	0	Wilkins	Paloma
233	scelerisque.mollis@utsem.ca	orci tincidunt adipiscing.	53	0	Wagner	Todd
234	luctus.Curabitur.egestas@Nullaaliquet.ca	enim	64	0	Gutierrez	Tanisha
235	eros.Nam@Phaselluselit.org	arcu. Curabitur ut odio	4	0	Barrera	Lysandra
236	dui@dolorsitamet.edu	ut, molestie in,	44	0	Herrera	Quamar
237	ultrices@necmauris.edu	arcu. Curabitur ut odio	65	0	Aguilar	Brady
238	Nullam.ut.nisi@penatibusetmagnis.com	ornare. Fusce mollis. Duis	47	0	Mcneil	Evelyn
239	mi.enim.condimentum@aliquetvel.edu	ad	42	0	Murray	Nyssa
240	nec.cursus.a@mauris.ca	sociosqu ad	71	0	Lane	Acton
241	justo.nec.ante@Proin.ca	malesuada	32	0	Golden	Todd
242	Curae;.Phasellus@pede.ca	enim	92	0	Fischer	Xandra
243	sociis.natoque@suscipit.org	imperdiet, erat nonummy ultricies	74	1	Aguilar	Brady
244	vestibulum.nec@actellusSuspendisse.ca	augue id ante dictum	1	1	Paul	Travis
245	tellus.sem@nibhlaciniaorci.com	arcu. Vestibulum ut	77	1	Rocha	Mariam
246	sed@aneque.ca	Suspendisse commodo	43	0	Merrill	India
247	Integer@consectetuerrhoncusNullam.edu	risus.	22	0	Merrill	Alfonso
248	nunc@Curae;Phasellus.com	pede sagittis	1	0	Flowers	Isaac
249	eleifend@Naminterdum.edu	nibh enim,	52	1	Evans	Blaze
250	ultrices.sit@etpedeNunc.org	vel pede	93	0	Sweet	Aladdin
251	eget.venenatis.a@lectuspedeet.ca	Sed nec metus	78	1	Allen	Cadman
252	sed.dui@faucibuslectus.edu	nibh enim, gravida sit	57	1	Meyers	Leilani
253	sit@nisinibhlacinia.ca	urna. Ut tincidunt vehicula	53	0	Weiss	Kirestin
254	sollicitudin.orci@eget.com	euismod urna. Nullam lobortis	59	0	Cline	Branden
255	luctus.aliquet@ligula.com	Phasellus dapibus quam	89	0	Keith	Genevieve
256	vitae@eros.edu	Integer sem elit, pharetra	81	0	Sharpe	Althea
257	quam@lobortis.ca	nibh enim, gravida sit	33	1	Navarro	Mohammad
258	pharetra.Nam.ac@habitantmorbi.edu	orci tincidunt adipiscing.	81	0	Barr	Medge
259	ac.eleifend.vitae@consequatnecmollis.org	euismod urna. Nullam lobortis	52	0	Buckley	Tasha
260	tempus.lorem@dolorDonecfringilla.com	nibh enim,	50	1	Maldonado	Inez
261	ut@mauriserateget.org	gravida nunc sed pede.	25	0	Finley	Lareina
262	at@loremeumetus.edu	tristique pharetra. Quisque ac	26	1	Merrill	India
263	magnis@euultrices.com	dolor elit, pellentesque	72	0	Hooper	Curran
264	vulputate@aliquet.com	bibendum. Donec	68	1	Slater	Mercedes
265	dictum.Proin@commodoauctor.com	nisi	44	0	Frederick	Margaret
266	nec.luctus@rhoncusNullam.org	in, cursus et, eros.	86	0	Prince	Reed
267	scelerisque.neque.Nullam@adipiscingnon.edu	quis massa.	43	0	Fernandez	Oprah
268	Maecenas.malesuada.fringilla@nonjusto.edu	bibendum. Donec	9	1	Waters	Hashim
269	sem.mollis.dui@atliberoMorbi.com	rutrum lorem ac	10	0	Bartlett	Teagan
270	non.sollicitudin@aenimSuspendisse.edu	eleifend egestas. Sed	30	0	Harvey	Cleo
271	ullamcorper.eu.euismod@ametrisusDonec.ca	Suspendisse commodo	80	0	Aguilar	Brady
272	Phasellus@ultrices.com	nibh enim, gravida sit	17	1	Pennington	Hanna
273	natoque.penatibus.et@nislelementumpurus.com	nibh enim,	49	1	Koch	Medge
274	mollis@felisadipiscing.com	molestie	49	0	Chase	Cedric
275	penatibus.et.magnis@Phasellus.ca	sodales. Mauris blandit	49	0	Nielsen	Oprah
276	Cum.sociis@lacus.com	luctus	74	0	Kirk	Troy
277	Mauris.eu.turpis@a.edu	eleifend egestas. Sed	35	0	Kirk	Troy
278	lectus.Cum.sociis@estvitaesodales.com	ligula	85	0	Dunn	Dorian
279	ipsum.Donec@felis.ca	nibh enim, gravida sit	11	1	Chaney	Mara
280	pellentesque.Sed.dictum@vitaeorci.ca	augue ac ipsum.	75	0	Good	Anastasia
281	Nam.interdum@egestas.edu	ipsum	41	0	Phillips	Chantale
282	vitae.sodales.at@felisadipiscing.org	congue turpis. In condimentum.	69	0	Chambers	Ina
283	Lorem.ipsum@liberoduinec.org	ut, molestie in,	36	0	Wiley	Rhonda
284	lectus.rutrum@dolorsitamet.org	arcu. Curabitur ut odio	51	0	Lopez	Shannon
285	tellus@eu.edu	sodales. Mauris blandit	86	0	Ingram	Chiquita
286	sagittis.lobortis.mauris@Curae;.edu	in faucibus orci luctus	39	0	Harmon	Yardley
287	massa.Mauris@loremsitamet.com	in faucibus orci luctus	41	0	Kaufman	Adrienne
288	nibh.vulputate@vehicula.org	et malesuada	16	0	Hensley	Kirestin
289	Suspendisse.non.leo@tempus.com	augue ac ipsum.	45	0	Lott	Aidan
290	aliquam.eu.accumsan@nascetur.org	auctor, nunc nulla	77	0	Delaney	Hunter
291	dolor.Fusce.feugiat@Proin.org	sodales. Mauris blandit	31	0	Gilbert	Ann
292	eu.sem.Pellentesque@consequatauctornunc.edu	Duis	55	0	Webster	Sopoline
293	odio.Nam@euismodmauriseu.com	Duis	97	0	Mcdowell	Mara
294	ligula.elit@eudui.ca	bibendum. Donec	85	1	Byrd	Ulla
295	in.felis.Nulla@temporest.org	scelerisque mollis. Phasellus libero	38	1	Sampson	Arsenio
296	semper.dui@hendreritaarcu.org	congue turpis. In condimentum.	28	0	Weiss	Kirestin
297	fermentum.convallis.ligula@eu.com	pede nec	29	1	Ochoa	Jeanette
298	urna.Ut@ipsumprimis.edu	vestibulum. Mauris magna.	8	1	Salinas	Alyssa
299	feugiat.Lorem.ipsum@ullamcorper.ca	penatibus et	85	0	Gutierrez	Tanisha
300	facilisis.magna@Integervulputaterisus.com	amet, dapibus	76	0	Clements	Kay
\.


--
-- Name: application_pkey; Type: CONSTRAINT; Schema: public; Owner: sultano; Tablespace: 
--

ALTER TABLE ONLY application
    ADD CONSTRAINT application_pkey PRIMARY KEY (id);


--
-- Name: avis_pkey; Type: CONSTRAINT; Schema: public; Owner: sultano; Tablespace: 
--

ALTER TABLE ONLY avis
    ADD CONSTRAINT avis_pkey PRIMARY KEY (id_avis);


--
-- Name: cle_primaire; Type: CONSTRAINT; Schema: public; Owner: sultano; Tablespace: 
--

ALTER TABLE ONLY mot_cle
    ADD CONSTRAINT cle_primaire PRIMARY KEY (id);


--
-- Name: info_payement_pkey; Type: CONSTRAINT; Schema: public; Owner: sultano; Tablespace: 
--

ALTER TABLE ONLY info_payement
    ADD CONSTRAINT info_payement_pkey PRIMARY KEY (id);


--
-- Name: peripherique_pkey; Type: CONSTRAINT; Schema: public; Owner: sultano; Tablespace: 
--

ALTER TABLE ONLY peripherique
    ADD CONSTRAINT peripherique_pkey PRIMARY KEY (id);


--
-- Name: systeme_exploitation_pkey; Type: CONSTRAINT; Schema: public; Owner: sultano; Tablespace: 
--

ALTER TABLE ONLY systeme_exploitation
    ADD CONSTRAINT systeme_exploitation_pkey PRIMARY KEY (id);


--
-- Name: user_mail_key; Type: CONSTRAINT; Schema: public; Owner: sultano; Tablespace: 
--

ALTER TABLE ONLY utilisateur
    ADD CONSTRAINT user_mail_key UNIQUE (mail);


--
-- Name: user_pkey; Type: CONSTRAINT; Schema: public; Owner: sultano; Tablespace: 
--

ALTER TABLE ONLY utilisateur
    ADD CONSTRAINT user_pkey PRIMARY KEY (id);


--
-- Name: _RETURN; Type: RULE; Schema: public; Owner: sultano
--

CREATE RULE "_RETURN" AS ON SELECT TO avg_app_dev DO INSTEAD SELECT avg_elstar_app.id_application, avg_elstar_app.avg, application.id_developpeur FROM (avg_elstar_app JOIN application ON ((avg_elstar_app.id_application = application.id))) GROUP BY avg_elstar_app.avg, application.id, avg_elstar_app.id_application;


--
-- Name: avis_id_application_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sultano
--

ALTER TABLE ONLY avis
    ADD CONSTRAINT avis_id_application_fkey FOREIGN KEY (id_application) REFERENCES application(id);


--
-- Name: avis_id_user_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sultano
--

ALTER TABLE ONLY avis
    ADD CONSTRAINT avis_id_user_fkey FOREIGN KEY (id_user) REFERENCES utilisateur(id);


--
-- Name: cle_etrangere; Type: FK CONSTRAINT; Schema: public; Owner: sultano
--

ALTER TABLE ONLY peripherique
    ADD CONSTRAINT cle_etrangere FOREIGN KEY (id_se) REFERENCES systeme_exploitation(id);


--
-- Name: cle_etrangere; Type: FK CONSTRAINT; Schema: public; Owner: sultano
--

ALTER TABLE ONLY mot_cle
    ADD CONSTRAINT cle_etrangere FOREIGN KEY (id_application) REFERENCES application(id);


--
-- Name: cle_etrangere; Type: FK CONSTRAINT; Schema: public; Owner: sultano
--

ALTER TABLE ONLY info_payement
    ADD CONSTRAINT cle_etrangere FOREIGN KEY (id_user) REFERENCES utilisateur(id);


--
-- Name: cle_etrangere1; Type: FK CONSTRAINT; Schema: public; Owner: sultano
--

ALTER TABLE ONLY liste_applications
    ADD CONSTRAINT cle_etrangere1 FOREIGN KEY (id_application) REFERENCES application(id);


--
-- Name: cle_etrangere2; Type: FK CONSTRAINT; Schema: public; Owner: sultano
--

ALTER TABLE ONLY liste_applications
    ADD CONSTRAINT cle_etrangere2 FOREIGN KEY (id_user) REFERENCES utilisateur(id);


--
-- Name: cle_etrangere2; Type: FK CONSTRAINT; Schema: public; Owner: sultano
--

ALTER TABLE ONLY peripherique
    ADD CONSTRAINT cle_etrangere2 FOREIGN KEY (id_user) REFERENCES utilisateur(id);


--
-- Name: id_developpeur_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sultano
--

ALTER TABLE ONLY application
    ADD CONSTRAINT id_developpeur_fkey FOREIGN KEY (id_developpeur) REFERENCES utilisateur(id);


--
-- Name: telechargement_id_application_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sultano
--

ALTER TABLE ONLY telechargement
    ADD CONSTRAINT telechargement_id_application_fkey FOREIGN KEY (id_application) REFERENCES application(id);


--
-- Name: telechargement_id_peripherique_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sultano
--

ALTER TABLE ONLY telechargement
    ADD CONSTRAINT telechargement_id_peripherique_fkey FOREIGN KEY (id_peripherique) REFERENCES peripherique(id);


--
-- Name: telechargement_id_user_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sultano
--

ALTER TABLE ONLY telechargement
    ADD CONSTRAINT telechargement_id_user_fkey FOREIGN KEY (id_user) REFERENCES utilisateur(id);


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

