# NFT
1. The `onlyNFTOwner` modifier ensures that the caller of a function is the owner of the NFT being operated on.
2. The `onlyNFTListed` modifier checks if an NFT is listed for sale before allowing certain operations.
3. The `notNFTListed` modifier ensures that an NFT is not already listed for sale before attempting to list it.
4. The mint function allows users to mint a decentralized identity NFT.
5. The getUserTokenId function returns the token ID associated with a user's address.
6. The _baseURI function provides the base URI for metadata. 
