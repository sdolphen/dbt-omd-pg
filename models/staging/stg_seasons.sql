with source as (

    select * from {{ source('f1', 'seasons') }}

),

renamed as (

    select
        year as season_year,
        url

    from source

)

select * from renamed
