# SchoolAdmission

This contract allows a school to manage the admission, withdrawal, and grade changes for students on the Ethereum blockchain."The purpose of the program is to demonstrate the error handling while  using require(), assert() and revert().

## Description
"The contract we’re looking at today is called SchoolAdmission. It’s designed to handle the lifecycle of a student within a school, from admission to potential withdrawal. The contract also allows for viewing student details and changing their grade level."
1. `admitStudent`
>>Purpose: Adds a new student to the school.
>> Process: It creates a new Student struct and stores it in the students mapping with a unique ID, while also incrementing the nextStudentId.
2. ` withdrawStudent`
>>Purpose: Withdraws a student from the school.
>>Process: The function checks that the student exists, is enrolled, and that the person calling the function is the student themselves.
3. `getStudentDetails`
>>Purpose: Retrieves the details of a specific student
>>Process: The function checks that the student exists, is enrolled, and that the caller is either the student themselves or an authorized user.
4. `changeGrade`
>>Purpose: Changes the grade level of a specific student.
>>Process: The function checks that the student exists, is enrolled, and that the caller is the student themselves.

## Getting Started

### Executing program

To run this program, you can use Remix, an online Solidity IDE. To get started, go to the Remix website at https://remix.ethereum.org/.


```js solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract SchoolAdmission {

    enum Grade { Kindergarten, Elementary, MiddleSchool, HighSchool }

    struct Student {
        address studentAddress;
        string name;
        uint dateOfBirth;
        Grade grade;
        uint admissionDate;
        bool isEnrolled;
    }

    mapping(uint => Student) public students;
    uint public nextStudentId = 1;

    event StudentAdmitted(address studentAddress, uint admissionDate);

    function admitStudent(
        address _studentAddress,
        string memory _name,
        uint _dateOfBirth,
        Grade _grade,
        uint _admissionDate
    ) public {
        emit StudentAdmitted(_studentAddress, _admissionDate);
        require(_admissionDate > block.timestamp, "Admission date must be in the future");

        students[nextStudentId++] = Student(
            _studentAddress,
            _name,
            _dateOfBirth,
            _grade,
            _admissionDate,
            true
        );
    }

    function withdrawStudent(uint _studentId) public {
        Student storage student = students[_studentId];
        require(student.studentAddress != address(0), "Student not found");
        require(student.isEnrolled, "Student already withdrawn");
        require(student.studentAddress == msg.sender, "You are not authorized to withdraw this student");

        student.isEnrolled = false;
    }

    function getStudentDetails(uint _studentId) public view returns (Student memory) {
        Student memory student = students[_studentId];
        require(student.studentAddress != address(0), "Student not found");
        require(student.isEnrolled, "Student is no longer enrolled");
        require(student.studentAddress == msg.sender || msg.sender == address(0), "You are not authorized to view this student's details");

        return student;
    }

    function changeGrade(uint _studentId, Grade _newGrade) public {
        Student storage student = students[_studentId];
        require(student.studentAddress != address(0), "Student not found");
        require(student.isEnrolled, "Student is no longer enrolled");
        require(student.studentAddress == msg.sender, "You are not authorized to change this student's grade");

        student.grade = _newGrade;
    }
}

```
To compile the code, click on the "Solidity Compiler" tab in the left-hand sidebar. Make sure the "Compiler" option is set to "0.8.7" (or another compatible version), and then click on the "Compile SchoolAdmission.sol" button.

Once the code is compiled, you can deploy the contract by clicking on the "Deploy & Run Transactions" tab in the left-hand sidebar. Select the "SchoolAdmission" contract from the dropdown menu, and then click on the "Deploy" button.

Once the contract is deployed, you can interact with it. The `SchoolAdmission` Solidity contract enables users to manage travel bookings on the Ethereum blockchain. 

#### Author
Mansi Shukla - Chandigarh University BE-C.S.E Students

#### License
This contract is licensed under the MIT License
