In order to better understand this cross-chain bridge, we will build a simple cross-chain bridge and implement ERC20 token transfer between the Goerli test network and the Sepolia test network. We use the burn/mint method, the tokens on the source chain will be destroyed and created on the target chain. This cross-chain bridge consists of a smart contract (deployed on both chains) and an Ethers.js script.

> **Please note**, this is a very simple cross-chain bridge implementation and is for educational purposes only. It does not deal with some possible problems, such as transaction failure, chain reorganization, etc. In a production environment, it is recommended to use a professional cross-chain bridge solution or other fully tested and audited frameworks.

### Cross-chain token contract

First, we need to deploy an ERC20 token contract, `CrossChainToken`, on the Goerli and Sepolia testnets. This contract defines the name, symbol, and total supply of the token, as well as a `bridge()` function for cross-chain transfers.

This contract has three main functions:

- `constructor()`: The constructor, which will be called once when deploying the contract, is used to initialize the name, symbol and total supply of the token.

- `bridge()`: The user calls this function to perform cross-chain transfer. It will destroy the number of tokens specified by the user and release the `Bridge` event.

- `mint()`: Only the owner of the contract can call this function to handle cross-chain events and release the `Mint` event. When the user calls the `bridge()` function on another chain to destroy the token, the script will listen to the `Bridge` event and mint the token for the user on the target chain.
