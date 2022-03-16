// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

import "ds-test/test.sol";
import "../11_elevator.sol";
import "../11_elevator_hack.sol";

interface CheatCodes {
    function roll(uint256) external;
}

contract HackElevatorTest is DSTest {
    CheatCodes cheats = CheatCodes(HEVM_ADDRESS);

    function testGoTo() public {
        MyBuilding b;
        b = new MyBuilding(address(0));
        assertEq(b.getFloor(), 0);
        assertTrue(!b.atTop());
        b.goTo(10);
        assertEq(b.getFloor(), 10);
        assertTrue(!b.atTop());
    }

    function testCannotGoToTop() public {
        MyBuilding b;
        b = new MyBuilding(address(0));
        assertEq(b.getFloor(), 0);
        assertTrue(!b.atTop());
        b.goTo(b.TOP_FLOOR());
        assertTrue(!b.atTop());
        assertLe(b.getFloor(), b.TOP_FLOOR());
    }

    function testCouldGoToTop() public {
        WeirdBuilding b;
        b = new WeirdBuilding(address(0));
        assertEq(b.getFloor(), 0);
        assertTrue(!b.atTop());
        b.goTo(b.TOP_FLOOR());
        assertTrue(b.atTop());
        assertEq(b.getFloor(), b.TOP_FLOOR());
    }
}
