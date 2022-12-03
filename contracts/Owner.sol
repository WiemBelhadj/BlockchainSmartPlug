// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

//import "contracts/Car.sol";

contract Owner {

    uint id;
    address private owner;
    constructor() {    
        owner = msg.sender; 
    }
    struct OwnerProfile {
        string name;
        string email;
        string pwd;
        //Car car;
    }    
      

    OwnerProfile private ownerprofile; 

    event OwnerSet(address indexed oldOwner, address indexed newOwner);
    //Requirments
    modifier isOwner() {
        require(msg.sender == owner, "Caller is not car");
        _;
    }
    function changeOwner(address newOwner) public isOwner {
        owner = newOwner;
        emit OwnerSet(owner, newOwner);
        
    }
    function getOwner() external view returns (address) {
        return owner;
    }


    
    function getName() public view returns (string memory) {
        return ownerprofile.name;
    }
     function setName(string memory  _name) public{
        ownerprofile.name=_name;
    }
    function getEmail() public view returns (string memory) {
        return ownerprofile.email;
    }
    function setEmail(string memory  _email) public{
        ownerprofile.email=_email;
    }
    function getpwd() public view returns (string memory) {
        return ownerprofile.pwd;
    }
      function setpwd(string memory  _pwd) public{
        ownerprofile.pwd=_pwd;
    }
    
}
   
