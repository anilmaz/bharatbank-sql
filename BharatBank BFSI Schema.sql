
-- ============================================================
-- BharatBank BFSI Schema for Indian Banking & Finance Vertical
-- Author: Anil Mahadev
-- Purpose: Modular, production-grade schema with sample data
-- Target: SQL Server 2025 CTP (Docker container)
-- ============================================================

-- Create the main database
CREATE DATABASE BharatBank;
GO
USE BharatBank;

-- ============================================================
-- 1. Customers Table
-- Stores KYC-compliant customer data
-- ============================================================
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    FullName NVARCHAR(100),
    DOB DATE,
    Aadhaar VARCHAR(12),
    PAN VARCHAR(10),
    Mobile VARCHAR(10),
    Email NVARCHAR(100),
    CreatedAt DATETIME DEFAULT GETDATE()
);

INSERT INTO Customers VALUES
(1, 'Ravi Kumar', '1985-06-15', '123456789012', 'ABCDE1234F', '9876543210', 'ravi.kumar@example.in', GETDATE()),
(2, 'Meena Joshi', '1990-03-22', '234567890123', 'FGHIJ5678K', '9123456789', 'meena.joshi@example.in', GETDATE());

-- ============================================================
-- 2. Branches Table
-- Stores geo-tagged branch info with IFSC codes
-- ============================================================
CREATE TABLE Branches (
    BranchID INT PRIMARY KEY,
    BranchName NVARCHAR(100),
    IFSC VARCHAR(11),
    PINCode VARCHAR(6)
);

INSERT INTO Branches VALUES
(1, 'MG Road Branch', 'BHRB000001', '560001'),
(2, 'Indiranagar Branch', 'BHRB000002', '560038');

-- ============================================================
-- 3. Accounts Table
-- Links customers to account types and balances
-- ============================================================
CREATE TABLE Accounts (
    AccountID INT PRIMARY KEY,
    CustomerID INT FOREIGN KEY REFERENCES Customers(CustomerID),
    AccountType NVARCHAR(20), -- Savings, FD, RD, etc.
    Balance DECIMAL(18,2),
    OpenDate DATE,
    BranchID INT FOREIGN KEY REFERENCES Branches(BranchID)
);

INSERT INTO Accounts VALUES
(101, 1, 'Savings', 25000.00, '2022-01-15', 1),
(102, 2, 'Fixed Deposit', 100000.00, '2023-03-10', 2);

-- ============================================================
-- 4. Transactions Table
-- Logs debit/credit activity with UPI/NEFT/IMPS modes
-- ============================================================
CREATE TABLE Transactions (
    TransactionID INT PRIMARY KEY,
    AccountID INT FOREIGN KEY REFERENCES Accounts(AccountID),
    TxnType NVARCHAR(10), -- Credit or Debit
    Amount DECIMAL(18,2),
    TxnMode NVARCHAR(10), -- UPI, NEFT, IMPS
    TxnDate DATETIME,
    ReferenceNo NVARCHAR(50)
);

INSERT INTO Transactions VALUES
(1001, 101, 'Credit', 5000.00, 'UPI', '2023-08-01 10:30:00', 'UPI123456'),
(1002, 101, 'Debit', 2000.00, 'NEFT', '2023-08-02 14:15:00', 'NEFT789012');

-- ============================================================
-- 5. LoanTypes Table
-- Defines loan categories and interest rates
-- ============================================================
CREATE TABLE LoanTypes (
    LoanTypeID INT PRIMARY KEY,
    TypeName NVARCHAR(50),
    InterestRate DECIMAL(5,2)
);

INSERT INTO LoanTypes VALUES
(1, 'Home Loan', 7.5),
(2, 'Personal Loan', 11.0);

-- ============================================================
-- 6. Loans Table
-- Tracks loan issuance and tenure
-- ============================================================
CREATE TABLE Loans (
    LoanID INT PRIMARY KEY,
    CustomerID INT FOREIGN KEY REFERENCES Customers(CustomerID),
    LoanTypeID INT FOREIGN KEY REFERENCES LoanTypes(LoanTypeID),
    PrincipalAmount DECIMAL(18,2),
    StartDate DATE,
    TenureMonths INT
);

INSERT INTO Loans VALUES
(201, 1, 1, 2500000.00, '2023-01-01', 240);

-- ============================================================
-- 7. EMI_Schedule Table
-- Monthly repayment tracking
-- ============================================================
CREATE TABLE EMI_Schedule (
    EMI_ID INT PRIMARY KEY,
    LoanID INT FOREIGN KEY REFERENCES Loans(LoanID),
    DueDate DATE,
    EMI_Amount DECIMAL(18,2),
    Paid BIT DEFAULT 0
);

INSERT INTO EMI_Schedule VALUES
(301, 201, '2023-02-01', 22000.00, 1),
(302, 201, '2023-03-01', 22000.00, 0);

-- ============================================================
-- 8. Roles Table
-- Defines staff roles for access control
-- ============================================================
CREATE TABLE Roles (
    RoleID INT PRIMARY KEY,
    RoleName NVARCHAR(50)
);

INSERT INTO Roles VALUES
(1, 'Manager'),
(2, 'Teller');

-- ============================================================
-- 9. Staff Table
-- Employee directory with branch and role mapping
-- ============================================================
CREATE TABLE Staff (
    StaffID INT PRIMARY KEY,
    FullName NVARCHAR(100),
    RoleID INT FOREIGN KEY REFERENCES Roles(RoleID),
    BranchID INT FOREIGN KEY REFERENCES Branches(BranchID),
    Mobile VARCHAR(10)
);

INSERT INTO Staff VALUES
(501, 'Anita Desai', 1, 1, '9812345678'),
(502, 'Kiran Rao', 2, 2, '9823456789');

-- ============================================================
-- 10. KYC_Documents Table
-- Tracks Aadhaar, PAN, and other document verification
-- ============================================================
CREATE TABLE KYC_Documents (
    DocID INT PRIMARY KEY,
    CustomerID INT FOREIGN KEY REFERENCES Customers(CustomerID),
    DocType NVARCHAR(50),
    DocNumber NVARCHAR(50),
    Verified BIT DEFAULT 0
);

INSERT INTO KYC_Documents VALUES
(1, 1, 'Aadhaar', '123456789012', 1),
(2, 2, 'PAN', 'FGHIJ5678K', 1);

-- ============================================================
-- 11. AuditLogs Table
-- Tracks system actions for compliance
-- ============================================================
CREATE TABLE AuditLogs (
    LogID INT PRIMARY KEY,
    Action NVARCHAR(100),
    PerformedBy NVARCHAR(100),
    Timestamp DATETIME DEFAULT GETDATE()
);

INSERT INTO AuditLogs VALUES
(1, 'Created Account 101', 'System', GETDATE()),
(2, 'Processed Loan 201', 'System', GETDATE());

-- ============================================================
-- End of Script
-- ============================================================
