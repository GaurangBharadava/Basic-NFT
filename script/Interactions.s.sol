// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script} from "forge-std/Script.sol";
import {BasicNFT} from "../src/BasicNFT.sol";
import {DeployBasicNFT} from "./DeployBasicNFT.s.sol";
import {DevOpsTools} from "lib/foundry-devops/src/DevOpsTools.sol";

contract MintBasicNFT is Script {

    string public constant PUG = "ipfs://bafybeig37ioir76s7mg5oobetncojcm3c3hxasyd4rvid4jqhy4gkaheg4/?filename=0-PUG.json";

    function run() external {
        address mostRecentlyDeloyed = DevOpsTools.get_most_recent_deployment("BasicNFT",block.chainid);
        mintNftOnContract(mostRecentlyDeloyed);
    }

    function mintNftOnContract(address ContractAddress) public {
        vm.startBroadcast();
        BasicNFT(ContractAddress).mintNft(PUG);
        vm.stopBroadcast();
    }
}