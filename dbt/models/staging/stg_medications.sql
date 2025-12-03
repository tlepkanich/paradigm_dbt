with

source as (

    select * from {{ source('test_data', 'medications') }}

),

renamed as (

    select
        id as medication_id,
        name as medication_name

    from source

)

select * from renamed
