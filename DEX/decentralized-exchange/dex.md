Next, we use smart contracts to write a decentralized exchange `SimpleSwap` to support users to trade a pair of tokens.

`SimpleSwap` inherits the ERC20 token standard and facilitates the recording of liquidity provided by liquidity providers. In the constructor, we specify a pair of token addresses `token0` and `token1`. The exchange only supports this pair of tokens. `reserve0` and `reserve1` record the reserve amount of tokens in the contract.

```solidity
contract SimpleSwap is ERC20 {
     //Token contract
     IERC20 public token0;
     IERC20 public token1;

     //Token reserve amount
     uint public reserve0;
     uint public reserve1;
    
     //Constructor, initialize token address
     constructor(IERC20 _token0, IERC20 _token1) ERC20("SimpleSwap", "SS") {
         token0 = _token0;
         token1 = _token1;
    }
}
```

There are two main types of participants in the exchange: Liquidity Provider (LP) and Trader. Below we implement the functions of these two parts respectively.

### Liquidity Provision

Liquidity providers provide liquidity to the market, allowing traders to obtain better quotes and liquidity, and charge a certain fee.

First, we need to implement the functionality to add liquidity. When a user adds liquidity to the token pool, the contract records the added LP share. According to Uniswap V2, LP share is calculated as follows:

1. When liquidity is added to the token pool for the first time, the LP share $\Delta{L}$ is determined by the square root of the product of the number of added tokens:

     $$\Delta{L}=\sqrt{\Delta{x} *\Delta{y}}$$

1. When liquidity is not added for the first time, the LP share is determined by the ratio of the number of added tokens to the pool’s token reserves (the smaller of the two tokens):

     $$\Delta{L}=L*\min{(\frac{\Delta{x}}{x}, \frac{\Delta{y}}{y})}$$

Because the `SimpleSwap` contract inherits the ERC20 token standard, after calculating the LP share, the share can be minted to the user in the form of tokens.

The following `addLiquidity()` function implements the function of adding liquidity. The main steps are as follows:

1. To transfer the tokens added by the user to the contract, the user needs to authorize the contract in advance.
2. Calculate the added liquidity share according to the formula and check the number of minted LPs.
3. Update the token reserve of the contract.
4. Mint LP tokens for liquidity providers.
5. Release the `Mint` event.

```solidity
event Mint(address indexed sender, uint amount0, uint amount1);

// Add liquidity, transfer tokens, and mint LP
// @param amount0Desired The amount of token0 added
// @param amount1Desired The amount of token1 added
function addLiquidity(uint amount0Desired, uint amount1Desired) public returns(uint liquidity){
     // To transfer the added liquidity to the Swap contract, you need to give the Swap contract authorization in advance.
     token0.transferFrom(msg.sender, address(this), amount0Desired);
     token1.transferFrom(msg.sender, address(this), amount1Desired);
     // Calculate added liquidity
     uint _totalSupply = totalSupply();
     if (_totalSupply == 0) {
         // If liquidity is added for the first time, mint L = sqrt(x * y) units of LP (liquidity provider) tokens
         liquidity = sqrt(amount0Desired * amount1Desired);
     } else {
         // If it is not the first time to add liquidity, LP will be minted in proportion to the number of added tokens, and the smaller ratio of the two tokens will be used.
         liquidity = min(amount0Desired * _totalSupply / reserve0, amount1Desired * _totalSupply /reserve1);

   // Check the amount of LP minted
     require(liquidity > 0, 'INSUFFICIENT_LIQUIDITY_MINTED');

     // Update reserve
     reserve0 = token0.balanceOf(address(this));
     reserve1 = token1.balanceOf(address(this));

     // Mint LP tokens for liquidity providers to represent the liquidity they provide
     _mint(msg.sender, liquidity);
    
     emit Mint(msg.sender, amount0Desired, amount1Desired);
}
```

Next, we need to implement the functionality to remove liquidity. When a user removes liquidity $\Delta{L}$ from the pool, the contract must destroy the LP share tokens and return the tokens to the user in proportion. The calculation formula for returning tokens is as follows:

$$\Delta{x}={\frac{\Delta{L}}{L} * x}$$
$$\Delta{y}={\frac{\Delta{L}}{L} * y}$$

The following `removeLiquidity()` function implements the function of removing liquidity. The main steps are as follows:

1. Get the token balance in the contract.
2. Calculate the number of tokens to be transferred according to the proportion of LP.
3. Check the number of tokens.
4. Destroy LP shares.
5. Transfer the corresponding tokens to the user.
6. Update reserves.
5. Release the `Burn` event.

