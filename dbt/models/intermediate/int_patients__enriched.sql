{{
    config(
        materialized='table'
    )
}}

with

patients as (

    select * from {{ ref('stg_patients') }}

),

enriched as (

    select
        patient_id,
        id,
        first_name,
        last_name,
        ssn,
        date_of_birth,
        gender,
        race,
        ethnicity,
        smoker,
        drinks_per_week,
        date_of_death,
        date_activated,
        date_deactivated,
        {{ calculate_age_years('date_of_birth') }} as age_years,
        case
            when date_of_death is not null then false
            when date_deactivated is not null then false
            else true
        end as is_active,
        updated_at

    from patients

)

select * from enriched

{{ deduplicate_by_latest('patient_id', 'updated_at') }}