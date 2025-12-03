
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select visit_date
from "takehome"."dev_bronze"."int_visits__with_patient_details"
where visit_date is null



  
  
      
    ) dbt_internal_test