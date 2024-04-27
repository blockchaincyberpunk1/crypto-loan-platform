# Crypto Loan Platform Smart Contract

[![License](https://img.shields.io/static/v1?label=License&message=MIT&color=blue)](https://opensource.org/licenses/MIT)
![GitHub repo size](https://img.shields.io/github/repo-size/blockchaindeveloper/crypto-loan-platform)
![GitHub top language](https://img.shields.io/github/languages/top/blockchaindeveloper/crypto-loan-platform)

## Table Of Content

- [Crypto Loan Platform Smart Contract](#crypto-loan-platform-smart-contract)
  - [Table Of Content](#table-of-content)
  - [Description](#description)
  - [Smart Contract Features](#smart-contract-features)
  - [Technology](#technology)
  - [Installation](#installation)
  - [Usage](#usage)
  - [Contribution](#contribution)
  - [Contact](#contact)
  - [License](#license)

## Description

The Crypto Loan Platform Smart Contract is designed for the Ethereum blockchain and enables a decentralized application to manage crypto-backed loans efficiently and securely. This smart contract allows users to engage in borrowing and lending operations underpinned by cryptocurrency collateral, leveraging Ethereum's secure environment to ensure transparency and reliability.

## Smart Contract Features

- **Loan Management**: Users can create new loans, repay loans, and view loan details.
- **Collateral Handling**: Manages collateral in Ethereum, ensuring loans are backed by digital assets.
- **Events**: Emit events for loan creation, repayment, and changes in loan status, facilitating frontend interaction and external integrations.

## Technology

- **Solidity**: Smart contracts are written in Solidity, Ethereum's native language.
- **Harhdat**: Utilized for compiling, migrating, and testing smart contracts.
- **Ethers.js**: A collection of libraries that allow for interaction with a local or remote ethereum node.

## Installation

To set up and deploy the smart contract locally:

1. **Clone the repository**:
   ```bash
   git clone https://github.com/blockchaindeveloper/crypto-loan-platform.git
   cd crypto-loan-platform
   ```
2. **Install dependencies**:
   ```bash
   npm install
   ```
3. **Compile the contract**:
    ```bash
    npx hardhat compile
   ```
4. **Deploy to a test network (e.g., Sepolia)**:
    ```bash
    npx hardhat run scripts/deploy.js --network sepolia
   ```


## Usage

To interact with the smart contract:

- **Creating a Loan**: Call the createLoan function specifying the loan amount and collateral.
- **Repaying a Loan**: Use the repayLoan function with the specific loan ID.
- **Querying a Loan**: Access detailed loan information using the getLoanDetails function.


## Contribution
 
Contributions are welcome! Please feel free to submit any issues or pull requests.


## Contact

Feel free to reach out to me on my email:
thepolyglot8@gmail.com


## License

[![License](https://img.shields.io/static/v1?label=Licence&message=MIT&color=blue)](https://opensource.org/license/MIT)

LoanContract deployed to: 0x4c61042B54E14CE4D69758d47C9fC379aB6bF565

LoanContract deployed to: 0xdeD1a7d1Cbe66523cd5dD7e27DE5A177fa182de5