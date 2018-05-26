pragma solidity ^0.4.18;

import "./MintableToken.sol";


/**
 * @title Burnable Token
 * @dev Token that can be irreversibly burned (destroyed).
 */
contract BurnableToken is MintableToken {

    mapping(address => uint) burnBalance;

    event BurnReserved(address indexed _burner, uint _amount);
    event BurnRecovered(address indexed _burner, uint _amount);
    event BurnExecuted(address indexed _burner, uint _amount);

    /**
     * @dev Reserves specific amount of tokens for burning
     * @param _amount The amount of token to be burned.
     */
    function burnReserve(uint _amount) whenNotPaused public {
        require(_amount <= balances[msg.sender]);

        address burner_ = msg.sender;
        burnBalance[burner_] = burnBalance[burner_].add(_amount);
        balances[burner_] = balances[burner_].sub(_amount);
        BurnReserved(burner_, _amount);
    }

    function burnRecover(address _burner) onlyOwner whenNotPaused public {
        //get burner balance
        uint burnerBalance_ = burnBalance[_burner];
        require(burnerBalance_ > 0);

        balances[_burner] = balances[_burner].add(burnerBalance_);
        burnBalance[_burner] = 0;
        BurnRecovered(_burner, burnerBalance_);
    }

    function burnExecute(address _burner) onlyOwner whenNotPaused public {
        return burnExecuteAndMint(_burner, true);
    }

    function burnExecuteAndMint(address _burner, bool _toMint) onlyOwner whenNotPaused public {
        uint burnerBalance_ = burnBalance[_burner];
        totalSupply = totalSupply.sub(burnerBalance_);
        burnBalance[_burner] = 0;
        BurnExecuted(_burner, burnerBalance_);
        if (_toMint) {
            mint(burnerBalance_);
        }
    }

    function burnBalanceOf(address _owner) public constant returns (uint balance) {
        return burnBalance[_owner];
    }

    function burnBalanceMy() public constant returns (uint balance) {
        return burnBalance[msg.sender];
    }
}
