/*
    Patients by Age

    This model summarizes the count of patients by their age in years.
*/

with

patients as (

    select * from {{ ref('int_patients__enriched') }}

)

select
    age_years,
    count(distinct patient_id) as patient_count

from patients

group by age_years
order by age_years