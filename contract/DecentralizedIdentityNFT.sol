// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721.sol";

contract DecentralizedIdentityNFT is ERC721Enumerable, Ownable {
    using Strings for uint256;

    uint256 private tokenIdCounter;

    // Mapping from user address to their decentralized identity
    mapping(address => uint256) private userToTokenId;
    address Owner;

    constructor() ERC721("DecentralizedIdentityNFT", "DIDNFT") Ownable(Owner){
        tokenIdCounter = 1;
    }

    function mint() external {
        require(userToTokenId[msg.sender] == 0, "User already has a decentralized identity");

        _safeMint(msg.sender, tokenIdCounter);
        userToTokenId[msg.sender] = tokenIdCounter;
        tokenIdCounter++;
    }

    function getUserTokenId(address user) external view returns (uint256) {
        return userToTokenId[user];
    }

    function _baseURI() internal pure override returns (string memory) {
        return "https://api.example.com/metadata/";
    }

    // Override isApprovedForAll to whitelist user's OpenSea proxy accounts to enable gas-less listings.
    function isApprovedForAll(address owner, address operator) public view override(ERC721, IERC721) returns (bool) {
        return super.isApprovedForAll(owner, operator);
    }
}
