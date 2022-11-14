
----------------------------------------------------------------------------------------------------
--IF OBJECT_ID('TempDB..#ndf') IS NOT NULL DROP TABLE #ndf
--select ndf.prd_cd,ndf.new_name,ndf.prod_flag,ndf.whs_price,ndf.prid_price,
--case when ndf.prod_flag='O' then ndf.whs_price else ndf.prid_price end as price
--into #ndf
--from [TPINDF].[dbo].[ndf1806] as ndf with (NOLOCK);
--ALTER TABLE #ndf ALTER COLUMN prd_cd varchar(7) NOT NULL;
--CREATE CLUSTERED INDEX prd_cd on #ndf (prd_cd);

--IF OBJECT_ID('TempDB..#ndf') IS NOT NULL DROP TABLE #ndf
--select ndf.month_code, ndf.prd_cd, ndf.prod_flag, ndf.whs_price, ndf.prid_price,
--case when ndf.prod_flag='O' then ndf.whs_price else ndf.prid_price end as price
--into #ndf
--from [BI_TEMP].[dbo].[LIDS_TR_M_1ES_90506739ME1__PRICES] as ndf with (NOLOCK) where ndf.month_code='M201806'; 
--ALTER TABLE #ndf ALTER COLUMN prd_cd varchar(7) NOT NULL;
--CREATE CLUSTERED INDEX prd_cd on #ndf (prd_cd);

IF OBJECT_ID('TempDB..#ndf') IS NOT NULL DROP TABLE #ndf
select * 
into #ndf
from [BI_TEMP].[dbo].[LIDS_TR_M_1ES_90506739ME1__PRICES] as ndf with (NOLOCK) where ndf.month_code='M201806'; 
ALTER TABLE #ndf ALTER COLUMN prd_cd varchar(7) NOT NULL;
CREATE CLUSTERED INDEX prd_cd on #ndf (prd_cd);
------------------------------------------------------------------------------------------------------

