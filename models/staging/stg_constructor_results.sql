with source as (

    select * from {{ source('f1', 'constructor_results') }}

),

renamed as (

    select
        constructorresultsid as constructor_results_id,
        raceid as race_id,
        constructorid as constructor_id,
        points,
        nullif(status, '\\N') as status

    from source

)

select * from renamed
