pragma solidity ^0.4.18;

import "./BurnableToken.sol";

contract BurnVilleToken is BurnableToken {

    uint256 public unitPrice;       // How many units of BURN can be bought by 1 ETH?
    uint256 public totalEthInWei;   // We'll store the total ETH raised here.
    address public mainWallet;      // The owner of the contract

    //    function BurnVilleToken(uint _amount) public payable {
    function BurnVilleToken() public {
        name = "Burn Token";
        symbol = "BURN";
        decimals = 18;
        version = 'BURN_1.0';

        unitPrice = 2000;  // Set the price of your token for the ICO

        totalSupply = 75000000 * 1000000000000000000;
        balances[msg.sender] = totalSupply;
        mainWallet = msg.sender;
    }

    /**
     * Don't expect to just send in money and get tokens.
     */
    function () public payable {
        revert();
    }

}
