CREATE TABLE Customer(
    CustomerID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOt NULL,
    PhoneNumber VARCHAR(15) UNIQUE CHECK (LENGTH(PhoneNumber) BETWEEN 10 AND 20),
    Email VARCHAR(100) UNIQUE,
    CustomerAddress TEXT,
    DateOfBirth TIMESTAMP,
    CreateAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CustomerType ENUM('Legal','Normal')
);


CREATE TABLE Employee(
    EmployeeID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOt NULL,
    PhoneNumber VARCHAR(15) UNIQUE CHECK (LENGTH(PhoneNumber) BETWEEN 10 AND 20),
    Email VARCHAR(100) UNIQUE,
    EmployeeAddress TEXT,
    DateOfBirth TIMESTAMP,
    CreateAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    JobPosition VARCHAR(50) NOT NULL
);


CREATE TABLE BankAccounts(
    AccountID INT PRIMARY KEY AUTO_INCREMENT,
    CustomerID INT NOT NULL,
    AccountNumber VARCHAR(20) NOT NULL UNIQUE,
    AccountType VARCHAR(50) NOT NULL,
    Balance DECIMAL(15,2) DEFAULT 0 CHECK ( Balance >= 0),
    AccountStatus ENUM('Active','Suspended','Closed') DEFAULT 'Active',
    CreateAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    ClosedAt TIMESTAMP,
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID) ON DELETE CASCADE
);


CREATE TABLE TransactionTable(
    TransactionID INT PRIMARY KEY AUTO_INCREMENT,
    sourceAccount INT NOT NULL,
    destinationAccount INT,
    TransactionAmount DECIMAL(15,2) NOT NULL,
    TransactionDate TIMESTAMP,
    TransactionType ENUM('withdraw','deposit','transfer') NOT NULL,
    FOREIGN KEY (sourceAccount) REFERENCES BankAccounts(AccountID),
    FOREIGN Key (destinationAccount) REFERENCES BankAccounts(AccountID)
);


CREATE TABLE Loan(
    LoanID INT PRIMARY KEY AUTO_INCREMENT,
    loanType ENUM('Education Loan','Mortgage','Personal Loan') NOT NULL,
    CustomerID INT NOT NULL,
    InterestRate DECIMAL(5, 4) NOT NULL CHECK (InterestRate > 0 AND InterestRate <= 1),
    LoanAmount DECIMAL(15,2) DEFAULT 0 CHECK(LoanAmount >= 0),
    PaybackPeriodMonths INT NOT NULL CHECK (PaybackPeriodMonths > 0),
    StartDate TIMESTAMP NOT NULL,
    EndDate TIMESTAMP NOT NULL,
    LoanStatus ENUM('Active','Closed') DEFAULT 'Active',
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID) ON DELETE CASCADE
);

CREATE TABLE INSTALLMENT (
    InstallmentID INT PRIMARY KEY AUTO_INCREMENT,
    LoanID INT NOT NULL,
    ScheduledPaymentDate TIMESTAMP NOT NULL,
    ActualPaymentDate TIMESTAMP,
    AmountPaid DECIMAL(15,2) DEFAULT 0 CHECK (AmountPaid >= 0),
    InterestAmount DECIMAL(15, 2) DEFAULT 0 CHECK (InterestAmount >= 0),
    TotalAmountPaid DECIMAL(15, 2) GENERATED ALWAYS AS (AmountPaid + InterestAmount) STORED,
    FOREIGN KEY (LoanID) REFERENCES Loan(LoanID) ON DELETE CASCADE
);




