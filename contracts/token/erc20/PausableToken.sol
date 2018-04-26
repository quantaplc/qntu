pragma solidity ^0.4.18;

import "./StandardToken.sol";

/**
 * @title Pausable token
 * @dev Token that can be freeze "Transfer" function
 */
contract PausableToken is StandardToken {

    bool public isTradable = true;

    /**
     * Events
     */
    event FreezeTransfer();
    event UnfreezeTransfer();

    modifier canTransfer() {
        require(isTradable);
        _;
    }

    /**
     * Disallow to transfer token from an address to other address
     */
    function freezeTransfer()
        public
        onlyOwner
    {
        isTradable = false;
        FreezeTransfer();
    }

    /**
     * Allow to transfer token from an address to other address
     */
    function unfreezeTransfer()
        public
        onlyOwner
    {
        isTradable = true;
        UnfreezeTransfer();
    }

    /**
     * @dev Transfer token for a specified address
     * @param _to The address to transfer to.
     * @param _value The amount to be transferred.
     */
    function transfer(address _to, uint _value)
        public
        canTransfer
        returns (bool)
    {
        return super.transfer(_to, _value);
    }

    /**
     * @dev Transfer tokens from one address to another
     * @param _from The address which you want to send tokens from
     * @param _to The address which you want to transfer to
     * @param _value The amount of tokens to be transferred
     */
    function transferFrom(address _from, address _to, uint _value)
        public
        canTransfer
        returns (bool)
    {
        return super.transferFrom(_from, _to, _value);
    }

    /**
     * @dev Approve the passed address to spend the specified amount of tokens on behalf of msg.sender.
     *
     * Beware that changing an allowance with this method brings the risk that someone may use both the old
     * and the new allowance by unfortunate transaction ordering. One possible solution to mitigate this
     * race condition is to first reduce the spender's allowance to 0 and set the desired value afterwards:
     * https://github.com/ethereum/EIPs/issues/20#issuecomment-263524729
     *
     * @param _spender The address which will spend the funds.
     * @param _value The amount of tokens to be spent.
     */
    function approve(address _spender, uint _value)
        public
        canTransfer
        returns (bool)
    {
        return super.approve(_spender, _value);
    }

    /**
     * @dev Increase the amount of tokens that an owner allowed to a spender.
     *
     * approve should be called when allowed[_spender] == 0. To increment
     * allowed value is better to use this function to avoid 2 calls (and wait until
     * the first transaction is mined)
     *
     * @param _spender The address which will spend the funds.
     * @param _addedValue The amount of tokens to increase the allowance by.
     */
    function increaseApproval(address _spender, uint _addedValue)
        public
        canTransfer
        returns (bool)
    {
        return super.increaseApproval(_spender, _addedValue);
    }

    /**
     * @dev Decrease the amount of tokens that an owner allowed to a spender.
     *
     * approve should be called when allowed[_spender] == 0. To decrement
     * allowed value is better to use this function to avoid 2 calls (and wait until
     * the first transaction is mined)
     *
     * @param _spender The address which will spend the funds.
     * @param _subtractedValue The amount of tokens to decrease the allowance by.
     */
    function decreaseApproval(address _spender, uint _subtractedValue)
        public
        canTransfer
        returns (bool)
    {
        return super.decreaseApproval(_spender, _subtractedValue);
    }

}