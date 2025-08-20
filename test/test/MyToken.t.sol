// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import {MyToken} from "../../src/MyToken.sol";

contract MyTokenTest is Test {
    MyToken token;
    address alice = address(0x1);
    address bob   = address(0x2);

    function setUp() public {
        token = new MyToken(1000, 10000); // ✅ initialSupply = 1000, cap = 10000
 // deploy with 1000 tokens
    }

    function testInitialSupply() public view {
        assertEq(token.totalSupply(), 1000 * 10 ** token.decimals());
    }

    function testTransfer() public {
        token.transfer(alice, 100);
        assertEq(token.balanceOf(alice), 100);
    }

    function testTransferFromWithAllowance() public {
        token.approve(alice, 200);                  // owner approves
        vm.prank(alice);                            // alice calls
        token.transferFrom(address(this), bob, 100);
        assertEq(token.balanceOf(bob), 100);
    }

    function test_Revert_TransferWithoutEnoughAllowance() public {
        vm.expectRevert(); // should fail because no approve
        token.transferFrom(address(this), bob, 100);
    }

    function test_Revert_TransferWithoutEnoughBalance() public {
        vm.expectRevert(); // bob has 0 tokens, can’t send 50
        vm.prank(bob);
        token.transfer(alice, 50);
    }
}
