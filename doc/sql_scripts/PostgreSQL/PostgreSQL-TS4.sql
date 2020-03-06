DO $$
DECLARE 
	v_CASE_FILE_ID NUMERIC(10) := 1073989;		
	v_CASE_TYPE_ID NUMERIC(10);
	v_CASE_TYPE_NAME character varying(160) := 'Foreclosure';
	v_CASE_TYPE_CODE character varying(160);
	v_MSG character varying(10485760);
	v_LOCATION_NAME character varying(240) := 'Boca';
	v_LOCATION_ID NUMERIC(10);
	v_BK_CHAPTER_NUM NUMERIC(10);
	v_BK_CHAPTER_ID NUMERIC(10);
	v_CASE_NUMBER character varying(20) := 'FC02';
	v_CASE_TMPL_ID NUMERIC(10) := 2313;
	v_CASE_FILE_RECEIVED character varying(20) := '02/18/2020';
	v_CASE_STARTED character varying(20) := '02/18/2020';
	v_CASE_WHO_HAS character varying(160) = N'Andriy Ruslyakov';
	v_CASE_ID NUMERIC(10);-- = 1434057,
	v_CASE_ID_VAR NUMERIC(10);
	v_USERID NUMERIC(10) := '6951';
	v_USERNAME character varying(40) := 'Andriy Ruslyakov';
	v_BK_ID NUMERIC(10);
	v_QUOTE_ID NUMERIC(10);
	v_CASE_STAT_ID NUMERIC(10);
	v_ACT_ID NUMERIC(10);
	v_UTC timestamp;
	v_COMMENT_ID NUMERIC(10);
	v_D_OCCUPANCY boolean := 'false';
	v_D_NOTICE_SENT_STAT boolean := 'false';
	v_DEFICIENCY_REASON_NAME character varying(240);
	v_APPEARANCE_TYPE_NAME character varying(240);
	v_CONSENT_TYPE_NAME character varying(240);
	v_DEFICIENCY_REASON_ID NUMERIC(10);
	v_APPEARANCE_TYPE_ID NUMERIC(10);
	v_CONSENT_TYPE_ID NUMERIC(10);
	v_CONT_TYPE_ID NUMERIC(10);
	v_CONT_TYPE_CASE_FILE boolean;
	v_COMP_FIELD_SNGL character varying(240);
	v_CONT_TYPE_NAME character varying(240) := 'Title Company';
	v_CONTACT_ID NUMERIC(10) := 4276114;
	v_ACTOR_ID NUMERIC(10);
	v_D_DEFICIENCY_PRESERVED boolean;
	v_D_DEFICIENCY_SOUGHT boolean;
	v_D_SERVICE_CODE character varying(240) := NULL;
	v_D_APPEAR_DATE timestamp without time zone;
	v_D_CONSENT_REQUESTED timestamp without time zone;
	v_D_CONSENT_RECEIVED timestamp without time zone;
	v_D_DEFAULT_NOTICE_SENT timestamp without time zone;
	v_D_DEFAULT_EXPIRED timestamp without time zone;
	v_D_DEFAULT_ORDERED timestamp without time zone; 
	v_D_ORDER_SENT timestamp without time zone;
	v_D_COURT_FILE_CHECK timestamp without time zone;
	v_D_DEFAULT_ORD_ENT timestamp without time zone;
	v_D_DUE_DILIGENCE_AFF_NEEDED boolean;
	v_D_DUE_DILIGENCE_AFF_RECEIVED timestamp without time zone;
	v_D_DUE_DILIGENCE_AFF_FILED timestamp without time zone;
	v_D_SEQ_NUMB NUMERIC(10) := 1;
	v_D_PLEADING_DATE timestamp without time zone;
	v_STATE_ID NUMERIC(10); 
	v_COUNTY_NAME character varying(240) := 'Washington'; 
	v_COUNTY_ID NUMERIC(10);
	v_STATE_CODE character varying(20) := 'FL';
	v_CNTR_ID numeric(10);
	v_COUNTRY_NAME character varying(240) := 'United States';
	v_ADDRESS_1_LINE character varying(240) := 'Main street 1'; 
	v_ADDRESS_2_LINE character varying(240);
	v_ADDRESS_TEXT character varying(240);
	v_ADDRESS_LINE_ATTN character varying(240);
	v_ADDRESS_CITY character varying(240) := 'Schdy';
	v_ADDRESS_ZIPCODE character varying(240) := '12345';
	v_ADDRESS_IS_PRIM boolean := 'false';
	v_ADDRESS_ID numeric(10);
	v_StartTime timestamp with time zone;
	v_EndTime timestamp with time zone;
	v_diff numeric(10);
