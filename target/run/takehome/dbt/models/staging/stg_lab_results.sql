
  
  create view "takehome"."dev_staging"."stg_lab_results__dbt_tmp" as (
    with

source as (

    select * from "takehome"."raw"."lab_results_json"

),

unnested as (

    select
        "testId" as test_id,
        "orderId" as order_id,
        "patientId" as patient_id,
        "resultDate"::date as result_date,
        unnest("testResults") as test_result

    from source

),

flattened as (

    select
        test_id,
        order_id,
        patient_id,
        result_date,
        test_result.componentName as component_name,
        test_result.componentRefHi as component_ref_hi,
        test_result.componentRefLo as component_ref_lo,
        test_result.componentUnits as component_units,
        test_result.resultValue as result_value

    from unnested

)

select * from flattened
  );
