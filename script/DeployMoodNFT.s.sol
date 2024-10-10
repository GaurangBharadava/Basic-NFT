// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script, console} from "forge-std/Script.sol";
import {MoodNFT} from "../src/MoodNFT.sol";
import {Base64} from "@openzeppelin/constracts/utils/Base64.sol";

contract DeployMoodNFT is Script {
    MoodNFT moodNft;
     
    function run() external returns(MoodNFT) {
        string memory happySvg = vm.readFile('./img/Happy.svg');
        string memory sadSvg = vm.readFile('./img/Sad.svg');
        
        vm.startBroadcast();
        moodNft = new MoodNFT(svgToImageUri(sadSvg),svgToImageUri(happySvg));
        vm.stopBroadcast();
        return moodNft;
    }

    //this function automatically encode our svg into bytes string.
    function svgToImageUri(string memory svg) public pure returns (string memory) {
        string memory baseURI = "data:image/svg+xml;base64,";
        bytes memory svgBytes = bytes(svg);
        string memory svgBase64Encoded = Base64.encode(
            bytes(string(abi.encodePacked(svgBytes))) // Removing unnecessary type castings, this line can be resumed as follows : 'abi.encodePacked(svg)'
        );


        return string(abi.encodePacked(baseURI, svgBase64Encoded));
    }
}