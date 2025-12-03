
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select test_id
from "takehome"."dev_staging"."stg_lab_results"
where test_id is null



  
  
      
    ) dbt_internal_test