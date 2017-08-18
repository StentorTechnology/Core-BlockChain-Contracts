pragma solidity ^0.4.13;

contract CoreClusterRegistrar {
    
    //cluster name -> cluster address
    mapping(string => address) clusters;

    function register(address newCluster, string name) returns (bool){
        if(clusters[name] == address(0x0)){
            clusters[name] = newCluster;
            return true;
        }
        return false;
    }
    
    function updateAddress(string name, address newaddress) returns(address){
        require(clusters[name] == msg.sender);
        clusters[name] = newaddress;
        return newaddress;
    }
    
    function getCluster(string name) constant returns(address){
        return clusters[name];
    }
}
/*
current address in test node:
0xf683b6c648d0999b7725330adb4d4e5ea3d48499
*/
