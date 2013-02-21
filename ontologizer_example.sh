#!/bin/bash
#
# Purpose of this scripts is to give an example of a successful ontologizer run
#
# Requirements - curl, java, R, graphviz
#
# see http://compbio.charite.de/contao/index.php/cmdlineOntologizer.html
# see http://compbio.charite.de/contao/index.php/datasetsOntologizer.html

mkdir bin
mkdir input
mkdir output

# generate data, assumes that R is installed 
# tested with R version 2.12.2 (2011-02-25)
# this should produce population file [populationGPL570.txt] and study file [studyGDS2821.txt]
Rscript --verbose generatePopulationAndStudyset.R
mv populationGPL570.txt studyGDS2821.txt input
# delete intermediate files
rm GDS2821.soft.gz GPL570.soft
 
# getting human gene association files (maps GO terms to human genes)
curl http://viewvc.geneontology.org/viewvc/GO-SVN/trunk/gene-associations/gene_association.goa_human.gz?pathrev=HEAD | gunzip -c > input/gene_association.goa_human

# getting GO (gene ontology)
curl http://www.geneontology.org/ontology/obo_format_1_2/gene_ontology_ext.obo > input/gene_ontology_ext.obo

curl http://compbio.charite.de/contao/index.php/cmdlineOntologizer.html?file=tl_files/ontologizer/cmdline/Ontologizer.jar > bin/ontologizer.jar

# running ontologizer with ontology, gene associations, population set and study sets.
java -Xmx2G -jar bin/ontologizer.jar --go input/gene_ontology_ext.obo --association input/gene_association.goa_human --population input/populationGPL570.txt --studyset input/studyGDS2821.txt --dot 0.05 --resamplingsteps 100 --mtc Westfall-Young-Single-Step 

mv view-* table-* output

# this should produce a view file [output/view-studyGDS2821-Parent-Child-Union-Westfall-Young-Single-Step.dot] table file [output/table-studyGDS2821-Parent-Child-Union-Westfall-Young-Single-Step.txt] with first three lines something like:
# ID      Pop.total       Pop.term        Study.total     Study.term      Pop.family      Study.family    nparents
#        is.trivial      p       p.adjusted      p.min
# GO:0000000      20639   15956   6040    4991    0       0       0       true    1.0     1.0     1.0
# GO:0070404      20639   2       6040    1       2525    862     2       false   0.5663168630650388      0.5663168630650

# dot file result can be used for visualization with graphviz
dot -Tpng output/view-studyGDS2821-Parent-Child-Union-Westfall-Young-Single-Step.dot -ooutput/view-studyGDS2821-Parent-Child-Union-Westfall-Young-Single-Step.png
