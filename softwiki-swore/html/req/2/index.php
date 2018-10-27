<?php header('HTTP/1.1 303 See Other');
$accept = explode(',', $_SERVER['HTTP_ACCEPT']);
if (in_array('text/turtle ', $accept))  header('Location: ontology.ttl');
else if (in_array('application/n-triples', $accept)) header('Location: ontology.nt');
elseif (in_array('application/ld+json', $accept)) header('Location: ontology.json');
elseif (in_array('application/rdf+xml', $accept)) header('Location: ontology.xml');
else header('Location: index-en.html');
?>
