
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select medication_name
from "takehome"."dev_staging"."stg_medications"
where medication_name is null



  
  
      
    ) dbt_internal_test