
  
    

  create  table omd."dbt_dev".int_qualifying_enhanced__dbt_tmp
  
  
    as
  
  (
    

with qualifying as (

    select * from omd."dbt_dev".stg_qualifying

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

enhanced as (

    select
        -- Qualifying identifiers
        qualifying.qualify_id,
        qualifying.race_id,
        qualifying.driver_id,
        qualifying.constructor_id,
        
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
        
        -- Qualifying performance
        qualifying.driver_number,
        qualifying.position as qualifying_position,
        qualifying.q1_time,
        qualifying.q2_time,
        qualifying.q3_time,
        
        -- Derived flags
        case when qualifying.position = 1 then true else false end as is_pole_position,
        case when qualifying.q3_time is not null then true else false end as reached_q3,
        case when qualifying.q2_time is not null then true else false end as reached_q2

    from qualifying
    left join races on qualifying.race_id = races.race_id
    left join drivers on qualifying.driver_id = drivers.driver_id
    left join constructors on qualifying.constructor_id = constructors.constructor_id
    left join circuits on races.circuit_id = circuits.circuit_id

)

select * from enhanced
  );
  