--
DO $$
DECLARE 
	v_object character varying(240);
	v_CASE_TYPE_NAME character varying(50);
	v_OFFICE_ID NUMERIC(10,0);
	v_OFFICE_CODE character varying(50);
	v_CASE_ID NUMERIC(10,0);
	v_CLIENT_CODE character varying(20);
	v_CASE_FILE_NUMB character varying(20);
	v_CASE_FILE_ID NUMERIC (10,0);
	v_CLIENT_ID NUMERIC(10,0);
	v_who_has character varying(160) := 'Perf Test';
	v_USERID character varying(20) := '6951';
	v_USERNAME character varying(160) := 'Perf Test';
	v_ACT_ID NUMERIC(10,0);
	v_OWNDATE timestamp := current_timestamp;
	v_STATE_ID NUMERIC(10,0) := NULL; 
	v_CASE_TYPE_ID NUMERIC(10,0) := 1;
	v_PROCESS_TYPE_ID NUMERIC(10,0) := NULL;  
	v_IS_ACTIVE BIT := 1;
	v_VAR1 NUMERIC(10,0);
	v_VAR2 NUMERIC(10,0);
	v_VAR3 character varying(260);--NUMERIC(10,0);
	v_VAR4 character varying(260);
	v_VAR5 character varying(260);
	v_VAR6 character varying(260);
	v_cf_id numeric(10);
	v_grp_id numeric(10);
	v_count numeric(10);
	v_old_date timestamp := current_timestamp;
	v_case character varying(260);
	v_IS_INCLUDE_SUB_ACTIVITIES	BIT 			:= 1;
	v_IS_INCLUDE_INACTIVE		BIT 			:= 1;
	v_COMMENT_ID numeric(10);
	v_StartTime timestamp with time zone;
	v_EndTime timestamp with time zone;
	v_diff numeric(10);
BEGIN
v_StartTime := clock_timestamp();
SELECT CASE_TYPE_NAME, OFFICE_ID, OFFICE_CODE 
into v_CASE_TYPE_NAME, v_OFFICE_ID, v_OFFICE_CODE
FROM public.TMP_CASE_TYPE__OFFICE_CODE 
order by RANDOM()
limit 1;

v_EndTime := clock_timestamp();
select extract(second from (v_EndTime - v_StartTime)) into v_Diff;
raise notice '  --- v_Diff = %',  cast(v_Diff as character varying(20));
-- -- get random CASE_TYPE_NAME

-- --exec CMSWS_SP_SEARCH_CASES_USER_LOGIN @OFFICE_CODE=N'AL',@CASE_FILE_NUMB=NULL,@ACTION_NUMB=NULL,@REF_SYS_NAME=NULL,@CASE_TYPE_NAME=N'Foreclosure',@CASE_TMPL_STATE_CODE=NULL,@CASE_TMPL_NAME=NULL,@CASE_FILE_REF=NULL,@CLIENT_CODE=NULL,@CASE_FILE_AGENCY=NULL,@CASE_FILE_INVESTOR=NULL,@CASE_FILE_INVESTOR_NUM=NULL,@STATUS_NAME=N'ACTIVE',@CASE_FILE_LOAN_NUMB=NULL,@CASE_COURT_NUMB=NULL,@CASE_OUTSOURCER_NUMB=NULL,@PROP_ADDRESS_1_LINE=NULL,@PROP_ADDRESS_2_LINE=NULL,@PROP_ADDRESS_CITY=NULL,@PROP_ADDRESS_STATE_CODE=NULL,@PROP_ADDRESS_ZIPCODE=NULL,@PROP_ADDRESS_COUNTY_NAME=NULL,@CASE_WHO_HAS=NULL,@CASE_FILE_RECEIVED=NULL,@SCHEDULED_MILESTONE_NAME=NULL,@SCHEDULED_MILESTONE_START_DATE=NULL,@SCHEDULED_MILESTONE_END_DATE=NULL,@COMPLETED_MILESTONE_NAME=NULL,@COMPLETED_MILESTONE_START_DATE=NULL,@COMPLETED_MILESTONE_END_DATE=NULL,@IS_ARCH=NULL,@TOP=200,@ISOFFSHOREUSER=0,@USER_LOGIN=N'aruslyakov',@SUB_PROCESS_TEMPLATE_ID=NULL,@SUB_PROCESS_STATUS_NAME=NULL

