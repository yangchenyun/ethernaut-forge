// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;


import "./11_elevator.sol";

contract MyBuilding is Building {
  uint public constant TOP_FLOOR = 42;
  Elevator elevator;

  constructor(address _addr) public {
      if (_addr != address(0)) {
          elevator = Elevator(_addr);
      } else {
          elevator = new Elevator();
      }
  }

  function isLastFloor(uint _floor) override external returns (bool) {
      return _floor == 42;
  }

  function goTo(uint _floor) public {
      elevator.goTo(_floor);
  }

  function getFloor() public view returns ( uint ) {
      return elevator.floor();
  }

  function atTop() public view returns ( bool ) {
      return elevator.top();
  }
}

// The WeirdBuilding is aware of block state and could work with the broken
// elevator.
contract WeirdBuilding is Building {
  uint public constant TOP_FLOOR = 42;
  uint blockNumber;
  Elevator elevator;

  constructor(address _addr) public {
      if (_addr != address(0)) {
          elevator = Elevator(_addr);
      } else {
          elevator = new Elevator();
      }
      blockNumber = 2**256 - 1;
  }

  function isLastFloor(uint _floor) override external returns (bool) {
      require(_floor <= 42, "Floor is over the top.");

      if (_floor < 42) {
          return false;
      }
      assert(_floor == 42);
      // NOTE: in the same block, if called twice returns different result.
      if (blockNumber != block.number) {
          blockNumber = block.number;
          return false;
      } else {
          return true;
      }
  }

  function goTo(uint _floor) public {
      elevator.goTo(_floor);
  }

  function getFloor() public view returns ( uint ) {
      return elevator.floor();
  }

  function atTop() public view returns ( bool ) {
      return elevator.top();
  }
}
