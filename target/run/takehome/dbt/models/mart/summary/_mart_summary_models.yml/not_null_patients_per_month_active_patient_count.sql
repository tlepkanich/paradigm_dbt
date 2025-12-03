
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select active_patient_count
from "takehome"."dev_silver"."patients_per_month"
where active_patient_count is null



  
  
      
    ) dbt_internal_test