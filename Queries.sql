# Total Loan Applications
-- SELECT count(LoanKey) AS total_applicants 
-- FROM fact_loan;

# MTD Applications
-- SELECT COUNT(LoanKey) AS MTD_Total_Applications FROM fact_loan
-- where month(IssueDate) = 12 and Year(issueDate) = 2021

# PMTD Loan Applications
-- SELECT COUNT(LoanKey) AS Total_Applications FROM fact_loan
-- WHERE MONTH(issuedate) = 11;

# Total Funded Amount
-- SELECT SUM(LoanAmount) AS Total_Funded_Amount 
-- FROM fact_loan

#  MTD Total Funded Amount
-- SELECT SUM(LoanAmount) AS Total_Funded_Amount FROM fact_loan
-- WHERE MONTH(issuedate) = 12

# PMTD Total Funded Amount 
-- SELECT SUM(LoanAmount) AS Total_Funded_Amount FROM fact_loan
-- WHERE MONTH(issuedate) = 11

# Total Amount Received
-- SELECT SUM(TotalPayment) AS Total_Amount_Collected 
-- FROM fact_loan

# MTD Total Amount Received
-- SELECT SUM(TotalPayment) AS Total_Amount_Collected 
-- FROM fact_loan
-- WHERE MONTH(issuedate) = 12

# PMTD Total Amount Received
-- SELECT SUM(TotalPayment) AS Total_Amount_Collected 
-- FROM fact_loan
-- WHERE MONTH(issuedate) = 11

# Average Interest Rate
-- SELECT AVG(InterestRate)*100 AS Avg_Int_Rate 
-- FROM fact_loan

# MTD Average Interest
-- SELECT AVG(InterestRate)*100 AS MTD_Avg_Int_Rate 
-- FROM fact_loan
-- WHERE MONTH(issuedate) = 12;

# PMTD Average Interest
-- SELECT AVG(InterestRate)*100 AS MTD_Avg_Int_Rate 
-- FROM fact_loan
-- WHERE MONTH(issuedate) = 11;

# Avg Debt_To_Income Ratio
-- SELECT 
--     AVG(dc.DTI)*100 AS avg_dti
-- FROM Fact_Loan fl
-- JOIN Dim_Customer dc
--       ON fl.MemberID = dc.MemberID;

# MTD Avg Debt_To_Income Ratio 
-- SELECT 
--     AVG(dc.DTI)*100 AS avg_dti
-- FROM Fact_Loan fl
-- JOIN Dim_Customer dc
--       ON fl.MemberID = dc.MemberID
--       WHERE MONTH(issuedate)=12;

# PMTD Avg Debt_To_Income Ratio 
-- SELECT 
--     AVG(dc.DTI)*100 AS avg_dti
-- FROM Fact_Loan fl
-- JOIN Dim_Customer dc
--       ON fl.MemberID = dc.MemberID
--       WHERE MONTH(issuedate)=11;

# Good Loan Percentage
-- SELECT
--     (COUNT(CASE WHEN LoanStatus = 'Fully Paid' OR LoanStatus = 'Current' THEN LoanKey END) * 100.0) / 
-- 	COUNT(LoanKey) AS Good_Loan_Percentage
-- FROM fact_loan

# Good Loan Applications
-- SELECT COUNT(LoanKey) AS Good_Loan_Applications FROM fact_loan
-- WHERE loanstatus = 'Fully Paid' OR loanstatus = 'Current'

# Good Loan Funded Amount
-- SELECT SUM(LoanAmount) AS Good_Loan_Funded_amount FROM fact_loan
-- WHERE loanstatus = 'Fully Paid' OR loanstatus = 'Current'

# Good Loan Amount Received
-- SELECT SUM(TotalPayment) AS Good_Loan_amount_received FROM fact_loan
-- WHERE loanstatus = 'Fully Paid' OR loanstatus = 'Current'

# Bad Loan Percentage
-- SELECT
--     (COUNT(CASE WHEN LoanStatus = 'Charged Off' THEN 1 END) * 100.0) / 
-- 	COUNT(*) AS Bad_Loan_Percentage
-- FROM fact_loan

#Bad Loan Applications
-- SELECT COUNT(*) AS Bad_Loan_Applications FROM fact_loan
-- WHERE loanstatus = 'Charged Off'

