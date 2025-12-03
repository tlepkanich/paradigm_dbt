
    
    

select
    id as unique_field,
    count(*) as n_records

from "takehome"."dev_staging"."stg_patients"
where id is not null
group by id
having count(*) > 1


