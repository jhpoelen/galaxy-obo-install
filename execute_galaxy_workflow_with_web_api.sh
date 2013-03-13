API_KEY=f9fc30fe2bca93c4c6da49163ec33b3d
GALAXY_API_ENDPOINT=http://galaxy:7474/api/

curl -X POST -H Accept:application/json -H Content-Type:application/json -d '{ "history":"", "workflow_id":"0a248a1f62a0cc04", "ds_map":"" }' -v $GALAXY_API_ENDPOINT/workflows?key=$API_KEY


