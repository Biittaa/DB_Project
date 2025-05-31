-- Insert into User table
INSERT INTO User (FirstName, LastName, PhoneNumber, Email, userAddress, DateOfBirth) 
VALUES 
('John', 'Doe', '1234567890', 'johndoe@example.com', '123 Main St, Springfield', '1990-01-01 00:00:00'),
('Alice', 'Smith', '9876543210', 'alice.smith@example.com', '456 Elm St, Metropolis', '1985-06-15 00:00:00');


-- Insert into Customer
INSERT INTO Customer (UserID, CustomerType)
VALUES
(2, 'Normal');  -- John is a customer


-- Insert into Employee
INSERT INTO Employee (UserID, JobPosition)
VALUES
(2, 'Accountant');  -- Alice is an employee



-- -- Insert into BankAccounts
INSERT INTO BankAccounts (CustomerID, AccountNumber, AccountType, Balance)
VALUES
(1, 'ACC1234567890', 'Savings', 5000.00),
(2, 'ACC0987654321', 'Checking', 1500.50);

-- -- Insert into Loan
INSERT INTO Loan (loanType, CustomerID, InterestRate, LoanAmount, PaybackPeriodMonths, StartDate, EndDate)
VALUES
('Education Loan', 1, 0.0350, 50000.00, 60, '2023-01-01 00:00:00', '2028-01-01 00:00:00'),
('Mortgage', 2, 0.0250, 250000.00, 240, '2022-06-15 00:00:00', '2030-06-15 00:00:00');

-- -- Insert into INSTALLMENT
INSERT INTO INSTALLMENT (LoanID, ScheduledPaymentDate, AmountPaid, InterestAmount)
VALUES
(1, '2023-12-01 00:00:00', 1000.00, 35.00),
(2, '2023-12-01 00:00:00', 2000.00, 50.00);


-- Insert into TransactionTable

INSERT INTO TransactionTable (sourceAccount, destinationAccount, TransactionAmount, TransactionDate, TransactionType)
VALUES
(3, NULL, 200.00, '2023-01-01 10:00:00', 'withdraw'),  -- Withdrawal from sourceAccount 1
(4, NULL, 150.00, '2023-01-02 15:30:00', 'deposit'),   -- Deposit to sourceAccount 2
(3, 4, 100.00, '2023-01-03 12:15:00', 'transfer');     -- Transfer from sourceAccount 1 to destinationAccount 2

