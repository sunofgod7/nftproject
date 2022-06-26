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
    string[] public allhashes; 
    uint public ii=1; 
    uint public jj=0;
    uint public mintIndex = 1;
    ERC721 public thisNft = ERC721(address(this));
    string public mehran;
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
    constructor() ERC721("AKUMUS_v1", "AKU1") {}

    function mint(string memory _uri) public onlyowner {
        
        _safeMint(address(0x10196a71ab44ffc932c778E7EF9db70fD4358F91), mintIndex);        
        _setTokenURI(mintIndex, _uri);
         mintIndex++;

    }
    

 
 
    function sethash(string[] memory hashes) public onlyowner{
        for(uint i=0;i<hashes.length;i++){
            allhashes.push(hashes[i]);
        }
    }
     
    function mintAllother() public onlyowner {
        
        for(uint i=ii;i<=(ii+35);i++){
             
             mehran = string(abi.encodePacked("https://gateway.pinata.cloud/ipfs/" , allhashes[jj], "/", Strings.toString(i), ".png"));
             string memory myname = string(abi.encodePacked("AKUMUS " ,  Strings.toString(mintIndex)));

              string memory json =  
                string( 
                    abi.encodePacked(
                        '{"name": "',  myname, '",',
                        '"image": "', mehran, '",',
                        '"description": "', 'Do u know whats f*cking scary? U.AKUMUS is collection of 3999 unique and randomly generated PFP`s Anime series on Polygon Blockchain.each NFT has its rarity and holding the NFT gives you access to AKU community network.also you can earn profit and get 8% of Box office sales of Animation series and some other awesome utilities.Find out more at Akumus.com', '",',
                        '"attributes": []}'
                    )
                )
            ;
            mint(json);
        }
        ii=ii+36;
        jj++;
    }

    function edit_token(uint[] memory index , uint dir , uint[] memory item) public onlyowner{
        for(uint i=0;i<index.length;i++){
             mehran = string(abi.encodePacked("https://gateway.pinata.cloud/ipfs/" , allhashes[dir], "/", Strings.toString(item[i]), ".png"));
             string memory myname = string(abi.encodePacked("AKUMUS " ,  Strings.toString(mintIndex)));
              string memory json =  
                string( 
                    abi.encodePacked(
                        '{"name": "',  myname, '",',
                        '"image": "', mehran, '",',
                        '"description": "', 'Do u know whats f*cking scary? U.AKUMUS is collection of 3999 unique and randomly generated PFP`s Anime series on Polygon Blockchain.each NFT has its rarity and holding the NFT gives you access to AKU community network.also you can earn profit and get 8% of Box office sales of Animation series and some other awesome utilities.Find out more at Akumus.com', '",',
                        '"attributes": []}'
                    )
                )
            ;
            _setTokenURI(index[i], json);
        }
    } 
    function burnToken(uint[] memory tokens) public onlyowner{
        for(uint i=0;i<tokens.length;i++){
            _burn(tokens[i]);
        }
    } 
    function changeii(uint newii) public onlyowner{
         ii = newii;
    } 
    function changejj(uint newjj) public onlyowner{
         jj = newjj;
    } 
    function changemintIndex(uint newindex) public onlyowner{
         mintIndex = newindex;
    } 
    


}
