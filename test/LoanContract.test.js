const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("LoanContract", function () {
  let loanContract;
  let owner;
  let borrower;
  let anotherAccount;

  beforeEach(async function () {
    [owner, borrower, anotherAccount] = await ethers.getSigners();

    const LoanContract = await ethers.getContractFactory("LoanContract");
    // Deploy the contract with the updated initial parameters
    loanContract = await LoanContract.deploy(300, 24 * 60 * 60, 150);
    await loanContract.deployed();
  });

  describe("Deployment", function () {
    it("Should set the right owner", async function () {
      expect(await loanContract.owner()).to.equal(owner.address);
    });

    it("Initial values are set correctly", async function () {
      expect(await loanContract.interestRate()).to.equal(300);
      expect(await loanContract.loanDuration()).to.equal(24 * 60 * 60);
      expect(await loanContract.collateralRequirement()).to.equal(150);
    });
  });

  describe("Loan Operations", function () {
    it("Should create a loan with correct parameters", async function () {
      const amount = ethers.utils.parseEther("1.0");
      const collateralRequired = amount.mul(150).div(100);

      await expect(borrower.sendTransaction({
        to: loanContract.address,
        value: collateralRequired,
        data: loanContract.interface.encodeFunctionData("createLoan", [amount])
      })).to.emit(loanContract, "LoanCreated");

      const loan = await loanContract.loans(1);
      expect(loan.borrower).to.equal(borrower.address);
      expect(loan.amount).to.equal(amount);
      expect(loan.collateralAmount).to.equal(collateralRequired);
    });

    it("Should fail to create a loan with insufficient collateral", async function () {
      const amount = ethers.utils.parseEther("1.0");
      const insufficientCollateral = amount.mul(100).div(100); // Only 100% instead of 150%

      await expect(borrower.sendTransaction({
        to: loanContract.address,
        value: insufficientCollateral,
        data: loanContract.interface.encodeFunctionData("createLoan", [amount])
      })).to.be.revertedWith("Incorrect collateral amount");
    });

    it("Should allow the borrower to repay the loan", async function () {
      // First create a loan
      const amount = ethers.utils.parseEther("1.0");
      const collateralRequired = amount.mul(150).div(100);

      await borrower.sendTransaction({
        to: loanContract.address,
        value: collateralRequired,
        data: loanContract.interface.encodeFunctionData("createLoan", [amount])
      });

      // Now repay it
      await expect(borrower.sendTransaction({
        to: loanContract.address,
        value: amount,
        data: loanContract.interface.encodeFunctionData("repayLoan", [1])
      })).to.emit(loanContract, "LoanRepaid");

      const loan = await loanContract.loans(1);
      expect(loan.isRepaid).to.be.true;
    });

    it("Should fail to repay the loan if not the borrower", async function () {
      const amount = ethers.utils.parseEther("1.0");
      const collateralRequired = amount.mul(150).div(100);

      await borrower.sendTransaction({
        to: loanContract.address,
        value: collateralRequired,
        data: loanContract.interface.encodeFunctionData("createLoan", [amount])
      });

      await expect(anotherAccount.sendTransaction({
        to: loanContract.address,
        value: amount,
        data: loanContract.interface.encodeFunctionData("repayLoan", [1])
      })).to.be.revertedWith("Only the borrower can repay the loan");
    });

    it("Should fail to repay the loan if already repaid", async function () {
      const amount = ethers.utils.parseEther("1.0");
      const collateralRequired = amount.mul(150).div(100);

      await borrower.sendTransaction({
        to: loanContract.address,
        value: collateralRequired,
        data: loanContract.interface.encodeFunctionData("createLoan", [amount])
      });

      // Repay once
      await borrower.sendTransaction({
        to: loanContract.address,
        value: amount,
        data: loanContract.interface.encodeFunctionData("repayLoan", [1])
      });

      // Attempt to repay again
      await expect(borrower.sendTransaction({
        to: loanContract.address,
        value: amount,
        data: loanContract.interface.encodeFunctionData("repayLoan", [1])
      })).to.be.revertedWith("Loan is already repaid");
    });
  });

  describe("Querying Loans", function () {
    it("Should get loans by borrower", async function () {
      const amount = ethers.utils.parseEther("1.0");
      const collateralRequired = amount.mul(150).div(100);

      await borrower.sendTransaction({
        to: loanContract.address,
        value: collateralRequired,
        data: loanContract.interface.encodeFunctionData("createLoan", [amount])
      });

      const loanIds = await loanContract.getLoansByBorrower(borrower.address);
      expect(loanIds.length).to.equal(1);
      expect(loanIds[0]).to.equal(1);
    });
  });
});
