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

hg clone https://bitbucket.org/galaxy/galaxy-dist
GALAXY_DIR=./galaxy-dist

cd $GALAXY_DIR
#apply patch for fixing http://dev.list.galaxyproject.org/KeyError-tools-on-importing-workflow-from-locally-installed-repository-td4658548.html
hg pull -b stable https://bitbucket.org/galaxy/galaxy-central/
hg update stable

# first start galaxy to create config files 
sh $GALAXY_DIR/run.sh --reload



