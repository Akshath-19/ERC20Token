🚀 RCB Token (ERC20)

An ERC20 token smart contract built using Foundry and OpenZeppelin.
This project is for learning ERC20 development, testing, and deployment.

📦 Project Setup

Clone this repo

git clone <your-repo-url>
cd ERC20Token


Install Foundry (if not installed)

curl -L https://foundry.paradigm.xyz | bash
foundryup


Install dependencies

forge install OpenZeppelin/openzeppelin-contracts


Check remappings
Make sure remappings.txt contains:

@openzeppelin/=lib/openzeppelin-contracts/

📝 Contract

src/MyToken.sol

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract MyToken is ERC20 {
    constructor(uint256 initialSupply) ERC20("RCB", "CHAMPION") {
        _mint(msg.sender, initialSupply * 10 ** decimals());
    }
}

🧪 Testing
Run all tests
forge test -vv

Example Tests

Metadata: Checks token name, symbol, decimals, supply

Transfer: Ensure balance updates correctly

Approve/Allowance: Validate ERC20 approvals

TransferFrom: Test delegated transfers

Reverts: Invalid operations should fail

🛠 VS Code Setup (Optional)

If you see errors like:
Source not found: File import callback not supported (6275)

➡ Fix by adding in .vscode/settings.json:

{
  "solidity.remappings": [
    "@openzeppelin/=lib/openzeppelin-contracts/"
  ]
}


Or install Foundry Solidity Language Server.

📜 License

MIT
