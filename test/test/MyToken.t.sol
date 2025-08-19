// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import {MyToken} from "../../src/MyToken.sol"; 
contract MyTokenTest is Test {
    MyToken token;

    function setUp() public {
        token = new MyToken(1000); // 1000 tokens initial supply
    }

    function testNameAndSymbol() public view {
        assertEq(token.name(), "MyToken");
        assertEq(token.symbol(), "MTK");
    }

    function testInitialSupply() public view {
        assertEq(token.totalSupply(), 1000 * 10 ** token.decimals());
    }

    function testTransfer() public {
        address receiver = address(0xBEEF);
        token.transfer(receiver, 100 * 10 ** token.decimals());
        assertEq(token.balanceOf(receiver), 100 * 10 ** token.decimals());
    }
}
