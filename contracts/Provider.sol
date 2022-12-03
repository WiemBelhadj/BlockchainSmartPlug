// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

//import "contracts/Station.sol";

contract Provider {

    uint id;
    address private provider;
    

    event ProviderSet(address indexed oldProvider, address indexed newProvider);

    modifier isProvider() {
        require(msg.sender == provider, "Caller is not provider");
        _;
    }
    function changeProvider(address newProvider) public isProvider {
        emit ProviderSet(provider, newProvider);
        provider = newProvider;
    }
    function getProvider() external view returns (address) {
        return provider;
    }
    struct ProviderProfile {
            string name;
            uint CA;  
    }

    ProviderProfile private providerprofile;

    // // event for EVM logging
    // event StationSet(address indexed oldStation, address indexed newStation);

    // // modifier to check if caller is station
    // modifier isStation() {
    //     require(msg.sender == station, "Caller is not station");
    //     _;
    // }

    // constructor() {
    //     console.log("Station contract deployed by:", msg.sender);
    //     station = msg.sender; // 'msg.sender' is sender of current call, contract deployer for a constructor
    //     emit StationSet(address(0), station);
    // }

    // function changeStation(address newStation) public isStation {
    //     emit StationSet(station, newStation);
    //     station = newStation;
    // }

    // function getStation() external view returns (address) {
    //     return station;
    // }
} 
