with source as (

    select * from {{ ref('seasons') }}

),

renamed as (

    select
        year as season_year,
        url

    from source

)

select * from renamed
