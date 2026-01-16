select * from pan_validation;

-- missing data

select * from pan_validation 
where Pan_Numbers is null;

-- duplicates

select Pan_Numbers, Count(1)
from pan_validation
group by Pan_numbers
having count(1) > 1;

-- trail and white spaces

select Pan_Numbers
from pan_validation
where Pan_Numbers <> trim(Pan_Numbers);

-- letter case

select Pan_Numbers
from pan_validation
where Pan_Numbers <> upper(Pan_Numbers);

-- cleaned data

select distinct upper(trim(Pan_Numbers)) as PanNum
from pan_validation 
where Pan_Numbers is not null
and trim(Pan_Numbers) <> '';
