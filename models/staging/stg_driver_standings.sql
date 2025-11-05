with source as (

    select * from {{ source('f1', 'driver_standings') }}

),

renamed as (

    select
        driverstandingsid as driver_standings_id,
        raceid as race_id,
        driverid as driver_id,
        points,
        position,
        positiontext as position_text,
        wins

    from source

)

select * from renamed
