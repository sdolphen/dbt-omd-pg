
  create view omd."dbt_dev".stg_driver_standings__dbt_tmp
    
    
  as (
    with source as (

    select * from omd."dbt_dev".driver_standings

),

renamed as (

    select
        source."driverStandingsId" as driver_standings_id,
        source."raceId" as race_id,
        source."driverId" as driver_id,
        points,
        position,
        source."positionText" as position_text,
        wins

    from source

)

select * from renamed
  );