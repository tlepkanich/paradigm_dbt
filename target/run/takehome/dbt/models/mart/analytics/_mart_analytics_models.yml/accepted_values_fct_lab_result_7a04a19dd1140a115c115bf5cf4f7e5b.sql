
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    

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



  
  
      
    ) dbt_internal_test