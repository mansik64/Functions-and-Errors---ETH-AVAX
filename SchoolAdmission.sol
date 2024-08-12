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
