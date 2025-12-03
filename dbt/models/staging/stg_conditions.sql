with

source as (

    select * from {{ source('test_data', 'conditions') }}

),

renamed as (

    select
        id as condition_id,
        name as condition_name

    from source

)

select * from renamed
