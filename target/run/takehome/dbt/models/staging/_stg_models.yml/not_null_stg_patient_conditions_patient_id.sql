
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select patient_id
from "takehome"."dev_staging"."stg_patient_conditions"
where patient_id is null



  
  
      
    ) dbt_internal_test