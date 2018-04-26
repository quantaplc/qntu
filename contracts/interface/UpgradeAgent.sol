pragma solidity ^0.4.18;

/**
 * @title UpgradeAgent Interface
 * @dev Upgrade agent transfers tokens to a new contract. Upgrade agent itself can be the
 * token contract, or just a middle man contract doing the heavy lifting.
 */
contract UpgradeAgent {

    bool public isUpgradeAgent = true;

    function upgradeFrom(address _from, uint _value) public;

}