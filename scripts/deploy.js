// Import ethers from Hardhat package
const { ethers } = require("hardhat");

async function main() {
    // We get the contract to deploy
    const LoanContract = await ethers.getContractFactory("LoanContract");

    // Set up initial parameters
    const interestRate = 300; // Representing 3.00%
    const loanDuration = 24 * 60 * 60; // 1 day in seconds
    const collateralRequirement = 150; // 150% of the loan amount

    // Deploy the contract with the initial setup
    const loanContract = await LoanContract.deploy(interestRate, loanDuration, collateralRequirement);

    // Wait for the contract to be deployed
    await loanContract.deployed();

    console.log("LoanContract deployed to:", loanContract.address);
}

// Call the main function and catch if there is any error
main()
    .then(() => process.exit(0))
    .catch(error => {
        console.error(error);
        process.exit(1);
    });
