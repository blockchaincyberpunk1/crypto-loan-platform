// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

/**
 * @title SafeMath
 * @dev Unsigned math operations with safety checks that revert on error.
 * This library is used to prevent overflow and underflow incidents in arithmetic operations.
 */
library SafeMath {
    /**
     * @dev Adds two unsigned integers, reverts on overflow.
     * @param a The first number to add.
     * @param b The second number to add.
     * @return uint256 The sum of `a` and `b`.
     */
    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a + b;
        require(c >= a, "SafeMath: addition overflow");

        return c;
    }

    /**
     * @dev Subtracts two unsigned integers, reverts on underflow (i.e., subtracting more than is available).
     * @param a The first number to subtract from.
     * @param b The second number to subtract.
     * @return uint256 The difference of `a` and `b`.
     */
    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        require(b <= a, "SafeMath: subtraction underflow");
        uint256 c = a - b;

        return c;
    }

    /**
     * @dev Multiplies two unsigned integers, reverts on overflow.
     * @param a The first number to multiply.
     * @param b The second number to multiply.
     * @return uint256 The product of `a` and `b`.
     */
    function mul(uint256 a, uint256 b) internal pure returns (uint256) {
        // Gas optimization: this is cheaper than requiring 'a' not being zero, but the
        // benefit is lost if 'b' is also tested.
        // See: https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/math/SafeMath.sol
        if (a == 0) {
            return 0;
        }

        uint256 c = a * b;
        require(c / a == b, "SafeMath: multiplication overflow");

        return c;
    }

    /**
     * @dev Divides two unsigned integers and returns the quotient, reverts on division by zero.
     * @param a The dividend.
     * @param b The divisor.
     * @return uint256 The quotient of dividing `a` by `b`.
     */
    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        require(b > 0, "SafeMath: division by zero");
        uint256 c = a / b;
        // assert(a == b * c + a % b); // There is no case in which this doesn't hold

        return c;
    }

    /**
     * @dev Divides two unsigned integers, returns the remainder, reverts when dividing by zero.
     * @param a The dividend.
     * @param b The divisor.
     * @return uint256 The remainder of dividing `a` by `b`.
     */
    function mod(uint256 a, uint256 b) internal pure returns (uint256) {
        require(b != 0, "SafeMath: modulo by zero");
        return a % b;
    }
}
