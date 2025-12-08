with source as (

    select * from omd."dbt_dev".races

),

renamed as (

    select
        source."raceId" as race_id,
        year as season_year,
        round as race_round,
        source."circuitId" as circuit_id,
        name as race_name,
        date as race_date,
        nullif(time, '\\N') as race_time,
        url,
        nullif(fp1_date, '\\N') as fp1_date,
        nullif(fp1_time, '\\N') as fp1_time,
        nullif(fp2_date, '\\N') as fp2_date,
        nullif(fp2_time, '\\N') as fp2_time,
        nullif(fp3_date, '\\N') as fp3_date,
        nullif(fp3_time, '\\N') as fp3_time,
        nullif(quali_date, '\\N') as quali_date,
        nullif(quali_time, '\\N') as quali_time,
        nullif(sprint_date, '\\N') as sprint_date,
        nullif(sprint_time, '\\N') as sprint_time

    from source

)

select * from renamed