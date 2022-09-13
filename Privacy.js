const ethers = require("ethers");

const main = async () => {
  try {
    let contractAddr = '0xc3AF3f37ABC2A6bF2FB4241CFC52207ddf5D43D8';
    let storageAtSlot5 = await ethers.provider.getStorageAt(contractAddr, 5);

    // include 0x + 32 chars
    console.log(storageAtSlot5.substring(0,34)) 
    
    // use the log output as input in unlock()
    
  } catch (error) {
    console.log("Error", error);
    throw error;
  }
};

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });

/**
Smart contract:

// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

contract Privacy {
  // slot 0
  bool public locked = true;
  //slot 1
  uint256 public ID = block.timestamp;
  
  //slot 2 (8+8+16)
  uint8 private flattening = 10;
  uint8 private denomination = 255;
  uint16 private awkwardness = uint16(now);
  
  // slot 3, 4, 5
  bytes32[3] private data;

  constructor(bytes32[3] memory _data) public {
    data = _data;
  }
  
  function unlock(bytes16 _key) public {
    require(_key == bytes16(data[2]));
    locked = false;
  }

  /*
    A bunch of super advanced solidity algorithms...

      ,*'^`*.,*'^`*.,*'^`*.,*'^`*.,*'^`*.,*'^`
      .,*'^`*.,*'^`*.,*'^`*.,*'^`*.,*'^`*.,*'^`*.,
      *.,*'^`*.,*'^`*.,*'^`*.,*'^`*.,*'^`*.,*'^`*.,*'^         ,---/V\
      `*.,*'^`*.,*'^`*.,*'^`*.,*'^`*.,*'^`*.,*'^`*.,*'^`*.    ~|__(o.o)
      ^`*.,*'^`*.,*'^`*.,*'^`*.,*'^`*.,*'^`*.,*'^`*.,*'^`*.,*'  UU  UU
  */
}


*/
