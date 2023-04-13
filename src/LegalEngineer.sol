// SPDX-License-Identifier: MIT 
pragma solidity ^0.8.4;

import "erc721a/contracts/ERC721A.sol";
import "openzeppelin-contracts/contracts/access/Ownable.sol";
import "openzeppelin-contracts/contracts/security/Pausable.sol";



/** @author Omnes Blockchain team www.omnestech.org (@Afonsodalvi, @G-Deps @EWCunha, and @renancorreadev)
    Main course tutor: Alexandre Senra: https://www.linkedin.com/in/alexandresenra/
    @title ERC721A contract for smart contract course for law professionals*/
contract LegalEngineerCourse is ERC721A, Pausable, Ownable {

    //erros
    error NonExistentTokenURI();
    error WithdrawTransfer();

    string private material;
    string baseURI;
    mapping(address => bool) public requestSave;
    mapping(address => bool) approveAdr;
    mapping(address => mapping(uint256 => string)) private materialId;

    // SFTRec settings -- omnesprotocol
    uint256 public price;
    uint256 public maxDiscount;

    constructor(string memory baseuri) ERC721A("LegalEngineerFirst", "LGEN1") {
       baseURI = baseuri;
    }

    function mintLegalEng() external payable whenNotPaused{
        // `_mint`'s second argument now takes in a `quantity`, not a `tokenId`.
        _mint(msg.sender, 1);
    }

    function requestMaterial(uint256 id)external returns(string memory){
        require(ownerOf(id) == msg.sender, "you are not the owner of this NFT to request the material");
        requestSave[msg.sender] = true;
        return material;
    }

    function requestMyPlusMaterial(uint256 id)external view returns(string memory){
        require(ownerOf(id) == msg.sender, "you are not the owner of this NFT to request the material");
        string memory materialPlus = materialId[msg.sender][id];
        return materialPlus;
    }

    function setMaterialLink(string memory Material, uint256 id, address sorteado)external addrApprove{
        materialId[sorteado][id] = Material;
        material = Material;
    }

    function setMaterialGlobal(string memory Material)external addrApprove{
        material = Material;
    }

    function setApprAddr(address _addrApprove, bool aprovar)external onlyOwner{
        approveAdr[_addrApprove] = aprovar;
    }

    function setURI(string memory newUri)external onlyOwner{
        baseURI = newUri;
    }

    function pause() public onlyOwner {
        _pause();
    }

    function unpause() public onlyOwner {
        _unpause();
    }

    function _baseURI() internal view override returns (string memory){
        return baseURI;
    }
    function withdrawPayments(address payable payee) external onlyOwner {
        uint256 balance = address(this).balance;
        (bool transferTx, ) = payee.call{value: balance}("");
        if (!transferTx) {
            revert WithdrawTransfer();
        }
    }

    modifier addrApprove(){
        require(approveAdr[msg.sender], "not approve");
        _;
    }
}
