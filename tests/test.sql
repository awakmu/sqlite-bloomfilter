
-- Load the extension
SELECT LOAD_EXTENSION('../libmurmur.so');

-- Create a db to test simple hashing
DROP TABLE IF EXISTS hash_test;
CREATE TABLE hash_test(id INTEGER PRIMARY KEY, key TEXT, hash BLOB);

-- Insert test values
INSERT INTO hash_test VALUES (1, 'a','B026F6FDA49C2528152BF82591CAEB25');
INSERT INTO hash_test VALUES (2, 'b','0FDB02CFD616ECB6EBF933FA29EE0F2C');
INSERT INTO hash_test VALUES (3, '0','5164977ADFCD113FB337004E5C45DC9A');
INSERT INTO hash_test VALUES (4, '1','42F4006E82A9DD7832200E645DEA0E71');
INSERT INTO hash_test VALUES (5, 'test','CB33D7BB447ADABA7712079DC17F1E72');
INSERT INTO hash_test VALUES (6, 'sqlite','3267EB7FA3A580CC7F9AAA94CC9620EF');
INSERT INTO hash_test VALUES (7, 'SQLite In 5 Minutes Or Less','2EB2C05C530C288D85FA0FBF9927CA36');
INSERT INTO hash_test VALUES (8, 'Datatypes In SQLite Version 3','5E666262DF92184386EF84D7BE2F7373');

-- Running the actual tests
SELECT 'Test failed: ' || id || '. ' || key || ' not equal to ' || hash 
FROM hash_test WHERE murmur3(key) <> hash;

-- Summary of tests
SELECT 'Number of tests failed: ' || COUNT(*) FROM (
SELECT 'Test failed: ' || id || '. ' || key || ' not equal to ' || hash 
FROM hash_test WHERE murmur3(key) <> hash);