```solidity
// Remove liquidity, destroy LP, and transfer tokens
// Transfer quantity = (liquidity / totalSupply_LP) * reserve
// @param liquidity The amount of liquidity removed
function removeLiquidity(uint liquidity) external returns (uint amount0, uint amount1) {
     // Get balance
     uint balance0 = token0.balanceOf(address(this));
     uint balance1 = token1.balanceOf(address(this));
     // Calculate the number of tokens to be transferred according to the proportion of LP
     uint _totalSupply = totalSupply();
     amount0 = liquidity * balance0 / _totalSupply;
     amount1 = liquidity * balance1 / _totalSupply;
     // Check the number of tokens
     require(amount0 > 0 && amount1 > 0, 'INSUFFICIENT_LIQUIDITY_BURNED');
     // Destroy LP
_burn(msg.sender, liquidity);
     // Transfer tokens
     token0.transfer(msg.sender, amount0);
     token1.transfer(msg.sender, amount1);
     // Update reserve
     reserve0 = token0.balanceOf(address(this));
     reserve1 = token1.balanceOf(address(this));

     emit Burn(msg.sender, amount0, amount1);
}
```

At this point, the functions related to the liquidity provider in the contract are completed, and the next step is the transaction part.

### trade

In a Swap contract, users can trade one token for another. So how many units of token1 can I exchange for $\Delta{x}$ units of token0? Let us briefly derive it below.

According to the constant product formula, before trading:

```text
$$k=x*y$$

```

After the transaction, there are:

```text
$$k=(x+\Delta{x})*(y+\Delta{y})$$
```

The value of $k$ remains unchanged before and after the transaction. Combining the above equations, we can get:

$$\Delta{y}=-\frac{\Delta{x}*y}{x+\Delta{x}}$$

Therefore, the number of tokens $\Delta{y}$ that can be exchanged is determined by $\Delta{x}$, $x$, and $y$. Note that $\Delta{x}$ and $\Delta{y}$ have opposite signs, as transferring in increases the token reserve, while transferring out decreases it.

The `getAmountOut()` below implements, given the amount of an asset and the reserve of a token pair, calculates the amount to exchange for another token.

```solidity
// Given the amount of an asset and the reserve of a token pair, calculate the amount to exchange for another token
function getAmountOut(uint amountIn, uint reserveIn, uint reserveOut) public pure returns (uint amountOut) {
    require(amountIn > 0, 'INSUFFICIENT_AMOUNT');
    require(reserveIn > 0 && reserveOut > 0, 'INSUFFICIENT_LIQUIDITY');
    amountOut = amountIn * reserveOut / (reserveIn + amountIn);
}
```

With this core formula in place, we can start implementing the trading function. The following `swap()` function implements the function of trading tokens. The main steps are as follows:

1. When calling the function, the user specifies the number of tokens for exchange, the address of the exchanged token, and the minimum amount for swapping out another token.
2. Determine whether token0 is exchanged for token1, or token1 is exchanged for token0.
3. Use the above formula to calculate the number of tokens exchanged.
4. Determine whether the exchanged tokens have reached the minimum number specified by the user, which is similar to the slippage of the transaction.
5. Transfer the user’s tokens to the contract.
6. Transfer the exchanged tokens from the contract to the user.
7. Update the token reserve of the contract.
8. Release the `Swap` event.

```solidity
// swap tokens
// @param amountIn the number of tokens used for exchange
// @param tokenIn token contract address used for exchange
// @param amountOutMin the minimum amount to exchange for another token
function swap(uint amountIn, IERC20 tokenIn, uint amountOutMin) external returns (uint amountOut, IERC20 tokenOut){
    require(amountIn > 0, 'INSUFFICIENT_OUTPUT_AMOUNT');
    require(tokenIn == token0 || tokenIn == token1, 'INVALID_TOKEN');
    
    uint balance0 = token0.balanceOf(address(this));
    uint balance1 = token1.balanceOf(address(this));

    if(tokenIn == token0){
// If token0 is exchanged for token1
         tokenOut = token1;
         // Calculate the number of token1 that can be exchanged
         amountOut = getAmountOut(amountIn, balance0, balance1);
         require(amountOut > amountOutMin, 'INSUFFICIENT_OUTPUT_AMOUNT');
         //Exchange
         tokenIn.transferFrom(msg.sender, address(this), amountIn);
         tokenOut.transfer(msg.sender, amountOut);
     }else{
         // If token1 is exchanged for token0
         tokenOut = token0;
         // Calculate the number of token1 that can be exchanged
        amountOut = getAmountOut(amountIn, balance1, balance0);
        require(amountOut > amountOutMin, 'INSUFFICIENT_OUTPUT_AMOUNT');
        //Exchange
         tokenIn.transferFrom(msg.sender, address(this), amountIn);
         tokenOut.transfer(msg.sender, amountOut);
     }

     // Update reserve
     reserve0 = token0.balanceOf(address(this));
     reserve1 = token1.balanceOf(address(this));

    emit Swap(msg.sender, amountIn, address(tokenIn), amountOut, address(tokenOut));
}
```
