with source as (

    select * from {{ ref('drivers') }}

),

renamed as (

    select
        source."driverId" as driver_id,
        source."driverRef" as driver_ref,
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
