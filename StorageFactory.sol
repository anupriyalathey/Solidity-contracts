// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

// import {SimpleStorage, SimpleStorage2} from "./SimpleStorage.sol";
import {SimpleStorage} from "./SimpleStorage.sol";

contract StorageFactory {

    // type visibility name
    // "public" keyword automatically gives the variable name a "getter" or "view" function

    // SimpleStorage public simpleStorage;
    SimpleStorage[] public listOfSimpleStorageContracts;


    function createSimpleStorageContract() public {
        // simpleStorage = new SimpleStorage();
        SimpleStorage newSimpleStorageContract = new SimpleStorage();
        listOfSimpleStorageContracts.push(newSimpleStorageContract);
    }

    function sfStore(uint256 _simpleStorageIndex, uint256 _newSimpleStorageNumber) public {
        // To interact with a contract always need these 2 things:
        // 1. Address
        // 2. ABI - Application Binary Interface (technically a lie, you just need the function selector)
        // Compiler will know the ABI since it generated it, and we know the addresses since we kept a list to track
        listOfSimpleStorageContracts[_simpleStorageIndex].store(_newSimpleStorageNumber);
        // SimpleStorage(address)
    }

    function sfGet(uint256 _simpleStorageIndex) public view returns(uint256) {
        return listOfSimpleStorageContracts[_simpleStorageIndex].retrieve();
    }
}