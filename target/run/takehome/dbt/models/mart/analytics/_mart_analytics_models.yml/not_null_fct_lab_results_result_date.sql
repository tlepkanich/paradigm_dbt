
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select result_date
from "takehome"."dev_silver"."fct_lab_results"
where result_date is null



  
  
      
    ) dbt_internal_test