

with enhanced_qualifying as (

    select * from omd."dbt_dev".int_qualifying_enhanced

)

select
    -- Primary key
    qualify_id,
    
    -- Foreign keys
    race_id,
    driver_id,
    constructor_id,
    circuit_id,
    
    -- Race context
    season_year,
    race_round,
    race_date,
    
    -- Qualifying performance
    qualifying_position,
    is_pole_position,
    
    -- Qualifying times
    q1_time,
    q2_time,
    q3_time,
    
    -- Session progression
    reached_q2,
    reached_q3

from enhanced_qualifying