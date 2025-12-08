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