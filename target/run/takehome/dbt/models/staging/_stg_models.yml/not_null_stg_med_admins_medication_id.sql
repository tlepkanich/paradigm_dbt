
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select medication_id
from "takehome"."dev_staging"."stg_med_admins"
where medication_id is null



  
  
      
    ) dbt_internal_test