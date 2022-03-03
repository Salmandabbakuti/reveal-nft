// SPDX-License-Identifier: MIT
pragma solidity ^0.8.3;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v4.5.0/contracts/token/ERC721/extensions/ERC721URIStorage.sol";

contract NFTReveal is ERC721URIStorage {
  
    address public owner;
    uint256 tokenId;
    bool private isRevealed;

    constructor() ERC721("Flower Collection", "FLWR") {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can perform this action");
        _;
    }

    function mintToken(string memory _tokenURI) public onlyOwner {
        _safeMint(msg.sender, tokenId);
        _setTokenURI(tokenId, _tokenURI);
        tokenId++;
    }

    function tokenURI(uint256 _tokenId)
        public
        view
        virtual
        override
        returns (string memory)
    {
        if (isRevealed) return super.tokenURI(_tokenId);
        return "https://salmandabbakuti.github.io/reveal-nft/metadata/notRevealed.json";
    }

    function reveal() public onlyOwner {
        isRevealed = true;
    }

    function hide() public onlyOwner {
        isRevealed = false;
    }
}
