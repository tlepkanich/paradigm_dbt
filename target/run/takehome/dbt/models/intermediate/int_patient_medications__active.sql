
  
    
    

    create  table
      "takehome"."dev_bronze"."int_patient_medications__active__dbt_tmp"
  
    as (
      

/*
    Active Patient Medications

    This intermediate model combines medication administration data with
    patient and medication reference data. It identifies which medications
    each patient is actively taking.
*/

with

med_admins as (

    select * from "takehome"."dev_staging"."stg_med_admins"

),

medications as (

    select * from "takehome"."dev_staging"."stg_medications"

),

patients as (

    select * from "takehome"."dev_staging"."stg_patients"

),

patient_conditions as (

    select * from "takehome"."dev_staging"."stg_patient_conditions"

),

joined as (

    select
        ma.patient_id,
        p.first_name,
        p.last_name,
        ma.patient_condition_id,
        pc.condition_id,
        ma.medication_id,
        m.medication_name,
        ma.dosage,
        ma.date_started,
        ma.date_stopped,
        case
            when ma.date_stopped is null then true
            else false
        end as is_currently_active

    from med_admins ma

    left join medications m
        on ma.medication_id = m.medication_id

    left join patients p
        on ma.patient_id = p.patient_id

    left join patient_conditions pc
        on ma.patient_condition_id = pc.patient_condition_id

)

select * from joined
    );
  
  