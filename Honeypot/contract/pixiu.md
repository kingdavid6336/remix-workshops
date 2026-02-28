Here, we introduce a simple ERC20 token contract called `Pixiu`. In this contract, only the contract owner can sell the tokens on Uniswap, while other addresses cannot.

`Pixiu` has a state variable called `pair`, which records the address of the `Pixiu-ETH LP` pair on Uniswap. It mainly consists of three functions:

1. Constructor: Initializes the token's name and symbol, and calculates the LP contract address based on the principles of Uniswap and `create2`. For more details, you can refer to [WTF Solidity 25: Create2](https://github.com/AmazingAng/WTF-Solidity/blob/main/Languages/en/25_Create2_en/readme.md). This address will be used in the `_beforeTokenTransfer()` function.
2. `mint()`: A minting function that can only be called by the `owner` address to mint `Pixiu` tokens.
3. `_beforeTokenTransfer()`: A function called before an ERC20 token transfer. In this function, we restrict the transfer when the destination address `to` is the LP address, which represents selling by investors. The transaction will `revert` unless the caller is the `owner`. This is the core of the Pixiu contract.