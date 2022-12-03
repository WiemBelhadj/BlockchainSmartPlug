// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

//import "contracts/Car.sol";
//import "contracts/Owner.sol";
//import "contracts/Provider.sol";

contract Station {

    uint id;
    address private station;

    event StationSet(address indexed oldStation, address indexed newStation);

    modifier isStation() {
        require(msg.sender == station, "Caller is not station");
        _;
    }
    function changeStation(address newStation) public isStation {
        emit StationSet(station, newStation);
        station = newStation;
    }
    function getStation() external view returns (address) {
        return station;
    }
    struct StationProfile {
        string ref;
        string location;
        uint compteur_car;
        uint compteur_provider;
    }

    struct EvInfo {
        uint8 energy_in_reserve;
        uint8 batterySize;
        uint cabletype;
    }

}