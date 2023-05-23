-------------------------------------------------------------------------
Account Table : Ac_No, Ac_Name, Openbal, Opentype
Transaction Table : Ac_No, Trans_Date, Trans_Type, Trans_Ammount

Query : To view all the account numbers and their amount of all debits transaction.

Trigger : During insertion into the Account table, the minimum amount for the
          opening balance has to be set by default based on the account type.
-------------------------------------------------------------------------

-- Create Account table
CREATE TABLE Account (
 Ac_No INT,
 Ac_Name VARCHAR(50),
 Openbal FLOAT,
 Opentype VARCHAR(20),
 PRIMARY KEY (Ac_No)
);

-- Create Transaction table
CREATE TABLE Transaction (
 Ac_No INT,
 Trans_Date DATE,
 Trans_Type VARCHAR(20),
 Trans_Amount FLOAT,
 FOREIGN KEY (Ac_No) REFERENCES Account(Ac_No)
);

-- Insert sample accounts into Account table
INSERT INTO Account VALUES (1, 'John Doe', 5000.00, 'Savings');
INSERT INTO Account VALUES (2, 'Jane Smith', 2000.00, 'Current');
INSERT INTO Account VALUES (3, 'Mike Johnson', 10000.00, 'Savings');

-- Insert sample transactions into Transaction table
INSERT INTO Transaction VALUES (1,'13-08-2023', 'Debit', 100.00);
INSERT INTO Transaction VALUES (1, '13-08-2023', 'Debit', 50.00);
INSERT INTO Transaction VALUES (2,'13-08-2023', 'Debit', 200.00);
INSERT INTO Transaction VALUES (3, '13-08-2023', 'Credit', 500.00);

------------------------------QUERY---------------------------------

-- Query to view all account numbers and their debit amount
SELECT T.Ac_No, SUM(T.Trans_Amount) AS Debit_Amount
FROM Account A
JOIN Transaction T ON A.Ac_No = T.Ac_No
WHERE T.Trans_Type = 'Debit'
GROUP BY T.Ac_No;

----------------------------------------------------------------------
------------------------------TRIGGER-------------------------------

-- Create trigger to set minimum opening balance based on account type
CREATE OR REPLACE TRIGGER SetBalance
BEFORE INSERT ON Account
FOR EACH ROW
BEGIN
 IF :NEW.Opentype = 'Savings' THEN
 :NEW.Openbal := 5000.00; -- Set minimum opening balance for Savings account
 ELSIF :NEW.Opentype = 'Current' THEN
 :NEW.Openbal := 1000.00; -- Set minimum opening balance for Current account
 END IF;
END;

----------------------------------------------------------------------
---------------------------TRIGGER EXECUTION--------------------------

INSERT INTO Account (Ac_No, Ac_Name, Opentype) VALUES (6, 'John Doe', 'Savings');
select * from account;

----------------------------------------------------------------------
