// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {PriceConverter} from "./PriceConverter.sol";

error NotOwner();

contract FundMe {
    using PriceConverter for uint256; // To use the imported library here for all uint256 

    // "constant" keyword -> gas efficient
    uint256 public constant MIN_USD = 5e18;

    address[] public funders;
    mapping(address funder => uint256 amountFunded) public addressToAmountFunded;

    // "immutable" keyword -> gas efficient
    address public immutable i_owner;
    constructor() {
        i_owner = msg.sender;
    }

    uint256 public myValue = 1;
    // payable -> contract accepts eth
    function fund() public payable{
        msg.value.getConversionRate();

        // require(msg.value > 1e18, "Didn't send enough ETH"); // 1e18 = 1 ETH = 1000000000000000000 wei = 1 * 10 ** 18

        require(msg.value.getConversionRate() >= MIN_USD, "Didn't send enough ETH"); 
       funders.push(msg.sender);
       addressToAmountFunded[msg.sender] += msg.value;

       // What is a revert?
       // Undo any actions that have been done, and send the remaining gas back

       // For a failed tx too, gas will be spent
    }

    function withdraw() public onlyOwner{
        for(uint256 funderIndex = 0; funderIndex < funders.length; funderIndex++) {
            address funder = funders[funderIndex];
            addressToAmountFunded[funder] = 0;
        }
        funders = new address[](0);

        // To send tokens from different contracts to each other:-

        // 1. transfer
        // payable(msg.sender).transfer(address(this).balance);

        // 2. send
        // bool sendSuccess = payable(msg.sender).send(address(this).balance);
        // require(sendSuccess, "Send failed");

        // 3. call (recommended)
        (bool callSuccess,) = payable(msg.sender).call{value: address(this).balance}("");
        require(callSuccess, "Call failed");
    }   

    // modifier will execute "require" first then _; means anything else in the function will get executed
    modifier onlyOwner() {
        // require(msg.sender == i_owner, "Sender is not owner");
        if(msg.sender != i_owner) { revert NotOwner(); } // gas efficient
        _;
    }

    // if someone sends this contract money without calling the fund() fn below function gets called
    receive() external payable {
        fund();
    }

    fallback() external payable {
        fund();
    }
}