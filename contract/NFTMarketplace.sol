// SPDX-License-Identifier: MIT
   pragma solidity ^0.8.0;

  // import "@openzeppelin/contracts-upgradeable/proxy/Initializable.sol";
   import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
   import "@openzeppelin/contracts-upgradeable/token/ERC721/IERC721Upgradeable.sol";
   import "@openzeppelin/contracts-upgradeable/token/ERC721/utils/ERC721HolderUpgradeable.sol";
   import "@openzeppelin/contracts-upgradeable/utils/math/SafeMathUpgradeable.sol";

   contract NFTMarketplace is Initializable, OwnableUpgradeable, ERC721HolderUpgradeable {
       using SafeMathUpgradeable for uint256;

       struct Listing {
           address seller;
           uint256 price;
           bool isListed;
       }

       mapping(address => mapping(uint256 => Listing)) public tokenListings;

       event NFTListed(address indexed nftContract, uint256 indexed tokenId, address indexed seller, uint256 price);
       event NFTSold(address indexed nftContract, uint256 indexed tokenId, address indexed buyer, uint256 price);
       event NFTListingCancelled(address indexed nftContract, uint256 indexed tokenId, address indexed seller);

       modifier onlyNFTOwner(address nftContract, uint256 tokenId) {
           require(IERC721Upgradeable(nftContract).ownerOf(tokenId) == msg.sender, "Not the NFT owner");
           _;
       }

       modifier onlyNFTListed(address nftContract, uint256 tokenId) {
           require(tokenListings[nftContract][tokenId].isListed, "NFT not listed for sale");
           _;
       }

       modifier notNFTListed(address nftContract, uint256 tokenId) {
           require(!tokenListings[nftContract][tokenId].isListed, "NFT already listed for sale");
           _;
       }

       //function initialize() initializer public {
          // __Ownable_init();
           // Additional initialization if needed
      // }

       function listNFT(address _nftContract, uint256 _tokenId, uint256 _price) external onlyNFTOwner(_nftContract, _tokenId) notNFTListed(_nftContract, _tokenId) {
           // Create a listing with seller, price, and set isListed to true
           tokenListings[_nftContract][_tokenId] = Listing({
               seller: msg.sender,
               price: _price,
               isListed: true
           });

           // Emit NFTListed event
           emit NFTListed(_nftContract, _tokenId, msg.sender, _price);
       }

       function buyNFT(address _nftContract, uint256 _tokenId) external payable onlyNFTListed(_nftContract, _tokenId) {
           // Ensure reentrancy protection
           require(!tokenListings[_nftContract][_tokenId].isListed, "NFT already sold");
           tokenListings[_nftContract][_tokenId].isListed = false;

           // Require payment to match the listed price
           require(msg.value == tokenListings[_nftContract][_tokenId].price, "Incorrect payment amount");

           // Transfer ownership of the NFT to the buyer
           IERC721Upgradeable(_nftContract).safeTransferFrom(tokenListings[_nftContract][_tokenId].seller, msg.sender, _tokenId);

           // Transfer funds to the seller
           address payable seller = payable(tokenListings[_nftContract][_tokenId].seller);
           seller.transfer(msg.value);

           // Emit NFTSold event
           emit NFTSold(_nftContract, _tokenId, msg.sender, msg.value);
       }

       function cancelListing(address _nftContract, uint256 _tokenId) external onlyNFTOwner(_nftContract, _tokenId) onlyNFTListed(_nftContract, _tokenId) {
           // Update listing information, set isListed to false, and emit NFTListingCancelled event
           tokenListings[_nftContract][_tokenId].isListed = false;
           emit NFTListingCancelled(_nftContract, _tokenId, msg.sender);
       }

   }

    
