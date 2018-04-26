pragma solidity ^0.4.18;

/**
 * @title Ownable
 * @dev The Ownable contract has an owner address, and provides basic authorization control
 * functions, this simplifies the implementation of "user permissions".
 */
contract Ownable {

    address public owner;

    /**
     * Events
     */
    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    /**
     * @dev Throws if called by any account other than the owner.
     */
    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }

    /**
     * @dev Constructor
     * Sets the original `owner` of the contract to the sender account.
     */
    function Ownable() public {
        owner = msg.sender;
        OwnershipTransferred(0, owner);
    }

    /**
     * @dev Allows the current owner to transfer control of the contract to a new owner.
     * @param _newOwner The address to transfer ownership to.
     */
    function transferOwnership(address _newOwner)
        public
        onlyOwner
    {
        require(_newOwner != 0);

        OwnershipTransferred(owner, _newOwner);
        owner = _newOwner;
    }

}