with

source as (

    select * from {{ source('test_data', 'orders') }}

),

renamed as (

    select
        id as order_id,
        patient_id,
        order_date,
        condition_id

    from source

)

select * from renamed
