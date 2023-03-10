--------------------------------------------------------------------------
-- GL Fixed Asset Data Transactions
-- Written by: Teo Espero, IT Administrator
-- Date written: 03/10/2023
-- Description:
--		This code was mainly written to generate data needed for evaluating
--		fixed asset data
-- 
-- Code Revision History:
-- 
-- 	base code (03/10)
--
--------------------------------------------------------------------------


select 
	distinct
	replicate('0', 2 - len(h.acct_1)) + cast (h.acct_1 as varchar)+ '-'+replicate('0', 2 - len(h.acct_2)) + cast (h.acct_2 as varchar) + '-'+replicate('0', 3 - len(h.acct_3)) + cast (h.acct_3 as varchar) + '-'+replicate('0', 3 - len(h.acct_4)) + cast (h.acct_4 as varchar)as AccountNumber,
	aph.check_date,
	je.[system] as Module,
	h.journal_entry,
	aph.vendor_no,
	v.last_name,
	aph.[description],
	aph.chk_fisc_year,
	aph.chk_fisc_prd,
	aph.batch_year,
	aph.check_batch_no,
	aph.check_batch_month,
	aph.check_batch_year,
	aph.check_number,
	h.dr_amount,
	h.cr_amount
from gl_history h
inner join
	gl_journal_entry je
	on je.fiscal_period=h.fiscal_period
	and je.fiscal_year=h.fiscal_year
	and je.journal_entry=h.journal_entry
inner join
	ap_history aph
	on aph.exp_fisc_year=h.fiscal_year
	and aph.exp_fisc_prd=h.fiscal_period
	and je.journal_entry=aph.exp_journal_entry
	and aph.acct_1=h.acct_1 
	and aph.acct_2=h.acct_2
	and aph.acct_3=h.acct_3
	and aph.acct_4=h.acct_4
inner join
	ap_vendor v
	on v.vendor_no=aph.vendor_no
where
	replicate('0', 2 - len(h.acct_1)) + cast (h.acct_1 as varchar)+ '-'+replicate('0', 2 - len(h.acct_2)) + cast (h.acct_2 as varchar) + '-'+replicate('0', 3 - len(h.acct_3)) + cast (h.acct_3 as varchar) + '-'+replicate('0', 3 - len(h.acct_4)) + cast (h.acct_4 as varchar) in (
	
	)
	and (h.cr_amount != 0 or h.dr_amount != 0)
	and h.dr_amount != 0
	and je.system='AP'
order by
	replicate('0', 2 - len(h.acct_1)) + cast (h.acct_1 as varchar)+ '-'+replicate('0', 2 - len(h.acct_2)) + cast (h.acct_2 as varchar) + '-'+replicate('0', 3 - len(h.acct_3)) + cast (h.acct_3 as varchar) + '-'+replicate('0', 3 - len(h.acct_4)) + cast (h.acct_4 as varchar),
	aph.check_date,
	aph.check_number,
	aph.chk_fisc_year,
	aph.chk_fisc_prd
