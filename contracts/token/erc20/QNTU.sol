pragma solidity ^0.4.18;

import "./UpgradableToken.sol";
import "./PausableToken.sol";
import "./../../interface/ReceivingContract.sol";

/**
 * @title QNTU 1.0 token
 */
contract QNTU is UpgradableToken, PausableToken {

    /**
     * @dev Constructor
     */
    function QNTU(address[] _wallets, uint[] _amount)
        public
    {
        require(_wallets.length == _amount.length);

        symbol = "QNTU";
        name = "QNTU Token";
        decimals = 18;

        uint num = 0;
        uint length = _wallets.length;
        uint multiplier = 10 ** uint(decimals);

        for (uint i = 0; i < length; i++) {
            num = _amount[i] * multiplier;

            balanceOf[_wallets[i]] = num;
            Transfer(0, _wallets[i], num);

            totalSupply += num;
        }
    }

    /**
     * @dev Transfer token for a specified contract
     * @param _to The address to transfer to.
     * @param _value The amount to be transferred.
     */
    function transferToContract(address _to, uint _value)
        public
        canTransfer
        returns (bool)
    {
        require(_value > 0);

        balanceOf[msg.sender] = balanceOf[msg.sender].sub(_value);
        balanceOf[_to] = balanceOf[_to].add(_value);

        ReceivingContract receiver = ReceivingContract(_to);
        receiver.tokenFallback(msg.sender, _value);

        Transfer(msg.sender, _to, _value);
        return true;
    }

}