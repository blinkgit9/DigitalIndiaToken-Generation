//SPDX License Identifier: MIT
// SPDX-License-Identifier: MIT
pragma solidity 0.8.29;

abstract contract ERC20 {
    function TransferFrom(address _from, address _to, uint256 _value) public virtual returns (bool success);
    function decimals() public virtual view returns (uint8);

}


contract DITSale {
    uint public  tokenPriceinWei = 1 ether;
    ERC20 public token;
    address public  TokenOwner;

    constructor(address _token) {
        TokenOwner = msg.sender;
        token = ERC20(_token);

    }
    
    function PurchaseDIT() public payable {
        require(msg.value >= tokenPriceinWei, "Not enough ether");
        uint tokenToTranfer = msg.value / tokenPriceinWei;
        uint remainder = msg.value - tokenToTranfer * tokenPriceinWei;
        token.TransferFrom(TokenOwner,msg.sender , tokenToTranfer * 10 ** token.decimals());
        payable (msg.sender).transfer(remainder);   // send the rest ether back
        paymentReceived();
    }
    
    function paymentReceived() public virtual {}
}