
  
    

  create  table omd."dbt_dev".int_race_results_enhanced__dbt_tmp
  
  
    as
  
  (
    

with results as (

    select * from omd."dbt_dev".stg_results

),

races as (

    select * from omd."dbt_dev".stg_races

),

drivers as (

    select * from omd."dbt_dev".stg_drivers

),

constructors as (

    select * from omd."dbt_dev".stg_constructors

),

circuits as (

    select * from omd."dbt_dev".stg_circuits

),

status as (

    select * from omd."dbt_dev".stg_status

),

enhanced as (

    select
        -- Result identifiers
        results.result_id,
        results.race_id,
        results.driver_id,
        results.constructor_id,
        
        -- Race context
        races.season_year,
        races.race_round,
        races.race_name,
        races.race_date,
        races.race_time,
        races.circuit_id,
        circuits.circuit_name,
        circuits.location as circuit_location,
        circuits.country as circuit_country,
        
        -- Driver details
        drivers.driver_ref,
        drivers.forename as driver_forename,
        drivers.surname as driver_surname,
        drivers.forename || ' ' || drivers.surname as driver_full_name,
        drivers.driver_code,
        drivers.driver_number as driver_permanent_number,
        drivers.nationality as driver_nationality,
        
        -- Constructor details
        constructors.constructor_ref,
        constructors.constructor_name,
        constructors.nationality as constructor_nationality,
        
        -- Race performance
        results.driver_number,
        results.grid_position,
        results.finish_position,
        results.position_text,
        results.position_order,
        results.points,
        results.laps,
        results.race_time as finish_time,
        results.race_time_milliseconds as finish_time_milliseconds,
        
        -- Lap performance
        results.fastest_lap,
        results.fastest_lap_rank,
        results.fastest_lap_time,
        results.fastest_lap_speed,
        
        -- Status
        results.status_id,
        status.status_description,
        
        -- Derived flags
        case when results.finish_position = '1' then true else false end as is_winner,
        case when results.finish_position in ('1', '2', '3') then true else false end as is_podium,
        case when results.finish_position is not null then true else false end as is_classified,
        case when results.fastest_lap_rank = '1' then true else false end as has_fastest_lap,
        case when results.grid_position = 1 then true else false end as started_from_pole,
        
        -- Position changes
        case 
            when results.finish_position is not null and results.grid_position is not null
            then results.grid_position - results.finish_position
            else null 
        end as positions_gained

    from results
    left join races on results.race_id = races.race_id
    left join drivers on results.driver_id = drivers.driver_id
    left join constructors on results.constructor_id = constructors.constructor_id
    left join circuits on races.circuit_id = circuits.circuit_id
    left join status on results.status_id = status.status_id

)

select * from enhanced
  );
  