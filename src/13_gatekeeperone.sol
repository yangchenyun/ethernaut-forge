// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

import '@openzeppelin/contracts/math/SafeMath.sol';

contract GatekeeperOne {

  using SafeMath for uint256;
  address public entrant;

  // Invoked from a contract which is called by signer
  modifier gateOne() {
    require(msg.sender != tx.origin, "gateOne failed");
    _;
  }

  // Called with the specific gas
  modifier gateTwo() {
    require(gasleft().mod(8191) == 0, "gateTwo failed");
    _;
  }

  modifier gateThree(bytes8 _gateKey) {
      // high-order bits are cut off
      // 0xffff ffff ffff ffff
      //             ^^^^      <- is zero
      //   ^^^^ ^^^^ <- is not zero
      //                  ^^^^ <- comes from origin
      require(uint32(uint64(_gateKey)) == uint16(uint64(_gateKey)), "GatekeeperOne: invalid gateThree part one");
      require(uint32(uint64(_gateKey)) != uint64(_gateKey), "GatekeeperOne: invalid gateThree part two");
      require(uint32(uint64(_gateKey)) == uint16(tx.origin), "GatekeeperOne: invalid gateThree part three");
    _;
  }

  function enter(bytes8 _gateKey) public gateOne gateTwo gateThree(_gateKey) returns (bool) {
    entrant = tx.origin;
    return true;
  }
}
