
pragma solidity ^0.4.18;

import "./EIP20Interface.sol";


contract Wallet {

    address private owner;
    mapping (EIP20Interface => uint256) public balances;
    mapping (EIP20Interface => address) public myAddresses;

    modifier ownerOnly(){
        require(msg.sender == owner);
        _;
    }

    function Wallet() public {
        owner = msg.sender;
    }

    function transfer(address _to, uint256 _value, EIP20Interface _from) ownerOnly public returns (bool success) {
        require(balances[_from] >= _value);
        if(_from.transfer(myAddresses[_from], _to, _value)){}
            balances[_from] -= _value;
            Transfer(msg.sender, _to, _value);

            return true;
        }
        return false
    }

    function balanceOf(EIP20Interface _owner) ownerOnly public view returns (uint256 balance) {
        return balances[_owner];
    }

    function addToken(EIP20Interface _token, addres _myAddress) ownerOnly external return (bool) {
        balances[_token] = _token.balanceOf(_myAddress);
        myAddresses[_token] = _myAddress;
    }

}
