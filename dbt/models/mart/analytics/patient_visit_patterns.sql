{{
    config(
        materialized='table'
    )
}}

/*
    Patient Visit Patterns

    Analyzes patient engagement and care utilization patterns including
    visit frequency, engagement duration, conditions treated, and activity status.
    Helps identify at-risk patients and optimize capacity planning.
*/

with

patients as (

    select * from {{ ref('int_patients__enriched') }}

),

visits_with_conditions as (

    select * from {{ ref('int_visits__with_patient_details') }}

),

visit_aggregates as (

    select
        patient_id,
        count(*) as total_visits,
        min(visit_date) as first_visit_date,
        max(visit_date) as last_visit_date,
        (max(visit_date) - min(visit_date)) as engagement_days,
        count(distinct condition_id) as conditions_treated_count,
        string_agg(distinct condition_name, ', ' order by condition_name) as conditions_list

    from visits_with_conditions

    group by patient_id

),

enriched as (

    select
        p.patient_id,
        p.first_name,
        p.last_name,
        p.age_years,
        p.gender,
        va.total_visits,
        va.first_visit_date,
        va.last_visit_date,
        va.engagement_days,
        case
            when va.total_visits > 1
            then va.engagement_days::float / (va.total_visits - 1)::float
            else null
        end as avg_days_between_visits,
        va.conditions_treated_count,
        va.conditions_list,
        case
            when va.last_visit_date >= current_date - interval '90 days'
            then true
            else false
        end as is_currently_active

    from patients p

    inner join visit_aggregates va
        on p.patient_id = va.patient_id

),

final as (

    select
        *,
        case
            when total_visits = 0 then 'NONE'
            when total_visits::float / (engagement_days::float / 365.0) < 2 then 'INFREQUENT'
            when total_visits::float / (engagement_days::float / 365.0) < 6 then 'REGULAR'
            else 'FREQUENT'
        end as visit_frequency_category

    from enriched

)

select * from final
