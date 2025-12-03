
    
    

select
    patient_condition_id as unique_field,
    count(*) as n_records

from "takehome"."dev_staging"."stg_patient_conditions"
where patient_condition_id is not null
group by patient_condition_id
having count(*) > 1


