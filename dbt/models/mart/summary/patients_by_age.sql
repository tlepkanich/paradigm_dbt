/*
    Patients by Age

    This model summarizes the count of patients by their age in years.
*/

with

patients as (

    select * from {{ ref('stg_patients') }}

),

patients_with_age as (

    select
        patient_id,
        datediff('year', date_of_birth, current_date) as age_years

    from patients

)

select
    age_years,
    count(distinct patient_id) as patient_count

from patients_with_age

group by age_years
order by age_years