v_StartTime := clock_timestamp();
SELECT 
	C.CASE_ID into v_CASE_ID
	FROM   
	public.CMS_CASE_FILE CF    
	LEFT OUTER JOIN public.CMS_CASE C  ON C.CASE_FILE_ID = CF.CASE_FILE_ID  
	LEFT OUTER JOIN public.CMS_CASE_TYPE CT  ON C.CASE_TYPE_ID = CT.CASE_TYPE_ID  
	LEFT OUTER JOIN public.CMS_CASE_TEMPLATE TMPL  ON C.CASE_TMPL_ID = TMPL.CASE_TMPL_ID  
	LEFT OUTER JOIN public.CMS_LOCATION LOC  ON LOC.LOCATION_ID = C.LOCATION_ID   
	LEFT OUTER JOIN public.CMS_CLIENT_HISTORY ch  ON ch.CASE_FILE_ID = cf.CASE_FILE_ID AND CH.CLIENT_HIST_CUR_CLIENT = 'true' AND CH.CLIENT_ROLE_ID=1     
	LEFT OUTER JOIN public.CMS_CLIENT cli  ON cli.CLIENT_ID = ch.CLIENT_ID  
	LEFT OUTER JOIN public.CMS_OFFICE OFC ON CF.OFFICE_ID = OFC.OFFICE_ID
	LEFT OUTER JOIN public.CMS_ADDRESS ADR  ON CF.CASE_FILE_ID = ADR.CASE_FILE_ID  
	LEFT OUTER JOIN public.CMS_COUNTY CN  ON ADR.COUNTY_ID = CN.COUNTY_ID  
	LEFT OUTER JOIN public.CMS_STATE ST  ON ADR.STATE_ID = ST.STATE_ID
	LEFT OUTER JOIN public.CMS_STATE TMPLST  ON TMPL.STATE_ID = TMPLST.STATE_ID  
	LEFT OUTER JOIN public.CMS_CASE_STATUS cs  ON c.CASE_ID = cs.CASE_ID AND cs.CASE_STAT_CUR_STAT = 'true' 
	LEFT OUTER JOIN public.CMS_STATUS_TYPE s ON cs.STATUS_ID = s.STATUS_ID
	LEFT OUTER JOIN public.CMS_REFERRING_SYSTEM REF  ON C.REF_SYS_ID=REF.REF_SYS_ID WHERE 1=1 
AND (coalesce(cli.SUPER_CODE_ID, -1) <> 3363 OR OFC.OFFICE_CODE NOT IN ('AZ', 'GA', 'KS', 'LA', 'MO', 'OIK', 'TX', 'VA') AND cli.SUPER_CODE_ID = 3363) 
 AND OFC.OFFICE_CODE =v_OFFICE_CODE
 AND CT.CASE_TYPE_NAME =v_CASE_TYPE_NAME AND S.STATUS_NAME ='ACTIVE'
 limit 200;

v_EndTime := clock_timestamp();
select extract(second from (v_EndTime - v_StartTime)) into v_Diff;
raise notice '  --- v_Diff = %',  cast(v_Diff as character varying(20));
-- --select @CASE_TYPE_NAME, @OFFICE_ID, @OFFICE_CODE 

 IF v_CASE_ID is not null THEN
	 --> if empty finish TS else get Case_id from the firts row

	--exec CMSWS_SP_GET_CMS_CASE_INFO @CASE_ID=3212238  -- get CHE

v_StartTime := clock_timestamp();
		SELECT
			C.CASE_FILE_ID, 
			CF.CASE_FILE_NUMB, 
			C.CASE_NUMBER, 
			CF.CASE_FILE_REF,
			C.CASE_HOLDER_NAME,
			CLI.CLIENT_CODE
			INTO
			v_CASE_FILE_ID,
			v_CASE_FILE_NUMB,
			v_VAR4,
			v_VAR5,
			v_VAR6,
			v_CLIENT_CODE
		FROM
			public.CMS_CASE_FILE CF 
			INNER JOIN public.CMS_CASE C  ON C.CASE_FILE_ID=CF.CASE_FILE_ID
			LEFT OUTER JOIN public.CMS_LOAN_TYPE LT  ON CF.LOAN_TYPE_ID=LT.LOAN_TYPE_ID
			LEFT JOIN public.CMS_CASE_TYPE CT  ON CT.CASE_TYPE_ID=C.CASE_TYPE_ID
			LEFT JOIN public.CMS_CASE_STATUS CS  ON C.CASE_ID=CS.CASE_ID AND CS.CASE_STAT_CUR_STAT = 'true'
			LEFT JOIN public.CMS_STATUS_TYPE ST  ON CS.STATUS_ID=ST.STATUS_ID
			LEFT OUTER JOIN public.CMS_DELAY_CODE DC  ON DC.DELAY_CODE_ID=CS.DELAY_CODE_ID
			LEFT JOIN public.CMS_CLIENT_HISTORY CH   ON CH.CASE_FILE_ID = CF.CASE_FILE_ID AND CH.CLIENT_ROLE_ID=1 AND CH.CLIENT_HIST_CUR_CLIENT = 'true'
			LEFT JOIN public.CMS_CLIENT CLI  ON CLI.CLIENT_ID = CH.CLIENT_ID
			LEFT OUTER JOIN public.CMS_LEGAL_PORTION LP  ON CLI.LEGAL_PORTION_ID=LP.LEGAL_PORTION_ID
			LEFT OUTER JOIN public.CMS_REFERRING_SYSTEM REF  ON C.REF_SYS_ID=REF.REF_SYS_ID
			LEFT OUTER JOIN public.CMS_LOCATION LOC ON C.LOCATION_ID=LOC.LOCATION_ID
			LEFT OUTER JOIN public.CMS_ADDRESS CA_PROP  ON CF.CASE_FILE_ID = CA_PROP.CASE_FILE_ID AND CA_PROP.ADDR_TYPE_ID = 12
			LEFT OUTER JOIN public.CMS_COUNTY CO_PROP ON CA_PROP.COUNTY_ID = CO_PROP.COUNTY_ID
			LEFT OUTER JOIN public.CMS_OCCUPANCY OCC  ON C.OCCUPANCY_ID=OCC.OCCUPANCY_ID
			LEFT OUTER JOIN public.CMS_DELAY_CODE_SUB_TYPE DST  ON CS.DELAY_CODE_SUB_TYPE_ID=DST.DELAY_CODE_SUB_TYPE_ID
			LEFT OUTER JOIN public.CMS_CASE_TEMPLATE TMPL  ON C.CASE_TMPL_ID=TMPL.CASE_TMPL_ID
		WHERE
			C.CASE_ID = v_CASE_ID;

