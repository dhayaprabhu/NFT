# NFT
1. The `onlyNFTOwner` modifier ensures that the caller of a function is the owner of the NFT being operated on.
2. The `onlyNFTListed` modifier checks if an NFT is listed for sale before allowing certain operations.
3. The `notNFTListed` modifier ensures that an NFT is not already listed for sale before attempting to list it.
4. The mint function allows users to mint a decentralized identity NFT.
5. The getUserTokenId function returns the token ID associated with a user's address.
6. The _baseURI function provides the base URI for metadata.
7. The createToken function allows the contract owner to mint new NFTs and assign them to a specific address.
8. The burnToken function allows the contract owner to burn (destroy) an existing NFT.
9. The baseTokenURI function provides the base URI for token metadata.
10. The tokenURI function is overridden to generate the full URI for a specific token.
11. MemebrshipToekn.sol: This contract inherits from ERC1155 and Ownable. The ERC1155 contract provides the implementation for the ERC-1155 standard.
12. Two membership levels are defined as constants (BASIC_MEMBERSHIP and PREMIUM_MEMBERSHIP), each with its own unique tokenId.
13. The contract is set up with initial supplies of membership tokens in the constructor.
14. The mint function allows the contract owner to mint additional membership tokens.
15. The transferMembership function allows the contract owner to transfer membership tokens between users.
16. The hasMembership function allows external callers to check if an address holds a specific membership level.
