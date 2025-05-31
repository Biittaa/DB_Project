INSERT INTO TransactionTable (sourceAccount, destinationAccount, TransactionAmount, TransactionDate, TransactionType)
VALUES
(6, NULL, 250.00, '2022-01-01 10:00:00', 'withdraw'),  
(6, NULL, 180.00, '2023-02-04 14:00:00', 'deposit'),
(4, 6, 800.00, '2021-01-03 10:15:00', 'transfer'),   
(6, 3, 90.00, '2020-01-03 10:10:00', 'transfer');  