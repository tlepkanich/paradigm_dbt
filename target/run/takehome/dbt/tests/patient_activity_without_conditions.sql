
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  -- Test for data completeness: patients with medication administrations but no conditions
-- Every patient who has been administered medication should have at least one condition recorded
-- This catches cases where medication data exists but the underlying condition is missing

with patients_with_meds as (

    select distinct
        patient_id
    from "takehome"."dev_staging"."stg_med_admins"

),

patients_with_conditions as (

    select distinct
        patient_id
    from "takehome"."dev_staging"."stg_patient_conditions"

)

select
    pwm.patient_id
from patients_with_meds pwm
left join patients_with_conditions pwc
    on pwm.patient_id = pwc.patient_id
where pwc.patient_id is null
  
  
      
    ) dbt_internal_test