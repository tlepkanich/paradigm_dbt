-- Test that condition end dates are after or equal to start dates
-- When a condition has an end date, it should be >= start date

select
    patient_condition_id,
    patient_id,
    condition_id,
    date_started,
    date_ended
from "takehome"."dev_staging"."stg_patient_conditions"
where
    date_ended is not null
    and date_ended < date_started