BEGIN
-- set initial param values
v_StartTime := clock_timestamp();
SELECT CASE_FILE_ID into v_CASE_FILE_ID FROM public.CMS_case_file 
order by RANDOM()
limit 1;

v_EndTime := clock_timestamp();
select extract(second from (v_EndTime - v_StartTime)) into v_Diff;
raise notice '  --- v_Diff = %',  cast(v_Diff as character varying(20));

raise notice 'v_CASE_FILE_ID = %',  cast(v_CASE_FILE_ID as character varying(20));

v_StartTime := clock_timestamp();
select CASE_TYPE_NAME into v_CASE_TYPE_NAME from public.CMS_CASE_TYPE
order by RANDOM()
limit 1;

v_EndTime := clock_timestamp();
select extract(second from (v_EndTime - v_StartTime)) into v_Diff;
raise notice '  --- v_Diff = %',  cast(v_Diff as character varying(20));
raise notice 'v_CASE_TYPE_NAME = %',  v_CASE_TYPE_NAME;

-- CMSWFWS_SP_CREATE_CASE_ACTION
v_StartTime := clock_timestamp();
SELECT CASE_TYPE_ID,
		CASE_TYPE_CODE 
INTO v_CASE_TYPE_ID, v_CASE_TYPE_CODE
FROM public.CMS_CASE_TYPE 
WHERE CASE_TYPE_NAME = v_CASE_TYPE_NAME;

v_EndTime := clock_timestamp();
select extract(second from (v_EndTime - v_StartTime)) into v_Diff;
raise notice '  --- v_Diff = %',  cast(v_Diff as character varying(20));

v_StartTime := clock_timestamp();
SELECT CASE_TMPL_ID into v_CASE_TMPL_ID FROM public.CMS_CASE_TEMPLATE
where CASE_TYPE_ID = v_CASE_TYPE_ID
order by RANDOM()
limit 1;

v_EndTime := clock_timestamp();
select extract(second from (v_EndTime - v_StartTime)) into v_Diff;
raise notice '  --- v_Diff = %',  cast(v_Diff as character varying(20));

