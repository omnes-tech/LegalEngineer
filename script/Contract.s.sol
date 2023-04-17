// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Script.sol";

import "src/LegalEngineer.sol";

contract ContractScript is Script {
    function setUp() public {}

    function run() public returns(address){
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");

        vm.startBroadcast(deployerPrivateKey);

        return address(new LegalEngineerCourse("https://bafybeic6pb52otefewwrowbjzmg2n7tsivjkydwx46pimvhkb32a4yqpnq.ipfs.nftstorage.link/"));

        vm.stopBroadcast();
    }
}
