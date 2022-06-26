// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC721/ERC721.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/math/SafeMath.sol";
import "./nfts.sol";
 import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/Strings.sol";

contract MinterYT is ERC721, ERC721Enumerable, ERC721URIStorage , mynfts{
    using SafeMath for uint256;
    uint public constant mintPrice = 0; 
    ERC721 public thisNft = ERC721(address(this));
    string public mehran; 
    uint ii=1;

    function _beforeTokenTransfer(address from, address to, uint256 tokenId)
        internal
        override(ERC721, ERC721Enumerable)
    {
        super._beforeTokenTransfer(from, to, tokenId);
    }
    function _burn(uint256 tokenId) internal override(ERC721, ERC721URIStorage) {
        super._burn(tokenId);
    }
    function tokenURI(uint256 tokenId)
        public
        view
        override(ERC721, ERC721URIStorage)
        returns (string memory)
    {
        return super.tokenURI(tokenId);
    }
    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC721, ERC721Enumerable)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }
    constructor() ERC721("Mirtat", "MRT") {}

    //Mint a nft with optional metadata
    function mint(string memory _uri) private {
        uint256 mintIndex = totalSupply();
        _safeMint(msg.sender, mintIndex);
        _setTokenURI(mintIndex, _uri);
    }

    //Mint of several NFTs together that metadata add by admin in a struct
    function mintAll(nft[] memory adminNfts) public onlyowner {
        for(uint i=0;i<adminNfts.length;i++){
            string memory json =  
                string(
                    abi.encodePacked(
                        '{"name": "',  adminNfts[i].name, '",',
                        '"image": "', adminNfts[i].image, '",',
                        '"description": "', adminNfts[i].description, '",',
                        '"attributes": [{"trait_type": "rariety", "value": "', adminNfts[i].rariety, '"},',
                        '{"trait_type": "type", "value": "', adminNfts[i].level, '"}',
                        ']}'
                    )
                )
            ;
            mint(json);
        }
    }
 
 
    //Mint of several NFTs together in special method
    function mintAllother(string memory myaddress) public onlyowner {
        uint end = ii+35;
        for(ii=ii;ii<=end;ii++){

             mehran = string(abi.encodePacked("https://gateway.pinata.cloud/ipfs/" , myaddress, "/", Strings.toString(ii), ".png"));

              string memory json =  
                string( 
                    abi.encodePacked(
                        '{"name": "',  'Akumus', '",',
                        '"image": "', mehran, '",',
                        '"description": "', 'Akumus is 3999 PFP collection that minted on polygon network. Rarity level of each  NFT specified by its code number depend on the schedule.', '",',
                        '"attributes": []}'
                    )
                )
            ;
            mint(json);
        }
    }

    //Edit a nft with index and new uri(metadata)
    function edit_token(uint index , string memory muri) public onlyowner{
        _setTokenURI(index, muri);
    } 
    
    //You can buy and mint nft if you be in our winner list
    function myUri(uint i) public payable{
        require(msg.value>=100000000 , "your value is not enough");
        require(winners[msg.sender] <= 5 , "you bought 5 nfts");
        require(winners[msg.sender] >= 1 , "you are not in winner list");
         string memory json =  
            string(
                abi.encodePacked(
                    '{"name": "',  nfts[i].name, '",',
                    '"image": "', nfts[i].image, '",',
                    '"description": "', nfts[i].description, '",',
                    '"attributes": [{"trait_type": "rariety", "value": "', nfts[i].rariety, '"},',
                    '{"trait_type": "type", "value": "', nfts[i].level, '"}',
                    ']}'
                )
            )
        ;
        winners[msg.sender] = winners[msg.sender]+1;
        mint(json);
}


}
