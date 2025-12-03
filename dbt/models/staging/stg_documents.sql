with

source as (

    select * from {{ source('test_data', 'documents') }}

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
