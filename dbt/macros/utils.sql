/*
    Utility Macros

    Reusable SQL patterns for common transformations across the project.
    These macros eliminate code duplication and ensure consistent logic.
*/

-- Generate boolean flag when end_date column is null (active/current status)
{% macro is_active(end_date_column) %}
    case
        when {{ end_date_column }} is null then true
        else false
    end
{% endmacro %}


-- Calculate age in years from date of birth
{% macro calculate_age_years(dob_column) %}
    datediff('year', {{ dob_column }}, current_date)
{% endmacro %}


-- Truncate date to month for time-series grouping
{% macro truncate_to_month(date_column) %}
    date_trunc('month', {{ date_column }})
{% endmacro %}


-- Truncate date to year for time-series grouping
{% macro truncate_to_year(date_column) %}
    date_trunc('year', {{ date_column }})
{% endmacro %}


-- Deduplicate rows using row_number() with QUALIFY clause
{% macro deduplicate_by_latest(partition_columns, order_column, nulls_handling='nulls last') %}
qualify 1 = row_number() over (
    partition by {{ partition_columns }}
    order by {{ order_column }} desc {{ nulls_handling }}
)
{% endmacro %}


-- Generate date spine for time-series analysis with monthly granularity
{% macro generate_month_spine(start_date_expr, end_date_expr) %}
select unnest(
    generate_series(
        {{ start_date_expr }},
        {{ end_date_expr }},
        interval '1 month'
    )
)::date as activity_month
{% endmacro %}
