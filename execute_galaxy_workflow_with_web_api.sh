# this example was inspired by 
#	https://bitbucket.org/galaxy/galaxy-central/src/f1bd817063e0/scripts/api/workflow_execute.py?at=default
# and
#	http://wiki.galaxyproject.org/Learn/API#REST
#
# The API seems to be documented in python code which lives here:
#	https://bitbucket.org/galaxy/galaxy-dist/src/9fd7fe0c5712/lib/galaxy/webapps/galaxy/api?at=default
. galaxy_api.rc

curl -X POST -H Accept:application/json -H Content-Type:application/json -d '{ "history":"", "workflow_id":"0a248a1f62a0cc04", "ds_map":"" }' -v $GALAXY_API_ENDPOINT/workflows?key=$API_KEY

# this triggered an execution of a input-less workflow and produced result that looks like:
# {
#    "history": "0a248a1f62a0cc04", 
#
#    "outputs": [
#        "0a248a1f62a0cc04"
#    ]
# Closing connection #0	

