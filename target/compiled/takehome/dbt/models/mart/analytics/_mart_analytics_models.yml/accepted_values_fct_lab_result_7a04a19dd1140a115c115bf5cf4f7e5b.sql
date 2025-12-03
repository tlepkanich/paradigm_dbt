
    
    

with all_values as (

    select
        result_status as value_field,
        count(*) as n_records

    from "takehome"."dev_silver"."fct_lab_results"
    group by result_status

)

select *
from all_values
where value_field not in (
    'HIGH','LOW','NORMAL'
)


