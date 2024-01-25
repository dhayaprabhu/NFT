// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract MembershipToken is ERC1155, Ownable {
    // Token ID to track different membership levels
    uint256 public constant BASIC_MEMBERSHIP = 1;
    uint256 public constant PREMIUM_MEMBERSHIP = 2;
    address addowner;

    // Events
    event MembershipMinted(address indexed account, uint256 tokenId, uint256 amount);
    event MembershipTransferred(address indexed from, address indexed to, uint256 tokenId, uint256 amount);

    constructor() ERC1155("https://api.example.com/token/{id}.json") Ownable(addowner) {
        // Mint initial supply for each membership level
        _mint(msg.sender, BASIC_MEMBERSHIP, 100, "");
        _mint(msg.sender, PREMIUM_MEMBERSHIP, 50, "");
    }

    // Mint new membership tokens
    function mint(address account, uint256 tokenId, uint256 amount) external onlyOwner {
        _mint(account, tokenId, amount, "");
        emit MembershipMinted(account, tokenId, amount);
    }

    // Transfer membership tokens
    function transferMembership(address from, address to, uint256 tokenId, uint256 amount) external onlyOwner {
        _safeTransferFrom(from, to, tokenId, amount, "");
        emit MembershipTransferred(from, to, tokenId, amount);
    }

    // Custom function to check if an address holds a specific membership level
    function hasMembership(address account, uint256 tokenId) external view returns (bool) {
        return balanceOf(account, tokenId) > 0;
    }
}
