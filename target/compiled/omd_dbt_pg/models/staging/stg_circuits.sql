with source as (

    select * from omd."dbt_dev".circuits

),

renamed as (

    select
        source."circuitId" as circuit_id,
        source."circuitRef" as circuit_ref,
        source.name as circuit_name,
        source.location,
        source.country,
        source.lat as latitude,
        source.lng as longitude,
        source.alt as altitude,
        source.url

    from source

)

select * from renamed