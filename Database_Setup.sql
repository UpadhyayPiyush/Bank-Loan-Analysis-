create database bank_loan; 
use bank_loan;

CREATE TABLE Dim_Date (
    Date         DATE NOT NULL,
    Year         SMALLINT,
    Quarter      CHAR(2),              
    MonthNumber  TINYINT,
    MonthName    VARCHAR(10)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4;


CREATE TABLE Dim_Customer (
    MemberID         BIGINT PRIMARY KEY,
    ApplicationType  VARCHAR(20),        -- e.g. 'INDIVIDUAL', 'JOINT'
    EmpLength        VARCHAR(20),        -- e.g. '< 1 year', '10+ years'
    EmpTitle         VARCHAR(100),       -- job title
    HomeOwnership    VARCHAR(20),        -- RENT, OWN, MORTGAGE, etc.
    AnnualIncome     DECIMAL(12,2),
    DTI              DECIMAL(6,4),       -- debt-to-income ratio
    TotalAcc         SMALLINT            -- total number of credit accounts
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4;


CREATE TABLE Dim_LoanPurpose (
    PurposeKey    INT PRIMARY KEY,
    Purpose       VARCHAR(50) NOT NULL UNIQUE,
    PurposeGroup  VARCHAR(50)           -- e.g. 'Debt & Credit', 'Home & Housing'
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4;

CREATE TABLE Dim_State (
    StateKey   INT PRIMARY KEY,
    StateCode  CHAR(2) NOT NULL UNIQUE,  -- e.g. 'CA', 'NY'
    StateName  VARCHAR(50)               -- e.g. 'California'
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4;


CREATE TABLE Fact_Loan (
    LoanID              BIGINT PRIMARY KEY,    
    MemberID            BIGINT NOT NULL,
    AddressState        CHAR(2),
    ApplicationType     VARCHAR(20),
    EmpTitle 			VARCHAR(100),
    Grade               CHAR(1),
    IssueDate           DATE,
    LastCreditPullDate  DATE,
    LastPaymentDate     DATE,
    LoanStatus          VARCHAR(20), 
    NextPaymentDate     DATE,
    Purpose             VARCHAR(50),
    SubGrade            CHAR(2),
    Term                VARCHAR(20),           
    VerificationStatus  VARCHAR(30),
    Installment         DECIMAL(10,2),
    InterestRate        DECIMAL(6,4),
    LoanAmount          DECIMAL(12,2),
    TotalPayment        DECIMAL(14,2),

    
    CONSTRAINT fk_fact_customer
        FOREIGN KEY (MemberID)
        REFERENCES Dim_Customer(MemberID),

    CONSTRAINT fk_fact_state
        FOREIGN KEY (AddressState)
        REFERENCES Dim_State(StateCode),

    CONSTRAINT fk_fact_purpose
        FOREIGN KEY (Purpose)
        REFERENCES Dim_LoanPurpose(Purpose)

) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4;

TRUNCATE TABLE Fact_Loan;

Alter table fact_loan 
Drop Primary Key;

ALTER TABLE Fact_Loan
MODIFY COLUMN LoanID BIGINT;

ALTER TABLE Fact_Loan
ADD COLUMN LoanKey INT NOT NULL;

Alter Table Fact_loan 
Add Primary Key (LoanKey);





