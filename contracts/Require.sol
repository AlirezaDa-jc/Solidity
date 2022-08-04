pragma solidity ^0.8.13;
// SPDX-License-Identifier: D.a
contract Require{

    modifier checkOwner(){
        require(owner == msg.sender , "You Are Not Owner");
        _;
    }

    struct Payment{
        uint amount;
        uint time;
    }
    
    struct Balance {
        uint totalBalance;
        // Arrays Cost To Much Gas , Mapping Uses Less
        //Payment[] payments;
        uint numPayments;
        mapping(uint => Payment) payments;
    }

    address owner;
    bool public paused;
    mapping(address => Balance) public senderAddresses;

    constructor() {
        owner = msg.sender;
    }
    

    function receiveMoney() public payable{
        require(!paused , "Paused");
        assert(senderAddresses[msg.sender].totalBalance + uint64(msg.value) >= senderAddresses[msg.sender].totalBalance);
        senderAddresses[msg.sender].totalBalance += uint64(msg.value);
        Payment memory payment =  Payment(msg.value,block.timestamp);
        senderAddresses[msg.sender].payments[senderAddresses[msg.sender].numPayments] = payment;
        senderAddresses[msg.sender].numPayments++;
    }

    function setPaused(bool _paused) public {
        require(owner == msg.sender , "You Are Not Owner");
        paused = _paused;
    }

    function getBalance() public view returns(uint){
        return address(this).balance;
    }

    function withdraw() public{
        require(!paused , "Paused");
        address payable to = payable(msg.sender);
        to.transfer(senderAddresses[msg.sender].totalBalance);
        senderAddresses[msg.sender].totalBalance = 0;
    }

    function withdrawAmount(uint amount) public{
        require(!paused , "Paused");
        address payable to = payable(msg.sender);
        require(senderAddresses[to].totalBalance >= amount , "Not Enough Funds");
        to.transfer(amount);
        senderAddresses[msg.sender].totalBalance -= amount;
    }

    function withdrawToAnotherAddressWithAmount(address payable to , uint amount) public{
        require(senderAddresses[to].totalBalance >= amount , "Not Enough Funds");
        require(owner == msg.sender , "You Are Not Owner");
        require(!paused , "Paused");
        to.transfer(amount);
        senderAddresses[msg.sender].totalBalance -= amount;
    }

    function withdrawToAnotherAddress(address payable to) public checkOwner{
        require(!paused , "Paused");
        to.transfer(this.getBalance());
    }

    function destroyThis (address payable _to) public checkOwner {
        selfdestruct(_to);
    }

    function towei(uint256 amount) public pure returns(uint256){
        return amount * 1 ether;
    }
}