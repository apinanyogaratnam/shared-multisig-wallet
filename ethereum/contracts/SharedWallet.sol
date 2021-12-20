// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SharedWallet {
    address public owner;
    address[] public owners;

    constructor() {
        owner = msg.sender;
        owners.push(msg.sender);
    }

    modifier onlyOwner {
        require(msg.sender == owner);
        _;
    }

    function addOwner(address _newOwner) external onlyOwner {
        owners.push(_newOwner);
    }

    function transferOwnership(address _newOwner) external onlyOwner {
        owner = _newOwner;
    }

    function removeOwner(uint _index) external onlyOwner {
        owners[_index] = owners[owners.length - 1];
        delete owners[owners.length - 1];
    }
}
