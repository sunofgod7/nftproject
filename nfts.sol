pragma solidity ^0.8.0;

contract mynfts{
    address public  manager;
    constructor () {
        manager = msg.sender;
    }

   //List of nft metadata
    struct nft{
        string name; 
        string image;
        string description;
        string rariety;
        string level; 
    }

    //Array of metadata
    nft[] nfts;

    //Winner list
    mapping (address=>uint) public winners; 

    mapping (address=>uint) public airdropWinners; 
    address[] public  airdropArrayWinners;

    modifier onlyowner() {
        require(msg.sender==manager);
        _;
    }
    function changeOwner(address newaddress) public onlyowner{
        manager = newaddress;
    }

    //Add new metadata by admin
    function addnft(nft[] memory mynfts) public onlyowner{
         for(uint i=0;i<mynfts.length;i++){
            nfts.push(mynfts[i]);
        }
    } 

    //Add new winner by admin
    function addwinner(address[] memory newwinner) public onlyowner{
         for(uint i=0;i<newwinner.length;i++){
              winners[newwinner[i]] = 1;
         }  
    }

    function addAirdropAddress(address[] memory newwinner) public onlyowner{
         for(uint i=0;i<newwinner.length;i++){
             airdropWinners[newwinner[i]] = 1;
         }  
      }

    //Show nfts to winners to buy
    function showNfts() public view returns(nft[] memory){
        require(winners[msg.sender] >=1 , "you are not in winner list");
        return (nfts);
    }

    function showAirdrop() public view returns(nft[] memory){
        require(airdropWinners[msg.sender] >=1 , "you are not in airdrop winner list");
        
        return (nfts);
    }




   


}
