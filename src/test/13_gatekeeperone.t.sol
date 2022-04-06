// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

import "ds-test/test.sol";
import "../13_gatekeeperone.sol";
import "../13_gatekeeperone_hack.sol";

interface CheatCodes {
    function roll(uint256) external;
    function expectRevert(bytes calldata msg) external;
}

contract GateOpenerOneTest is DSTest {
    CheatCodes cheats = CheatCodes(HEVM_ADDRESS);
    GatekeeperOne target;

    constructor() public {
        target = new GatekeeperOne();
    }

    // How to print reverted reason
    function testOpenGateOne() public {
        GateOpenerOne attacker;
        attacker = new GateOpenerOne(address(target));

        uint gas = 100000;
        assertTrue(attacker.attack{gas: gas + 706 }());

        // HACK: find the gas needed by iterating.
        // for (uint i = 0; i < 8191; i++) {
        //     console.logUint(i);
        //     cheats.expectRevert(bytes("gateTwo failed"));
        //     attacker.attack{gas: gas + i }();
        // }
    }
}
