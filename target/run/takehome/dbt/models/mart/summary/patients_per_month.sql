
  
    
    

    create  table
      "takehome"."dev_silver"."patients_per_month__dbt_tmp"
  
    as (
      /*
    Patients Per Month

    This model gives the total number of active patients by month.
    A patient is considered active in a month if they had a visit during that month.
*/

with

visits as (

    select * from "takehome"."dev_bronze"."int_visits__with_patient_details"

),

final as (

    select
        visit_month as activity_month,
        count(distinct patient_id) as active_patient_count,
        count(distinct visit_id) as total_visits,
        count(distinct condition_id) as unique_conditions_treated

    from visits

    group by 1

)

select * from final
order by 1
    );
  
  