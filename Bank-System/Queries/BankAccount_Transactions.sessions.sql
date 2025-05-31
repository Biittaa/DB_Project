SELECT *
FROM transactiontable
WHERE sourceAccount = 6 or destinationAccount = 6;


-- INSERT INTO Loan (loanType, CustomerID, InterestRate, LoanAmount, PaybackPeriodMonths, StartDate, EndDate, LoanStatus)
-- VALUES
-- ('Education Loan', 1, 0.0350, 50000.00, 60, '2023-01-01 00:00:00', '2028-01-01 00:00:00', 'Active'),
-- ('Mortgage', 3, 0.0250, 250000.00, 240, '2022-06-15 00:00:00', '2030-06-15 00:00:00', 'Closed'),
-- ('Personal Loan', 3, 0.0450, 15000.00, 24, '2023-05-01 00:00:00', '2025-05-01 00:00:00', 'Active'),
-- ('Education Loan', 2, 0.0400, 75000.00, 48, '2021-09-01 00:00:00', '2025-09-01 00:00:00', 'Closed'),
-- ('Mortgage', 3, 0.0200, 500000.00, 360, '2015-01-01 00:00:00', '2024-01-01 00:00:00', 'Active');