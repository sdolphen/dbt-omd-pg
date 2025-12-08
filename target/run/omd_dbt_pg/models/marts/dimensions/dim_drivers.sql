
  
    

  create  table omd."dbt_dev".dim_drivers__dbt_tmp
  
  
    as
  
  (
    

with drivers as (

    select * from omd."dbt_dev".stg_drivers

),

driver_stats as (

    select
        driver_id,
        count(*) as total_races,
        sum(case when is_winner then 1 else 0 end) as total_wins,
        sum(case when is_podium then 1 else 0 end) as total_podiums,
        sum(points) as total_points,
        count(distinct season_year) as seasons_active,
        min(race_date) as first_race_date,
        max(race_date) as last_race_date
    from omd."dbt_dev".fct_race_results
    group by driver_id

)

select
    -- Primary key
    drivers.driver_id,
    
    -- Driver identification
    drivers.driver_ref,
    drivers.driver_number,
    drivers.driver_code,
    
    -- Driver name
    drivers.forename,
    drivers.surname,
    drivers.forename || ' ' || drivers.surname as full_name,
    
    -- Personal information
    drivers.date_of_birth,
    drivers.nationality,
    
    -- Career statistics
    coalesce(driver_stats.total_races, 0) as total_races,
    coalesce(driver_stats.total_wins, 0) as total_wins,
    coalesce(driver_stats.total_podiums, 0) as total_podiums,
    coalesce(driver_stats.total_points, 0) as total_points,
    coalesce(driver_stats.seasons_active, 0) as seasons_active,
    driver_stats.first_race_date,
    driver_stats.last_race_date,
    
    -- Reference
    drivers.url

from drivers
left join driver_stats on drivers.driver_id = driver_stats.driver_id
  );
  