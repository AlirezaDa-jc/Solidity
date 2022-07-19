pragma solidity ^0.8.13;
// SPDX-License-Identifier: D.a
// send and Withdraw from smart Contract
contract SendAndReceiveMoney{
    
    function receiveMoney() public payable{

    }

    function getBalance() public view returns(uint){
        return address(this).balance;
    }

    function withdraw() public{
        address payable to = payable(msg.sender);
        to.transfer(this.getBalance());
    }

    function withdraw(address payable to) public{
        to.transfer(this.getBalance());
    }
}