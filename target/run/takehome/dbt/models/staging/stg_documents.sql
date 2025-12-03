
  
  create view "takehome"."dev_staging"."stg_documents__dbt_tmp" as (
    with

source as (

    select * from "takehome"."raw"."documents"

),

renamed as (

    select
        document_id,
        patient_id,
        visit_id,
        document_line,
        document_text

    from source

)

select * from renamed
  );
