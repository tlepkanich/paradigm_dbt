with

source as (

    select * from "takehome"."raw"."medications"

),

renamed as (

    select
        id as medication_id,
        name as medication_name

    from source

)

select * from renamed