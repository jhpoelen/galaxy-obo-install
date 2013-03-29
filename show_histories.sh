# show histories, copy history and share as link
. galaxy_api.rc

curl -X GET -H Accept:application/json -H Content-Type:application/json -v $GALAXY_API_ENDPOINT/histories?key=$API_KEY
