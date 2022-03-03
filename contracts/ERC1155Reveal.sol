// SPDX-License-Identifier: MIT
pragma solidity ^0.8.3;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v4.5.0/contracts/token/ERC1155/ERC1155.sol";

contract NFTReveal is ERC1155 {
    
    address public owner;
    bool private isRevealed;
    string constant name = "Flower Collection";
    string constant symbol = "FLWR";

    constructor() ERC1155("https://salmandabbakuti.github.io/reveal-nft/metadata/{id}.json") {
        owner = msg.sender;
        _mint(msg.sender, 0, 200, "");
        _mint(msg.sender, 1, 120, "");
        _mint(msg.sender, 2, 1, "");
        _mint(msg.sender, 3, 50, "");
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can perform this action");
        _;
    }

    function uri(uint256 _tokenId)
        public
        view
        override
        returns (string memory)
    {
        if (isRevealed) return super.uri(_tokenId);
        return "https://salmandabbakuti.github.io/reveal-nft/metadata/notRevealed.json";
    }

    function reveal() public onlyOwner {
        isRevealed = true;
    }

    function hide() public onlyOwner {
        isRevealed = false;
    }
}
