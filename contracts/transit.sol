// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

contract Transit {
    struct Details{
        address manager;
        string location;
        string batchIDmanDate;
    }

    mapping(uint => Details) public updates;
    
    function update(uint transit_id,address manager, string memory location, string memory batchIDmanDate) external {
        updates[transit_id] = Details(manager, location, batchIDmanDate);
    }

    function fetch(uint transit_id) external view returns(address,string memory,string memory){
        Details memory Detail = updates[transit_id];
        return(Detail.manager,Detail.location,Detail.batchIDmanDate);
    }
}