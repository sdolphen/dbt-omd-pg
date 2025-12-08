
  create view omd."dbt_dev".stg_status__dbt_tmp
    
    
  as (
    with source as (

    select * from omd."dbt_dev".status

),

renamed as (

    select
        source."statusId" as status_id,
        source."status" as status_description

    from source

)

select * from renamed
  );