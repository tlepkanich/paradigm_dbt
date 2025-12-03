
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select result_value
from "takehome"."dev_staging"."stg_lab_results"
where result_value is null



  
  
      
    ) dbt_internal_test