raise notice 'v_CASE_TMPL_ID = %',  cast(v_CASE_TMPL_ID as character varying(20));

		-- determine the next case number (e.g. FC01, MON10)
		-- start with the next # for that action type
		v_StartTime := clock_timestamp();
		SELECT CAST(COUNT(1)+1 AS VARCHAR(3)) INTO v_CASE_NUMBER FROM public.CMS_CASE_FILE CF
		JOIN public.CMS_CASE C ON CF.CASE_FILE_ID=C.CASE_FILE_ID
		WHERE CF.CASE_FILE_ID = v_CASE_FILE_ID AND C.CASE_TYPE_ID = v_CASE_TYPE_ID;
		
		v_EndTime := clock_timestamp();
		select extract(second from (v_EndTime - v_StartTime)) into v_Diff;
		raise notice '  --- v_Diff = %',  cast(v_Diff as character varying(20));

		-- pad left 0 for # under 10 (eg 01, 02)
		IF LENGTH(v_CASE_NUMBER) = 1 THEN
			v_CASE_NUMBER = '0' || v_CASE_NUMBER;
		END IF;
		-- and prefix with the type (eg fc, bk)
		v_CASE_NUMBER := v_CASE_TYPE_CODE || v_CASE_NUMBER;

		raise notice 'v_CASE_NUMBER = %',  cast(v_CASE_NUMBER as character varying(20));

		-- CREATE THE ACTION AND GET ITS ID FOR OTHER INSERTS/AUDIT
		v_StartTime := clock_timestamp();
		SELECT nextval('sq_case_serial') into v_CASE_ID;
		INSERT INTO public.CMS_CASE
		(	CASE_ID,
			CASE_FILE_ID,
			CASE_TYPE_ID,
			LOCATION_ID,
			BK_CHAPTER_ID,
			CASE_TMPL_ID,
			CASE_FILE_RECEIVED,
			CASE_STARTED,
			CASE_WHO_HAS,
			CASE_NUMBER
			--CORE_PROCESS_NAME
		)
		VALUES
		(	v_CASE_ID,
			v_CASE_FILE_ID,
			v_CASE_TYPE_ID,
			v_LOCATION_ID,
			v_BK_CHAPTER_ID,
			v_CASE_TMPL_ID,
			v_CASE_FILE_RECEIVED::timestamp without time zone,
			v_CASE_STARTED::timestamp without time zone,
			v_CASE_WHO_HAS,
			v_CASE_NUMBER
			--@CORE_PROCESS_NAME
		);
	
	v_EndTime := clock_timestamp();
	select extract(second from (v_EndTime - v_StartTime)) into v_Diff;
	raise notice '  --- v_Diff = %',  cast(v_Diff as character varying(20));

	raise notice 'v_CASE_ID = %',  cast(v_CASE_ID as character varying(20));
	
	v_StartTime := clock_timestamp();
	SELECT nextval('public.sq_case_status_serial') into v_CASE_STAT_ID;
	INSERT INTO public.CMS_CASE_STATUS (CASE_STAT_ID, STATUS_ID, CASE_ID, CASE_STAT_USR_ID, CASE_STAT_USR_NAME)
	VALUES (v_CASE_STAT_ID, 1, v_CASE_ID, v_USERID, v_USERNAME);
	raise notice 'CASE STATUS inserted: %',  cast(v_CASE_STAT_ID as character varying(20));

v_EndTime := clock_timestamp();
select extract(second from (v_EndTime - v_StartTime)) into v_Diff;
raise notice '  --- v_Diff = %',  cast(v_Diff as character varying(20));

		-- CREATE THE BK ROW AND AUDIT THAT
v_StartTime := clock_timestamp();
	SELECT nextval('public.sq_bankruptcy_serial') into v_BK_ID;
	INSERT INTO public.CMS_BANKRUPTCY (BK_ID, CASE_ID) VALUES (v_BK_ID, v_CASE_ID);
	raise notice 'BANKRUPTCY inserted: %',  cast(v_BK_ID as character varying(20));

v_EndTime := clock_timestamp();
select extract(second from (v_EndTime - v_StartTime)) into v_Diff;
raise notice '  --- v_Diff = %',  cast(v_Diff as character varying(20));

v_StartTime := clock_timestamp();
	SELECT nextval('public.sq_quote_serial') into v_QUOTE_ID;
	INSERT INTO public.CMS_QUOTE (QUOTE_ID, CASE_ID, QUOTE_TYPE_ID, QUOTE_IS_TAGGED) VALUES (v_QUOTE_ID, v_CASE_ID, 8, true);
	raise notice 'QUOTE inserted: %',  cast(v_QUOTE_ID as character varying(20));

v_EndTime := clock_timestamp();
select extract(second from (v_EndTime - v_StartTime)) into v_Diff;
raise notice '  --- v_Diff = %',  cast(v_Diff as character varying(20));

