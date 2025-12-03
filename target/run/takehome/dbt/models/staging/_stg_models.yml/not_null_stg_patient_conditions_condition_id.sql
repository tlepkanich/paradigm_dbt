
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select condition_id
from "takehome"."dev_staging"."stg_patient_conditions"
where condition_id is null



  
  
      
    ) dbt_internal_test