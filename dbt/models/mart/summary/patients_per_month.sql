/*
    Patients Per Month

    This model gives the total number of active patients by month.
    A patient is considered active in a month if they had a visit during that month.
*/

with

visits as (

    select * from {{ ref('stg_visits') }}

),

patients_by_month as (

    select
        date_trunc('month', visit_date) as activity_month,
        patient_condition_id,
        count(distinct visit_id) as visit_count

    from visits

    group by 1, 2

),

patient_conditions as (

    select * from {{ ref('stg_patient_conditions') }}

),

final as (

    select
        pbm.activity_month,
        count(distinct pc.patient_id) as active_patient_count,
        sum(pbm.visit_count) as total_visits

    from patients_by_month pbm
    left join patient_conditions pc
        on pbm.patient_condition_id = pc.patient_condition_id

    group by 1

)

select * from final
order by activity_month
