with

source as (

    select * from {{ source('test_data', 'med_admins') }}

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
