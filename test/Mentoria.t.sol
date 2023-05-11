// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.10;

import "forge-std/Test.sol";
import "../src/MentoringV2.sol";

contract mentoriaNFTtest is Test {
    using stdStorage for StdStorage;

    Mentoring private nft;
     address public owner = makeAddr("owner");
    address public user = makeAddr("user");
    address public fullUser = makeAddr("fullUser");

    function setUp() public {
        // Deploy NFT contract
        vm.startPrank(owner);
        nft = new Mentoring("baseUri", 1 ether, 50 wei);
         vm.stopPrank();
    }

    function testSetApprAddr() public{
        vm.prank(address(owner));
        nft.setApprAddr(user, true);
    }
    function testPause() public{
    vm.prank(address(owner));
    nft.pause();
}

    function testFailOwner() public{
        vm.prank(address(user));
        nft.unpause();
    }

    function testInterestMint() public{
        vm.startPrank(address(owner), address(user));
        nft.setApprAddr(user, true);
        nft.setPrices(1 ether, 2 ether);
        nft.interest{value: nft.priceSign()}(1, "olamun", "emil", "redesocial");
        nft.acceptOmnes(user);
    }


}

