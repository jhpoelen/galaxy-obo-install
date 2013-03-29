# idea is to trigger an execution of a workflow from admin account as another account
# see http://osdir.com/ml/galaxy-development-source-control/2012-02/msg00407.html
# Note: could not get this to work - workflows were executed, but not as the impersonated user.


. galaxy_api.rc

URL="$GALAXY_API_ENDPOINT/workflows?key=$API_KEY&run_as=1cd8e2f6b131e891"

curl -X POST -H Accept:application/json -H Content-Type:application/json -d '{ "history":"", "workflow_id":"0a248a1f62a0cc04", "ds_map":"" }' -v $URL

# this triggered an execution of a input-less workflow and produced result that looks like:
# {
#    "history": "0a248a1f62a0cc04", 
#
#    "outputs": [
#        "0a248a1f62a0cc04"
#    ]
# Closing connection #0	

