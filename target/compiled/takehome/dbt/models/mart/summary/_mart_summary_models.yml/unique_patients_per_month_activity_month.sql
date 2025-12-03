
    
    

select
    activity_month as unique_field,
    count(*) as n_records

from "takehome"."dev_silver"."patients_per_month"
where activity_month is not null
group by activity_month
having count(*) > 1


