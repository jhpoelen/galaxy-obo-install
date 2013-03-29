# show histories, copy history and share as link
. galaxy_api.rc

curl -X GET -H Accept:application/json -H Content-Type:application/json -v $GALAXY_API_ENDPOINT/histories/1e8ab44153008be8?key=$API_KEY
