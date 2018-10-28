#!/bin/bash

ONTONAME="req"

ONTOVERSION="2"

echo "Generating Documentation for $ONTONAME/$ONTOVERSION"

mkdir ../html/$ONTONAME/$ONTOVERSION
rm -R ../html/$ONTONAME/$ONTOVERSION/*

#generate documentation 
java -jar widoco-1.4.6-jar-with-dependencies.jar -ontFile ../model/$ONTONAME-$ONTOVERSION/ontology.ttl -lang en-de -webVowl -rewriteAll -includeAnnotationProperties -outFolder ../html/$ONTONAME/$ONTOVERSION/

#generate ontology to visualizey
java -jar OWL2VOWL-0.3.5-shaded.jar -file ../model/$ONTONAME-$ONTOVERSION/ontology.ttl -output ../html/$ONTONAME/$ONTOVERSION/webvowl/data/ontology.json


#warte 5 Sekunden
echo "Documentation generated. Wait now 5s to copy additional files."  
sleep 5

#start post processing

# Content Negoiation /$ONTONAME
echo "<?php header('HTTP/1.1 303 See Other');"  	> ../html/$ONTONAME/index.php
echo "header('Location: $ONTOVERSION/index-en.html'); ?>" >> ../html/$ONTONAME/index.php


# Content Negoiation for rdf formats
echo "<?php header('HTTP/1.1 303 See Other');"  	> ../html/$ONTONAME/$ONTOVERSION/index.php
echo "\$accept = explode(',', \$_SERVER['HTTP_ACCEPT']);"	>> ../html/$ONTONAME/$ONTOVERSION/index.php
echo "if (in_array('text/turtle ', \$accept))  header('Location: ontology.ttl');" >> ../html/$ONTONAME/$ONTOVERSION/index.php
echo "else if (in_array('application/n-triples', \$accept)) header('Location: ontology.nt');" >> ../html/$ONTONAME/$ONTOVERSION/index.php
echo "elseif (in_array('application/ld+json', \$accept)) header('Location: ontology.json');" >> ../html/$ONTONAME/$ONTOVERSION/index.php
echo "elseif (in_array('application/rdf+xml', \$accept)) header('Location: ontology.xml');" >> ../html/$ONTONAME/$ONTOVERSION/index.php
echo "else header('Location: index-en.html');" >> ../html/$ONTONAME/$ONTOVERSION/index.php
echo "?>" >> ../html/$ONTONAME/$ONTOVERSION/index.php

# Adjust more content in index-de.html

INDEX="../html/$ONTONAME/$ONTOVERSION/index-en.html"
cp $INDEX output.html

sed 's$version\ 2$<br/>version\ 2$' output.html > output1.html
mv output1.html output.html
sed 's$version\ 1$<br/>version\ 1$' output.html > output1.html
mv output1.html output.html
sed 's$version\ 0$<br/>version\ 0$' output.html > output1.html
mv output1.html output.html
sed 's$insertlicenseURIhere.org$creativecommons.org\/licenses\/by\/3.0$' output.html > output1.html
mv output1.html output.html
sed 's$license%20name%20goes%20here$CC%20BY%203.0$' output.html > output1.html
mv output1.html output.html
sed 's$license%20name%20goes%20here$CC%20BY%203.0$' output.html > output1.html
mv output1.html output.html
sed 's$http://insertlicenseURIhere.org$CC%20BY%203.0$' output.html > output1.html
mv output1.html output.html

mv output.html $INDEX 

# Copy aditional content

cp ../model/$ONTONAME-$ONTOVERSION/references.html ../html/$ONTONAME/$ONTOVERSION/sections/references-en.html
cp ../model/$ONTONAME-$ONTOVERSION/references.html ../html/$ONTONAME/$ONTOVERSION/sections/references-de.html

cp ../model/$ONTONAME-$ONTOVERSION/abstract-en.html ../html/$ONTONAME/$ONTOVERSION/sections/abstract-e.nhtml
cp ../model/$ONTONAME-$ONTOVERSION/abstract-de.html ../html/$ONTONAME/$ONTOVERSION/sections/abstract-de.html




