
 

// SPDX-Licence-Identifier: 3.0

pragma solidity>=0.5.0 < 0.9.0;

contract Mapping{
    mapping(uint=>string) public roll_no;

    function setter(uint keys, string memory values) public{
        roll_no[keys]=values;
    }

}
