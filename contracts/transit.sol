// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

contract Transit {
    enum transitStatus{PENDING, IN_TRANSIT, RECIEVED, RECEIEVED_FINAL, TAMPERED}
    
    event tempTamper(address indexed sender, string message);

    struct Details {
        address sender;
        address receiver;
        uint pickupTime;
        uint deliveryTime;
        transitStatus status;
    }

    mapping(uint => Details) public transits;

    Details[] transitArray;

    function createTransit(uint _transitId, address _sender, address _receiver) external {
        transits[_transitId] = Details(_sender, _receiver,0, 0, transitStatus.PENDING);
        
    }

    function startTransit(uint _transitId, address _receiver) external {
        Details storage detail = transits[_transitId];
        require(detail.sender == msg.sender && detail.receiver == _receiver, "Invalid sender or reciever");
        require(detail.status == transitStatus.PENDING,"Invalid transit status");
        detail.status = transitStatus.IN_TRANSIT;
        detail.pickupTime = block.timestamp;
    }

    function receiveTransit(uint _transitId, address _sender) external {
        Details storage detail = transits[_transitId];
        require(detail.sender == _sender && detail.receiver == msg.sender,"Invalid sender or receiver");
        require(detail.status == transitStatus.IN_TRANSIT,"Invalid transit status");
        detail.status = transitStatus.RECIEVED;
        detail.deliveryTime  = block.timestamp;
        transitArray.push(transits[_transitId]);
    }

    function getallTransit() public view returns (Details[] memory) {
        return transitArray;
    }

    function tempTampered(uint _transitID) external {
        Details storage detail = transits[_transitID];
        require(detail.status == transitStatus.IN_TRANSIT || detail.status == transitStatus.RECIEVED);
        detail.status = transitStatus.TAMPERED;
        emit tempTamper(msg.sender, "TAMPERED");
    }

    function getTransitbyID(uint _transitID) public view returns(Details memory) {
        Details storage detail = transits[_transitID];
        return detail;
    }
}