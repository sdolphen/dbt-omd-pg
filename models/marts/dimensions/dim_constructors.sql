{{
    config(
        materialized='table'
    )
}}

with constructors as (

    select * from {{ ref('stg_constructors') }}

),

constructor_stats as (

    select
        constructor_id,
        count(*) as total_race_entries,
        sum(case when is_winner then 1 else 0 end) as total_wins,
        sum(case when is_podium then 1 else 0 end) as total_podiums,
        sum(points) as total_points,
        count(distinct season_year) as seasons_active,
        min(race_date) as first_race_date,
        max(race_date) as last_race_date
    from {{ ref('fct_race_results') }}
    group by constructor_id

)

select
    -- Primary key
    constructors.constructor_id,
    
    -- Constructor identification
    constructors.constructor_ref,
    constructors.constructor_name,
    
    -- Constructor information
    constructors.nationality,
    
    -- Career statistics
    coalesce(constructor_stats.total_race_entries, 0) as total_race_entries,
    coalesce(constructor_stats.total_wins, 0) as total_wins,
    coalesce(constructor_stats.total_podiums, 0) as total_podiums,
    coalesce(constructor_stats.total_points, 0) as total_points,
    coalesce(constructor_stats.seasons_active, 0) as seasons_active,
    constructor_stats.first_race_date,
    constructor_stats.last_race_date,
    
    -- Reference
    constructors.url

from constructors
left join constructor_stats on constructors.constructor_id = constructor_stats.constructor_id
