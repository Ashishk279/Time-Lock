// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract TimeLock {
     address public owner;
     uint256 public lockTime = 1 minutes;
     uint256 public startTime;

     modifier onlyBy(address _account) {
         require(msg.sender == _account, "Unauthorized");
         _;
     }

     constructor() {
         owner = msg.sender;
         startTime = block.timestamp;
     }

     function deposite() external payable {}

     function withdraw() public onlyBy(owner) {
         require(block.timestamp >= startTime + lockTime, "Lock time not reached");
         (bool success, ) = payable (owner).call{value:address(this).balance}("");
         require(success, "Transfer failed");

     }

   

}