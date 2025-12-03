
    
    

select
    visit_id as unique_field,
    count(*) as n_records

from "takehome"."dev_bronze"."int_visits__with_patient_details"
where visit_id is not null
group by visit_id
having count(*) > 1


