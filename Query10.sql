-------------------------------------------------------------------------
Account Table : Ac_No, Ac_Name, Openbal, Opentype, Currentbal
Transaction Table : Ac_No, Trans_Date, Trans_Type, Trans_Amount

Function : To compute the balance.

Procedure : To update the balance of account (call the function within procedure)
-------------------------------------------------------------------------

-- Create Account table
CREATE TABLE Account (
Ac_No INT,
Ac_Name VARCHAR(50),
Openbal FLOAT,
Opentype VARCHAR(20),
Currentbal FLOAT,
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

-- Insert sample records into Account table
INSERT INTO Account VALUES (1, 'John Doe', 1000.00, 'Savings', 1000.00);
INSERT INTO Account VALUES (2, 'Jane Smith', 500.00, 'Current', 500.00);
INSERT INTO Account VALUES (3, 'Mike Johnson', 2000.00, 'Savings', 2000.00);

-- Insert sample records into Transaction table
INSERT INTO Transaction VALUES (1, '14-05-2023', 'Deposit', 200.00);
INSERT INTO Transaction VALUES (1,'14-05-2023', 'Withdrawal', 50.00);
INSERT INTO Transaction VALUES (2,'14-05-2023', 'Deposit', 100.00);
INSERT INTO Transaction VALUES (3,'14-05-2023', 'Withdrawal', 300.00);

------------------------------FUNCTION---------------------------------

-- Create function to compute the balance
CREATE OR REPLACE FUNCTION Compute_Balance(p_ac_no IN INT) RETURN
NUMBER AS
balance NUMBER;
BEGIN
SELECT Currentbal INTO balance
FROM Account
WHERE Ac_No = p_ac_no;
RETURN balance;
END;

----------------------------------------------------------------------
------------------------------PROCEDURE-------------------------------

-- Create procedure to update the balance
CREATE OR REPLACE PROCEDURE Update_Balance(p_ac_no IN INT) AS
current_balance NUMBER;
BEGIN
current_balance := Compute_Balance(p_ac_no); -- Call the function to get the current
balance

-- Update the balance based on your business logic
-- For example, you can add or subtract the transaction amount from the current balance
UPDATE Account
SET Currentbal = current_balance - (
SELECT SUM(Trans_Amount)
FROM Transaction
WHERE Ac_No = p_ac_no
)
WHERE Ac_No = p_ac_no;

-- Commit the transaction
COMMIT;
END;

----------------------------------------------------------------------
------------------------------EXECUTION-------------------------------

-- Execute the procedure for account 1
set serveroutput on;
BEGIN
 Update_Balance(1);
END;

SELECT * FROM Account;

----------------------------------------------------------------------