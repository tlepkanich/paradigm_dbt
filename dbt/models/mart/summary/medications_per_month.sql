/*
    Medications per Month

    This model gives the total number of patients actively taking each medication by month.
    A patient is considered actively taking a medication if the month falls between
    the medication start date and stop date (or current date if not stopped).
*/

with

med_admins as (

    select * from {{ ref('stg_med_admins') }}

),

medications as (

    select * from {{ ref('stg_medications') }}

),

-- Generate a series of months from first medication date to current date
date_bounds as (

    select
        date_trunc('month', min(date_started)) as min_month,
        date_trunc('month', current_date) as max_month

    from med_admins

),

date_spine as (

    select unnest(
        generate_series(
            min_month,
            max_month,
            interval '1 month'
        )
    )::date as activity_month

    from date_bounds

),

-- Expand medication administrations to show active medications per month
active_medications as (

    select
        ds.activity_month,
        ma.medication_id,
        ma.patient_id

    from date_spine ds
    cross join med_admins ma

    where
        ds.activity_month >= date_trunc('month', ma.date_started)
        and (
            ma.date_stopped is null
            or ds.activity_month <= date_trunc('month', ma.date_stopped)
        )

),

final as (

    select
        am.activity_month,
        m.medication_name,
        count(distinct am.patient_id) as active_patient_count

    from active_medications am
    left join medications m
        on am.medication_id = m.medication_id

    group by 1, 2

)

select * from final
order by activity_month, medication_name