IF OBJECT_ID('TempDB..#LIDS_TR_M_1ES_90506739ME1__GEOGRAPHY') IS NOT NULL DROP TABLE [#LIDS_TR_M_1ES_90506739ME1__GEOGRAPHY]
select distinct GEOGRAPHY_datakey into [#LIDS_TR_M_1ES_90506739ME1__GEOGRAPHY] from [BI_TEMP].[dbo].[LIDS_TR_M_1ES_90506739ME1__GEOGRAPHY] with (NOLOCK) ;
CREATE CLUSTERED INDEX GEOGRAPHY_datakey on [#LIDS_TR_M_1ES_90506739ME1__GEOGRAPHY] (GEOGRAPHY_datakey);

IF OBJECT_ID('TempDB..#LIDS_TR_M_1ES_90506739ME1__PRODUCT') IS NOT NULL DROP TABLE [#LIDS_TR_M_1ES_90506739ME1__PRODUCT]
select distinct PRODUCT_datakey into [#LIDS_TR_M_1ES_90506739ME1__PRODUCT] from [BI_TEMP].[dbo].[LIDS_TR_M_1ES_90506739ME1__PRODUCT] with (NOLOCK) ;
CREATE CLUSTERED INDEX PRODUCT_datakey on [#LIDS_TR_M_1ES_90506739ME1__PRODUCT] (PRODUCT_datakey);

------------------------------------------------------------------------------------------------------
IF OBJECT_ID('TempDB..#q0') IS NOT NULL DROP TABLE #q0
select GEOGRAPHY_datakey,PRODUCT_datakey
    ,cast(SUM(t_unit) as int) as U, cast(SUM(t_bonus) as int) as B, cast(SUM(r_unit) as int) as R,cast(SUM(r_bonus) as int) as BR  
into #q0  
from
(
    select [#LIDS_TR_M_1ES_90506739ME1__GEOGRAPHY].GEOGRAPHY_datakey as GEOGRAPHY_datakey,[#LIDS_TR_M_1ES_90506739ME1__PRODUCT].PRODUCT_datakey as PRODUCT_datakey
		,t.wunit as t_unit, t.wbonus as t_bonus, 0 as r_unit,0 as r_bonus  
    from [TPIHTS].[dbo].[OUT11806] as t with (NOLOCK)
join [#LIDS_TR_M_1ES_90506739ME1__GEOGRAPHY] with (NOLOCK) on [#LIDS_TR_M_1ES_90506739ME1__GEOGRAPHY].GEOGRAPHY_datakey = t.u_code
join [#LIDS_TR_M_1ES_90506739ME1__PRODUCT] with (NOLOCK) on [#LIDS_TR_M_1ES_90506739ME1__PRODUCT].PRODUCT_datakey = t.pfc
WHERE  
    LEFT(U_CODE,1)= '1' AND 
    Unittype = '01'     AND  
    Groupcode <> '08'   AND  
    LEFT(PFC,1)<> 'P'   AND  
    LEFT(PFC,1)<> 'S'   
union all		 
    select [#LIDS_TR_M_1ES_90506739ME1__GEOGRAPHY].GEOGRAPHY_datakey as GEOGRAPHY_datakey,[#LIDS_TR_M_1ES_90506739ME1__PRODUCT].PRODUCT_datakey as PRODUCT_datakey
		,0 as t_unit,0 as t_bonus, t.wunit as r_unit, t.wbonus as r_bonus 
    from [TPIHTS].[dbo].[ROUT11806] as t with (NOLOCK)
join [#LIDS_TR_M_1ES_90506739ME1__GEOGRAPHY] with (NOLOCK) on [#LIDS_TR_M_1ES_90506739ME1__GEOGRAPHY].GEOGRAPHY_datakey = t.u_code
join [#LIDS_TR_M_1ES_90506739ME1__PRODUCT] with (NOLOCK) on [#LIDS_TR_M_1ES_90506739ME1__PRODUCT].PRODUCT_datakey = t.pfc
WHERE  
    LEFT(U_CODE,1)= '1' AND 
    Unittype = '01' AND  
    Groupcode <> '08' AND  
    LEFT(PFC,1)<> 'P' AND  
    LEFT(PFC,1)<> 'S'   
) a 
group by GEOGRAPHY_datakey,PRODUCT_datakey
----------------------------------------------------------------------------------------------------
IF OBJECT_ID('[BI_TEMP].[dbo].[LIDS_TR_M_1ES_90506739ME1_DATA]') IS NULL
begin 
    select 
	    'C00201806' as PERIOD_id, a.GEOGRAPHY_id, b.PRODUCT_id 
,sum( ( t.U+t.R+t.B+t.BR ) ) as u
,sum( ( t.U+t.R ) * #ndf.mnf_price/1.08 ) as tlhp

into [LIDS_TR_M_1ES_90506739ME1_DATA] 
    from
    (
	    select t.*,a.ID as GEOGRAPHY_pk, b.ID as PRODUCT_pk   
	    from #q0 as t with (NOLOCK) 
join [BI_TEMP].[dbo].[LIDS_TR_M_1ES_90506739ME1__GEOGRAPHY] as a with (NOLOCK) on a.GEOGRAPHY_datakey = t.GEOGRAPHY_datakey
join [BI_TEMP].[dbo].[LIDS_TR_M_1ES_90506739ME1__PRODUCT] as b with (NOLOCK) on b.PRODUCT_datakey = t.PRODUCT_datakey

    ) as t 
join [BI_TEMP].[dbo].[LIDS_TR_M_1ES_90506739ME1__GEOGRAPHY] as a with (NOLOCK) on a.ID = t.GEOGRAPHY_pk
join [BI_TEMP].[dbo].[LIDS_TR_M_1ES_90506739ME1__PRODUCT] as b with (NOLOCK) on b.ID = t.PRODUCT_pk

    join #ndf on #ndf.prd_cd = t.PRODUCT_datakey  
    group by a.GEOGRAPHY_id, b.PRODUCT_id 
end
else
begin
    insert into [LIDS_TR_M_1ES_90506739ME1_DATA]
    select 
	    'C00201806' as PERIOD_id, a.GEOGRAPHY_id, b.PRODUCT_id 
,sum( ( t.U+t.R+t.B+t.BR ) ) as u
,sum( ( t.U+t.R ) * #ndf.mnf_price/1.08 ) as tlhp

    from 
    (
	    select t.*,a.ID as GEOGRAPHY_pk, b.ID as PRODUCT_pk   
	    from #q0 as t with (NOLOCK) 
join [BI_TEMP].[dbo].[LIDS_TR_M_1ES_90506739ME1__GEOGRAPHY] as a with (NOLOCK) on a.GEOGRAPHY_datakey = t.GEOGRAPHY_datakey
join [BI_TEMP].[dbo].[LIDS_TR_M_1ES_90506739ME1__PRODUCT] as b with (NOLOCK) on b.PRODUCT_datakey = t.PRODUCT_datakey

    ) as t 
join [BI_TEMP].[dbo].[LIDS_TR_M_1ES_90506739ME1__GEOGRAPHY] as a with (NOLOCK) on a.ID = t.GEOGRAPHY_pk
join [BI_TEMP].[dbo].[LIDS_TR_M_1ES_90506739ME1__PRODUCT] as b with (NOLOCK) on b.ID = t.PRODUCT_pk

    join #ndf on #ndf.prd_cd = t.PRODUCT_datakey  
    group by a.GEOGRAPHY_id, b.PRODUCT_id 
end
----------------------------------------------------------------------------------------------------
