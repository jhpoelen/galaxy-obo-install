#!/bin/bash
# steps to get galaxy-obo up and running on aws Ubuntu 12.04

APT_OPTS=-y

# prereqs
sudo apt-get update
sudo apt-get $APT_OPTS install mercurial git
sudo apt-get $APT_OPTS install openjdk-6-jre-headless
sudo apt-get $APT_OPTS install python-dev
sudo apt-get $APT_OPTS install swi-prolog
sudo apt-get $APT_OPTS install make

# monit - process monitoring 
sudo apt-get $APT_OPTS install monit

# termfinder needs g++ and other build tools
sudo apt-get $APT_OPTS install build-essential

# perl dbi / perl DBD::mysql 
sudo apt-get $APT_OPTS install libdbi-perl libdbd-mysql-perl

# GO:TermFinder needs dependencies GraphViz and GD graphics libraries 
sudo apt-get $APT_OPTS install libgraphviz-perl
sudo apt-get $APT_OPTS install libgd-gd2-perl

git clone git://github.com/cmungall/blipkit.git
# note that: check install by running blipkit/bin/blip produced: ERROR: source_sink `library(odbc)' does not exist
 
git clone http://github.com/cmungall/obo-scripts

# rather than using http://owltools.googlecode.com/files/, chris mentioned to lastest jenkins build instead:
curl http://build.berkeleybop.org/job/owltools/lastSuccessfulBuild/artifact/OWLTools/OWLTools-Runner/bin/owltools-runner-all.jar > owltools-runner-all.jar

hg clone https://bitbucket.org/galaxy/galaxy-dist

# custom dist goes away
hg clone https://bitbucket.org/cmungall/galaxy-obo

GALAXY_DIR=./galaxy-obo

# start galaxy-obo
sh $GALAXY_DIR/run.sh --reload

# OBO release manager needs java - assuming java 6 is ok
# curl http://owltools.googlecode.com/files/OBOReleaseManager_unix_0.4.0-20121220.sh > OBOReleaseManager_unix_0.4.0-20121220.sh

# install xserver
# export DEBIAN_FRONTEND=noninteractive
# sudo -E apt-get update
# sudo -E apt-get install -y ubuntu-desktop
# note that for some reason previous three lines have to be executed to run installer headless (e.g. -c ); this seems counter intuitive to have to install xserver to run something headless. 
# sh OBOReleaseManager_unix_0.4.0-20121220.sh -c



