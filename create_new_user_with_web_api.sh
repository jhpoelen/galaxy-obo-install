# this example was inspired by 
#	https://bitbucket.org/galaxy/galaxy-central/src/f1bd817063e0/scripts/api/workflow_execute.py?at=default
# and
#	http://wiki.galaxyproject.org/Learn/API#REST
#
# The API seems to be documented in python code which lives here:
#	https://bitbucket.org/galaxy/galaxy-dist/src/9fd7fe0c5712/lib/galaxy/webapps/galaxy/api?at=default
#
# For enable user creation through api, you have to:
# 	- configure use_remote_user = True in universe_wsgi.ini .
#	- have access to an admin user api key
# 	- note that enabling this, disabled login through the regular web admin 
#	
#	- for more info, see http://wiki.g2.bx.psu.edu/Admin/Config/Apache%20Proxy


API_KEY=f9fc30fe2bca93c4c6da49163ec33b3d
GALAXY_API_ENDPOINT=http://galaxy:7474/api/

curl -X POST -H Accept:application/json -H Content-Type:application/json -d '{ "remote_user_email":"test123@foo.bar" }' -v $GALAXY_API_ENDPOINT/users?key=$API_KEY

# yellow:galaxy-obo-install jorrit$ sh create_new_user_with_web_api.sh 
# * About to connect() to galaxy port 7474 (#0)
# * About to connect() to galaxy port 7474 (#0)
# *   Trying 54.245.186.37... connected
# * Connected to galaxy (54.245.186.37) port 7474 (#0)
# > POST /api//users?key=f9fc30fe2bca93c4c6da49163ec33b3d HTTP/1.1
# > User-Agent: curl/7.21.4 (universal-apple-darwin11.0) libcurl/7.21.4 OpenSSL/0.9.8r zlib/1.2.5
# > Host: galaxy:7474
# > Accept:application/json
# > Content-Type:application/json
# > Content-Length: 41
# > 
# * HTTP 1.0, assume close after body
# < HTTP/1.0 200 OK
# < Server: PasteWSGIServer/0.5 Python/2.7.3
# < Date: Mon, 25 Mar 2013 06:52:20 GMT
# < content-type: application/json
# < cache-control: max-age=0,no-cache,no-store
# < Connection: close
# < 
# {
#     "email": "test123@foo.bar", 
#     "id": "f597429621d6eb2b", 
#     "nice_total_disk_usage": "0 bytes", 
#     "total_disk_usage": 0.0, 
#     "username": "test123"
# * Closing connection #0

# getting a list of users

# yellow:galaxy-obo-install jorrit$ curl http://galaxy:7474/api/users?key=f9fc30fe2bca93c4c6da49163ec33b3d
# [
#     {
#         "email": "jhpoelen@xs4all.nl", 
#         "id": "f2db41e1fa331b3e", 
#         "quota_percent": null, 
#         "url": "/api/users/f2db41e1fa331b3e"
#     }, 
#     {
#         "email": "test123@foo.bar", 
#         "id": "f597429621d6eb2b", 
#         "quota_percent": null, 
#         "url": "/api/users/f597429621d6eb2b"
#     }
# ]

