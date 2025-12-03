{{
    config(
        materialized='incremental',
        unique_key=['patient_id', 'medication_id', 'date_started'],
        on_schema_change='fail'
    )
}}

/*
    Active Patient Medications

    This intermediate model combines medication administration data with
    patient and medication reference data. It identifies which medications
    each patient is actively taking.
*/

with

med_admins as (

    select * from {{ ref('stg_med_admins') }}
    {% if is_incremental() %}
    where date_started >= (select max(date_started) from {{ this }})
    {% endif %}

),

medications as (

    select * from {{ ref('stg_medications') }}

),

patients as (

    select * from {{ ref('stg_patients') }}

),

patient_conditions as (

    select * from {{ ref('stg_patient_conditions') }}

),

joined as (

    select
        ma.patient_id,
        p.first_name,
        p.last_name,
        ma.patient_condition_id,
        pc.condition_id,
        ma.medication_id,
        m.medication_name,
        ma.dosage,
        ma.date_started,
        ma.date_stopped,
        {{ is_active('ma.date_stopped') }} as is_currently_active

    from med_admins ma

    left join medications m
        on ma.medication_id = m.medication_id

    left join patients p
        on ma.patient_id = p.patient_id

    left join patient_conditions pc
        on ma.patient_condition_id = pc.patient_condition_id

)

select * from joined