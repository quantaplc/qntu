pragma solidity ^0.4.18;

/**
 * @title SafeMath
 * @dev Math operations with safety checks that throw on error
 */
library SafeMath {

    /**
     * @dev Multiplies two numbers, throws on overflow.
     */
    function mul(uint _a, uint _b)
        internal
        pure
        returns (uint)
    {
        if (_a == 0) {
            return 0;
        }
    
        uint c = _a * _b;
        assert(c / _a == _b);
        return c;
    }

    /**
     * @dev Integer division of two numbers, truncating the quotient.
     */
    function div(uint _a, uint _b)
        internal
        pure
        returns (uint)
    {
        // Solidity automatically throws when dividing by 0
        uint c = _a / _b;
        return c;
    }

    /**
     * @dev Substracts two numbers, throws on overflow (i.e. if subtrahend is greater than minuend).
     */
    function sub(uint _a, uint _b)
        internal
        pure
        returns (uint)
    {
        assert(_b <= _a);
        return _a - _b;
    }

    /**
     * @dev Adds two numbers, throws on overflow.
     */
    function add(uint _a, uint _b)
        internal
        pure
        returns (uint)
    {
        uint c = _a + _b;
        assert(c >= _a);
        return c;
    }

}