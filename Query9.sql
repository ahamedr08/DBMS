-------------------------------------------------------------------------
Account Table : Ac_No, Ac_Name, Openbal, Opentype, Currentbal
Transaction Table : Ac_No, Trans_Date, Trans_Type, Trans_Amount

Query : Find the number of transactions for every user on a particular date.

Trigger : Update the current balance of the account holder whenever there
is a transaction.
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

---------------------------------QUERY---------------------------------

SELECT A.Ac_No, A.Ac_Name, COUNT(*) AS Transaction_Count
FROM Account A
JOIN Transaction T ON A.Ac_No = T.Ac_No
WHERE T.Trans_Date = TO_DATE('14-05-2023')
GROUP BY A.Ac_No, A.Ac_Name;

----------------------------------------------------------------------
------------------------------TRIGGER---------------------------------

CREATE OR REPLACE TRIGGER Update_Current_Balance
AFTER INSERT ON Transaction
FOR EACH ROW
BEGIN
IF :NEW.Trans_Type = 'Deposit' THEN
UPDATE Account
SET Currentbal = Currentbal + :NEW.Trans_Amount
WHERE Ac_No = :NEW.Ac_No;
ELSIF :NEW.Trans_Type = 'Withdrawal' THEN
UPDATE Account
SET Currentbal = Currentbal - :NEW.Trans_Amount
WHERE Ac_No = :NEW.Ac_No;
END IF;
END;

----------------------------------------------------------------------
------------------------------EXECUTION-------------------------------

INSERT INTO Transaction VALUES (1,'14-05-2023', 'Deposit', 200.00);
INSERT INTO Transaction VALUES (1,'14-05-2023', 'Withdrawal', 100.00);

SELECT Ac_No, Ac_Name, Currentbal
FROM Account;

----------------------------------------------------------------------