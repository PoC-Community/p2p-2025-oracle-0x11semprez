// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract Oracle {

    error nodeAlreadyExist();
    error nodeDoNotExist();
    
    address public owner;
    address[] public nodes;
    mapping(address => bool) public isNode;
    mapping(string => uint256) public currentPrices;

    constructor (address _owner) {
        owner = _owner;
    }

    function getQuorum() public view returns(uint256) {
        uint nodeCount = nodes.length;
        if (nodeCount < 3 ) {return 3;}
        return (nodeCount * 2 + 2) / 3;
    }

    function addNode() public {
       if (isNode[msg.sender]) {revert nodeAlreadyExist();}
        isNode[msg.sender] = true;
        nodes.push(msg.sender);
    }

    function removeNode() public {
        if (!isNode[msg.sender]) {revert nodeDoNotExist();}
        isNode[msg.sender] = false;
        
        uint256 nodesLength = nodes.length;
        for (uint256 i = 0; i < nodesLength; i++) {
            if (nodes[i] == msg.sender) {
                nodes[i] = nodes[nodesLength - 1]; 
                nodes.pop();                 
                break;
            }
        }

    }


 
}