v_EndTime := clock_timestamp();
select extract(second from (v_EndTime - v_StartTime)) into v_Diff;
raise notice '  --- v_Diff = %',  cast(v_Diff as character varying(20));

-- 	--get client_code, case_file_number, case_file_id
-- raise notice '  --- v_CLIENT_CODE = %',  cast(v_CLIENT_CODE as character varying(20));
-- 	--exec CMSWS_SP_GET_CASE_FILE_INFO_BY_CASE_ID @CASE_ID=3212238

v_StartTime := clock_timestamp();
		SELECT
		CF.CASE_FILE_ID,
		CF.OFFICE_ID,
		OFC.OFFICE_CODE,
		CF.CASE_FILE_NUMB,
		CF.LOAN_TYPE_ID,
		LT.LOAN_TYPE_NAME
		into
		v_VAR1,
		v_VAR2,
		v_VAR3,
		v_VAR4,
		v_VAR5,
		v_VAR6
		FROM
		public.CMS_CASE C
		INNER JOIN public.CMS_CASE_FILE CF  ON C.CASE_FILE_ID=CF.CASE_FILE_ID
		LEFT OUTER JOIN public.CMS_LOAN_TYPE LT  ON CF.LOAN_TYPE_ID=LT.LOAN_TYPE_ID
		INNER JOIN public.CMS_OFFICE OFC ON CF.OFFICE_ID=OFC.OFFICE_ID
		WHERE
		C.CASE_ID = v_CASE_ID;

v_EndTime := clock_timestamp();
select extract(second from (v_EndTime - v_StartTime)) into v_Diff;
raise notice '  --- v_Diff = %',  cast(v_Diff as character varying(20));

 	-- exec CMSWS_SP_GET_CLIENT_INFO @CLIENT_CODE=N'CHE' -- get client_id
v_StartTime := clock_timestamp();
		IF (v_CLIENT_CODE IS NULL) THEN
			SELECT
				CLI.CLIENT_ID,
				CLI.CLIENT_NAME,
				CLI.CLIENT_CODE,
				CS.STATUS_NAME
				INTO
				v_CLIENT_ID,
				v_VAR4,
				v_VAR5,
				v_VAR6
			FROM public.CMS_CLIENT CLI
			LEFT OUTER JOIN public.CMS_SUPER_CODE SC ON CLI.SUPER_CODE_ID=SC.SUPER_CODE_ID
			LEFT OUTER JOIN public.CMS_CLIENT_STATUS CS ON CLI.CL_STATUS_ID=CS.CL_STATUS_ID
			LEFT OUTER JOIN public.CMS_LEGAL_PORTION LP  ON CLI.LEGAL_PORTION_ID=LP.LEGAL_PORTION_ID
			LEFT OUTER JOIN public.CMS_BILLING_PORTION BP ON CLI.BILLING_PORTION_ID=BP.BILLING_PORTION_ID
			LEFT OUTER JOIN public.CMS_CLIENT_REFERRING_SYS CR ON CLI.CLIENT_REFERRING_SYS_ID=CR.REFERRING_SYS_ID;
		ELSE
			SELECT
				CLI.CLIENT_ID,
				CLI.CLIENT_NAME,
				CLI.CLIENT_CODE,
				CS.STATUS_NAME
				INTO
				v_CLIENT_ID,
				v_VAR4,
				v_VAR5,
				v_VAR6
			FROM public.CMS_CLIENT CLI
			LEFT OUTER JOIN public.CMS_SUPER_CODE SC ON CLI.SUPER_CODE_ID=SC.SUPER_CODE_ID
			LEFT OUTER JOIN public.CMS_CLIENT_STATUS CS ON CLI.CL_STATUS_ID=CS.CL_STATUS_ID
			LEFT OUTER JOIN public.CMS_LEGAL_PORTION LP  ON CLI.LEGAL_PORTION_ID=LP.LEGAL_PORTION_ID
			LEFT OUTER JOIN public.CMS_BILLING_PORTION BP  ON CLI.BILLING_PORTION_ID=BP.BILLING_PORTION_ID
			LEFT OUTER JOIN public.CMS_CLIENT_REFERRING_SYS CR  ON CLI.CLIENT_REFERRING_SYS_ID=CR.REFERRING_SYS_ID
			WHERE CLI.CLIENT_CODE = v_CLIENT_CODE;
		END IF;

