Renowned blockchain security expert `samczsun` summarized how to prevent oracle manipulation in a [blog post](https://www.paradigm.xyz/2020/11/so-you-want-to-use-a-price-oracle). Here's a summary:

1. Avoid using pools with low liquidity as price oracles.
2. Avoid using spot/instant prices as price oracles; incorporate price delays, such as Time-Weighted Average Price (TWAP).
3. Use decentralized oracles.
4. Use multiple data sources and select the ones closest to the median price as oracles to avoid extreme situations.
5. Carefully read the documentation and parameter settings of third-party price oracles.

## Conclusion

In this lesson, we introduced the manipulation of price oracles and attacked a vulnerable synthetic stablecoin contract, exchanging `1 ETH` for 17 trillion stablecoins, making us the richest person in the world (not really).
