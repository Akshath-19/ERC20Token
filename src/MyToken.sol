// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";
import "openzeppelin-contracts/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "openzeppelin-contracts/contracts/token/ERC20/extensions/ERC20Capped.sol";
import "openzeppelin-contracts/contracts/access/Ownable.sol";

contract MyToken is ERC20, ERC20Burnable, ERC20Capped, Ownable {
    constructor(
        uint256 initialSupply,
        uint256 cap
    ) ERC20("MyToken", "MTK") ERC20Capped(cap) Ownable() {
        _mint(msg.sender, initialSupply * 10 ** decimals());
    }

    // override _mint from ERC20Capped
    function _mint(address account, uint256 amount) internal override(ERC20, ERC20Capped) {
        super._mint(account, amount);
    }
}