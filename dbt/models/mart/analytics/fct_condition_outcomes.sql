{{
    config(
        materialized='table'
    )
}}

/*
    Condition Outcomes

    Tracks condition lifecycle metrics including duration, resolution rates,
    visit frequency, medication usage, and common co-conditions.
    Provides benchmarks for treatment effectiveness and resource planning.
*/

with

patient_conditions as (

    select * from {{ ref('stg_patient_conditions') }}

),

conditions as (

    select * from {{ ref('stg_conditions') }}

),

visits as (

    select * from {{ ref('stg_visits') }}

),

medications as (

    select * from {{ ref('int_patient_medications__active') }}

),

condition_episodes as (

    select
        pc.patient_condition_id,
        pc.patient_id,
        pc.condition_id,
        pc.date_started,
        pc.date_ended,
        case
            when pc.date_ended is not null
            then (pc.date_ended - pc.date_started)
            else null
        end as duration_days

    from patient_conditions pc

),

visit_counts as (

    select
        patient_condition_id,
        count(*) as visit_count
    from visits
    group by patient_condition_id

),

medication_counts as (

    select
        patient_condition_id,
        count(distinct medication_id) as medication_count
    from medications
    where patient_condition_id is not null
    group by patient_condition_id

),

co_conditions as (

    select
        pc1.condition_id,
        pc2.condition_id as co_condition_id,
        count(*) as co_occurrence_count
    from patient_conditions pc1
    inner join patient_conditions pc2
        on pc1.patient_id = pc2.patient_id
        and pc1.condition_id < pc2.condition_id
    group by pc1.condition_id, pc2.condition_id

),

top_co_conditions as (

    select
        condition_id,
        string_agg(
            cast(co_condition_id as varchar),
            ', '
            order by co_occurrence_count desc
        ) as common_co_condition_ids
    from (
        select
            condition_id,
            co_condition_id,
            co_occurrence_count,
            row_number() over (partition by condition_id order by co_occurrence_count desc) as rn
        from co_conditions
    )
    where rn <= 3
    group by condition_id

),

condition_metrics as (

    select
        ce.condition_id,
        count(distinct ce.patient_id) as total_patients,
        avg(ce.duration_days) as avg_duration_days,
        (sum(case when ce.date_ended is not null then 1 else 0 end)::float /
         count(*)::float * 100) as resolution_rate_pct,
        avg(vc.visit_count) as avg_visits_per_episode,
        avg(mc.medication_count) as avg_medications_per_patient

    from condition_episodes ce

    left join visit_counts vc
        on ce.patient_condition_id = vc.patient_condition_id

    left join medication_counts mc
        on ce.patient_condition_id = mc.patient_condition_id

    group by ce.condition_id

),

final as (

    select
        c.condition_id,
        c.condition_name,
        cm.total_patients,
        cm.avg_duration_days,
        cm.resolution_rate_pct,
        cm.avg_visits_per_episode,
        cm.avg_medications_per_patient,
        tcc.common_co_condition_ids

    from conditions c

    left join condition_metrics cm
        on c.condition_id = cm.condition_id

    left join top_co_conditions tcc
        on c.condition_id = tcc.condition_id

    where cm.total_patients is not null

)

select * from final
