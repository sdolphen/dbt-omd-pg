with source as (

    select * from {{ ref('constructors') }}

),

renamed as (

    select
        source."constructorId" as constructor_id,
        source."constructorRef" as constructor_ref,
        name as constructor_name,
        nationality,
        url

    from source

)

select * from renamed
