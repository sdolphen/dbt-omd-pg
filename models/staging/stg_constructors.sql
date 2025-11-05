with source as (

    select * from {{ source('f1', 'constructors') }}

),

renamed as (

    select
        constructorid as constructor_id,
        constructorref as constructor_ref,
        name as constructor_name,
        nationality,
        url

    from source

)

select * from renamed
