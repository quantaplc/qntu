pragma solidity ^0.4.18;

/**
 * @title ReceivingContract Interface
 * @dev ReceivingContract handle incoming token transfers.
 */
contract ReceivingContract {

    /**
     * @dev Handle incoming token transfers.
     * @param _from The token sender address.
     * @param _value The amount of tokens.
     */
    function tokenFallback(address _from, uint _value) public;

}