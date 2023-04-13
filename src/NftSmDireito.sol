// SPDX-License-Identifier: MIT 
pragma solidity ^0.8.9; //expecificação da versão do compilador da linguagem solidity

//bibliotecas do Openzeppelin 
import "openzeppelin-contracts/contracts/security/Pausable.sol"; //que permite pausar determinadas funções
import "openzeppelin-contracts/contracts/access/Ownable.sol"; // que permite restrição de que o somente o dono do contrato pode executar determinadas funções
import "openzeppelin-contracts/contracts/token/ERC721/extensions/ERC721Enumerable.sol"; //enumerabilidade de todos os IDs de token no contrato, bem como todos os IDs de token pertencentes a cada conta.
import "openzeppelin-contracts/contracts/utils/Strings.sol";


//Inserir o código no Remix: https://remix.ethereum.org/
//
contract SmartContracteDireito is ERC721, Pausable, Ownable { //declaramos todas as importações acima

    uint256 public cost;//variável global/estável referente ao custo definido do NFT
    string baseURI;//variável global/estável referente ao metadado do NFT
    //metadado: definições de imagem e atributos do NFT
    constructor(uint256 _cost, string memory _initBaseURI, address _owner) ERC721("Nome", "simbolo") { //parametros iniciais antes do deploy do NFT
        setCost(_cost); //setando o custo do contrato
        setBaseURI(_initBaseURI); // setando o metadado devendo ser um link IPFS: https://ipfs.io/ipfs/CID
        _transferOwnership(_owner); // setando o endereço que será o dono do contrato
    } 

    function _baseURI() internal view override returns (string memory) {
        return baseURI; //função que retorna o metadado que foi definido como base
    }

    function setBaseURI(string memory _newBaseURI) public onlyOwner {
    baseURI = _newBaseURI;//função que permite que o dono do contrato possa setar um novo metadado
  }

    function setCost(uint256 _cost) public onlyOwner {
    cost = _cost; //função que permite o dono setar o novo custo do NFT
    }

    function pause() public onlyOwner {
        _pause();//que permite que o dono pause determinadas funções do contrato
    }

    function unpause() public onlyOwner {
        _unpause();//que permite que o dono despause determinadas funções do contrato
    }

    function safeMint(address to, uint256 tokenId) payable public whenNotPaused { //verifica se não está pausado o contrato e permite passar valores na função
        require(msg.value >= cost, 'Insufficient funds!');//requisição que verifica se o valor enviado na transação pe igual ou maior ao custo do NFT
        _safeMint(to, tokenId);//função importada do ERC721 que registra para onde vai e qual o id do NFT mintado
    }

    function withdraw() public payable onlyOwner { //função que permite o dono do contrato sacar todos os valores arrecadados da venda primária
    (bool os, ) = payable(owner()).call{value: address(this).balance}("");
    require(os);
  }
}
