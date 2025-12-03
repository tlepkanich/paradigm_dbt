
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select age_years
from "takehome"."dev_silver"."patients_by_age"
where age_years is null



  
  
      
    ) dbt_internal_test