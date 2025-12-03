
  
    
    

    create  table
      "takehome"."dev_bronze"."int_lab_results__with_abnormal_flag__dbt_tmp"
  
    as (
      with

lab_results as (

    select * from "takehome"."dev_staging"."stg_lab_results"

),

enriched as (

    select
        *,
        case
            when result_value > component_ref_hi then 'HIGH'
            when result_value < component_ref_lo then 'LOW'
            else 'NORMAL'
        end as result_status

    from lab_results

)

select * from enriched
    );
  
  