// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "./SafeMath.sol";

/**
 * @title LoanContract
 * @dev Implementation of a contract for managing crypto-backed loans
 */
contract LoanContract is Ownable {
    using SafeMath for uint256;

    struct Loan {
        uint256 id;
        address borrower;
        uint256 amount;
        uint256 collateralAmount;
        uint256 dueDate;
        bool isRepaid;
    }

    uint256 public nextLoanId;
    uint256 public interestRate; // Annual interest rate, e.g., 500 for 5.00%
    uint256 public loanDuration;
    uint256 public collateralRequirement; // Collateral requirement in percentage of loan amount

    mapping(uint256 => Loan) public loans;
    mapping(address => uint256[]) public loansByBorrower;

    event LoanCreated(uint256 indexed loanId, address indexed borrower, uint256 amount, uint256 collateralAmount, uint256 dueDate);
    event LoanRepaid(uint256 indexed loanId, address indexed borrower);

    constructor(uint256 _interestRate, uint256 _loanDuration, uint256 _collateralRequirement) Ownable(msg.sender) {
        interestRate = _interestRate;
        loanDuration = _loanDuration;
        collateralRequirement = _collateralRequirement;
        nextLoanId = 1;
    }

    /**
     * @dev Create a new loan
     * @param amount The amount of ETH borrowed
     */
    function createLoan(uint256 amount) external payable {
        uint256 collateralAmount = amount.mul(collateralRequirement).div(100);
        require(msg.value == collateralAmount, "Incorrect collateral amount");

        uint256 dueDate = block.timestamp.add(loanDuration);
        loans[nextLoanId] = Loan(nextLoanId, msg.sender, amount, collateralAmount, dueDate, false);
        loansByBorrower[msg.sender].push(nextLoanId);

        emit LoanCreated(nextLoanId, msg.sender, amount, collateralAmount, dueDate);
        nextLoanId++;
    }

    /**
     * @dev Repay a loan
     * @param loanId The ID of the loan being repaid
     */
    function repayLoan(uint256 loanId) external payable {
        Loan storage loan = loans[loanId];
        require(msg.sender == loan.borrower, "Only the borrower can repay the loan");
        require(!loan.isRepaid, "Loan is already repaid");
        require(msg.value == loan.amount, "Repayment amount must match the loan amount");

        loan.isRepaid = true;
        payable(loan.borrower).transfer(loan.collateralAmount);

        emit LoanRepaid(loanId, loan.borrower);
    }

    /**
     * @dev Get loans by borrower
     * @param borrower The address of the borrower
     * @return An array of loan IDs
     */
    function getLoansByBorrower(address borrower) external view returns (uint256[] memory) {
        return loansByBorrower[borrower];
    }

    /**
     * @dev Fetch all loans
     * @return array of all loans
     */
    function fetchAllLoans() public view returns (Loan[] memory) {
        Loan[] memory allLoans = new Loan[](nextLoanId - 1);
        for (uint i = 1; i < nextLoanId; i++) {
            Loan storage loan = loans[i];
            allLoans[i - 1] = loan;
        }
        return allLoans;
    }
}
