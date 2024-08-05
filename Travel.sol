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