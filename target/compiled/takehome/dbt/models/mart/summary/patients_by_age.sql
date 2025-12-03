/*
    Patients by Age

    This model summarizes the count of patients by their age in years.
*/

with

patients as (

    select * from "takehome"."dev_bronze"."int_patients__enriched"

)

select
    age_years,
    count(distinct patient_id) as patient_count

from patients

group by 1
order by 1