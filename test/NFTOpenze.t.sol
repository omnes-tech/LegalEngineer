// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.10;

import "forge-std/Test.sol";
import "../src/NftSmDireito.sol";

contract NFTTest is Test {
    using stdStorage for StdStorage;

    SmartContracteDireito private nft;

    uint256 _cost = 0;
    string _baseURI = "BaseURI";

    function setUp() public {
        // Deploy NFT contract
        nft = new SmartContracteDireito(_cost, _baseURI, address(1));
    }

    function testMintPricePaid() public {
        uint256 id = 1;
        nft.safeMint(address(1), id);
    }

}