
  
  create view "takehome"."dev_staging"."stg_conditions__dbt_tmp" as (
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
  );
