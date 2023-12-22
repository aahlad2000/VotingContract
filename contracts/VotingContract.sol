// SPDX-License-Identifier: MIT
pragma solidity >=0.6.12 <0.9.0;

/*
Contract to cast a vote with eth address
*/

contract VotingContract {

    constructor(){
        voteInitLogger();
    }
    
    //Event for casting vote
    event castVoteEvent(address from_address, string voted_for);

    //Logger to track who is trying to vote 
    function voteInitLogger() public view  returns (string memory) {
        return string.concat(string(abi.encodePacked(msg.sender)), " Address is trying to cast a vote..." );
    }

    //Logger to track who has casted vote
    function voteCompletionLogger() public view  returns (string memory) {
        return string.concat("Account with address ",string(abi.encodePacked(msg.sender))," has cast a vote");
    }

    //Logger to throw error
    function voteErrorLogger() public view  returns (string memory) {
        return string.concat("Account with address ",string(abi.encodePacked(msg.sender))," has already cast a vote!!");
    }

    //Stores the voter info
    mapping(address => string) internal voterInfo;
    address[] public addressList;

    // Function to check if an address exists in the array
    function addressExists(address _target) public view returns (bool) {
        for (uint i = 0; i < addressList.length; i++) {
            if (addressList[i] == _target) {
                return true;
            }
        }
        return false; 
    }

    function castVote(address from_address) public payable {
        string memory voted_for = string(abi.encodePacked(msg.value));
        if(!addressExists(from_address)){
            emit castVoteEvent(msg.sender, voted_for);
            voterInfo[msg.sender] = voted_for;
            addressList.push(from_address);
            voteCompletionLogger();
        }

        else{
            voteErrorLogger();
        }
    }
    
}