with source as (

    select * from {{ source('f1', 'drivers') }}

),

renamed as (

    select
        driverid as driver_id,
        driverref as driver_ref,
        number as driver_number,
        code as driver_code,
        forename,
        surname,
        dob as date_of_birth,
        nationality,
        url

    from source

)

select * from renamed
