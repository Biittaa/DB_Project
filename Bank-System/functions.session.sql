-- trigger 1
-- set Data with out need of manual input
CREATE TRIGGER setDateOpenedBankAccounts
BEFORE INSERT On BankAccounts
FOR EACH ROW 
BEGIN
    SET NEW.CreateAt = CURRENT_TIMESTAMP;
END;


-- trigger 2
-- prevent deleting a customer with active loans
CREATE TRIGGER checkActiveLoansBeforeDeleteCustomer
BEFORE DELETE ON Customer
FOR EACH ROW
BEGIN
    IF EXISTS( SELECT * 
            FROM Loan
            WHERE OLD.CustomerID = CustomerID AND loanStatus = 'Active'
            )THEN
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Cannot delete customer with active loan';
    END IF;
END;



-- trigger 3
-- updating account info and balance after inserting a transaction
CREATE TRIGGER updateAccounts
AFTER INSERT ON transactiontable
FOR EACH ROW
BEGIN
    IF NEW.TransactionType = 'withdraw' THEN
       UPDATE BankAccounts
       SET Balance = Balance - NEW.TransactionAmount
       WHERE AccountID = NEW.sourceAccount ;
    
    ELSEIF NEW.TransactionType = 'deposit' THEN
       UPDATE BankAccounts
       SET Balance = Balance + NEW.TransactionAmount
       WHERE AccountID = NEW.sourceAccount ;

    ELSEIF NEW.TransactionType = 'transfer' THEN
       UPDATE BankAccounts
       SET Balance = Balance - NEW.TransactionAmount
       WHERE AccountID = NEW.sourceAccount;

       UPDATE BankAccounts
       SET Balance = Balance + NEW.TransactionAmount
       WHERE AccountID = NEW.destinationAccount ;
    END IF;
END;


-- trigger 4
-- checking balance before transaction and preventing balance from becoming under zero
CREATE TRIGGER checkBalanceBeforeTransaction
BEFORE INSERT ON transactiontable
FOR EACH ROW
BEGIN
    IF (NEW.TransactionType = 'withdraw' OR NEW.TransactionType = 'transfer')  
    AND NEW.TransactionAmount > (SELECT Balance FROM BankAccounts WHERE AccountID = NEW.sourceAccount) THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Insufficient funds for this transaction';
    END IF;

END;

-- function 1
CREATE FUNCTION calculateTotalBalance(Customer_ID int)
RETURNS DECIMAL(15,2)
DETERMINISTIC  
NO SQL  
BEGIN
    DECLARE totalBalance   DECIMAL(15,2);

    SELECT sum(Balance) INTO totalBalance
    FROM bankaccounts
    WHERE Customer_ID = CustomerID;

    RETURN totalBalance;

END;


SELECT calculateTotalBalance(1) AS TotalBalance;


-- function 2
CREATE FUNCTION checkLoanStatus(Loan_ID int)
RETURNS VARCHAR(10)
DETERMINISTIC  
NO SQL 
BEGIN
    DECLARE loanStatus VARCHAR(10);
    DECLARE loanEndDate TIMESTAMP;
    IF NOT EXISTS (
        SELECT * FROM installment WHERE LoanID = Loan_ID AND ActualPaymentDate IS NULL
    )THEN
       SELECT EndDate INTO loanEndDate FROM loan WHERE LoanID = Loan_ID;
       IF(loanEndDate < CURRENT_TIMESTAMP)THEN
            SET loanStatus = 'Closed';
        ELSE
            SET loanStatus = 'Active';
        END IF;
    ELSE
        SET loanStatus = 'Active';
    END IF;
    RETURN loanStatus;
END;


SELECT checkLoanStatus(1);
SELECT checkLoanStatus(2);
SELECT checkLoanStatus(3);
SELECT checkLoanStatus(4);
SELECT checkLoanStatus(5);
SELECT checkLoanStatus(6);
SELECT checkLoanStatus(7);


-- fuction 3
CREATE FUNCTION findActiveAccountForCustomer(Customer_ID INT)
RETURNS INT
DETERMINISTIC  
NO SQL 
BEGIN
    DECLARE accountCount INT;
    DECLARE status VARCHAR(10);
    SET status = 'Active';
    SELECT count(*) INTO accountCount
    FROM Loan as l
    WHERE checkLoanStatus(l.LoanID)=status AND l.CustomerID = Customer_ID;
    RETURN accountCount;
END;


SELECT
    findActiveAccountForCustomer(1) AS activeAccounts1,
    findActiveAccountForCustomer(2) AS activeAccounts2,
    findActiveAccountForCustomer(3) AS activeAccounts3;



-- function 4 
CREATE FUNCTION totalPaidForLoan(Loan_ID INT)
RETURNS DECIMAL(15,2)
DETERMINISTIC  
NO SQL 
BEGIN
    DECLARE Totalpaid DECIMAL(15,2);
    SELECT sum(i.TotalAmountPaid) INTO Totalpaid
    FROM installment as i
    WHERE i.LoanID = Loan_ID AND i.ActualPaymentDate IS NOT NULL;

    RETURN Totalpaid;
END;

SELECT
   totalPaidForLoan(1) AS paidforLoan1,
   totalPaidForLoan(2) AS paidforLoan2,
   totalPaidForLoan(3) AS paidforLoan3;



-- function 5
CREATE FUNCTION getCustomerINFO(Customer_id INT)
RETURNS VARCHAR(250)
DETERMINISTIC  
NO SQL 
BEGIN
    DECLARE fullName VARCHAR(250);
    SELECT CONCAT(u.FirstName, ' ', u.LastName) INTO fullName
    FROM customer c
    JOIN user u ON u.UserID = c.UserID 
    WHERE c.CustomerID = customer_id;
    RETURN fullName;
END;

 SELECT
    getCustomerINFO(1) as Customer1,
    getCustomerINFO(2) as Customer2,
    getCustomerINFO(3) as Customer3;


