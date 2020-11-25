
CREATE TABLE public.mlm_notification (
    id integer NOT NULL,
    last_updated_on timestamp with time zone,
    created_by character varying(60),
    last_updated_by character varying(60),
    is_to_admin boolean NOT NULL,
    subject character varying(150) NOT NULL,
    message text NOT NULL,
    status character varying(20) NOT NULL,
    created_on timestamp with time zone NOT NULL,
    from_user_id integer,
    to_user_id integer,
    tag character varying(30) NOT NULL
);


ALTER TABLE public.mlm_notification OWNER TO postgres;

--
-- Name: mlm_payment_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.mlm_payment_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.mlm_payment_id_seq OWNER TO postgres;

--
-- Name: mlm_payment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.mlm_payment_id_seq OWNED BY public.mlm_notification.id;


--
-- Name: mlm_notification id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mlm_notification ALTER COLUMN id SET DEFAULT nextval('public.mlm_payment_id_seq'::regclass);


--
-- Data for Name: mlm_notification; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.mlm_notification (id, last_updated_on, created_by, last_updated_by, is_to_admin, subject, message, status, created_on, from_user_id, to_user_id, tag) FROM stdin;
1	\N	\N	\N	t	Structure completed!	 kannan successfully completed the structure. All the users in the structure paid the fee.	unread	2020-11-25 16:53:06.746137+05:30	\N	\N	info
2	\N	\N	\N	t	Structure completed!	 kannan successfully completed the structure. All the users in the structure paid the fee.	unread	2020-11-25 17:12:36.548656+05:30	\N	\N	important
3	\N	\N	\N	t	Structure completed!	 kannan successfully completed the structure. All the users in the structure paid the fee.	unread	2020-11-25 17:18:09.271116+05:30	\N	\N	info
4	\N	\N	\N	t	Structure completed!	 kannan successfully completed the structure. All the users in the structure paid the fee.	unread	2020-11-25 17:19:14.563867+05:30	\N	\N	info
5	\N	\N	\N	t	Structure completed!	 User 1 (user1@mlm.com) successfully completed the structure. All the users in the structure paid the fee.	unread	2020-11-25 17:31:14.196816+05:30	\N	\N	info
\.


--
-- Name: mlm_payment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.mlm_payment_id_seq', 5, true);


--
-- Name: mlm_notification mlm_payment_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mlm_notification
    ADD CONSTRAINT mlm_payment_pkey PRIMARY KEY (id);


--
-- Name: mlm_payment_from_user_id_bc269377; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX mlm_payment_from_user_id_bc269377 ON public.mlm_notification USING btree (from_user_id);


--
-- Name: mlm_payment_to_user_id_2548b171; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX mlm_payment_to_user_id_2548b171 ON public.mlm_notification USING btree (to_user_id);


--
-- Name: mlm_notification mlm_payment_from_user_id_bc269377_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mlm_notification
    ADD CONSTRAINT mlm_payment_from_user_id_bc269377_fk_auth_user_id FOREIGN KEY (from_user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: mlm_notification mlm_payment_to_user_id_2548b171_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mlm_notification
    ADD CONSTRAINT mlm_payment_to_user_id_2548b171_fk_auth_user_id FOREIGN KEY (to_user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- PostgreSQL database dump complete
--

