galaxy-obo-install
==================

These are install (UNDER DEVELOPMENT) instructions for running Galaxy (Tool Shed)  with go/obo/owl tools.

##installing local instance of Galaxy

steps

0. create dir in which you'd like to install galaxy and its dependencies

1. run ```sh install.sh``` from this git repo  to install dependencies and do first run of galaxy. First run also create config files.

2. stop galaxy

3. edit galaxy configuration (e.g. GALAXY_DIR/universe_wsgi.ini) for network/ database settings

4. restart galaxy ```sh GALAXY_DIR/run.sh```

5. (TODO start galaxy as service + process monitoring like monit to ensure restart)

6. see below for instructions on how to install GO/Obo/Owl tool repositories from tool sheds

##installing local instance of Galaxy Tool Shed
Note: Tools Shed host Galaxy tools, just like an app store hosts apps. Tool dev work.

steps

0. create dir for toolshed

1. run install.sh in this dir (first run of galaxy bootstraps config files)

2. stop galaxy

3. edit galaxy tool shed config (e.g. community_wsgi.ini) for network / database settings

4. start toolshed using ```sh run_community.sh```

##installing a new tool into galaxy tool shed

Rather than using Galaxy Toolshed as a source repository, I'd recommend uploading tools into toolshed from separate bitbucket mercurial repositories. In toolshed > select repository > select upload files.  Then enter url like ```hgs://bitbucket.org/jhpoelen/obo/src``` to import the head/tip of the bitbucket repo. Cloning repos from toolshed led to problems like below. Not quite sure why this happens.

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
abort: authorization failed
```

##installing a tool into galaxy from galaxy tool shed

steps

1. config tool_config_file in universe_wsgi.ini
```
...
tool_config_file = tool_conf.xml,shed_tool_conf.xml
...
```
with shed_tool_conf.xml containing tool shed urls you'd like to include.

2. configure dependency dir for storing tool dependencies in universe_wsgi.ini. This is binaries of tools (e.g. obo-scripts) are installed.
```
...
tool_dependency_dir = ../galaxy_tool_deps
...
```

3. ensure that all tool sheds you'd like to use are in tool_sheds_conf.xml 

4. (re-)start galaxy 

5. ensuring that you have admin privileges, install using web path: admin > tool sheds > search and browse tool sheds > etc 

6. test valid installation of the tool by running 
```bash
galaxy-dist$ sh run_functional_tests.sh -installed
```
This starts a separate test instance of Galaxy and runs the tests of the (manually) installed tools from tool shed.

## Example 
In the official test tool shed at Penn State (http://testtoolshed.g2.bx.psu.edu), there's a tool called obotools. This contains a fetch-remote-ontology wrapper. This tools installs a dependency (obo-scripts) and as the tool is executed, the dependency is added to the path, so that the perl scripts can be executed ok. 

## Known issues 

### KeyError['tools'] on importing workflows from tool shed
At time of writing (Feb 19, 2013), galaxy-dist has a bug that prevents workflows from importing. This bug has been fixed by Dave.  Please follow instructions below to get access to bug fix.  I've (jorrit) have confirmed that bug has been fixed.
```
From http://dev.list.galaxyproject.org/KeyError-tools-on-importing-workflow-from-locally-installed-repository-tp4658548.html :
```
$ hg pull -b stable https://bitbucket.org/galaxy/galaxy-central/
$ hg update stable
```
