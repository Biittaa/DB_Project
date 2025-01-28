CREATE USER 'Blazkowicz'@'%' IDENTIFIED BY 'William1939';

-- REVOKE INSERT, UPDATE, DELETE ON mydatabase.* FROM 'Blazkowicz'@'%';

GRANT SELECT ON mydatabase.* TO 'Blazkowicz'@'%';

FLUSH PRIVILEGES;

SHOW GRANTS FOR 'Blazkowicz'@'%';








