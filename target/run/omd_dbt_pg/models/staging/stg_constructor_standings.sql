
  create view omd."dbt_dev".stg_constructor_standings__dbt_tmp
    
    
  as (
    with source as (

    select * from omd."dbt_dev".constructor_standings

),

renamed as (

    select
        source."constructorStandingsId" as constructor_standings_id,
        source."raceId" as race_id,
        source."constructorId" as constructor_id,
        source.points,
        source.position,
        source."positionText" as position_text,
        source.wins

    from source

)

select * from renamed
  );