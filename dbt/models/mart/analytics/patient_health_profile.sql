{{
    config(
        materialized='table'
    )
}}

/*
    Patient Health Profile

    Comprehensive patient health snapshot for risk stratification and care management.
    Combines demographics, lifestyle factors, condition/medication counts, visit frequency,
    and lab abnormalities into a health complexity score and risk category.
*/

with

patients as (

    select * from {{ ref('int_patients__enriched') }}

),

active_conditions as (

    select
        patient_id,
        count(*) as condition_count
    from {{ ref('stg_patient_conditions') }}
    where date_ended is null
    group by patient_id

),

active_medications as (

    select
        patient_id,
        count(*) as medication_count
    from {{ ref('int_patient_medications__active') }}
    where is_currently_active = true
    group by patient_id

),

recent_visits as (

    select
        pc.patient_id,
        count(*) as visit_count
    from {{ ref('stg_visits') }} v
    inner join {{ ref('stg_patient_conditions') }} pc
        on v.patient_condition_id = pc.patient_condition_id
    where v.visit_date >= current_date - interval '12 months'
    group by pc.patient_id

),

abnormal_labs as (

    select
        patient_id,
        count(*) as abnormal_count
    from {{ ref('fct_lab_results') }}
    where result_status in ('HIGH', 'LOW')
    group by patient_id

),

enriched as (

    select
        p.patient_id,
        p.first_name,
        p.last_name,
        p.age_years,
        p.gender,
        p.smoker as is_smoker,
        p.drinks_per_week as alcohol_use,
        coalesce(ac.condition_count, 0) as active_condition_count,
        coalesce(am.medication_count, 0) as active_medication_count,
        coalesce(rv.visit_count, 0) as visits_last_12mo,
        coalesce(al.abnormal_count, 0) as abnormal_lab_count,
        -- Health complexity score calculation
        (coalesce(ac.condition_count, 0) * 2.0) +
        coalesce(am.medication_count, 0) +
        (coalesce(al.abnormal_count, 0) / 5.0) +
        (coalesce(rv.visit_count, 0) / 10.0) as health_complexity_score

    from patients p

    left join active_conditions ac
        on p.patient_id = ac.patient_id

    left join active_medications am
        on p.patient_id = am.patient_id

    left join recent_visits rv
        on p.patient_id = rv.patient_id

    left join abnormal_labs al
        on p.patient_id = al.patient_id

),

final as (

    select
        *,
        case
            when health_complexity_score < 5 then 'LOW'
            when health_complexity_score < 10 then 'MEDIUM'
            else 'HIGH'
        end as risk_category

    from enriched

)

select * from final
