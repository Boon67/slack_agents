container_name="slack_bot_agent"
container_registry="sfsenorthamerica-tboon-aws2.registry.snowflakecomputing.com/apps/config/containers"

snow sql -f db_repository_setup.sql #Setup the database repository 
snow spcs image-registry login #Login to the Snowflake SPCS image registry
#docker login $container_registry #Auth for container 
#TODO: Switch to auth with Keypair auth
docker login $container_registry 
docker build --rm --platform linux/amd64 -t $container_name .
docker tag $container_name $container_registry/$container_name:latest #Tag the container for pushing to the SF Container
#Push to SF container repository
docker push $container_registry/$container_name:latest
snow sql -f spcs_setup.sql #Setup the SPCS container and network rules
