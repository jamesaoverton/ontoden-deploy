SPARQL LOAD <http://purl.obolibrary.org/obo/obi.owl>;

SPARQL
DEFINE get:soft "replace" 
SELECT DISTINCT * 
FROM <http://purl.obolibrary.org/obo/obi.owl> 
WHERE 
  {
  ?s ?p ?o
};
