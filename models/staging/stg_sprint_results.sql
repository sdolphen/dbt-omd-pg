with source as (

    select * from {{ ref('sprint_results') }}

),

renamed as (

    select
        source."resultId" as result_id,
        source."raceId" as race_id,
        source."driverId" as driver_id,
        source."constructorId" as constructor_id,
        number as driver_number,
        grid as grid_position,
        nullif(position, '\\N') as finish_position,
        source."positionText" as position_text,
        source."positionOrder" as position_order,
        points,
        laps,
        nullif(time, '\\N') as sprint_time,
        nullif(milliseconds, '\\N') as sprint_time_milliseconds,
        nullif(source."fastestLap", '\\N') as fastest_lap,
        nullif(source."fastestLapTime", '\\N') as fastest_lap_time,
        source."statusId" as status_id

    from source

)

select * from renamed
