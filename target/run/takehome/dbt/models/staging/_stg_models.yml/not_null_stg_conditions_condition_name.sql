
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select condition_name
from "takehome"."dev_staging"."stg_conditions"
where condition_name is null



  
  
      
    ) dbt_internal_test