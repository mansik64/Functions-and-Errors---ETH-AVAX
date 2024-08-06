# AccountManagement

This Solidity program is a simple demo code for error handling. The purpose of the program is to demonstrate the error handling while creation and updation of travel reservations  for visa using require(), assert() and revert().

## Description
A Solidity smart contract called `AccountManagement` was created to simplify the process of booking travel on the Ethereum network. 
>>`createAccount(string memory _name, uint _age)`=This function allows a user to create a new customer account.A new Customer struct is created and stored in the customers mapping with the user's address as the key. An `AccountCreated` event is emitted, logging the user's address, name, and age.
>>`updateAccount(string memory _name, uint _age)`=This function allows a user to update their existing customer account.The `Customer` struct associated with the user's address is updated with the new name and age. An AccountUpdated event is emitted, logging the user's address, name, and age.
>>`viewAccount() public view returns (Customer memory)`=This function allows a user to view their own customer account details.The function returns the Customer struct associated with the user's address.


## Getting Started

### Executing program

To run this program, you can use Remix, an online Solidity IDE. To get started, go to the Remix website at https://remix.ethereum.org/.


```js solidity
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
```
To compile the code, click on the "Solidity Compiler" tab in the left-hand sidebar. Make sure the "Compiler" option is set to "0.8.7" (or another compatible version), and then click on the "Compile AccountManagement.sol" button.

Once the code is compiled, you can deploy the contract by clicking on the "Deploy & Run Transactions" tab in the left-hand sidebar. Select the "AccountManagement" contract from the dropdown menu, and then click on the "Deploy" button.

Once the contract is deployed, you can interact with it. The `AccountManagement` Solidity contract enables users to manage travel bookings on the Ethereum blockchain. 

#### Author
Mansi Shukla - Chandigarh University BE-C.S.E Students

#### License
This contract is licensed under the MIT License
