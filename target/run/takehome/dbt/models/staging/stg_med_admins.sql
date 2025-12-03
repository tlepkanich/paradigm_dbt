
  
  create view "takehome"."dev_staging"."stg_med_admins__dbt_tmp" as (
    with

source as (

    select * from "takehome"."raw"."med_admins"

),

renamed as (

    select
        patient_id,
        patient_condition_id,
        medication_id,
        date_started,
        date_stopped,
        dosage

    from source

)

select * from renamed
  );
