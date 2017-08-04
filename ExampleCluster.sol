pragma solidity ^0.4.13;
import './CoreCluster.sol';

contract ExampleCluster is CoreCluster{
    address[] users;
    uint userCount;

    function ExampleCluster(string name){
        owner = msg.sender;
        users.push(msg.sender);
        userCount = 1;
    }
    
    function allowUser(address user){
        require(msg.sender == owner);
        users.push(user);
        userCount++;
    }
    
    function withdraw(uint amount) returns(bool){
        if(amount > this.balance){
            return false;
        }
        for(uint i = 0; i < userCount; i++){
            if(msg.sender == users[i]){
                msg.sender.transfer(amount);
                return true;
            }
        }
        return false;
    }

    
    //depositing value to the cluster should be done natively 
    //with eth.sendTrascation({from: sender, to: this , value: amount}) 
    //address of all clusters can be retrieved from the registry
}
