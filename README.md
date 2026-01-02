# Financial Lending Analytics 

## Project Overview
This project focuses on end-to-end Financial Lending Analytics using a real-world bank loan dataset to analyze portfolio performance, credit risk, and recovery behavior. 
The analysis covers the complete lifecycle of loan data — from data modeling and SQL-based analysis to interactive dashboarding in Power BI.
A star schema data model was designed using multiple fact and dimension tables to enable scalable, enterprise-grade analytics. 
Key metrics such as loan applications, funded amount, amount received, charge-off rate, average interest rate, debt-to-income ratio (DTI), and recovery rate were analyzed to evaluate overall portfolio health and risk exposure.
The final output is a multi-page Power BI report that provides portfolio-level insights, detailed risk segmentation (Good vs Bad Loans), and transaction-level drill-downs, making the project highly relevant for financial institutions such as banks, NBFCs, and credit risk teams.

## Business Problem & Objective
Financial institutions manage large volumes of loan applications and face continuous challenges in balancing growth, profitability, and credit risk. Without structured analytics, it becomes difficult to identify high-risk borrowers, monitor portfolio performance, and understand the factors contributing to loan defaults and recoveries.

The objective of this project is to:

- Analyze overall loan portfolio performance across applications, funding, and repayments
- Identify risk patterns by loan status, borrower profile, geography, and loan purpose
- Measure credit risk indicators such as Charge-Off Rate, DTI, Interest Rate, and Recovery Rate
- Enable data-driven decision-making through interactive dashboards for portfolio monitoring and risk assessment
- This analysis helps simulate how financial institutions can use data analytics to reduce credit losses, improve loan quality, and strengthen risk management strategies.

## Schema Structure 
``` sql
# Create Database
create database bank_loan;
use bank_loan;

# Create Date Table
CREATE TABLE Dim_Date (
    Date         DATE NOT NULL,
    Year         SMALLINT,
    Quarter      CHAR(2),              
    MonthNumber  TINYINT,
    MonthName    VARCHAR(10)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4;

# Create Customer Table
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

# Create Loan_Purpose Table
CREATE TABLE Dim_LoanPurpose (
    PurposeKey    INT PRIMARY KEY,
    Purpose       VARCHAR(50) NOT NULL UNIQUE,
    PurposeGroup  VARCHAR(50)           -- e.g. 'Debt & Credit', 'Home & Housing'
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4;

# Create State Table
CREATE TABLE Dim_State (
    StateKey   INT PRIMARY KEY,
    StateCode  CHAR(2) NOT NULL UNIQUE,  -- e.g. 'CA', 'NY'
    StateName  VARCHAR(50)               -- e.g. 'California'
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4;

# Create Loan Table
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
```

## Tools & Technologies 
**MySQL**
- Used to store, manage, and query structured loan data. Advanced SQL techniques such as CTEs, window functions, and subqueries were applied for in-depth financial and risk analysis.
**Power BI**
- Used for data modeling, DAX-based calculations, and building interactive, multi-page dashboards with KPIs, slicers, drill-throughs, and risk-focused visualizations.
**DAX (Data Analysis Expressions)**
- Implemented to calculate key financial and risk metrics including MTD trends, Charge-Off Rate, Recovery Rate, Average DTI, and portfolio-level aggregations.
**Power Query**
- Used for data transformation, data type handling (especially date parsing), and preparing clean datasets for analytics.
**GitHub**
- Used for version control and project documentation, enabling structured presentation of the analytics workflow and results.

## Project Workflow 
**Data Preparation & Modeling**
Raw loan data was structured into a star schema consisting of one fact table and multiple dimension tables (Customer, Date, State, Loan Purpose) to support scalable and efficient analytics.

Data Storage & SQL Analysis
All tables were loaded into MySQL, where advanced SQL queries were written using joins, CTEs, window functions, and aggregations to extract portfolio, risk, and recovery insights.

Data Transformation
Power Query was used to clean and transform the data, handle date conversions, and ensure data quality before visualization.

Metric Development (DAX)
Key financial and risk metrics such as Total Loan Applications, Funded Amount, Amount Received, Charge-Off Rate, Average Interest Rate, Average DTI, and Recovery Rate were calculated using DAX.

Visualization & Reporting
A multi-page Power BI dashboard was developed to present portfolio performance, Good vs Bad loan analysis, risk drivers, and transaction-level details through interactive visuals, slicers, and drill-throughs.

