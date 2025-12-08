

with status as (

    select * from omd."dbt_dev".stg_status

),

status_usage as (

    select
        status_id,
        count(*) as times_used
    from omd."dbt_dev".fct_race_results
    group by status_id

)

select
    -- Primary key
    status.status_id,
    
    -- Status information
    status.status_description,
    
    -- Classification
    case
        when status.status_description in ('Finished', '+1 Lap', '+2 Laps', '+3 Laps', '+4 Laps', '+5 Laps') 
            then 'Classified'
        when status.status_description like 'Accident%' 
            then 'Accident'
        when status.status_description like 'Collision%' 
            then 'Collision'
        when status.status_description like '%mechanical%' or status.status_description like '%engine%' or status.status_description like '%gearbox%'
            then 'Mechanical'
        when status.status_description = 'Disqualified'
            then 'Disqualified'
        else 'Other DNF'
    end as status_category,
    
    -- Usage statistics
    coalesce(status_usage.times_used, 0) as times_used

from status
left join status_usage on status.status_id = status_usage.status_id