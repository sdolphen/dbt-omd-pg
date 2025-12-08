

with lap_times as (

    select * from omd."dbt_dev".stg_lap_times

),

races as (

    select 
        race_id,
        season_year,
        race_round,
        race_date,
        circuit_id
    from omd."dbt_dev".stg_races

)

select
    -- Composite key components
    lap_times.race_id,
    lap_times.driver_id,
    lap_times.lap,
    
    -- Race context from races
    races.season_year,
    races.race_round,
    races.race_date,
    races.circuit_id,
    
    -- Lap performance
    lap_times.position as position_after_lap,
    lap_times.lap_time,
    lap_times.lap_time_milliseconds

from lap_times
left join races on lap_times.race_id = races.race_id