v_EndTime := clock_timestamp();
select extract(second from (v_EndTime - v_StartTime)) into v_Diff;
raise notice '  --- v_Diff = %',  cast(v_Diff as character varying(20));
-- 	-- get Client_id

-- 	--exec CMSWS_SP_GET_CLIENT_FULL_INFO @CLIENT_ID=587

v_StartTime := clock_timestamp();
		SELECT
			CLIENT_ID,
			CLIENT_CODE,
			CL_STATUS_ID,
			IR_ID
			into
			v_VAR1,
			v_VAR4,
			v_VAR2,
			v_VAR3
		FROM public.CMS_CLIENT CLI
		WHERE CLI.CLIENT_ID = v_CLIENT_ID;

v_EndTime := clock_timestamp();
select extract(second from (v_EndTime - v_StartTime)) into v_Diff;
raise notice '  --- v_Diff = %',  cast(v_Diff as character varying(20));
-- 	-- exec CMS_P_GET_CONTACT_FOR_CLIENT @CLIENT_ID=587


-- 		-- get contact for client
v_StartTime := clock_timestamp();
		SELECT cc.CLIENT_CONT_ID, cc.CLIENT_ID, cc.CLIENT_CONT_TYPE_ID, cct.CLIENT_CONT_TYPE_NAME,
				CONCAT(
					COALESCE(a.ADDRESS_1_LINE || ', ', ''),
					COALESCE(a.ADDRESS_2_LINE || ', ', ''),
					COALESCE(a.ADDRESS_CITY || ', ', ''),
					COALESCE(s.STATE_CODE || ', ', ''),
					COALESCE(a.ADDRESS_ZIPCODE, '')
				)
				into
				v_VAR1,
				v_VAR2,
				v_VAR3,
				v_VAR5,
				v_VAR4
		FROM	public.CMS_CLIENT_CONTACT AS cc
			INNER JOIN public.CMS_CLIENT_CONTACT_TYPE cct  ON cc.CLIENT_CONT_TYPE_ID = cct.CLIENT_CONT_TYPE_ID
			LEFT OUTER JOIN public.CMS_ADDRESS a  ON a.CLIENT_CONT_ID = cc.CLIENT_CONT_ID AND a.ADDRESS_IS_PRIM = 'true'
			LEFT JOIN public.CMS_STATE s ON s.STATE_ID = a.STATE_ID
		WHERE   cc.CLIENT_ID = v_client_id
		limit 1;

v_EndTime := clock_timestamp();
select extract(second from (v_EndTime - v_StartTime)) into v_Diff;
raise notice '  --- v_Diff = %',  cast(v_Diff as character varying(20));

-- 	--exec CMSWS_SP_GET_CMS_CASE_INFO_BY_CASENUMBER @OFFICE_CODE=N'AL',@CASE_FILE_NUMB=N'14-003582'
v_StartTime := clock_timestamp();
		/* RETURNS A LIST OF ACTIONS FOR THE GIVEN OFFICE/CASE # */
		SELECT
			C.CASE_ID,
			C.CASE_FILE_ID,
			CF.CASE_FILE_LOAN_NUMB,
			CF.CASE_FILE_NUMB,
			C.CASE_NUMBER
			INTO
			v_VAR1,
			v_VAR2,
			v_VAR4,
			v_VAR5,
			v_VAR6
		FROM
			public.CMS_CASE_FILE CF
			INNER JOIN public.CMS_CASE C  ON C.CASE_FILE_ID=CF.CASE_FILE_ID
			LEFT OUTER JOIN public.CMS_LOAN_TYPE LT  ON CF.LOAN_TYPE_ID=LT.LOAN_TYPE_ID
			INNER JOIN public.CMS_CASE_TYPE CT  ON CT.CASE_TYPE_ID=C.CASE_TYPE_ID
			INNER JOIN public.CMS_CASE_STATUS CS  ON C.CASE_ID=CS.CASE_ID AND CS.CASE_STAT_CUR_STAT='true'
			INNER JOIN public.CMS_STATUS_TYPE ST  ON CS.STATUS_ID=ST.STATUS_ID
			LEFT OUTER JOIN public.CMS_DELAY_CODE DC  ON DC.DELAY_CODE_ID=CS.DELAY_CODE_ID
			INNER JOIN public.CMS_CLIENT_HISTORY CH  ON CH.CASE_FILE_ID = CF.CASE_FILE_ID AND CH.CLIENT_ROLE_ID=1 AND CH.CLIENT_HIST_CUR_CLIENT='true'
			INNER JOIN public.CMS_CLIENT CLI  ON CLI.CLIENT_ID = CH.CLIENT_ID
			LEFT OUTER JOIN public.CMS_REFERRING_SYSTEM REF  ON C.REF_SYS_ID=REF.REF_SYS_ID
			INNER JOIN public.CMS_OFFICE OFC  ON CF.OFFICE_ID=OFC.OFFICE_ID
			LEFT OUTER JOIN public.CMS_LOCATION LOC ON C.LOCATION_ID=LOC.LOCATION_ID
			LEFT OUTER JOIN public.CMS_ADDRESS CA_PROP ON CF.CASE_FILE_ID = CA_PROP.CASE_FILE_ID AND CA_PROP.ADDR_TYPE_ID = 12
			LEFT OUTER JOIN public.CMS_COUNTY CO_PROP ON CA_PROP.COUNTY_ID = CO_PROP.COUNTY_ID
			LEFT OUTER JOIN public.CMS_OCCUPANCY OCC  ON C.OCCUPANCY_ID=OCC.OCCUPANCY_ID
			LEFT OUTER JOIN public.CMS_DELAY_CODE_SUB_TYPE DST  ON CS.DELAY_CODE_SUB_TYPE_ID=DST.DELAY_CODE_SUB_TYPE_ID
			LEFT OUTER JOIN public.CMS_CASE_TEMPLATE TMPL  ON C.CASE_TMPL_ID=TMPL.CASE_TMPL_ID

		WHERE
			CF.CASE_FILE_NUMB = v_CASE_FILE_NUMB AND
			OFC.OFFICE_CODE = v_OFFICE_CODE
		limit 1;

