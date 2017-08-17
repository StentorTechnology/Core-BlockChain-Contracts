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
    CoreClusterRegistrar constant internal registrar = CoreClusterRegistrar(0xf683b6c648d0999b7725330adb4d4e5ea3d48499);
    string name;
    
    /*
    creates a default cluster with its balance available to all accounts within 
    the cluster and registars the given name with this cluster in the registrar
    */
    function CoreCluster(string _name){
        bool success = registrar.register(this, _name);
        require(success == true);
        name = _name;
        owner = msg.sender;
    }
    
    /*
    Deletes this cluster off of the blockchain and transfers any leftover
    balance from this location to the address of the new cluster. The new
    cluster must have already been created. This function requires the caller
    to be the original creater of the cluster.
    */
    function updateAddress(address newAddress){
        require(msg.sender == owner);
        address check = registrar.updateAddress(name, newAddress);
        require(check == newAddress);
        selfdestruct(newAddress);
    }
    
    function getName() constant returns(string){
        return name;
    }
    
    /*
    Allows this cluster to holde a balance. If you do not want your cluster
    to ever have a balance, delete this function and do NOT put the 'payable'
    modifier on any of the functions written in the cluster.
    */
    function() payable{}
}
