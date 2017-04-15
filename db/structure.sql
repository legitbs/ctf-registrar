--
-- PostgreSQL database dump
--

-- Dumped from database version 9.6.2
-- Dumped by pg_dump version 9.6.2

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- Name: pg_stat_statements; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pg_stat_statements WITH SCHEMA public;


--
-- Name: EXTENSION pg_stat_statements; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION pg_stat_statements IS 'track execution statistics of all SQL statements executed';


SET search_path = public, pg_catalog;

--
-- Name: scoreboard_refresh_proc(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION scoreboard_refresh_proc() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
      BEGIN
        REFRESH MATERIALIZED VIEW CONCURRENTLY scoreboard;
        RETURN new;
      END;
      $$;


--
-- Name: scored_challenges_refresh_proc(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION scored_challenges_refresh_proc() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
      BEGIN
        REFRESH MATERIALIZED VIEW CONCURRENTLY scored_challenges;
        RETURN new;
      END;
      $$;


--
-- Name: solution_histogram_refresh_proc(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION solution_histogram_refresh_proc() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
      BEGIN
        REFRESH MATERIALIZED VIEW solution_histogram;
        RETURN new;
      END;
      $$;


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: achievements; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE achievements (
    id integer NOT NULL,
    name character varying,
    condition character varying,
    description character varying,
    image character varying,
    trophy_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: achievements_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE achievements_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: achievements_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE achievements_id_seq OWNED BY achievements.id;


--
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: awards; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE awards (
    id integer NOT NULL,
    achievement_id integer,
    team_id integer,
    user_id integer,
    comment character varying,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: awards_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE awards_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: awards_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE awards_id_seq OWNED BY awards.id;


--
-- Name: categories; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE categories (
    id integer NOT NULL,
    name character varying,
    "order" integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    description text
);


--
-- Name: categories_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE categories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE categories_id_seq OWNED BY categories.id;


--
-- Name: challenges; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE challenges (
    id integer NOT NULL,
    name character varying,
    clue character varying,
    answer_digest character varying,
    category_id integer,
    points integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    unlocked_at timestamp without time zone,
    solved_at timestamp without time zone
);


--
-- Name: challenges_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE challenges_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: challenges_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE challenges_id_seq OWNED BY challenges.id;


--
-- Name: fallback_tokens; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE fallback_tokens (
    id integer NOT NULL,
    user_id integer,
    key character varying,
    secret_digest character varying,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: fallback_tokens_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE fallback_tokens_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: fallback_tokens_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE fallback_tokens_id_seq OWNED BY fallback_tokens.id;


--
-- Name: notices; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE notices (
    id integer NOT NULL,
    body character varying,
    team_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    twitter character varying
);


--
-- Name: notices_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE notices_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: notices_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE notices_id_seq OWNED BY notices.id;


--
-- Name: observations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE observations (
    id integer NOT NULL,
    team_id integer,
    challenge_id integer,
    user_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: observations_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE observations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: observations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE observations_id_seq OWNED BY observations.id;


--
-- Name: resets; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE resets (
    id integer NOT NULL,
    user_id integer NOT NULL,
    key character varying NOT NULL,
    digest character varying NOT NULL,
    consumed_at timestamp without time zone,
    disavowed_at timestamp without time zone,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: resets_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE resets_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: resets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE resets_id_seq OWNED BY resets.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE schema_migrations (
    version character varying NOT NULL
);


--
-- Name: solutions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE solutions (
    id integer NOT NULL,
    team_id integer,
    challenge_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: solution_histogram; Type: MATERIALIZED VIEW; Schema: public; Owner: -
--

CREATE MATERIALIZED VIEW solution_histogram AS
 SELECT s.challenge_id,
    end_time.end_time,
    count(s.id) AS count,
    ( SELECT count(q.id) AS count
           FROM solutions q
          WHERE (q.challenge_id = s.challenge_id)) AS tot,
    (((100 * count(s.id)) / ( SELECT count(q.id) AS count
           FROM solutions q
          WHERE (q.challenge_id = s.challenge_id))))::double precision AS pct
   FROM (generate_series(( SELECT ('1970-01-01 00:00:00'::timestamp without time zone + ((1463788800)::double precision * '00:00:01'::interval))), ( SELECT ('1970-01-01 00:00:00'::timestamp without time zone + ((1463961600)::double precision * '00:00:01'::interval))), '01:00:00'::interval) end_time(end_time)
     RIGHT JOIN solutions s ON (((s.created_at <= end_time.end_time) AND (s.challenge_id = s.challenge_id))))
  GROUP BY end_time.end_time, s.challenge_id
  ORDER BY s.challenge_id, end_time.end_time
  WITH NO DATA;


--
-- Name: solutions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE solutions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: solutions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE solutions_id_seq OWNED BY solutions.id;


--
-- Name: teams; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE teams (
    id integer NOT NULL,
    name character varying,
    password_digest character varying,
    user_id integer NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    hot boolean,
    prequalified boolean,
    fun boolean,
    logo_file_name character varying,
    logo_content_type character varying,
    logo_file_size integer,
    logo_updated_at timestamp without time zone,
    logo_fingerprint character varying,
    display character varying
);


--
-- Name: teams_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE teams_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: teams_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE teams_id_seq OWNED BY teams.id;


--
-- Name: trophies; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE trophies (
    id integer NOT NULL,
    name character varying,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: trophies_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE trophies_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: trophies_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE trophies_id_seq OWNED BY trophies.id;


--
-- Name: uploads; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE uploads (
    id integer NOT NULL,
    user_id integer,
    challenge_id integer,
    file_file_name character varying,
    file_content_type character varying,
    file_file_size integer,
    file_updated_at timestamp without time zone,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: uploads_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE uploads_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: uploads_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE uploads_id_seq OWNED BY uploads.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE users (
    id integer NOT NULL,
    username character varying,
    password_digest character varying,
    team_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    email character varying,
    email_confirmation character varying,
    email_confirmed_at timestamp without time zone,
    visa boolean,
    auth_secret character varying
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- Name: achievements id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY achievements ALTER COLUMN id SET DEFAULT nextval('achievements_id_seq'::regclass);


--
-- Name: awards id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY awards ALTER COLUMN id SET DEFAULT nextval('awards_id_seq'::regclass);


--
-- Name: categories id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY categories ALTER COLUMN id SET DEFAULT nextval('categories_id_seq'::regclass);


--
-- Name: challenges id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY challenges ALTER COLUMN id SET DEFAULT nextval('challenges_id_seq'::regclass);


--
-- Name: fallback_tokens id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY fallback_tokens ALTER COLUMN id SET DEFAULT nextval('fallback_tokens_id_seq'::regclass);


--
-- Name: notices id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY notices ALTER COLUMN id SET DEFAULT nextval('notices_id_seq'::regclass);


--
-- Name: observations id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY observations ALTER COLUMN id SET DEFAULT nextval('observations_id_seq'::regclass);


--
-- Name: resets id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY resets ALTER COLUMN id SET DEFAULT nextval('resets_id_seq'::regclass);


--
-- Name: solutions id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY solutions ALTER COLUMN id SET DEFAULT nextval('solutions_id_seq'::regclass);


--
-- Name: teams id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY teams ALTER COLUMN id SET DEFAULT nextval('teams_id_seq'::regclass);


--
-- Name: trophies id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY trophies ALTER COLUMN id SET DEFAULT nextval('trophies_id_seq'::regclass);


--
-- Name: uploads id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY uploads ALTER COLUMN id SET DEFAULT nextval('uploads_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- Name: challenges challenges_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY challenges
    ADD CONSTRAINT challenges_pkey PRIMARY KEY (id);


--
-- Name: scored_challenges; Type: MATERIALIZED VIEW; Schema: public; Owner: -
--

CREATE MATERIALIZED VIEW scored_challenges AS
 SELECT c.id,
    c.name,
    c.clue,
    c.answer_digest,
    c.category_id,
    c.points,
    c.created_at,
    c.updated_at,
    c.unlocked_at,
    c.solved_at,
    (((5000)::numeric * (1.0 / ((count(s.challenge_id))::numeric + 11.5))) + (1)::numeric) AS calc_points,
    count(s.challenge_id) AS solve_count
   FROM (challenges c
     LEFT JOIN solutions s ON ((c.id = s.challenge_id)))
  GROUP BY c.id
  WITH NO DATA;


--
-- Name: teams teams_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY teams
    ADD CONSTRAINT teams_pkey PRIMARY KEY (id);


--
-- Name: scoreboard; Type: MATERIALIZED VIEW; Schema: public; Owner: -
--

CREATE MATERIALIZED VIEW scoreboard AS
 SELECT t.id AS team_id,
        CASE
            WHEN ((t.display IS NULL) OR ((t.display)::text = ''::text)) THEN t.name
            ELSE t.display
        END AS team_name,
    round(sum(c.calc_points), 0) AS score,
    max(s.created_at) AS last_solve
   FROM ((teams t
     JOIN solutions s ON ((s.team_id = t.id)))
     JOIN scored_challenges c ON ((s.challenge_id = c.id)))
  WHERE (s.team_id <> 1)
  GROUP BY t.id
  ORDER BY (round(sum(c.calc_points), 0)) DESC, (max(s.created_at)), (max(s.id))
  WITH NO DATA;


--
-- Name: achievements achievements_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY achievements
    ADD CONSTRAINT achievements_pkey PRIMARY KEY (id);


--
-- Name: ar_internal_metadata ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: awards awards_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY awards
    ADD CONSTRAINT awards_pkey PRIMARY KEY (id);


--
-- Name: categories categories_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (id);


--
-- Name: fallback_tokens fallback_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY fallback_tokens
    ADD CONSTRAINT fallback_tokens_pkey PRIMARY KEY (id);


--
-- Name: notices notices_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY notices
    ADD CONSTRAINT notices_pkey PRIMARY KEY (id);


--
-- Name: observations observations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY observations
    ADD CONSTRAINT observations_pkey PRIMARY KEY (id);


--
-- Name: resets resets_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY resets
    ADD CONSTRAINT resets_pkey PRIMARY KEY (id);


--
-- Name: solutions solutions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY solutions
    ADD CONSTRAINT solutions_pkey PRIMARY KEY (id);


--
-- Name: trophies trophies_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY trophies
    ADD CONSTRAINT trophies_pkey PRIMARY KEY (id);


--
-- Name: uploads uploads_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY uploads
    ADD CONSTRAINT uploads_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: index_achievements_on_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_achievements_on_name ON achievements USING btree (name);


--
-- Name: index_achievements_on_trophy_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_achievements_on_trophy_id ON achievements USING btree (trophy_id);


--
-- Name: index_awards_on_achievement_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_awards_on_achievement_id ON awards USING btree (achievement_id);


--
-- Name: index_awards_on_team_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_awards_on_team_id ON awards USING btree (team_id);


--
-- Name: index_awards_on_team_id_and_achievement_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_awards_on_team_id_and_achievement_id ON awards USING btree (team_id, achievement_id);


--
-- Name: index_awards_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_awards_on_user_id ON awards USING btree (user_id);


--
-- Name: index_categories_on_name; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_categories_on_name ON categories USING btree (name);


--
-- Name: index_challenges_on_category_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_challenges_on_category_id ON challenges USING btree (category_id);


--
-- Name: index_fallback_tokens_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_fallback_tokens_on_user_id ON fallback_tokens USING btree (user_id);


--
-- Name: index_notices_on_created_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_notices_on_created_at ON notices USING btree (created_at);


--
-- Name: index_notices_on_team_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_notices_on_team_id ON notices USING btree (team_id);


--
-- Name: index_notices_on_team_id_and_created_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_notices_on_team_id_and_created_at ON notices USING btree (team_id, created_at);


--
-- Name: index_observations_on_challenge_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_observations_on_challenge_id ON observations USING btree (challenge_id);


--
-- Name: index_observations_on_team_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_observations_on_team_id ON observations USING btree (team_id);


--
-- Name: index_observations_on_team_id_and_challenge_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_observations_on_team_id_and_challenge_id ON observations USING btree (team_id, challenge_id);


--
-- Name: index_observations_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_observations_on_user_id ON observations USING btree (user_id);


--
-- Name: index_resets_on_key; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_resets_on_key ON resets USING btree (key);


--
-- Name: index_resets_on_key_and_disavowed_at_and_consumed_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_resets_on_key_and_disavowed_at_and_consumed_at ON resets USING btree (key, disavowed_at, consumed_at);


--
-- Name: index_resets_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_resets_on_user_id ON resets USING btree (user_id);


--
-- Name: index_scored_challenges_on_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_scored_challenges_on_id ON scored_challenges USING btree (id);


--
-- Name: index_solutions_on_challenge_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_solutions_on_challenge_id ON solutions USING btree (challenge_id);


--
-- Name: index_solutions_on_team_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_solutions_on_team_id ON solutions USING btree (team_id);


--
-- Name: index_solutions_on_team_id_and_challenge_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_solutions_on_team_id_and_challenge_id ON solutions USING btree (team_id, challenge_id);


--
-- Name: index_teams_on_name; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_teams_on_name ON teams USING btree (name);


--
-- Name: index_teams_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_teams_on_user_id ON teams USING btree (user_id);


--
-- Name: index_uploads_on_challenge_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_uploads_on_challenge_id ON uploads USING btree (challenge_id);


--
-- Name: index_uploads_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_uploads_on_user_id ON uploads USING btree (user_id);


--
-- Name: index_users_on_email; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_users_on_email ON users USING btree (email);


--
-- Name: index_users_on_team_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_users_on_team_id ON users USING btree (team_id);


--
-- Name: index_users_on_username; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_users_on_username ON users USING btree (username);


--
-- Name: scoreboard_team_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX scoreboard_team_id_idx ON scoreboard USING btree (team_id);


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


--
-- Name: solutions scored_challenges_update_trigger; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER scored_challenges_update_trigger AFTER INSERT ON solutions FOR EACH STATEMENT EXECUTE PROCEDURE scored_challenges_refresh_proc();


--
-- Name: solutions solution_histogram_update_trigger; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER solution_histogram_update_trigger AFTER INSERT ON solutions FOR EACH STATEMENT EXECUTE PROCEDURE solution_histogram_refresh_proc();


--
-- Name: achievements achievements_trophy_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY achievements
    ADD CONSTRAINT achievements_trophy_id_fk FOREIGN KEY (trophy_id) REFERENCES trophies(id);


--
-- Name: awards awards_achievement_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY awards
    ADD CONSTRAINT awards_achievement_id_fk FOREIGN KEY (achievement_id) REFERENCES achievements(id);


--
-- Name: awards awards_team_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY awards
    ADD CONSTRAINT awards_team_id_fk FOREIGN KEY (team_id) REFERENCES teams(id);


--
-- Name: awards awards_user_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY awards
    ADD CONSTRAINT awards_user_id_fk FOREIGN KEY (user_id) REFERENCES users(id);


--
-- Name: challenges challenges_category_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY challenges
    ADD CONSTRAINT challenges_category_id_fk FOREIGN KEY (category_id) REFERENCES categories(id);


--
-- Name: uploads fk_rails_15d41e668d; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY uploads
    ADD CONSTRAINT fk_rails_15d41e668d FOREIGN KEY (user_id) REFERENCES users(id);


--
-- Name: observations fk_rails_60d667a791; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY observations
    ADD CONSTRAINT fk_rails_60d667a791 FOREIGN KEY (user_id) REFERENCES users(id);


--
-- Name: observations fk_rails_9c84189689; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY observations
    ADD CONSTRAINT fk_rails_9c84189689 FOREIGN KEY (challenge_id) REFERENCES challenges(id);


--
-- Name: uploads fk_rails_ad8e6a4ed1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY uploads
    ADD CONSTRAINT fk_rails_ad8e6a4ed1 FOREIGN KEY (challenge_id) REFERENCES challenges(id);


--
-- Name: observations fk_rails_ecadd80be6; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY observations
    ADD CONSTRAINT fk_rails_ecadd80be6 FOREIGN KEY (team_id) REFERENCES teams(id);


--
-- Name: solutions solutions_challenge_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY solutions
    ADD CONSTRAINT solutions_challenge_id_fk FOREIGN KEY (challenge_id) REFERENCES challenges(id);


--
-- Name: solutions solutions_team_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY solutions
    ADD CONSTRAINT solutions_team_id_fk FOREIGN KEY (team_id) REFERENCES teams(id);


--
-- Name: teams teams_user_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY teams
    ADD CONSTRAINT teams_user_id_fk FOREIGN KEY (user_id) REFERENCES users(id);


--
-- Name: users users_team_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_team_id_fk FOREIGN KEY (team_id) REFERENCES teams(id);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user", public;

INSERT INTO "schema_migrations" (version) VALUES
('20150405204455'),
('20150428023637'),
('20150510162044'),
('20150516180242'),
('20160430183739'),
('20160430185139'),
('20160430215440'),
('20160507192341'),
('20160512000142'),
('20160512011030'),
('20160512174805'),
('20160515184309'),
('20170415195705');


