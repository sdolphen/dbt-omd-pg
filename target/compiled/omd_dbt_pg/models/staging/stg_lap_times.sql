with source as (

    select * from omd."dbt_dev".lap_times

),

renamed as (

    select
        source."raceId" as race_id,
        source."driverId" as driver_id,
        lap,
        position,
        time as lap_time,
        milliseconds as lap_time_milliseconds

    from source

)

select * from renamed