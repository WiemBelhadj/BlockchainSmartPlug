// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

// import "contracts/Car.sol";
// import "contracts/Owner.sol";
// import "contracts/Provider.sol";
// import "contracts/Owner.sol";
// import "contracts/Station.sol";

contract ChargeBill is Owner,Car,Provider,Station {

    uint id;
    address private chargebill;

    event ChargeBillSet(address indexed oldChargeBill, address indexed newChargeBill);

    modifier isChargeBill() {
        require(msg.sender == chargebill, "Caller is not ChargeBill");
        _;
    }
    function changeChargeBill(address newChargeBill) public isChargeBill {
        emit ChargeBillSet(chargebill, newChargeBill);
        chargebill = newChargeBill;
    }
    function getChargeBill() external view returns (address) {
        return chargebill;
    }



function closecontract() external payable onlyOwner {
            uint fee;
            fee = 1000000000000000000;
                msg.sender.transfer(operationalDeposit-fee);
        //currState = State.FINISHED;
    }

     function initializePaymentChannel() public payable returns (bool) {
        // payment channel has to be inactive
        require(!channelActive, "payment channel already active");
        // value sent with the transaction has to be at least as much as the minimum required deposit
        require(msg.value >= minDeposit, "minimum deposit value not reached");

        // set global payment channel information
        channelActive = true;
        // set channel customer to the address of the caller of the transaction
        channelCustomer = msg.sender;
        // set the maximum transaction value to the deposited value
        maxValue = msg.value;
        // set the timestamp of the payment channel intialization
        creationTimeStamp = now;
        // calculate and set the expiration timestamp
        expirationDate = now.add(expirationDuration);

        // emit the initialization event
        // It's cheaper in gas to use msg.sender instead of loading the channelCustomer variable, msg.value instead of maxValue, etc.
        emit InitializedPaymentChannel(msg.sender, now, now.add(expirationDuration), msg.value);
        return true;
    }
    function closeChannel(uint256 _value, bytes memory _signature) public onlyOwner returns (bool) {
        // save value to a temporary variable, as it is reassigned later
        uint256 value = _value;
        // payment channel has to be active
        require(channelActive, "payment channel not active");
        // call verify signature function, if it returns false, the signature is invalid and the function throws
        require(verifySignature(value, _signature), "signature not valid");

        // increase nonce after payment channel is closed
        customerNonces[channelCustomer] = customerNonces[channelCustomer].add(1);

        // if maxValue was exceeded, set value to maxValue
        if (value > maxValue) {
            value = maxValue;
            // value of payment channel equals the exact deposited amount
            // credit owner the total value
            balances[owner] = balances[owner].add(value);
        } else {
            // credit owner the value from the payment channel
            balances[owner] = balances[owner].add(value);
            // refund the remaining value to the customer
            balances[channelCustomer] = balances[channelCustomer].add(maxValue.sub(value));
        }


}

