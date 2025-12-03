-- Test that visits occur within the patient condition timeline
-- A visit should occur on or after the condition started
-- and before the condition ended (if ended)

with visits_with_conditions as (

    select
        v.visit_id,
        v.visit_date,
        pc.date_started as condition_started,
        pc.date_ended as condition_ended
    from {{ ref('stg_visits') }} v
    inner join {{ ref('stg_patient_conditions') }} pc
        on v.patient_condition_id = pc.patient_condition_id

)

select *
from visits_with_conditions
where
    visit_date < condition_started
    or (condition_ended is not null and visit_date > condition_ended)
