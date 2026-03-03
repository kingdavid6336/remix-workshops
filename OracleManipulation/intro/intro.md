In this lesson, we will introduce the oracle manipulation attack on smart contracts and reproduce it using Foundry. In the example, we use `1 ETH` to exchange for 17 trillion stablecoins. In 2021, oracle manipulation attacks caused user asset losses of more than 200 million U.S. dollars.

## Price Oracle

For security reasons, the Ethereum Virtual Machine (EVM) is a closed and isolated sandbox. Smart contracts running on the EVM can access on-chain information but cannot actively communicate with the outside world to obtain off-chain information. However, this type of information is crucial for decentralized applications.

An oracle can help us solve this problem by obtaining information from off-chain data sources and adding it to the blockchain for smart contract use.

One of the most commonly used oracles is a price oracle, which refers to any data source that allows you to query the price of a token. Typical use cases include:

- Decentralized lending platforms (AAVE) use it to determine if a borrower has reached the liquidation threshold.
- Synthetic asset platforms (Synthetix) use it to determine the latest asset prices and support 0-slippage trades.
- MakerDAO uses it to determine the price of collateral and mint the corresponding stablecoin, DAI.

![](https://raw.githubusercontent.com/remix-project-org/remix-workshops/master/OracleManipulation/img/S15-1.png)

## Oracle Vulnerabilities

If an oracle is not used correctly by developers, it can pose significant security risks.

- In October 2021, Cream Finance, a DeFi platform on the Binance Smart Chain, suffered a [theft of $130 million in user funds](https://rekt.news/cream-rekt-2/) due to an Oracle vulnerability.
- In May 2022, Mirror Protocol, a synthetic asset platform on the Terra blockchain, suffered a [theft of $115 million in user funds](https://rekt.news/mirror-rekt/) due to an Oracle vulnerability.
- In October 2022, Mango Market, a decentralized lending platform on the Solana blockchain, suffered a [theft of $115 million in user funds](https://rekt.news/mango-markets-rekt/) due to an Oracle vulnerability.
