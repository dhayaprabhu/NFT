// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract MyNFT is ERC721, Ownable {
    uint256 private tokenIdCounter;

    constructor() ERC721("MyNFT", "MNFT") {
        tokenIdCounter = 1;
    }

    function createToken(address to) external onlyOwner {
        _safeMint(to, tokenIdCounter);
        tokenIdCounter++;
    }

    function burnToken(uint256 tokenId) external onlyOwner {
        require(_exists(tokenId), "Token does not exist");
        _burn(tokenId);
    }

    function baseTokenURI() public view returns (string memory) {
        return "https://api.example.com/metadata/";
    }

    function tokenURI(uint256 tokenId) public view override returns (string memory) {
        require(_exists(tokenId), "Token does not exist");
        return string(abi.encodePacked(baseTokenURI(), tokenId.toString()));
    }
}
