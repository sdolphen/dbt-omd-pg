
  
    

  create  table omd."dbt_dev".dim_circuits__dbt_tmp
  
  
    as
  
  (
    

with circuits as (

    select * from omd."dbt_dev".stg_circuits

),

circuit_stats as (

    select
        circuit_id,
        count(distinct race_id) as total_races_held,
        count(distinct season_year) as seasons_active,
        min(race_date) as first_race_date,
        max(race_date) as last_race_date
    from omd."dbt_dev".fct_race_results
    group by circuit_id

)

select
    -- Primary key
    circuits.circuit_id,
    
    -- Circuit identification
    circuits.circuit_ref,
    circuits.circuit_name,
    
    -- Location information
    circuits.location,
    circuits.country,
    circuits.latitude,
    circuits.longitude,
    circuits.altitude,
    
    -- Usage statistics
    coalesce(circuit_stats.total_races_held, 0) as total_races_held,
    coalesce(circuit_stats.seasons_active, 0) as seasons_active,
    circuit_stats.first_race_date,
    circuit_stats.last_race_date,
    
    -- Reference
    circuits.url

from circuits
left join circuit_stats on circuits.circuit_id = circuit_stats.circuit_id
  );
  