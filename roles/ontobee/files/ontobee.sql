DROP TABLE IF EXISTS ontology;

CREATE TABLE ontology (
  id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  ontology_abbrv VARCHAR(100),
  ontology_fullname VARCHAR(255),
  ontology_url VARCHAR(255),
  ontology_graph_url VARCHAR(255),
  end_point VARCHAR(255),
  loaded VARCHAR(1),
  to_list VARCHAR(1)
);

INSERT INTO ontology VALUES(1, "OBI", "Ontology for Biomedical Ontologies", "http://purl.obolibrary.org/obo/obi.owl", "http://purl.obolibrary.org/obo/obi.owl", "http://localhost:8890/sparql", "y", "y");



DROP TABLE IF EXISTS key_terms;

CREATE TABLE key_terms (
  id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  ontology_abbrv VARCHAR(100),
  term_label VARCHAR(255)
);
