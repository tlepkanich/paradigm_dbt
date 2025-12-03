
  
  create view "takehome"."dev_staging"."stg_patient_conditions__dbt_tmp" as (
    with

source as (

    select * from "takehome"."raw"."patient_conditions"

),

renamed as (

    select
        id as patient_condition_id,
        patient_id,
        condition_id,
        date_started,
        date_ended

    from source

)

select * from renamed
  );
