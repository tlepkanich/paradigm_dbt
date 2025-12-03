
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select total_visits
from "takehome"."dev_silver"."patients_per_month"
where total_visits is null



  
  
      
    ) dbt_internal_test