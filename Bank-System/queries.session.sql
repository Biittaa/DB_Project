-- QUERY number 1 
-- Insert a person table
INSERT INTO User (FirstName,LastName,PhoneNumber,Email,userAddress,DateOfBirth) 
VALUES ('Bita','Asheghi','12345690999','bita@gmail.com','456 Elm St, Metropoli','2003-06-15 00:00:00' );


INSERT INTO Customer (UserID, CustomerType)
VALUES ('6','Normal');

-- QUERY number 2 
-- Insert a Bank Account
INSERT INTO bankaccounts (CustomerID, AccountNumber, AccountType, Balance)
VALUES (3,"ACC0987654456","Savings","2000");



-- Insert some transactions
INSERT INTO TransactionTable (sourceAccount, destinationAccount, TransactionAmount, TransactionDate, TransactionType)
VALUES
(6, NULL, 250.00, '2022-01-01 10:00:00', 'withdraw'),  
(6, NULL, 180.00, '2023-02-04 14:00:00', 'deposit'),
(4, 6, 800.00, '2021-01-03 10:15:00', 'transfer'),   
(6, 3, 90.00, '2020-01-03 10:10:00', 'transfer');  


-- Insert some installments
INSERT INTO INSTALLMENT (LoanID, ScheduledPaymentDate, ActualPaymentDate, AmountPaid, InterestAmount)
VALUES
(1, '2023-12-01 00:00:00', '2023-12-01 00:00:00', 1000.00, 35.00),  -- On-time payment
(1, '2023-11-15 00:00:00', '2023-11-16 00:00:00', 2000.00, 50.00), -- Late payment
(2, '2023-10-01 00:00:00', '2023-10-01 00:00:00', 750.00, 33.75),  -- On-time payment
(2, '2023-11-01 00:00:00', '2023-11-05 00:00:00', 750.00, 31.50),  -- Late payment with reduced interest
(4, '2023-09-01 00:00:00', '2023-09-01 00:00:00', 1500.00, 60.00), -- On-time payment
(6, '2023-08-01 00:00:00', '2023-08-01 00:00:00', 2500.00, 100.00),-- Early payment
(7, '2023-12-01 00:00:00', '2023-12-01 00:00:00', 1200.00, 40.20); -- On-time payment


-- QUERY number 3 
-- get all transactions of a specific account
SELECT *
FROM transactiontable
WHERE sourceAccount = 6 or destinationAccount = 6;

-- Insert to Loan table
INSERT INTO Loan (loanType, CustomerID, InterestRate, LoanAmount, PaybackPeriodMonths, StartDate, EndDate, LoanStatus)
VALUES
('Education Loan', 1, 0.0350, 50000.00, 60, '2023-01-01 00:00:00', '2028-01-01 00:00:00', 'Active'),
('Mortgage', 3, 0.0250, 250000.00, 240, '2022-06-15 00:00:00', '2030-06-15 00:00:00', 'Closed'),
('Personal Loan', 3, 0.0450, 15000.00, 24, '2023-05-01 00:00:00', '2025-05-01 00:00:00', 'Active'),
('Education Loan', 2, 0.0400, 75000.00, 48, '2021-09-01 00:00:00', '2025-09-01 00:00:00', 'Closed'),
('Mortgage', 3, 0.0200, 500000.00, 360, '2015-01-01 00:00:00', '2024-01-01 00:00:00', 'Active');





--  QUERY number 4
-- select info of all active loans
SELECT loanType,CustomerID,InterestRate,LoanAmount,PaybackPeriodMonths,LoanStatus
FROM loan
WHERE LoanStatus = 'Active';




-- QUERY number 5
-- select info of bank accounts with balance more than 2500
SELECT * 
FROM bankaccounts
WHERE Balance >= 2500;



-- QUERY number 6
-- select sum of all balances of all bank accounts of customers and other info of them
SELECT 
    u.FirstName, 
    u.LastName, 
    ba.AccountType, 
    SUM(ba.Balance) AS totalBalance
FROM 
    BankAccounts ba
JOIN 
    Customer c ON ba.CustomerID = c.CustomerID
JOIN 
    User u ON c.UserID = u.UserID
GROUP BY 
    u.FirstName, 
    u.LastName, 
    ba.AccountType;


-- -- QUERY number 7
-- select sum of loans of employees and other info of them
SELECT u.FirstName,u.LastName,sum(l.LoanAmount) as totalAmount
FROM 
        loan  l 
join 
        customer c on c.CustomerID = l.CustomerID
join 
         user  u on c.UserID = u.UserID
WHERE l.LoanStatus = 'Active' AND u.UserID IN ( SELECT UserID FROM employee)
GROUP BY u.FirstName,u.LastName;







-- QUERY number 8
-- select number of accounts of customers
SELECT u.FirstName,u.LastName,count(b.AccountNumber) as accountCount
FROM 
        bankaccounts b
join 
        customer c on c.CustomerID = b.CustomerID
JOIN
        user u on u.UserID = c.UserID
GROUP BY u.FirstName,u.LastName
HAVING count(b.AccountNumber>1);



-- QUERY bonus 1
-- select customers with highest number of active loans
with ActiveLoanCount AS(
    SELECT CustomerID, count(LoanID) as loan_count
    FROM loan
    WHERE LoanStatus = 'active'
    GROUP BY CustomerID
),

maxLoanCount AS(
    SELECT Max(loan_count) as maxLoan
    FROM ActiveLoanCount
)

SELECT u.FirstName,u.LastName,alc.loan_count
FROM 
       ActiveLoanCount alc
JOIN    
        customer c on c.CustomerID = alc.CustomerID
JOIN                
        user u on u.UserID = c.UserID
JOIN 
        maxLoanCount mlc on mlc.maxLoan=alc.loan_count;


-- QUERY bonus 2
-- select 5 loans with lowest number of installments paid
with paidInstallmentCount AS(
    SELECT l.LoanID as loan_id,count(i.InstallmentID) as installmentCount
    FROM loan l
    JOIN installment i on l.LoanID = i.LoanID
    WHERE i.ActualPaymentDate is not null
    GROUP BY l.LoanID
)

SELECT *
FROM paidInstallmentCount
ORDER BY installmentCount ASC
LIMIT 5;



-- QUERY bonus 3
-- select info of customers with late payment
with totalLoanAmount AS(
    SELECT l.LoanID as loan_id ,l.CustomerID as customer_id,sum(i.TotalAmountPaid) as totalAmount
    FROM
        installment i 
    JOIN
        loan l on l.LoanID = i.LoanID
    WHERE (i.ActualPaymentDate IS NULL AND i.ScheduledPaymentDate < CURRENT_DATE)
       OR (i.ActualPaymentDate IS NOT NULL AND i.ScheduledPaymentDate < i.ActualPaymentDate)

    GROUP BY l.LoanID
)


SELECT c.CustomerID,u.FirstName,u.LastName,t.loan_id,t.totalAmount
FROM 
    totalLoanAmount t
JOIN 
    customer c on c.CustomerID=t.customer_id
JOIN
    user u on u.UserID = c.UserID;



-- QUERY BONUS 4
-- select 5 customers with highest balance
SELECT u.FirstName,u.LastName,b.Balance
FROM 
    bankaccounts b
JOIN
    customer c on c.CustomerID=b.CustomerID
JOIN
    user u ON u.UserID = c.UserID
ORDER BY b.Balance DESC
LIMIT 5;

