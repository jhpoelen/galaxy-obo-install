galaxy-obo-install
==================

These are install (UNDER DEVELOPMENT) instructions for running Galaxy (Tool Shed)  with go/obo/owl tools.

Local instance of Galaxy

Steps

0. create dir in which you'd like to install galaxy and its dependencies

1. run install.sh  to install dependencies and do first run of galaxy. First run also create config files.

2. stop galaxy

3. edit galaxy configuration (e.g. GALAXY_DIR/universe_wsgi.ini) for network/ database settings

4. restart galaxy (sh GALAXY_DIR/run.sh)

5. (TODO start galaxy as service + process monitoring like monit to ensure restart)

6. (TODO install GO/Obo/Owl tool repositories from tool repositories)

Local instance of Galaxy Tool Shed
Note: Tools Shed host Galaxy tools, just like an app store hosts apps. Tool dev work.

Steps

0. create dir for toolshed

1. run install.sh in this dir (first run of galaxy bootstraps config files)

2. stop galaxy

3. edit galaxy tool shed config (e.g. community_wsgi.ini) for network / database settings

4. start toolshed using (sh run_community.sh)

Installing a new tool.

Rather than using Galaxy Toolshed as a source repository, I'd recommend uploading tools into toolshed from separate bitbucket mercurial repositories. In toolshed > select repository > select upload files.  Then enter url inf like hgs://bitbucket.org/jhpoelen/obo/src to import the head/tip of the bitbucket repo. Cloning repos from toolshed led to problems like:

```bash
ubuntu@ip-10-254-13-230:~/tmp/obotest$ vi README 
ubuntu@ip-10-254-13-230:~/tmp/obotest$ hg commit -m 'bla' -u jorrit
ubuntu@ip-10-254-13-230:~/tmp/obotest$ hg push
pushing to http://jorrit@testtoolshed.g2.bx.psu.edu/repos/jorrit/obotest
searching for changes
http authorization required
realm: 
user: jorrit
password: 
```


