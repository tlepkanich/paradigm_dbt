with

source as (

    select * from {{ source('test_data', 'patients') }}

),

renamed as (

    select
        *,
        null as updated_at,
        id as patient_id

    from source

)

select * from renamed