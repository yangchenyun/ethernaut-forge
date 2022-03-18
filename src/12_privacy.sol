// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

// Storage Layout:
// - Each slot is 32 bytes
// - Data is stored insequence
// - Neighboring data is packed into one slot

contract Privacy {
  // slot 0, takes 256 bits
  bool public locked = true;
  // slot 1
  uint256 public ID = block.timestamp;
  // slot 2, packed
  uint8 private flattening = 10;
  uint8 private denomination = 255;
  uint16 private awkwardness = uint16(now);

  // slot 3, 4, 5
  bytes32[3] private data;

  constructor(bytes32[3] memory _data) public {
    data = _data;
  }
  function unlock(bytes16 _key) public {
    // NOTE:  `bytes16` will truncate at the end.
    require(_key == bytes16(data[2]));
    locked = false;
  }

  /*
    A bunch of super advanced solidity algorithms...

      ,*'^`*.,*'^`*.,*'^`*.,*'^`*.,*'^`*.,*'^`
      .,*'^`*.,*'^`*.,*'^`*.,*'^`*.,*'^`*.,*'^`*.,
      *.,*'^`*.,*'^`*.,*'^`*.,*'^`*.,*'^`*.,*'^`*.,*'^         ,---/V\
      `*.,*'^`*.,*'^`*.,*'^`*.,*'^`*.,*'^`*.,*'^`*.,*'^`*.    ~|__(o.o)
      ^`*.,*'^`*.,*'^`*.,*'^`*.,*'^`*.,*'^`*.,*'^`*.,*'^`*.,*'  UU  UU
  */
}
