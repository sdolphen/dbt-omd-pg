with source as (

    select * from {{ ref('constructor_standings') }}

),

renamed as (

    select
        source."constructorStandingsId" as constructor_standings_id,
        source."raceId" as race_id,
        source."constructorId" as constructor_id,
        source.points,
        source.position,
        source."positionText" as position_text,
        source.wins

    from source

)

select * from renamed