# Bad Loan Funded Amount 
-- SELECT SUM(LoanAmount) AS Bad_Funded_Amount 
-- FROM fact_loan
-- WHERE LoanStatus= 'Charged off';

# Bad Loan Amount Received 
-- SELECT SUM(TotalPayment) AS Bad_Amount_Received 
-- FROM fact_loan
-- WHERE LoanStatus = 'Charged off';

# Loan Status 
-- SELECT
--         loanstatus,
--         COUNT(fl.Loankey) AS LoanCount,
--         SUM(fl.TotalPayment) AS Total_Amount_Received,
--         SUM(fl.LoanAmount) AS Total_Funded_Amount,
--         AVG(fl.InterestRate * 100) AS Interest_Rate,
--         AVG(dc.DTI *  100) AS DTI
--     FROM
--         fact_loan fl join dim_customer dc 
--         on fl.MemberID = dc.MemberID
--     GROUP BY
--         fl.LoanStatus


-- SELECT 
-- 	loanstatus, 
-- 	SUM(totalpayment) AS MTD_Total_Amount_Received, 
-- 	SUM(loanamount) AS MTD_Total_Funded_Amount 
-- FROM fact_loan
-- WHERE MONTH(issuedate) = 12 
-- GROUP BY loanstatus

# Month Wise Bank Loan Report 
-- SELECT 
--     MONTH(IssueDate) AS Month_Number,
--     MONTHNAME(IssueDate) AS Month_Name,
--     COUNT(LoanKey) AS Total_Loan_Applications,
--     SUM(LoanAmount) AS Total_Funded_Amount,
--     SUM(TotalPayment) AS Total_Amount_Received
-- FROM 
--     Fact_Loan
-- GROUP BY 
--     MONTH(IssueDate),
--     MONTHNAME(IssueDate)
-- ORDER BY 
--     MONTH(IssueDate);

# State Wise
-- SELECT 
-- 	ds.StateName AS State, 
-- 	COUNT(fl.LoanKey) AS Total_Loan_Applications,
-- 	SUM(fl.loanamount) AS Total_Funded_Amount,
-- 	SUM(fl.totalpayment) AS Total_Amount_Received
-- FROM fact_loan fl
-- JOIN dim_state ds
-- ON fl.AddressState = ds.StateCode
-- GROUP BY ds.StateName
-- ORDER BY ds.StateName

# Term wise Report 
-- SELECT 
-- 	term AS Term, 
-- 	COUNT(LoanKey) AS Total_Loan_Applications,
-- 	SUM(loanamount) AS Total_Funded_Amount,
-- 	SUM(totalpayment) AS Total_Amount_Received
-- FROM fact_loan
-- GROUP BY term
-- ORDER BY term


# Employee Length wise 
-- SELECT 
-- 	ds.EmpLength AS Employee_Length, 
-- 	COUNT(LoanKey) AS Total_Loan_Applications,
-- 	SUM(loanamount) AS Total_Funded_Amount,
-- 	SUM(totalpayment) AS Total_Amount_Received
-- FROM fact_loan fl
-- JOIN dim_customer ds
-- ON fl.MemberID = ds.MemberID
-- GROUP BY emplength
-- ORDER BY emplength

# Purpose Wise
-- SELECT 
-- 	purpose AS PURPOSE, 
-- 	COUNT(LoanKey) AS Total_Loan_Applications,
-- 	SUM(loanamount) AS Total_Funded_Amount,
-- 	SUM(totalpayment) AS Total_Amount_Received
-- FROM fact_loan
-- GROUP BY purpose
-- ORDER BY purpose

# HomeOwnership 
SELECT 
	dc.homeownership AS Home_Ownership, 
	COUNT(LoanKey) AS Total_Loan_Applications,
	SUM(loanamount) AS Total_Funded_Amount,
	SUM(totalpayment) AS Total_Amount_Received
FROM fact_loan fl
JOIN dim_customer dc
ON fl.MemberID = dc.MemberID
GROUP BY dc.homeownership
ORDER BY dc.homeownership;

# Grade Wise 
SELECT 
	Grade AS Grades,
    COUNT(loankey) as Total_Loan_Applications, 
    SUM(LoanAmount) as Total_Funded_Amount, 
    SUM(TotalPayment) as Total_Amount_Received 
FROM fact_loan
GROUP BY Grade
ORDER BY Grade



