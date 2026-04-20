
In this lecture, we will introduce the Constant Product Automated Market Maker (CPAMM), which is the core mechanism of decentralized exchanges and is used by a series of DEXs such as Uniswap and PancakeSwap. The teaching contract is simplified from the [Uniswap-v2](https://github.com/Uniswap/v2-core) contract and includes the core functions of CPAMM.

## Automatic market maker

An Automated Market Maker (AMM) is an algorithm or a smart contract that runs on the blockchain, which allows decentralized transactions between digital assets. The introduction of AMM has created a new trading method that does not require traditional buyers and sellers to match orders. Instead, a liquidity pool is created through a preset mathematical formula (such as a constant product formula), allowing users to trade at any time. Trading.

![A traditional order book from a centralized exchange, where buyers and sellers manually match orders — AMMs replace this mechanism with a liquidity pool and a mathematical formula.](https://raw.githubusercontent.com/remix-project-org/remix-workshops/master/DEX/img/56-1.png)

Next, we will introduce AMM to you, taking the markets of Coke ($COLA) and US Dollar ($USD) as examples. For convenience, we specify the symbols: $x$ and $y$ respectively represent the total amount of cola and dollars in the market, $\Delta x$ and $\Delta y$ respectively represent the changes in cola and dollars in a transaction, $L$ and $\Delta L$ represent total liquidity and changes in liquidity.

### Constant Sum Automated Market Maker

The Constant Sum Automated Market Maker (CSAMM) is the simplest automated market maker model, and we will start with it. Its constraints during transactions are:

$$k=x+y$$

where $k$ is a constant. That is, the sum of the quantities of colas and dollars in the market remains the same before and after the trade. For example, there are 10 bottles of Coke and $10 in the market. At this time, $k=20$, and the price of Coke is $1/bottle. I was thirsty and wanted to exchange my $2 for a Coke. The total number of dollars in the post-trade market becomes 12. According to the constraint $k=20$, there are 8 bottles of Coke in the post-trade market at a price of $1/bottle. I got 2 bottles of Coke in the deal for $1/bottle.

The advantage of CSAMM is that it can ensure that the relative price of tokens remains unchanged. This is very important in a stable currency exchange. Everyone hopes that 1 USDT can always be exchanged for 1 USDC. But its shortcomings are also obvious. Its liquidity is easily exhausted: I only need $10 to exhaust the liquidity of Coke in the market, and other users who want to drink Coke will not be able to trade.

Below we introduce the constant product automatic market maker with "unlimited" liquidity.

### Constant product automatic market maker

Constant Product Automatic Market Maker (CPAMM) is the most popular automatic market maker model and was first adopted by Uniswap. Its constraints during transactions are:

$$k=x*y$$

where $k$ is a constant. That is, the product of the quantities of colas and dollars in the market remains the same before and after the trade. In the same example, there are 10 bottles of Coke and $10 in the market. At this time, $k=100$, and the price of Coke is $1/bottle. I was thirsty and wanted to exchange $10 for a Coke. If it were in CSAMM, my transaction would be in exchange for 10 bottles of Coke and deplete the liquidity of Cokes in the market. But in CPAMM, the total amount of dollars in the post-trade market becomes 20. According to the constraint $k=100$, there are 5 bottles of Coke in the post-trade market with a price of $20/5 = 4$ dollars/bottle. I got 5 bottles of Coke in the deal at a price of $10/5 = $2$ per bottle.

The advantage of CPAMM is that it has "unlimited" liquidity: the relative price of tokens will change with buying and selling, and the scarcer tokens will have a higher relative price to avoid exhaustion of liquidity. In the example above, the transaction increases the price of Coke from $1/bottle to $4/bottle, thus preventing Coke on the market from being bought out.

Next, let us build a minimalist decentralized exchange based on CPAMM.
