

with enhanced_sprint as (

    select * from omd."dbt_dev".int_sprint_results_enhanced

)

select
    -- Primary key
    result_id,
    
    -- Foreign keys
    race_id,
    driver_id,
    constructor_id,
    circuit_id,
    status_id,
    
    -- Race context
    season_year,
    race_round,
    race_date,
    
    -- Starting position
    grid_position,
    
    -- Finishing position
    finish_position,
    position_order,
    
    -- Position change
    positions_gained,
    
    -- Points and results
    points,
    is_winner,
    is_podium,
    
    -- Laps
    laps,
    
    -- Times
    finish_time,
    finish_time_milliseconds,
    
    -- Fastest lap
    fastest_lap,
    fastest_lap_time,
    
    -- Status
    status_description

from enhanced_sprint