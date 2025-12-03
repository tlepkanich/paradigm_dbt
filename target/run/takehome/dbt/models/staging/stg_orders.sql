
  
  create view "takehome"."dev_staging"."stg_orders__dbt_tmp" as (
    with

source as (

    select * from "takehome"."raw"."orders"

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
  );
