    // SPDX-License-Identifier: MIT
    pragma solidity ^0.8.20;

// If using Foundry, ensure forge-std is installed via: forge install foundry-rs/forge-std
import "forge-std/Test.sol";
import {MyToken} from "src/MyToken.sol";


    // ...existing code...

    contract MyTokenTest is Test {
        MyToken token;
        address owner = address(this);
        address spender = address(0xBEEF);
        address receiver = address(0xCAFE);

        function setUp() public {
            token = new MyToken(1000); // initial supply = 1000 MTK
        }

        function testNameAndSymbol() public view {
            assertEq(token.name(), "RCB");
            assertEq(token.symbol(), "MTK");
        }

        function testInitialSupply() public view {
            assertEq(token.totalSupply(), 1000 * 10 ** token.decimals());
        }

        function testTransfer() public {
            token.transfer(spender, 100 * 10 ** token.decimals());
            assertEq(token.balanceOf(spender), 100 * 10 ** token.decimals());
        }

        // ----------- Day 3 New Tests -----------

        function testApproveAndAllowance() public {
            token.approve(spender, 200 * 10 ** token.decimals());
            assertEq(token.allowance(owner, spender), 200 * 10 ** token.decimals());
        }

        function testTransferFromWithAllowance() public {
            token.approve(spender, 100 * 10 ** token.decimals());
            vm.prank(spender);
            token.transferFrom(owner, receiver, 100 * 10 ** token.decimals());
            assertEq(token.balanceOf(receiver), 100 * 10 ** token.decimals());
        }

        function test_Revert_TransferWithoutEnoughAllowance() public {
            vm.prank(spender);
            vm.expectRevert(); // expect revert since no allowance
            token.transferFrom(owner, receiver, 50 * 10 ** token.decimals());
        }

        function test_Revert_TransferWithoutEnoughBalance() public {
            vm.startPrank(spender);
            token.approve(spender, 5000 * 10 ** token.decimals()); // give allowance first
            vm.expectRevert(); // expect revert due to insufficient balance
            token.transferFrom(owner, receiver, 5000 * 10 ** token.decimals());
            vm.stopPrank();
        }

    }
