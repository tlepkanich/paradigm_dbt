
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select patient_id
from "takehome"."dev_bronze"."int_visits__with_patient_details"
where patient_id is null



  
  
      
    ) dbt_internal_test