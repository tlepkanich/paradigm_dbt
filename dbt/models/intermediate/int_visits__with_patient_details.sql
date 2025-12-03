{{
    config(
        materialized='incremental',
        unique_key='visit_id',
        on_schema_change='fail'
    )
}}

/*
    Visits with Patient Details

    This intermediate model enriches visit data with patient and condition information,
    creating a comprehensive view of patient visits for analysis.
*/

with

visits as (

    select * from {{ ref('stg_visits') }}
    {% if is_incremental() %}
    where visit_date >= (select max(visit_date) from {{ this }})
    {% endif %}

),

patient_conditions as (

    select * from {{ ref('stg_patient_conditions') }}

),

conditions as (

    select * from {{ ref('stg_conditions') }}

),

patients as (

    select * from {{ ref('int_patients__enriched') }}

),

joined as (

    select
        v.visit_id,
        v.visit_date,
        date_trunc('month', v.visit_date) as visit_month,
        date_trunc('year', v.visit_date) as visit_year,
        v.patient_condition_id,
        pc.patient_id,
        p.first_name,
        p.last_name,
        p.age_years,
        p.gender,
        p.race,
        p.ethnicity,
        p.is_active as patient_is_active,
        pc.condition_id,
        c.condition_name,
        pc.date_started as condition_started_at,
        pc.date_ended as condition_ended_at

    from visits v

    left join patient_conditions pc
        on v.patient_condition_id = pc.patient_condition_id

    left join conditions c
        on pc.condition_id = c.condition_id

    left join patients p
        on pc.patient_id = p.patient_id

)

select * from joined