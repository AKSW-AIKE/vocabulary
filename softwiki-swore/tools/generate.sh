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
echo "header('Location: index-en.html'); ?>" >> ../html/$ONTONAME/index.php


# Content Negoiation for rdf formats
echo "<?php header('HTTP/1.1 303 See Other');"  	> ../html/$ONTONAME/$ONTOVERSION/index.php
echo "\$accept = explode(',', \$_SERVER['HTTP_ACCEPT']);"	>> ../html/$ONTONAME/$ONTOVERSION/index.php
echo "if (in_array('text/turtle ', \$accept))  header('Location: ontology.ttl');" >> ../html/$ONTONAME/$ONTOVERSION/index.php
echo "else if (in_array('application/n-triples', \$accept)) header('Location: ontology.nt');" >> ../html/$ONTONAME/$ONTOVERSION/index.php
echo "elseif (in_array('application/ld+json', \$accept)) header('Location: ontology.json');" >> ../html/$ONTONAME/$ONTOVERSION/index.php
echo "elseif (in_array('application/rdf+xml', \$accept)) header('Location: ontology.xml');" >> ../html/$ONTONAME/$ONTOVERSION/index.php
echo "else header('Location: index-en.html');" >> ../html/$ONTONAME/$ONTOVERSION/index.php
echo "?>" >> ../html/$ONTONAME/$ONTOVERSION/index.php