v_StartTime := clock_timestamp();
	INSERT INTO public.CMS_ACTIVITY (
		ACT_ID,
		CASE_ID,
		ACT_NAME,
		ACT_ACTIV_ID,
		ACT_SEQ,
		ACT_TMPL_ID,
		USER_GROUP_ID
	)
    SELECT 	nextval('public.sq_activity_serial'), --v_ACT_ID,
			v_case_id,
			a.BF_ACTIVITY_NAME,
            a.BF_ACT_ID,
			a.ACT_TMPL_SEQ_NUM,
			a.ACT_TMPL_ID,
			mtn.USER_GROUP_ID
    FROM public.CMS_ACTIVITY_TEMPLATE a 
		JOIN public.CMS_MS_TEMPLATE_NEW mtn ON a.MS_ID = mtn.MS_ID
    WHERE a.CASE_TMPL_ID = v_case_tmpl_id 
    ORDER BY a.ACT_TMPL_SEQ_NUM asc;
	
v_EndTime := clock_timestamp();
select extract(second from (v_EndTime - v_StartTime)) into v_Diff;
raise notice '  --- v_Diff = %',  cast(v_Diff as character varying(20));

	SELECT currval('public.sq_activity_serial') into v_ACT_ID;
	raise notice 'ACTIVITY inserted: %',  cast(v_ACT_ID as character varying(20));

v_StartTime := clock_timestamp();
	SELECT c.CASE_FILE_RECEIVED,
        	c.CASE_TMPL_ID
		into v_case_file_received, v_case_tmpl_id
    FROM public.CMS_CASE c
    WHERE c.CASE_ID = v_case_id;

v_EndTime := clock_timestamp();
select extract(second from (v_EndTime - v_StartTime)) into v_Diff;
raise notice '  --- v_Diff = %',  cast(v_Diff as character varying(20));

v_StartTime := clock_timestamp();
	select current_timestamp at time zone 'utc' into v_UTC;
	select nextval('public.sq_comment_serial') into v_COMMENT_ID;
	INSERT INTO public.CMS_COMMENT(COMMENT_ID, CMNT_TYPE_ID,CASE_ID,COMMENT_TEXT,COMMENT_USR_ID,COMMENT_USR_NAME,COMMENT_DATE) 
      VALUES(v_COMMENT_ID,6,v_CASE_ID,'Comment',v_USERID,v_USERNAME,v_UTC);
	raise notice 'COMMENT inserted: %',  cast(v_COMMENT_ID as character varying(20));

v_EndTime := clock_timestamp();
select extract(second from (v_EndTime - v_StartTime)) into v_Diff;
raise notice '  --- v_Diff = %',  cast(v_Diff as character varying(20));

	--raise notice 'v_case_file_received %',  v_case_file_received;
	--raise notice 'v_case_file_received %',  to_date(v_case_file_received, 'YYYY-MM-DD');

v_StartTime := clock_timestamp();
	UPDATE public.CMS_ACTIVITY
    SET ACT_SCHDL_DATE = coalesce(to_date(v_case_file_received, 'YYYY-MM-DD'), to_date(current_timestamp::text, 'YYYY-MM-DD'))
    WHERE CASE_ID = v_case_id AND ACT_ACTIV_ID = '000';

v_EndTime := clock_timestamp();
select extract(second from (v_EndTime - v_StartTime)) into v_Diff;
raise notice '  --- v_Diff = %',  cast(v_Diff as character varying(20));

-- CMSWS_SP_INSERT_DEFENDANT_NEW
v_StartTime := clock_timestamp();
		SELECT DEFICIENCY_REASON_ID into v_DEFICIENCY_REASON_ID FROM public.CMS_DEFENDANT_DEFICIENCY_REASON 
			WHERE DEFICIENCY_REASON_NAME = v_DEFICIENCY_REASON_NAME;

		SELECT APPEARANCE_TYPE_ID into v_APPEARANCE_TYPE_ID FROM public.CMS_DEFENDANT_APPEARANCE_TYPE 
			WHERE APPEARANCE_TYPE_NAME = v_APPEARANCE_TYPE_NAME;

		SELECT CONSENT_TYPE_ID into v_CONSENT_TYPE_ID FROM public.CMS_DEFENDANT_CONSENT_TYPE
			WHERE CONSENT_TYPE_NAME = v_CONSENT_TYPE_NAME;

