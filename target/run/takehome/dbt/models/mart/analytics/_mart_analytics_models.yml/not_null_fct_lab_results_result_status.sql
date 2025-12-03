
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select result_status
from "takehome"."dev_silver"."fct_lab_results"
where result_status is null



  
  
      
    ) dbt_internal_test