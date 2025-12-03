
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select visit_date
from "takehome"."dev_staging"."stg_visits"
where visit_date is null



  
  
      
    ) dbt_internal_test