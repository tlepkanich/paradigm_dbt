
  
    
    

    create  table
      "takehome"."dev_silver"."medications_per_month__dbt_tmp"
  
    as (
      /*
    Medications per Month

    This model gives the total number of patients actively taking each medication by month.
    A patient is considered actively taking a medication if the month falls between
    the medication start date and stop date (or current date if not stopped).
*/

with

patient_medications as (

    select * from "takehome"."dev_bronze"."int_patient_medications__active"

),

-- Generate a series of months from first medication date to current date
date_bounds as (

    select
        date_trunc('month', min(date_started)) as min_month,
        date_trunc('month', current_date) as max_month

    from patient_medications

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
        pm.medication_id,
        pm.medication_name,
        pm.patient_id

    from date_spine ds
    cross join patient_medications pm

    where
        ds.activity_month >= date_trunc('month', pm.date_started)
        and (
            pm.date_stopped is null
            or ds.activity_month <= date_trunc('month', pm.date_stopped)
        )

),

final as (

    select
        activity_month,
        medication_name,
        count(distinct patient_id) as active_patient_count

    from active_medications

    group by 1, 2

)

select * from final
order by 1, 2
    );
  
  