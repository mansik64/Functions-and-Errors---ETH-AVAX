# TravelReservation

This Solidity program is a simple demo code for error handling. The purpose of the program is to demonstrate the error handling while creation and updation of travel reservations  for visa using require(), assert() and revert().

## Description
A Solidity smart contract called `TravelReservation` was created to simplify the process of booking travel on the Ethereum network. It possesses the following qualities: <>>Locations: Four locations are listed in this list: {London, Dubai, Africa, Korea}.

>>Unique Booking ID: An ID is assigned to every booking by a counter ({nextBookingId}).Create Booking: With the use of this tool, users may add new bookings by inputting the traveler's details, destination, departure date, and ticket count. The first reservations are not confirmed.
>>Confirm Booking: By enabling verification, this feature ensures that bookings will never need to be validated again.
>>View Booking: Passengers may view the details of their own bookings using this feature, which also contains authorization checks to ensure that only authorized travelers can access themselves. reservations.

## Getting Started

### Executing program

To run this program, you can use Remix, an online Solidity IDE. To get started, go to the Remix website at https://remix.ethereum.org/.


```js solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract TravelReservation {

    // Define an enum for different travel destinations
    enum Location { London, Dubai, Africa, Korea }

    // Structure to store travel reservation details
    struct Reservation {
        address customer;
        Location location;
        uint ticketCount;
        bool isApproved;
    }

    // Mapping for storing reservations with unique identifiers
    mapping(uint => Reservation) public reservations;
    uint public nextReservationId = 1; // Keeps track of next reservation ID

    // Function to create a new travel reservation
    function createReservation(address _customer, Location _location, uint _ticketCount) public {
        require(_ticketCount > 0, "Ticket count must be greater than zero");

        Reservation memory newReservation = Reservation(_customer, _location, _ticketCount, false);
        reservations[nextReservationId] = newReservation;
        nextReservationId++;
    }

    // Function to approve a reservation 
    function approveReservation(uint _reservationId) public {
        require(reservations[_reservationId].customer == msg.sender, "Only the customer can approve their reservation");
        require(reservations[_reservationId].isApproved == false, "Reservation already approved");

        reservations[_reservationId].isApproved = true;
    }

    // Function to view reservation details 
    function viewReservation(uint _reservationId) public view returns (Reservation memory) {
        require(reservations[_reservationId].customer == msg.sender, "Unauthorized to view reservation");
        return reservations[_reservationId];
    }

    // Function to cancel a reservation before it is approved
    function cancelReservation(uint _reservationId) public {
        require(reservations[_reservationId].customer == msg.sender, "Only the customer can cancel their reservation");
        require(reservations[_reservationId].isApproved == false, "Cannot cancel an approved reservation");

        delete reservations[_reservationId];
    }
}
```
To compile the code, click on the "Solidity Compiler" tab in the left-hand sidebar. Make sure the "Compiler" option is set to "0.8.7" (or another compatible version), and then click on the "Compile TravelBooking.sol" button.

Once the code is compiled, you can deploy the contract by clicking on the "Deploy & Run Transactions" tab in the left-hand sidebar. Select the "TravelBooking" contract from the dropdown menu, and then click on the "Deploy" button.

Once the contract is deployed, you can interact with it. The `TravelReservation` Solidity contract enables users to manage travel bookings on the Ethereum blockchain. It supports destinations (London, Dubai, Africa, Korea) and stores booking details (traveler, destination, travel date, ticket count, confirmation status) in a mapping identified by unique booking IDs. Users can create bookings, which initially have an unconfirmed status, and confirm bookings later. Travelers can view their own booking details, ensuring privacy. The contract maintains a counter for the next booking ID, ensuring each booking is uniquely identified. The system includes functions to create, confirm, and view bookings with authorization checks for security.

#### Author
Mansi Shukla - Chandigarh University BE-C.S.E Students

#### License
This contract is licensed under the MIT License