v_EndTime := clock_timestamp();
select extract(second from (v_EndTime - v_StartTime)) into v_Diff;
raise notice '  --- v_Diff = %',  cast(v_Diff as character varying(20));

-- 	--exec CMSWS_SP_GET_PROPERTY_ADDRESS @CASE_FILE_ID=2067753
v_StartTime := clock_timestamp();
		SELECT
		ADRS.ADDRESS_ID,
		ADRS.ADDRESS_1_LINE,
		ADRS.ADDRESS_2_LINE
		into
		v_VAR1,
		v_VAR4,
		v_VAR5
		FROM
		public.CMS_ADDRESS ADRS
		LEFT OUTER JOIN public.CMS_STATE ST  ON ADRS.STATE_ID=ST.STATE_ID
		LEFT OUTER JOIN public.CMS_COUNTY CNTY ON ADRS.COUNTY_ID=CNTY.COUNTY_ID
		LEFT OUTER JOIN public.CMS_COUNTRY CNTRY  ON ADRS.CNTR_ID=CNTRY.CNTR_ID
		WHERE
		ADRS.ADDR_TYPE_ID = 12 AND
		ADRS.CASE_FILE_ID = v_CASE_FILE_ID
		limit 1;

v_EndTime := clock_timestamp();
select extract(second from (v_EndTime - v_StartTime)) into v_Diff;
raise notice '  --- v_Diff = %',  cast(v_Diff as character varying(20));

-- 	--exec CMSWS_SP_GET_ALERTS_ON_ACTION @CASE_ID=3212238
v_StartTime := clock_timestamp();
		SELECT
		BP.BP_ID,
		BP.BP_NAME
		into
		v_VAR1,
		v_VAR4
		FROM
		public.CMS_BOILER_PLATE_LINK BPL
		INNER JOIN public.CMS_BOILER_PLATE BP  ON BPL.BP_ID=BP.BP_ID
		WHERE
		BPL.CASE_ID = v_CASE_ID;

v_EndTime := clock_timestamp();
select extract(second from (v_EndTime - v_StartTime)) into v_Diff;
raise notice '  --- v_Diff = %',  cast(v_Diff as character varying(20));

	-- exec CMS_P_GET_ACTION_CASE_ASSOCIATED @cf_id=2067753
	-- set case id
	v_cf_id := v_CASE_FILE_ID;

v_StartTime := clock_timestamp();
	SELECT CASE_FILE_GRP_ID into v_grp_id FROM public.CMS_CASE_FILE_ASSOCIATED
		WHERE CASE_FILE_ID = v_cf_id;

v_EndTime := clock_timestamp();
select extract(second from (v_EndTime - v_StartTime)) into v_Diff;
raise notice '  --- v_Diff = %',  cast(v_Diff as character varying(20));

