pragma solidity ^0.4.18;

import "./BaseToken.sol";

/**
 * @title Mintable token
 * @dev Simple ERC20 Token example, with mintable token creation
 * @dev Issue: * https://github.com/OpenZeppelin/zeppelin-solidity/issues/120
 * Based on code by TokenMarketNet: https://github.com/TokenMarketNet/ico/blob/master/contracts/MintableToken.sol
 */
contract MintableToken is BaseToken {

    /* Token supply got increased and a new owner received these tokens */
    event Minted(address indexed receiver, uint amount);

    /**
     * @dev Function to mint tokens
     * @param _amount The amount of tokens to mint.
     * @return A boolean that indicates if the operation was successful.
     */
    function mint(uint _amount) onlyOwner whenNotPaused public returns (bool) {
        totalSupply = totalSupply.add(_amount);
        address to_ = msg.sender;
        balances[to_] = balanceOf(to_).add(_amount);
        Minted(to_, _amount);
        return true;
    }
}
