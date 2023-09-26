-- Setup for postgrest
\set pgpass `echo "$POSTGRES_PASSWORD"`;

-- Create the people table
CREATE TABLE people (
    person_id SERIAL PRIMARY KEY,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL
);

-- Create the interactions table
CREATE TABLE interactions (
    interaction_id SERIAL PRIMARY KEY,
    person_id INT REFERENCES people(person_id), -- Foreign Key referencing the people table
    notes TEXT
);

-- Inserting example data into the people table
INSERT INTO people (first_name, last_name) VALUES ('John', 'Doe');
INSERT INTO people (first_name, last_name) VALUES ('Jane', 'Smith');
INSERT INTO people (first_name, last_name) VALUES ('Alice', 'Johnson');
INSERT INTO people (first_name, last_name) VALUES ('Bob', 'Williams');
INSERT INTO people (first_name, last_name) VALUES ('Charlie', 'Brown');

-- Inserting example data into the interactions table
INSERT INTO interactions (person_id, notes) VALUES (1, 'Met at a conference.');
INSERT INTO interactions (person_id, notes) VALUES (2, 'Had a phone call regarding the project.');
INSERT INTO interactions (person_id, notes) VALUES (3, 'Sent an email about the upcoming meeting.');
INSERT INTO interactions (person_id, notes) VALUES (4, 'Discussed the new proposal.');
INSERT INTO interactions (person_id, notes) VALUES (5, 'Met for coffee to discuss collaboration.');