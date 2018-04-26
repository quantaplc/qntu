pragma solidity ^0.4.18;

import "./../interface/UpgradeAgent.sol";

/**
 * Only for test
 */
contract UpgradeToken is UpgradeAgent {

    mapping(address => uint) public balanceOf;

    function upgradeFrom(address _from, uint _value)
        public
    {
        balanceOf[_from] = _value;
    }

}