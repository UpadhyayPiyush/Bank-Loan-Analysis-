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
- **MySQL**: Used to store, manage, and query structured loan data. Advanced SQL techniques such as CTEs, window functions, and subqueries were applied for in-depth financial and risk analysis.
- **Power BI**: Used for data modeling, DAX-based calculations, and building interactive, multi-page dashboards with KPIs, slicers, drill-throughs, and risk-focused visualizations.
- **DAX (Data Analysis Expressions)**: Implemented to calculate key financial and risk metrics including MTD trends, Charge-Off Rate, Recovery Rate, Average DTI, and portfolio-level aggregations.
- **Power Query**: Used for data transformation, data type handling (especially date parsing), and preparing clean datasets for analytics.
- **GitHub**: Used for version control and project documentation, enabling structured presentation of the analytics workflow and results.

## Project Workflow 
- **Data Preparation & Modeling**: Raw loan data was structured into a star schema consisting of one fact table and multiple dimension tables (Customer, Date, State, Loan Purpose) to support scalable and efficient analytics.
- **Data Storage & SQL Analysis**: All tables were loaded into MySQL, where advanced SQL queries were written using joins, CTEs, window functions, and aggregations to extract portfolio, risk, and recovery insights.
- **Data Transformation**: Power Query was used to clean and transform the data, handle date conversions, and ensure data quality before visualization.
- **Metric Development (DAX)**: Key financial and risk metrics such as Total Loan Applications, Funded Amount, Amount Received, Charge-Off Rate, Average Interest Rate, Average DTI, and Recovery Rate were calculated using DAX.
- **Visualization & Reporting**: A multi-page Power BI dashboard was developed to present portfolio performance, Good vs Bad loan analysis, risk drivers, and transaction-level details through interactive visuals, slicers, and drill-throughs.

## Key Insights
- Out of ~50,000 loan applications, approximately 13.7% were charged off, indicating a significant credit risk portion within the overall lending portfolio.
- The portfolio recorded a Total Funded Amount of $565.94M, while the Total Amount Received reached $614.92M, showing that good loans generated surplus collections beyond the funded principal.
- Charged-off loans resulted in an estimated loss of ~$36M, highlighting the financial impact of defaults despite recovery efforts.
- Recovery Rate for Good Loans (Fully Paid + Current) exceeded 100%, whereas Bad Loans (Charged Off) recovered only ~57% of the funded amount, demonstrating a clear contrast in portfolio quality.
- Charged-off loans exhibited higher Average DTI and higher Average Interest Rates compared to Fully Paid loans, confirming that borrower affordability and risk-based pricing are strong indicators of default risk.
- Loan grades with lower credit quality showed disproportionately higher charge-off rates, reinforcing the inverse relationship between credit grade and portfolio stability.

## Recommendations
- **Strengthen credit screening for high-risk borrowers**: Since ~13.7% of loans are charged off and charged-off borrowers show higher DTI levels, stricter DTI thresholds and enhanced affordability checks should be applied before loan approval.
- **Refine risk-based pricing strategies**: Charged-off loans carry higher average interest rates, indicating pricing alone is not sufficient to offset risk. Combining interest rates with stronger borrower quality metrics can help reduce future losses.
- **Focus on improving recovery mechanisms for bad loans**: With bad loan recovery at ~57% compared to >100% recovery for good loans, early intervention strategies such as proactive reminders and structured repayment plans can help improve recoveries.
- **Prioritize low-risk segments for portfolio growth**: Fully Paid and Current loans contribute positively to the portfolio, generating surplus collections over funded amounts. Expanding lending in these segments can improve overall profitability.
- **Leverage data-driven monitoring for ongoing risk management**: Regular tracking of Charge-Off Rate, Recovery Rate, Avg DTI, and Interest Rate trends through dashboards can help identify emerging risks early and support timely decision-making.

## Report View  
![Home Page](https://github.com/UpadhyayPiyush/Bank-Loan-Analysis-/blob/main/Home.png)
![Overview Page](https://github.com/UpadhyayPiyush/Bank-Loan-Analysis-/blob/main/Overview.png)
![Summary Page](https://github.com/UpadhyayPiyush/Bank-Loan-Analysis-/blob/main/Summary.png)
![Details Page](https://github.com/UpadhyayPiyush/Bank-Loan-Analysis-/blob/main/Details.png)

## Conclusion 
This project demonstrates how financial lending data can be transformed into actionable insights through structured data modeling, advanced SQL analysis, and interactive business intelligence reporting. By combining portfolio-level metrics with detailed risk and recovery analysis, the project highlights key factors influencing loan performance and credit risk.
The analysis shows that charged-off loans contribute a measurable financial loss, while good loans generate surplus recoveries, emphasizing the importance of borrower quality and effective risk management. The Power BI dashboards provide a clear and intuitive view of portfolio health, enabling stakeholders to monitor trends, assess risk drivers, and support data-driven lending decisions.
Overall, this project reflects a practical application of financial analytics and credit risk analysis, making it highly relevant for roles in data analytics, banking, and financial services.
