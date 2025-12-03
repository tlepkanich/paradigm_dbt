
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select component_name
from "takehome"."dev_silver"."fct_lab_results"
where component_name is null



  
  
      
    ) dbt_internal_test