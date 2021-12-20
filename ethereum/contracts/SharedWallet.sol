// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SharedWallet {
    address public owner;
    address[] public owners;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner {
        require(msg.sender == owner, 'only owner');
        _;
    }

    function addOwner(address _newOwner) external onlyOwner {
        require(_newOwner != owner, 'cannot add contract owner to list');
        require(_newOwner != address(0), 'cannot add null address to list');))
        owners.push(_newOwner);
    }

    function transferOwnership(address _newOwner) external onlyOwner {
        require(_newOwner != owner, 'cannot transfer ownership to self');
        require(_newOwner != address(0), 'cannot transfer ownership to null address');
        owner = _newOwner;
    }

    function removeOwner(uint _index) external onlyOwner {
        require(_index < owners.length, 'index out of bounds');
        owners[_index] = owners[owners.length - 1];
        delete owners[owners.length - 1];
    }
}
