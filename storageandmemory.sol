
 

// SPDX-Licence-Identifier: 3.0

pragma solidity>=0.5.0 < 0.9.0;

contract strandmem{
    string[] public student=["ravi", "bhanu", "sweta", "aman"];

    function mem() public view{
        string[] memory s1=student;
        s1[0]="Akash";

    }
    function sto() public {
        string[] storage s1=student;
        s1[0]="Akash";
     
    }
}
