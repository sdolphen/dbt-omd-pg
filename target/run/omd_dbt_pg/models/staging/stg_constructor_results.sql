
  create view omd."dbt_dev".stg_constructor_results__dbt_tmp
    
    
  as (
    with source as (

    select * from omd."dbt_dev".constructor_results

),

renamed as (

    select
        source."constructorResultsId" as constructor_results_id,
        source."raceId" as race_id,
        source."constructorId" as constructor_id,
        source.points,
        nullif(status, '\\N') as status

    from source

)

select * from renamed
  );