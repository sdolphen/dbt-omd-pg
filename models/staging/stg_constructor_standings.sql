with source as (

    select * from {{ source('f1', 'constructor_standings') }}

),

renamed as (

    select
        constructorstandingsid as constructor_standings_id,
        raceid as race_id,
        constructorid as constructor_id,
        points,
        position,
        positiontext as position_text,
        wins

    from source

)

select * from renamed
