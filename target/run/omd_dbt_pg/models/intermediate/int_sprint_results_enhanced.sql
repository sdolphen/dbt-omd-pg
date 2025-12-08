
  
    

  create  table omd."dbt_dev".int_sprint_results_enhanced__dbt_tmp
  
  
    as
  
  (
    

with sprint_results as (

    select * from omd."dbt_dev".stg_sprint_results

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
        -- Sprint identifiers
        sprint_results.result_id,
        sprint_results.race_id,
        sprint_results.driver_id,
        sprint_results.constructor_id,
        
        -- Race context
        races.season_year,
        races.race_round,
        races.race_name,
        races.race_date,
        races.circuit_id,
        circuits.circuit_name,
        circuits.location as circuit_location,
        circuits.country as circuit_country,
        
        -- Driver details
        drivers.driver_ref,
        drivers.forename || ' ' || drivers.surname as driver_full_name,
        drivers.driver_code,
        drivers.nationality as driver_nationality,
        
        -- Constructor details
        constructors.constructor_ref,
        constructors.constructor_name,
        constructors.nationality as constructor_nationality,
        
        -- Sprint performance
        sprint_results.driver_number,
        sprint_results.grid_position,
        sprint_results.finish_position,
        sprint_results.position_text,
        sprint_results.position_order,
        sprint_results.points,
        sprint_results.laps,
        sprint_results.sprint_time as finish_time,
        sprint_results.sprint_time_milliseconds as finish_time_milliseconds,
        sprint_results.fastest_lap,
        sprint_results.fastest_lap_time,
        
        -- Status
        sprint_results.status_id,
        status.status_description,
        
        -- Derived flags
        case when sprint_results.finish_position = '1' then true else false end as is_winner,
        case when sprint_results.finish_position in ('1', '2', '3') then true else false end as is_podium,
        
        -- Position changes
        case 
            when sprint_results.finish_position is not null 
                and sprint_results.finish_position not in ('N', '\N')
                and sprint_results.grid_position is not null
            then sprint_results.grid_position - cast(sprint_results.finish_position as int)
            else null  
        end as positions_gained

    from sprint_results
    left join races on sprint_results.race_id = races.race_id
    left join drivers on sprint_results.driver_id = drivers.driver_id
    left join constructors on sprint_results.constructor_id = constructors.constructor_id
    left join circuits on races.circuit_id = circuits.circuit_id
    left join status on sprint_results.status_id = status.status_id

)

select * from enhanced
  );
  