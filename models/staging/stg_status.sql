with source as (

    select * from {{ ref('status') }}

),

renamed as (

    select
        source."statusId" as status_id,
        source."status" as status_description

    from source

)

select * from renamed
