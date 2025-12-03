
    
    

with child as (
    select condition_id as from_field
    from "takehome"."dev_staging"."stg_patient_conditions"
    where condition_id is not null
),

parent as (
    select condition_id as to_field
    from "takehome"."dev_staging"."stg_conditions"
)

select
    from_field

from child
left join parent
    on child.from_field = parent.to_field

where parent.to_field is null


