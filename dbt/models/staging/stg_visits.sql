with

source as (

    select * from {{ source('test_data', 'visits') }}

),

renamed as (

    select
        id as visit_id,
        patient_condition_id,
        visit_date

    from source

)

select * from renamed
