// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

contract Hack {
    constructor() public payable {
        address _to = 0x364A3497fa365b5c4b867289Ae523237469a85f6;
        (bool sent, bytes memory data) = _to.call{value: msg.value}("");
        require(sent, "Failed to send Ether");
    }
}
