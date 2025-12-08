
  create view omd."dbt_dev".stg_constructors__dbt_tmp
    
    
  as (
    with source as (

    select * from omd."dbt_dev".constructors

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
  );