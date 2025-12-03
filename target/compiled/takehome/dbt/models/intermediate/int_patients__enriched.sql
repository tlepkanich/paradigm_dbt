

with

patients as (

    select * from "takehome"."dev_staging"."stg_patients"

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
        datediff('year', date_of_birth, current_date) as age_years,
        case
            when date_of_death is not null then false
            when date_deactivated is not null then false
            else true
        end as is_active,
        updated_at

    from patients

)

select * from enriched

qualify 1 = row_number() over (
    partition by patient_id
    order by updated_at desc nulls last
)