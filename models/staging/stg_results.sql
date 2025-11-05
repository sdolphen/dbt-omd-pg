with source as (

    select * from {{ source('f1', 'results') }}

),

renamed as (

    select
        resultid as result_id,
        raceid as race_id,
        driverid as driver_id,
        constructorid as constructor_id,
        number as driver_number,
        grid as grid_position,
        nullif(position, '\\N') as finish_position,
        positiontext as position_text,
        positionorder as position_order,
        points,
        laps,
        nullif(time, '\\N') as race_time,
        nullif(milliseconds, '\\N') as race_time_milliseconds,
        nullif(fastestlap, '\\N') as fastest_lap,
        nullif(rank, '\\N') as fastest_lap_rank,
        nullif(fastestlaptime, '\\N') as fastest_lap_time,
        nullif(fastestlapspeed, '\\N') as fastest_lap_speed,
        statusid as status_id

    from source

)

select * from renamed
