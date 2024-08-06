// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract AccountManagement {

    // Structure to store customer account details
    struct Customer {
        bool exists;
        string name;
        uint age;
    }

    // Mapping for storing customer accounts
    mapping(address => Customer) public customers;

    // Event for new account creation
    event AccountCreated(address customer, string name, uint age);

    // Event for account update
    event AccountUpdated(address customer, string name, uint age);

    // Function to create a new customer account
    function createAccount(string memory _name, uint _age) public {
        require(!customers[msg.sender].exists, "Account already exists");
        require(bytes(_name).length > 0, "Name is required");
        require(_age > 0, "Age must be greater than zero");

        customers[msg.sender] = Customer(true, _name, _age);
        emit AccountCreated(msg.sender, _name, _age);
    }

    // Function to update an existing customer account
    function updateAccount(string memory _name, uint _age) public {
        require(customers[msg.sender].exists, "Account does not exist");
        require(bytes(_name).length > 0, "Name is required");
        require(_age > 0, "Age must be greater than zero");

        customers[msg.sender].name = _name;
        customers[msg.sender].age = _age;
        emit AccountUpdated(msg.sender, _name, _age);
    }

    // Function to view customer account details
    function viewAccount() public view returns (Customer memory) {
        require(customers[msg.sender].exists, "Account does not exist");
        return customers[msg.sender];
    }
}
