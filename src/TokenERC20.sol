// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "solmate/tokens/ERC20.sol";
import "openzeppelin-contracts/contracts/security/Pausable.sol";
import "openzeppelin-contracts/contracts/access/Ownable.sol";
import "openzeppelin-contracts/contracts/token/ERC20/utils/TokenTimelock.sol";


contract DescomplicaToken is ERC20, TokenTimelock, Pausable, Ownable {
    
    constructor(uint256 _totalSupply, string memory _name, string memory _symbol) //todas as definições do construtor estão no contrato da solmate
        ERC20(_name, _symbol, 18) 
        TokenTimelock(IERC20(address(this)), 0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2, 1679339410){ //https://www.epochconverter.com/ - inserir o atual mais 100
        //as definições acima são referentes ao tempo de travamento do token no contrato e qual benefciário só poderá pegar depois de passar o prazo
        _mint(address(this), 100);//mintando no contrato
        totalSupply = _totalSupply;
    }

    function pause() public onlyOwner {
        _pause();
    }

    function unpause() public onlyOwner {
        _unpause();
    }

    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }

    function _release() public  { //o beneficiário conseguirá executar depois do prazo estipulado
        release();
    }
   
}

