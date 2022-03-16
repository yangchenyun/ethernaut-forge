// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

import "ds-test/test.sol";
import "../10_reentrancy.sol";
import "../10_reentrancy_hack.sol";

interface CheatCodes {
    function deal(address who, uint256 newBalance) external;
    function prank(address) external;
}

contract HackReentrancyTest is DSTest {

    Reentrance public target;
    ReentryAttack public  attacker;
    CheatCodes cheats = CheatCodes(HEVM_ADDRESS);

    constructor() public {
        target = new Reentrance();
        attacker = new ReentryAttack(address(target));
    }

    function testDrainBalance() public {
        address victim1 = address(0x01);
        address victim2 = address(0x02);

        cheats.deal(victim1, 0.49 ether);
        cheats.deal(victim2, 0.51 ether);
        cheats.deal(address(this), 0.1 ether);

        cheats.prank(victim1);
        target.donate{value: 0.49 ether}(victim1);
        assertEq(target.balanceOf(victim1), 0.49 ether);

        cheats.prank(victim2);
        target.donate{value: 0.51 ether}(victim2);
        assertEq(target.balanceOf(victim2), 0.51 ether);

        target.donate{value: 0.1 ether}(address(attacker));
        assertEq(target.balanceOf(address(attacker)), 0.1 ether);

        assertEq(address(target).balance, 1.1 ether);
        attacker.attack();
        assertEq(address(target).balance, 0);
    }
}
