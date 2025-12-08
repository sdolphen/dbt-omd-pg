with source as (

    select * from omd."dbt_dev".results

),

renamed as (

    select
        source."resultId" as result_id,
        source."raceId" as race_id,
        source."driverId" as driver_id,
        source."constructorId" as constructor_id,
        number as driver_number,
        grid as grid_position,
        case 
            when source."position" = 'N' 
                or source."position" = '\N' 
                or source."position" is null then 0
            else source."position"::int
        end as finish_position,
        source."positionText" as position_text,
        source."positionOrder" as position_order,
        points,
        laps,
        nullif(time, '-1') as race_time,
        nullif(milliseconds, '-1') as race_time_milliseconds,
        nullif(source."fastestLap", '-1') as fastest_lap,
        nullif(rank, '-1') as fastest_lap_rank,
        nullif(source."fastestLapTime", '-1') as fastest_lap_time,
        nullif(source."fastestLapSpeed", '-1') as fastest_lap_speed,
        source."statusId" as status_id

    from source

)

select * from renamed