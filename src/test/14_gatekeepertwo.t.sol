// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

import "ds-test/test.sol";
import "../14_gatekeepertwo.sol";
import "../14_gatekeepertwo_hack.sol";

import "forge-std/console.sol";

contract GateOpenerTwoTest is DSTest {
    GatekeeperTwo target;

    constructor() public {
        target = new GatekeeperTwo();
    }

    function testOpenGateTwo() public {
        GateOpenerTwo attacker;
        attacker = new GateOpenerTwo(address(target));
        assertTrue(target.entrant() != address(0));

        // TODO: why?
        // assertTrue(target.entrant() == address(this));
    }
}
