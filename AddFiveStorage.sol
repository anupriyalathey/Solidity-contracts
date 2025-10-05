// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {SimpleStorage} from "./SimpleStorage.sol";

contract AddFiveStorage is SimpleStorage {
    // Inheritance
    // pure -> not view
    function sayHello() public pure returns(string memory) {
        return "Hello";
    }
    // +5
    // overrides
    // virtual override
    function store(uint256 _newNum) public override {
        myFavoriteNumber = _newNum +5;
    }
}