v_StartTime := clock_timestamp();
	SELECT cfa.CFA_ID,
			c.CASE_ID,
			cf.CASE_FILE_ID,
			cf.CASE_FILE_NUMB,
			c.CASE_NUMBER,
			cf.CASE_FILE_REF
			into
			v_VAR1,
			v_VAR2,
			v_VAR3,
			v_VAR4
			v_VAR5,
			v_VAR6
	FROM
		public.CMS_CASE_FILE_ASSOCIATED AS cfa  INNER JOIN
	    public.CMS_CASE_FILE AS cf  ON cfa.CASE_FILE_ID = cf.CASE_FILE_ID INNER JOIN
		  public.CMS_CLIENT_HISTORY AS ch  ON cf.CASE_FILE_ID = ch.CASE_FILE_ID AND ch.CLIENT_HIST_CUR_CLIENT = 'true' AND ch.CLIENT_ROLE_ID = 1 INNER JOIN
		  public.CMS_CLIENT AS cl  ON ch.CLIENT_ID = cl.CLIENT_ID LEFT OUTER JOIN
		  public.CMS_CASE c  INNER JOIN
		  public.CMS_CASE_STATUS cs  INNER JOIN
		public.CMS_STATUS_TYPE st on cs.STATUS_ID = st.STATUS_ID
        	    				  ON c.CASE_ID = cs.CASE_ID AND cs.CASE_STAT_CUR_STAT = 'true'
        	    			  ON cf.CASE_FILE_ID = c.CASE_FILE_ID
	WHERE     cfa.CASE_FILE_GRP_ID = v_grp_id
	limit 1;

v_EndTime := clock_timestamp();
select extract(second from (v_EndTime - v_StartTime)) into v_Diff;
raise notice '  --- v_Diff = %',  cast(v_Diff as character varying(20));


-- 	--exec CMSWS_SP_GET_ACTION_INFO_BY_CASE_ID @CASE_ID=3212238
v_StartTime := clock_timestamp();
		SELECT
		C.CASE_ID,
		C.CASE_FILE_ID,
		C.CASE_NUMBER,
		C.CASE_TYPE_ID,
		CT.CASE_TYPE_NAME,
		LOC.LOCATION_NAME
		into
		v_VAR1,
		v_VAR2,
		v_VAR4,
		v_VAR3,
		v_VAR5,
		v_VAR6
		FROM public.CMS_CASE C
		INNER JOIN public.CMS_CASE_FILE CF ON C.CASE_FILE_ID = CF.CASE_FILE_ID
		INNER JOIN public.CMS_OFFICE O  ON CF.OFFICE_ID = O.OFFICE_ID
		INNER JOIN public.CMS_CASE_TYPE CT  ON C.CASE_TYPE_ID=CT.CASE_TYPE_ID
		LEFT OUTER JOIN public.CMS_LOCATION LOC  ON C.LOCATION_ID=LOC.LOCATION_ID
		LEFT OUTER JOIN public.CMS_REFERRING_SYSTEM REF  ON C.REF_SYS_ID=REF.REF_SYS_ID
		LEFT OUTER JOIN public.CMS_OCCUPANCY OCC  ON C.OCCUPANCY_ID=OCC.OCCUPANCY_ID
		LEFT OUTER JOIN public.CMS_DWELLING_TYPE DT  ON C.DT_ID=DT.DT_ID
		LEFT OUTER JOIN public.CMS_MORTGAGE_LIEN_POSITION MLP ON C.MLP_ID=MLP.MLP_ID
		WHERE C.CASE_ID = v_CASE_ID
		limit 1;

v_EndTime := clock_timestamp();
select extract(second from (v_EndTime - v_StartTime)) into v_Diff;
raise notice '  --- v_Diff = %',  cast(v_Diff as character varying(20));

	--exec CMS_P_MY_LAST_TEN_CASE_UPDATE @who_has=N'Andriy Ruslyakov',@case_file_id=2067753,@case_id=3212238
		-- get case file number plus case number
v_StartTime := clock_timestamp();
		SELECT (cf.CASE_FILE_NUMB || ' ' || c.CASE_NUMBER)
		into v_case
		FROM 	public.CMS_CASE c
		INNER JOIN public.CMS_CASE_FILE cf
			 ON c.CASE_FILE_ID = cf.CASE_FILE_ID
		WHERE
			(c.CASE_ID = v_case_id);

v_EndTime := clock_timestamp();
select extract(second from (v_EndTime - v_StartTime)) into v_Diff;
raise notice '  --- v_Diff = %',  cast(v_Diff as character varying(20));

v_StartTime := clock_timestamp();
		UPDATE public.CMS_MY_LAST_TEN_CASE
		SET LOAD_DATE = current_date
		WHERE
			CASE_WHO_HAS = v_who_has AND
			CASE_FILE_NUMB = v_case;

v_EndTime := clock_timestamp();
select extract(second from (v_EndTime - v_StartTime)) into v_Diff;
raise notice '  --- v_Diff = %',  cast(v_Diff as character varying(20));

		IF NOT FOUND THEN
	/*  If no record were update therefore is because it does not exist */
		--IF (@@ROWCOUNT = 0)
				-- get  counting Case and last oldening loading date
v_StartTime := clock_timestamp();
         		SELECT COUNT(CASE_ID), min(LOAD_DATE)
				INTO
				V_count,
				v_old_date
				FROM public.CMS_MY_LAST_TEN_CASE
     			WHERE CASE_WHO_HAS = v_who_has;

				-- deleting last oldening loading date if count > 10
				IF v_count >= 10 THEN
					DELETE FROM public.CMS_MY_LAST_TEN_CASE
					WHERE
						CASE_WHO_HAS = v_who_has AND
						LOAD_DATE = v_old_date;
				END IF;
				-- inserting loading Case
				INSERT INTO public.CMS_MY_LAST_TEN_CASE (CASE_ID, CASE_FILE_ID, CASE_FILE_NUMB, CASE_WHO_HAS, LOAD_DATE)
				VALUES (v_case_id, v_case_file_id, v_case, v_who_has, current_date);
