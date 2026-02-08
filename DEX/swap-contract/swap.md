The complete code of `SimpleSwap` is as follows:

## Remix Reappearance

1. Deploy two ERC20 token contracts (token0 and token1) and record their contract addresses.

2. Deploy the `SimpleSwap` contract and fill in the token address above.

3. Call the `approve()` function of the two ERC20 tokens to authorize 1000 units of tokens to the `SimpleSwap` contract respectively.

4. Call the `addLiquidity()` function of the `SimpleSwap` contract to add liquidity to the exchange, and add 100 units to token0 and token1 respectively.

5. Call the `balanceOf()` function of the `SimpleSwap` contract to view the user’s LP share, which should be 100. ($\sqrt{100*100}=100$)

6. Call the `swap()` function of the `SimpleSwap` contract to trade tokens, using 100 units of token0.

7. Call the `reserve0` and `reserve1` functions of the `SimpleSwap` contract to view the token reserves in the contract, which should be 200 and 50. In the previous step, we used 100 units of token0 to exchange 50 units of token 1 ($\frac{100*100}{100+100}=50$).

## Summary

In this lecture, we introduced the constant product automatic market maker and wrote a minimalist decentralized exchange. In the minimalist Swap contract, we have many parts that we have not considered, such as transaction fees and governance parts. If you are interested in decentralized exchanges, it is recommended that you read [Programming DeFi: Uniswap V2](https://jeiwan.net/posts/programming-defi-uniswapv2-1/) and [Uniswap v3 book](https: //y1cunhui.github.io/uniswapV3-book-zh-cn/) for more in-depth learning.
