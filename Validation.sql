select * 
from pan_validation
where Pan_Numbers regexp upper('^[A-Z]{5}[0-9]{4}[A-Z]$');

with cte_cleaned_pan as 
	  (select distinct upper(trim(Pan_Numbers)) as Pan_Numbers
	   from pan_validation 
       where Pan_Numbers is not null
	   and trim(Pan_Numbers) <> ''),
     cte_valid_pans as 
      ( select *
        from cte_cleaned_pan
        where adjacent_characters(Pan_Numbers) = false
        and adjacent_characters(substring(Pan_Numbers,1,5)) = false
        and adjacent_characters(substring(Pan_Numbers,6,4)) = false
        and Pan_Numbers regexp upper('^[A-Z]{5}[0-9]{4}[A-Z]$')
	  )
select cln.Pan_Numbers
, case when vld.Pan_Numbers is not null
            then 'Valid PAN'
		else 'Invalid PAN'
	end as status
from cte_cleaned_pan cln
left join cte_valid_pans vld
on vld.Pan_Numbers = cln.Pan_Numbers;
      
