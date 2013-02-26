#!/bin/bash
#
# Purpose of this scripts is to give an example of a successful ontologizer run
#
# Requirements - curl, java, svn, graphviz
#
# see http://compbio.charite.de/contao/index.php/cmdlineOntologizer.html
# see http://compbio.charite.de/contao/index.php/datasetsOntologizer.html

mkdir bin
mkdir output

# grab test data from obo-experimental repo
svn --force export svn://ext.geneontology.org/trunk/experimental/enrichment-genesets/test input 

# get ontologizer
curl http://compbio.charite.de/contao/index.php/cmdlineOntologizer.html?file=tl_files/ontologizer/cmdline/Ontologizer.jar > bin/ontologizer.jar

STUDY=test
# running ontologizer with ontology, gene associations, population set and study sets.
java -Xmx2G -jar bin/ontologizer.jar --go input/test.obo --association input/test.gaf --population input/test.gset --studyset input/test.gset --dot 0.5
mv view-* table-* output

METHOD=Parent-Child-Union-None

# this should produce a view file [output/view-$STUDY-$METHOD.dot] table file [output/table-$STUDY-$METHOD.txt] with first three lines something like:
# ID      Pop.total       Pop.term        Study.total     Study.term      Pop.family      Study.family    nparents
#        is.trivial      p       p.adjusted      p.min
# GO:0000000      20639   15956   6040    4991    0       0       0       true    1.0     1.0     1.0
# GO:0070404      20639   2       6040    1       2525    862     2       false   0.5663168630650388      0.5663168630650

# dot file result can be used for visualization with graphviz
dot -Tpng output/view-$STUDY-$METHOD.dot -ooutput/view-$STUDY-$METHOD.png
