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


