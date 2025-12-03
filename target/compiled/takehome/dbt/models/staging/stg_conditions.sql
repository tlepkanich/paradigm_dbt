with

source as (

    select * from "takehome"."raw"."conditions"

),

renamed as (

    select
        id as condition_id,
        name as condition_name

    from source

)

select * from renamed