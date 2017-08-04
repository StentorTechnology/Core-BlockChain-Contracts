pragma solidity ^0.4.13;

/*
Prototype of the functions needed to registar and change the address of a
cluster
*/
contract CoreClusterRegistrar{
    function register(address, string) returns(bool);
    function updateAddress(string, address) returns(address);
}

contract CoreCluster{
    address owner; //address of cluster creator
    CoreClusterRegistrar constant internal registrar = CoreClusterRegistrar(0x145b3c46293c4d3c6d33f1fc420f2ac8bc9f561f);
    
    /*
    creates a default cluster with its balance available to all accounts within 
    the cluster and registars the given name with this cluster in the registrar
    */
    function CoreCluster(string name){
        bool success = registrar.register(this, name);
        require(success == true);
        owner = msg.sender;
    }
    
    /*
    Deletes this cluster off of the blockchain and transfers any leftover
    balance from this location to the address of the new cluster. The new
    cluster must have already been created. This function requires the caller
    to be the original creater of the cluster.
    */
    function updateAddress(string name, address newAddress){
        require(msg.sender == owner);
        address check = registrar.updateAddress(name, newAddress);
        require(check == newAddress);
        selfdestruct(newAddress);
    }
    
    /*
    Allows this cluster to holde a balance. If you do not want your cluster
    to ever have a balance, delete this function and do NOT put the 'payable'
    modifier on any of the functions written in the cluster.
    */
    function() payable{}
}
