
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select date_started
from "takehome"."dev_staging"."stg_med_admins"
where date_started is null



  
  
      
    ) dbt_internal_test