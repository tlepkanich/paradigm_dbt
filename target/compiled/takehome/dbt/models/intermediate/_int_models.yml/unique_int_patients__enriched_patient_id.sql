
    
    

select
    patient_id as unique_field,
    count(*) as n_records

from "takehome"."dev_bronze"."int_patients__enriched"
where patient_id is not null
group by patient_id
having count(*) > 1


