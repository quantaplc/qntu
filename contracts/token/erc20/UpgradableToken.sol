pragma solidity ^0.4.18;

import "./StandardToken.sol";
import "./../../interface/UpgradeAgent.sol";

/**
 * @title Upgradable token
 */
contract UpgradableToken is StandardToken {

    address public upgradeMaster;

    // The next contract where the tokens will be migrated.
    UpgradeAgent public upgradeAgent;

    bool public isUpgradable = false;

    // How many tokens we have upgraded by now.
    uint public totalUpgraded;

    /**
     * Events
     */
    event ChangeUpgradeMaster(address newMaster);
    event ChangeUpgradeAgent(address newAgent);
    event FreezeUpgrade();
    event UnfreezeUpgrade();
    event Upgrade(address indexed from, address indexed to, uint value);

    modifier onlyUpgradeMaster() {
        require(msg.sender == upgradeMaster);
        _;
    }

    modifier canUpgrade() {
        require(isUpgradable);
        _;
    }

    /**
     * Change the upgrade master.
     * @param _newMaster New upgrade master.
     */
    function changeUpgradeMaster(address _newMaster)
        public
        onlyOwner
    {
        require(_newMaster != 0);

        upgradeMaster = _newMaster;
        ChangeUpgradeMaster(_newMaster);
    }

    /**
     * Change the upgrade agent.
     * @param _newAgent New upgrade agent.
     */
    function changeUpgradeAgent(address _newAgent)
        public
        onlyOwner
    {
        require(totalUpgraded == 0);

        upgradeAgent = UpgradeAgent(_newAgent);

        require(upgradeAgent.isUpgradeAgent());

        ChangeUpgradeAgent(_newAgent);
    }

    /**
     * Disallow to upgrade token to new smart contract
     */
    function freezeUpgrade()
        public
        onlyOwner
    {
        isUpgradable = false;
        FreezeUpgrade();
    }

    /**
     * Allow to upgrade token to new smart contract
     */
    function unfreezeUpgrade()
        public
        onlyOwner
    {
        isUpgradable = true;
        UnfreezeUpgrade();
    }

    /**
     * Token holder upgrade their tokens to a new smart contract.
     */
    function upgrade()
        public
        canUpgrade
    {
        uint amount = balanceOf[msg.sender];

        require(amount > 0);

        processUpgrade(msg.sender, amount);
    }

    /**
     * Upgrader upgrade tokens of holder to a new smart contract.
     * @param _holders List of token holder.
     */
    function forceUpgrade(address[] _holders)
        public
        onlyUpgradeMaster
        canUpgrade
    {
        uint amount;

        for (uint i = 0; i < _holders.length; i++) {
            amount = balanceOf[_holders[i]];

            if (amount == 0) {
                continue;
            }

            processUpgrade(_holders[i], amount);
        }
    }

    function processUpgrade(address _holder, uint _amount)
        private
    {
        balanceOf[_holder] = balanceOf[_holder].sub(_amount);

        // Take tokens out from circulation
        totalSupply = totalSupply.sub(_amount);
        totalUpgraded = totalUpgraded.add(_amount);

        // Upgrade agent reissues the tokens
        upgradeAgent.upgradeFrom(_holder, _amount);
        Upgrade(_holder, upgradeAgent, _amount);
    }

}