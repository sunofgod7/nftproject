pragma solidity ^0.8.0;

contract mynfts{
    address public  manager;
    constructor () {
        manager = msg.sender;
    }


    modifier onlyowner() {
        require(msg.sender==manager);
        _;
    }
    function changeOwner(address newaddress) public onlyowner{
        manager = newaddress; 
    }

}
