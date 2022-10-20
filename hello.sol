//SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.5.0<0.9.0;

contract CrowdFunding{
    mapping(address=>uint) public contributors; //contribotors[msg.sendeer = 100wei
    address public manager;
    uint public minimumcontribution;
    uint public deadline;
    uint public target;      //variables

    uint public raisedAmounnt;
    uint public noofcontributors;

    struct Request{
        string description;
        address payable recipient;
        uint value;
        bool completed;
        uint noofvoters;
        mapping(address=>bool) voters;
    }
mapping(uint=>Request) public Requests;
uint public numRequest;
constructor(uint _target,uint _deadline){
    target=_target;
    deadline=block.timestamp+_deadline; //10sec = 3600sec(60*60)
    minimumcontribution=100 wei;
manager=msg.sender;
}

function sendEth() public payable{
    require(block.timestamp<deadline,"deadline has passed");
    require(msg.value >=minimumcontribution,"minimumcontribution is not met");

    if(contributors[msg.sender]==0){
        noofcontributors++;
    }
    contributors[msg.sender]=contributors[msg.sender]+msg.value;
    raisedAmounnt==msg.value;
}
function getcontractbalance() public view returns (uint){
    return address (this).balance;
}
function refund() public{
    require(block.timestamp>deadline && raisedAmounnt<target," you are not eligible forrefund");
    require(contributors[msg.sender]>0);
    address payable user=payable(msg.sender); //make payable
    user.transfer(100);
    contributors[msg.sender]=0;
}

modifier onlyManager(){
    require(msg.sender==manager,"only manager can call this function");
    _;  //sepicial modifier sign
}
function createRequests(string memory _description,address payable _recipient, uint _value)public onlyManager
{
    Request storage newRequest = Requests[numRequest];
    numRequest++;
    newRequest.description=_description;
    newRequest.recipient=_recipient;  
    newRequest.value=_value;
    newRequest.completed=false;
    newRequest.noofvoters=0;
}
function voteRequest(uint _requestno) public {
    require(contributors[msg.sender]>0,"you must be contributor");
    Request storage thisRequest=Requests[_requestno];
    require(thisRequest.voters[msg.sender]==false, "you have already voted");
    thisRequest.voters[msg.sender]=true;
    thisRequest.noofvoters++;
}
function makePayment(uint _requestno) public onlyManager{
    require(raisedAmounnt>=target);
    Request storage thisRequest=Requests[_requestno];
    require(thisRequest.completed==false, "the request has been completed");
    require(thisRequest.noofvoters > noofcontributors/2,"majority does not support");  //to cheack 50%
    thisRequest.recipient.transfer(thisRequest.value);
    thisRequest.completed=true;
}
 
}