v_EndTime := clock_timestamp();
select extract(second from (v_EndTime - v_StartTime)) into v_Diff;
raise notice '  --- v_Diff = %',  cast(v_Diff as character varying(20));
			END IF;

	--exec CMSWS_SP_GET_PROPERTY_ADDRESS @CASE_FILE_ID=2067753
v_StartTime := clock_timestamp();
		SELECT
		ADRS.ADDRESS_ID,
		ADRS.ADDRESS_1_LINE,
		ADRS.ADDRESS_2_LINE,
		CNTRY.CNTR_NAME
		INTO
		v_VAR1,
		v_VAR4,
		v_VAR5,
		v_VAR6
		FROM
		public.CMS_ADDRESS ADRS
		LEFT OUTER JOIN public.CMS_STATE ST  ON ADRS.STATE_ID=ST.STATE_ID
		LEFT OUTER JOIN public.CMS_COUNTY CNTY  ON ADRS.COUNTY_ID=CNTY.COUNTY_ID
		LEFT OUTER JOIN public.CMS_COUNTRY CNTRY  ON ADRS.CNTR_ID=CNTRY.CNTR_ID
		WHERE
		ADRS.ADDR_TYPE_ID=12 AND
		ADRS.CASE_FILE_ID = v_CASE_FILE_ID
		LIMIT 1;

v_EndTime := clock_timestamp();
select extract(second from (v_EndTime - v_StartTime)) into v_Diff;
raise notice '  --- v_Diff = %',  cast(v_Diff as character varying(20));

-- 	--exec CMSWS_SP_GET_CMS_CASE_INFO @CASE_ID=3212238

	--exec CMSWS_SP_GET_CMS_ACTIVITIES_BY_CASE_ID @CASE_ID=3212238,@IS_INCLUDE_SUB_ACTIVITIES=1,@IS_INCLUDE_INACTIVE=1
v_StartTime := clock_timestamp();
	SELECT
			a.ACT_ID,
			a.CASE_ID,
			a.ACT_NAME,
			SPT.SUB_PROCESS_TEMPLATE_NAME
			into
			v_ACT_ID,
			v_VAR1,
			v_VAR4,
			v_VAR5
		FROM public.CMS_ACTIVITY a
			INNER JOIN public.CMS_ACTIVITY_TEMPLATE atmpl ON a.ACT_TMPL_ID = atmpl.ACT_TMPL_ID
			INNER JOIN public.CMS_MS_TEMPLATE_NEW m ON atmpl.MS_ID = m.MS_ID
			LEFT JOIN public.CMS_CASE_SUB_PROCESS  sp ON sp.CASE_SUB_PROCESS_ID = a.CASE_SUB_PROCESS_ID
			LEFT JOIN public.CMS_SUBPROCESS_TEMPLATE SPT  ON sp.SUB_PROCESS_TEMPLATE_ID = SPT.SUB_PROCESS_TEMPLATE_ID
		WHERE
			a.CASE_ID = v_CASE_ID
			AND ((v_IS_INCLUDE_SUB_ACTIVITIES = 1::bit AND (v_IS_INCLUDE_INACTIVE=1::bit OR (sp.CASE_SUB_PROCESS_ID IS NULL ))) OR (sp.CASE_SUB_PROCESS_ID IS NULL))
			AND a.ACT_CMPL_DATE is NULL
		ORDER BY m.MS_SEQ_NUM
		limit 1;

v_EndTime := clock_timestamp();
select extract(second from (v_EndTime - v_StartTime)) into v_Diff;
raise notice '  --- v_Diff = %',  cast(v_Diff as character varying(20));
-- 	-- get activity id

	--exec CMSWS_SP_UPDATE_MILESTONE_NEW @USERID=N'6951',@USERNAME=N'Andriy Ruslyakov',@CASE_ID=3212238,@SCHDL_CMPL_FLAG=1,@MILESTONE_TYPE_NAME=N'Sale Bid Rcvd',@MILESTONE_DATE=N'02/18/2020',@CLIENT_UPLOAD_ATTEMPT_DATE=NULL,@CLIENT_UPLOAD_SUCCESSFUL=NULL,@CLIENT_UPLOAD_COMPLETED_BY=NULL,@ACT_ID=66831625
v_StartTime := clock_timestamp();
				UPDATE public.CMS_ACTIVITY
					SET ACT_CMPL_DATE = v_OWNDATE,
						ACT_CMPL_BY = v_USERNAME
				WHERE ACT_ID = v_act_id;

			UPDATE public.CMS_ACTIVITY
				SET ACT_COUNTER = ACT_COUNTER+1,
					ACT_CHNG_FLAG = 'true',
					ACT_SCHDL_DATE = v_OWNDATE
				WHERE ACT_ID = v_act_id;

