with source as (

    select * from {{ ref('driver_standings') }}

),

renamed as (

    select
        source."driverStandingsId" as driver_standings_id,
        source."raceId" as race_id,
        source."driverId" as driver_id,
        points,
        position,
        source."positionText" as position_text,
        wins

    from source

)

select * from renamed
