{{
    config(
        materialized='table'
    )
}}

with seasons as (

    select * from {{ ref('stg_seasons') }}

),

season_stats as (

    select
        season_year,
        count(distinct race_id) as total_races,
        count(distinct circuit_id) as unique_circuits,
        count(distinct driver_id) as unique_drivers,
        count(distinct constructor_id) as unique_constructors
    from {{ ref('fct_race_results') }}
    group by season_year

)

select
    -- Primary key
    seasons.season_year,
    
    -- Season statistics
    coalesce(season_stats.total_races, 0) as total_races,
    coalesce(season_stats.unique_circuits, 0) as unique_circuits,
    coalesce(season_stats.unique_drivers, 0) as unique_drivers,
    coalesce(season_stats.unique_constructors, 0) as unique_constructors,
    
    -- Reference
    seasons.url

from seasons
left join season_stats on seasons.season_year = season_stats.season_year