v_EndTime := clock_timestamp();
select extract(second from (v_EndTime - v_StartTime)) into v_Diff;
raise notice '  --- v_Diff = %',  cast(v_Diff as character varying(20));

		--SET @TEMP_CONTACT_ID = @CONTACT_ID
v_StartTime := clock_timestamp();		
		SELECT CT.CONT_TYPE_ID, 
				CT.CONT_TYPE_CASE_FILE,
				CMPLX.COMP_FIELD_SNGL 
			into v_CONT_TYPE_ID, v_CONT_TYPE_CASE_FILE, v_COMP_FIELD_SNGL
			FROM public.CMS_CONTACT_TYPE CT 
				LEFT OUTER JOIN public.CMS_COMPLEX_FIELD CMPLX ON CT.CONT_TYPE_ID=CMPLX.CONT_TYPE_ID
			WHERE CONT_TYPE_NAME = v_CONT_TYPE_NAME;

v_EndTime := clock_timestamp();
select extract(second from (v_EndTime - v_StartTime)) into v_Diff;
raise notice '  --- v_Diff = %',  cast(v_Diff as character varying(20));

		-- ACTOR DOES NOT GET CASE ID ENTERED FOR CASE FILE LEVEL CONTACTS
		IF v_CONT_TYPE_CASE_FILE then
			v_CASE_ID_VAR := v_CASE_ID;
		END IF;
 
		IF EXISTS (SELECT 1 FROM public.CMS_ACTOR  WHERE CASE_ID = V_CASE_ID AND CONTACT_ID = V_CONTACT_ID 
			AND CASE_FILE_ID = V_CASE_FILE_ID) THEN
				 delete from public.CMS_ACTOR  WHERE CASE_ID = V_CASE_ID AND CONTACT_ID = v_CONTACT_ID 
				AND CASE_FILE_ID = v_CASE_FILE_ID;
			END IF;

v_StartTime := clock_timestamp();
		select nextval('public.sq_actor_serial') into v_ACTOR_ID;
		INSERT INTO public.CMS_ACTOR
		(	ACTOR_ID,
			CASE_FILE_ID,
			CONT_TYPE_ID,
			CASE_ID,
			CONTACT_ID,
			ACTOR_INACTIVE
		)
		VALUES
		(	v_ACTOR_ID,
			v_CASE_FILE_ID,
			v_CONT_TYPE_ID,
			v_CASE_ID_VAR,  -- CASE_ID OR NULL AS APPROPRIATE SEE ABOVE
			v_CONTACT_ID,
			0::boolean
		);

v_EndTime := clock_timestamp();
select extract(second from (v_EndTime - v_StartTime)) into v_Diff;
raise notice '  --- v_Diff = %',  cast(v_Diff as character varying(20));

	raise notice 'ACTOR inserted: %',  cast(v_ACTOR_ID as character varying(20));

