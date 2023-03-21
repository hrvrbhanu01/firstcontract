// SPDX-Licence-Identifier: GPL-3.0

pragma solidity>=0.5.0 < 0.9.0;

contract local
{
    uint age=23;

    function getter() public view returns(uint){                                              //getter is like print
        return age;
    }
   *** function setter() public{
        age=age+2;
    }***
    function setter(uint newage) public
    {
    age=newage;
    }

}

