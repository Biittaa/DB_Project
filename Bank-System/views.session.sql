-- show all info of customers and their banck account's info
CREATE VIEW customer_accounts AS
SELECT u.FirstName as FirstName,u.LastName as LastName,
    u.PhoneNumber as PhoneNumber,u.Email as Email,
    b.AccountNumber as AccountNumber,b.AccountType as AccountType,b.Balance as Balance
FROM
     bankaccounts b 
JOIN 
    customer c ON c.CustomerID=b.CustomerID
JOIN  
    User u ON u.UserID = c.UserID


-- show info of transactions
CREATE VIEW bank_transactions AS
SELECT TransactionID , sourceAccount,destinationAccount,TransactionAmount,TransactionDate
FROM transactiontable

-- info of employees and customerss
CREATE VIEW bank_member AS
SELECT u.UserID,u.FirstName,u.LastName,
        CASE
            WHEN c.CustomerID is NOT NULL AND e.EmployeeID IS NOT NULL THEN 'Both'
            WHEN c.CustomerID is NOT NULL AND e.EmployeeID IS NULL THEN 'Customer'
            WHEN c.CustomerID is NULL AND e.EmployeeID IS NOT NULL THEN 'Employee'
            ELSE 'None'
        END AS userRole,
        u.PhoneNumber,u.Email
FROM
    user u
LEFT JOIN
    customer c ON c.UserID = u.UserID
LEFT JOIN
    employee e ON e.UserID = u.UserID