v_StartTime := clock_timestamp();
	INSERT INTO public.CMS_DEFENDANT 
		(
			ACTOR_ID,
			D_OCCUPANCY,
			D_DEFICIENCY_PRESERVED,
			D_DEFICIENCY_SOUGHT,
			DEFICIENCY_REASON_ID,
			D_SERVICE_CODE,
			D_APPEAR_DATE,
			APPEARANCE_TYPE_ID,
			D_CONSENT_REQUESTED,
			D_CONSENT_RECEIVED,
			CONSENT_TYPE_ID,
			D_NOTICE_SENT_STAT,
			D_DEFAULT_NOTICE_SENT,		
			D_DEFAULT_EXPIRED,
			D_DEFAULT_ORDERED,
			D_ORDER_SENT,
			D_COURT_FILE_CHECK,
			D_DEFAULT_ORD_ENT,
			D_DUE_DILIGENCE_AFF_NEEDED,
			D_DUE_DILIGENCE_AFF_RECEIVED,
			D_DUE_DILIGENCE_AFF_FILED,
			D_PLEADING_DATE,
			DEF_SEQ_NUMB
		)
		VALUES
		(
			v_ACTOR_ID,
			v_D_OCCUPANCY,
			v_D_DEFICIENCY_PRESERVED,
			v_D_DEFICIENCY_SOUGHT,
			v_DEFICIENCY_REASON_ID,
			v_D_SERVICE_CODE,
			v_D_APPEAR_DATE,
			v_APPEARANCE_TYPE_ID,
			v_D_CONSENT_REQUESTED,
			v_D_CONSENT_RECEIVED,
			v_CONSENT_TYPE_ID,
			v_D_NOTICE_SENT_STAT,
			v_D_DEFAULT_NOTICE_SENT,		
			v_D_DEFAULT_EXPIRED,
			v_D_DEFAULT_ORDERED,
			v_D_ORDER_SENT,
			v_D_COURT_FILE_CHECK,
			v_D_DEFAULT_ORD_ENT,
			v_D_DUE_DILIGENCE_AFF_NEEDED,
			v_D_DUE_DILIGENCE_AFF_RECEIVED,
			v_D_DUE_DILIGENCE_AFF_FILED,
			v_D_PLEADING_DATE,
			v_D_SEQ_NUMB
		);

v_EndTime := clock_timestamp();
select extract(second from (v_EndTime - v_StartTime)) into v_Diff;
raise notice '  --- v_Diff = %',  cast(v_Diff as character varying(20));

	raise notice 'DEFENDANT inserted: %',  cast(v_ACTOR_ID as character varying(20));

v_StartTime := clock_timestamp();
	SELECT  STATE_ID into v_STATE_ID FROM public.CMS_STATE
			WHERE STATE_CODE = v_STATE_CODE;

		SELECT  COUNTY_ID into v_COUNTY_ID FROM public.CMS_COUNTY
			WHERE COUNTY_NAME = v_COUNTY_NAME AND STATE_ID = v_STATE_ID;

		SELECT  CNTR_ID into v_CNTR_ID FROM public.CMS_COUNTRY 
			WHERE CNTR_NAME = v_COUNTRY_NAME;

		select nextval('public.sq_address_serial') into v_ADDRESS_ID;
		INSERT INTO public.CMS_ADDRESS
		(	ADDRESS_ID,
			ADDR_TYPE_ID,
			CONTACT_ID,
			STATE_ID,
			COUNTY_ID,
			ADDRESS_1_LINE,
			ADDRESS_2_LINE,
			ADDRESS_CITY,
			ADDRESS_ZIPCODE,
			ADDRESS_IS_PRIM,
			ADDRESS_TEXT,
			CNTR_ID,
			ADDRESS_LINE_ATTN
		)
		VALUES
		(	v_ADDRESS_ID,
			1,  -- CONTACT
			v_CONTACT_ID,
			v_STATE_ID,
			v_COUNTY_ID,
			v_ADDRESS_1_LINE,
			v_ADDRESS_2_LINE,
			v_ADDRESS_CITY,
			v_ADDRESS_ZIPCODE,
			v_ADDRESS_IS_PRIM,
			v_ADDRESS_TEXT,
			v_CNTR_ID,
			v_ADDRESS_LINE_ATTN
		);
		
v_EndTime := clock_timestamp();
select extract(second from (v_EndTime - v_StartTime)) into v_Diff;
raise notice '  --- v_Diff = %',  cast(v_Diff as character varying(20));

	raise notice 'ADDRESS inserted: %',  cast(v_ADDRESS_ID as character varying(20));
END$$;