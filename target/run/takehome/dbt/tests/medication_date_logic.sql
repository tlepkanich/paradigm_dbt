
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  -- Test that medication stop dates are after or equal to start dates
-- When a medication has a stop date, it should be >= start date

select
    patient_id,
    patient_condition_id,
    medication_id,
    date_started,
    date_stopped
from "takehome"."dev_staging"."stg_med_admins"
where
    date_stopped is not null
    and date_stopped < date_started
  
  
      
    ) dbt_internal_test