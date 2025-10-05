// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;
// pragma solidity >=0.8.18 <0.9.0;

contract SimpleStorage {
    // Basic Types: boolean, uint, int, address, bytes
    // bool hasFavNum = true;
    // uint256 favNum = 88; // 256 bits (unisgned int), max is 256 (default too), default initialisation value = 0
    // int256 favNumber = -88;
    // string favNumInText = "88";
    // address favAddress = 0x0000000000000000000000000000000000000000;
    // bytes32 favBytes = "cat"; // 32 is max

    // default visibility -> internal
    // view, pure -> don't have to send a tx to run
    // only sending a call not a tx

    uint256 public favNum; // 0
    uint256[] favNums;

    struct Person {
        uint256 my_fav_num;
        string name;
    }

    Person public my_friend = Person({
        my_fav_num: 33,
        name: "Paul"
    });

    Person[] public list_of_peoples;

    // Mapping
    mapping(string => uint256) public nameToFavNum;
    
    function store(uint256 _favNum) public {
        favNum = _favNum;
    }

    // since "view" thus can't modify state
    // "pure" disallow modification as well as reading of state from storage
    function retrieve() public view returns(uint256) {
        return favNum;
    }

    // calldata, memory, storage
    function add_person(string memory _name, uint256 _my_fav_num) public {
        list_of_peoples.push(Person(_my_fav_num, _name));
        nameToFavNum[_name] = _my_fav_num;
    }
}