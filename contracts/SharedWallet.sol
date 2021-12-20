// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SharedWallet {
    address public owner;
    address[] public owners;
    mapping(address => bool) public isOwner;
    uint numberOfOwners;

    struct Request {
        uint amount;
        uint numberOfApprovals;
        mapping(address => bool) approved;
    }

    Request[] requests;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner {
        require(msg.sender == owner, 'only owner');
        _;
    }

    function addOwner(address _newOwner) external onlyOwner {
        require(_newOwner != owner, 'cannot add contract owner to list');
        require(_newOwner != address(0), 'cannot add null address to list');
        require(!isOwner[_newOwner], 'address already exists in list');

        // add to list and mark as owner
        owners.push(_newOwner);
        isOwner[_newOwner] = true;

        // increment number of owners
        numberOfOwners++;
    }

    function transferOwnership(address _newOwner) external onlyOwner {
        require(_newOwner != owner, 'cannot transfer ownership to self');
        require(_newOwner != address(0), 'cannot transfer ownership to null address');
        owner = _newOwner;
    }

    function removeOwner(uint _index) external onlyOwner {
        require(_index < owners.length, 'index out of bounds');

        // remove owner from list
        owners[_index] = owners[owners.length - 1];
        delete owners[owners.length - 1];
        isOwner[owners[_index]] = false;

        // decrement number of owners
        numberOfOwners--;
    }

    function withdrawRequest(uint _amount) external {
        require(_amount > 0, 'amount must be greater than 0');
        require(isOwner[msg.sender], 'only owner can withdraw');

        // create new request
        Request storage request = requests[requests.length + 1];
        request.amount = _amount;
        request.numberOfApprovals = 0;
        request.approved[msg.sender] = true;
    }

    function approve(uint _requestIndex) external {
        require(_requestIndex < requests.length, 'index out of bounds');
        require(requests[_requestIndex].numberOfApprovals < numberOfOwners, 'request has already been approved');
        require(isOwner[msg.sender], 'only owner can approve');
        require(requests[_requestIndex].approved[msg.sender] == false, 'already approved');

        // increment number of approvals and mark approval
        requests[_requestIndex].numberOfApprovals++;
        requests[_requestIndex].approved[msg.sender] = true;
    }

    function withdraw(uint _requestIndex) external {
        require(_requestIndex < requests.length, 'index out of bounds');
        require(requests[_requestIndex].approved[msg.sender], 'only approved owners can withdraw');
        require(requests[_requestIndex].numberOfApprovals == numberOfOwners, 'not all owners have approved');

        // delete request
        uint amount = requests[_requestIndex].amount;
        delete requests[_requestIndex];

        // send funds to owner
        payable(msg.sender).transfer(amount);
    }
}
