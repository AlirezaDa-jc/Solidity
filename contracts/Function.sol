pragma solidity ^0.8.13;

contract Function{
     uint256 public myUint;

     function setMyUint(uint _myUint) public{
        myUint = _myUint;
    }

     bool public myBoolean;

     function setMyBool(bool _myBoolean) public{
        myBoolean = _myBoolean;
    }

    address public myAddress;

    function setAddress(address _address) public{
        myAddress = _address;
    }

    function getBalanceOfAddress() public view returns(uint){
        return myAddress.balance;
    }

    function incrementUint() public{
        myUint++;
    }

    function decrementUint() public{
        myUint--;
    }

    string public myString;

    function setMyString(string memory _myString) public{
        myString = _myString;
    }
}