v_EndTime := clock_timestamp();
select extract(second from (v_EndTime - v_StartTime)) into v_Diff;
raise notice '  --- v_Diff = %',  cast(v_Diff as character varying(20));

v_StartTime := clock_timestamp();
		select nextval('public.sq_comment_serial') into v_COMMENT_ID;
		INSERT INTO public.CMS_COMMENT(COMMENT_ID, CMNT_TYPE_ID,CASE_ID,COMMENT_TEXT,COMMENT_USR_ID,COMMENT_USR_NAME,COMMENT_DATE,CASE_SUB_PROCESS_ID)
		  VALUES(v_COMMENT_ID, 6,v_CASE_ID,'@COMMENTTEXT',v_USERID,v_USERNAME,current_timestamp,1);

v_EndTime := clock_timestamp();
select extract(second from (v_EndTime - v_StartTime)) into v_Diff;
raise notice '  --- v_Diff = %',  cast(v_Diff as character varying(20));

	-- run twice for next activity
v_StartTime := clock_timestamp();
			SELECT
			a.ACT_ID,
			a.CASE_ID,
			a.ACT_NAME,
			SPT.SUB_PROCESS_TEMPLATE_NAME
			into
			v_ACT_ID,
			v_VAR1,
			v_VAR4,
			v_VAR5
		FROM public.CMS_ACTIVITY a
			INNER JOIN public.CMS_ACTIVITY_TEMPLATE atmpl  ON a.ACT_TMPL_ID = atmpl.ACT_TMPL_ID
			INNER JOIN public.CMS_MS_TEMPLATE_NEW m  ON atmpl.MS_ID = m.MS_ID
			LEFT JOIN public.CMS_CASE_SUB_PROCESS  sp ON sp.CASE_SUB_PROCESS_ID = a.CASE_SUB_PROCESS_ID
			LEFT JOIN public.CMS_SUBPROCESS_TEMPLATE SPT  ON sp.SUB_PROCESS_TEMPLATE_ID = SPT.SUB_PROCESS_TEMPLATE_ID
		WHERE
			a.CASE_ID = v_CASE_ID
			AND ((v_IS_INCLUDE_SUB_ACTIVITIES=1::bit AND (v_IS_INCLUDE_INACTIVE=1::bit OR (sp.CASE_SUB_PROCESS_ID IS NULL ))) OR (sp.CASE_SUB_PROCESS_ID IS NULL))
			AND a.ACT_CMPL_DATE is NULL
		ORDER BY m.MS_SEQ_NUM
		limit 1;

v_EndTime := clock_timestamp();
select extract(second from (v_EndTime - v_StartTime)) into v_Diff;
raise notice '  --- v_Diff = %',  cast(v_Diff as character varying(20));
-- 	-- get activity id

	--exec CMSWS_SP_UPDATE_MILESTONE_NEW @USERID=N'6951',@USERNAME=N'Andriy Ruslyakov',@CASE_ID=3212238,@SCHDL_CMPL_FLAG=1,@MILESTONE_TYPE_NAME=N'Sale Bid Rcvd',@MILESTONE_DATE=N'02/18/2020',@CLIENT_UPLOAD_ATTEMPT_DATE=NULL,@CLIENT_UPLOAD_SUCCESSFUL=NULL,@CLIENT_UPLOAD_COMPLETED_BY=NULL,@ACT_ID=66831625
v_StartTime := clock_timestamp();
			UPDATE public.CMS_ACTIVITY
					SET ACT_CMPL_DATE = v_OWNDATE,
						ACT_CMPL_BY = v_USERNAME
				WHERE ACT_ID = v_act_id;

			UPDATE public.CMS_ACTIVITY
				SET ACT_COUNTER = ACT_COUNTER+1,
					ACT_CHNG_FLAG = 'true',
					ACT_SCHDL_DATE = v_OWNDATE
				WHERE ACT_ID = v_act_id;

v_EndTime := clock_timestamp();
select extract(second from (v_EndTime - v_StartTime)) into v_Diff;
raise notice '  --- v_Diff = %',  cast(v_Diff as character varying(20));

v_StartTime := clock_timestamp();
		select nextval('public.sq_comment_serial') into v_COMMENT_ID;
		INSERT INTO public.CMS_COMMENT(COMMENT_ID, CMNT_TYPE_ID,CASE_ID,COMMENT_TEXT,COMMENT_USR_ID,COMMENT_USR_NAME,COMMENT_DATE,CASE_SUB_PROCESS_ID)
		  VALUES(v_COMMENT_ID, 6,v_CASE_ID,'@COMMENTTEXT',v_USERID,v_USERNAME,current_timestamp,1);

v_EndTime := clock_timestamp();
select extract(second from (v_EndTime - v_StartTime)) into v_Diff;
raise notice '  --- v_Diff = %',  cast(v_Diff as character varying(20));

ELSE
	raise notice 'V_CASE_ID is null';
END IF;
END$$