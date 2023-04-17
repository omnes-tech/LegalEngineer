// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Script.sol";

import "src/LegalEngineer.sol";

contract ContractScript is Script {
    function setUp() public {}

    function run() public returns(address){
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");

        vm.startBroadcast(deployerPrivateKey);

        return new LegalEngineerCourse("https://bafybeid7rsqvtd454ra4tkfa3y2vobmz75zexgxe6zndsj5jk23tbjdnsq.ipfs.nftstorage.link/");

        vm.stopBroadcast();
    }
}
