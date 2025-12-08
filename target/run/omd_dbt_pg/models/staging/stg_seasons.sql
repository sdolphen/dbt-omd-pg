
  create view omd."dbt_dev".stg_seasons__dbt_tmp
    
    
  as (
    with source as (

    select * from omd."dbt_dev".seasons

),

renamed as (

    select
        year as season_year,
        url

    from source

)

select * from renamed
  );