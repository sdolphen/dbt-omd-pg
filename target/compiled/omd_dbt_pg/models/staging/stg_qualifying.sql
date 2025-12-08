with source as (

    select * from omd."dbt_dev".qualifying

),

renamed as (

    select
        source."qualifyId" as qualify_id,
        source."raceId" as race_id,
        source."driverId" as driver_id,
        source."constructorId" as constructor_id,
        number as driver_number,
        position,
        nullif(q1, '\\N') as q1_time,
        nullif(q2, '\\N') as q2_time,
        nullif(q3, '\\N') as q3_time

    from source

)

select * from renamed