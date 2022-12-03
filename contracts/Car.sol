// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;
import "contracts/Owner.sol";

contract Car {

    uint id;
    address private car;

    event CarSet(address indexed oldCar, address indexed newCar);

    modifier isCar() {
        require(msg.sender == car, "Caller is not car");
        _;
    }
    function changeCar(address newCar) public isCar {
        emit CarSet(car, newCar);
        car = newCar;
    }
    function getCar() external view returns (address) {
        return car;
    }
    


    struct CarProfile {
        string matricule;
        string model;
        string brand;
        string location;
    }

    CarProfile private carprofile;

     function getMatricule() external view returns (string memory) {
        return carprofile.matricule;
    }
    function setMatricule(string memory  _matricule) public{
        carprofile.matricule=_matricule;
    }
    function getModel() external view returns (string memory) {
        return carprofile.model;
    }
     function setModel(string memory  _model) public{
        carprofile.model=_model;
    }
    function getBrand() external view returns (string memory) {
        return carprofile.brand;
    }
     function setBrand(string memory  _brand) public{
        carprofile.brand=_brand;
    }
    function getLocation() external view returns (string memory) {
        return carprofile.location;
    }
      function setLocation(string memory  _location) public{
        carprofile.location=_location;
    }

    struct EvInfo {
        uint8 energy_in_reserve;
        uint8 batterySize;
        uint cabletype;
    }


constructor() {
        car = msg.sender;
        emit CarSet(address(0), car);
    }



}