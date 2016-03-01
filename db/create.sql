-- Check if database exists
print "Checking if database exists..."
IF EXISTS (SELECT name FROM master.sys.databases WHERE name = N'testing')
BEGIN
    print "Database already exists"
    RAISERROR ('Database already exists', 20, 1) with log;
END;
print "Database doesnt exists. Continue..."
-- END: Check if database exists


-- Init Database Dump
GO
CREATE DATABASE example;
GO

USE example;
GO

CREATE TABLE table01(
  id uniqueidentifier NOT NULL DEFAULT newid(),
  PRIMARY KEY(id),
  name VARCHAR(64),
);
GO

INSERT INTO table01(id, name) VALUES(newid(), 'Example 01');
INSERT INTO table01(id, name) VALUES(newid(), 'Example 02');
GO

print "End dump"
