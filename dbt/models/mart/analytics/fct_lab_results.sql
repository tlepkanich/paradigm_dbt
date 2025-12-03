{{
    config(
        materialized='incremental',
        unique_key=['test_id', 'component_name'],
        on_schema_change='fail'
    )
}}

with

lab_results as (

    select * from {{ ref('int_lab_results__with_abnormal_flag') }}
    {% if is_incremental() %}
    where result_date >= (select max(result_date) from {{ this }})
    {% endif %}

),

patients as (

    select * from {{ ref('stg_patients') }}

),

orders as (

    select * from {{ ref('stg_orders') }}

),

final as (

    select
        lr.test_id,
        lr.order_id,
        lr.patient_id,
        p.first_name,
        p.last_name,
        p.date_of_birth,
        lr.result_date,
        o.order_date,
        lr.component_name,
        lr.result_value,
        lr.component_units,
        lr.component_ref_hi,
        lr.component_ref_lo,
        lr.result_status

    from lab_results lr
    inner join patients p
        on lr.patient_id = p.patient_id
    inner join orders o
        on lr.order_id = o.order_id

)

select * from final
