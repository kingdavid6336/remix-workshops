You must have heard the term “flash loan attack”, but what is a flash loan? How to write a flash loan contract? In this lecture, we will introduce flash loans in the blockchain, implement flash loan contracts based on Uniswap V2, Uniswap V3, and AAVE V3, and use Foundry for testing.

## Flash Loan

The first time you heard about "flash loan" must be in Web3, because Web2 does not have this thing. Flashloan is a DeFi innovation that allows users to lend and quickly return funds in one transaction without providing any collateral.

Imagine that you suddenly find an arbitrage opportunity in the market, but you need to prepare 1 million U of funds to complete the arbitrage. In Web2, you go to the bank to apply for a loan, which requires approval, and you may miss the arbitrage opportunity. In addition, if the arbitrage fails, you not only have to pay interest but also need to return the lost principal.

In Web3, you can obtain funds through flash loans on the DeFi platform (Uniswap, AAVE, Dodo). You can borrow 1 million U tokens without guarantee, perform on-chain arbitrage, and finally return the loan and interest.

Flash loans take advantage of the atomicity of Ethereum transactions: a transaction (including all operations within it) is either fully executed or not executed at all. If a user attempts to use a flash loan and does not return the funds in the same transaction, the entire transaction will fail and be rolled back as if it never happened. Therefore, the DeFi platform does not need to worry about the borrower not being able to repay the loan, because if it is not repaid, it means that the money has not been loaned out; at the same time, the borrower does not need to worry about the arbitrage being unsuccessful, because if the arbitrage is unsuccessful, the repayment will not be repaid, and it means that the loan was unsuccessful.

![](https://raw.githubusercontent.com/remix-project-org/remix-workshops/master/FlashLoan/img/57-1.png)

## Utility file

We have created a Lib.sol file, which is a shared helper file that contains all the external interfaces and utilities needed by the three flash loan contracts in this lesson. Instead of duplicating these definitions in each contract, they are centralized here and imported with import "./Lib.sol".

It includes:

- IERC20 — The standard ERC-20 token interface (transfer, approve, balanceOf, etc.), used by all three contracts to interact with tokens like WETH.
- IUniswapV2Pair — Interface for Uniswap V2 pair contracts. The swap() function is what triggers a V2 flash loan.
- IUniswapV2Factory — Interface to look up Uniswap V2 pair addresses via getPair().
- IWETH — Wrapped ETH interface, extending IERC20 with deposit() and withdraw() to convert between ETH and WETH.
- PoolAddress (library) — A utility that computes Uniswap V3 pool addresses deterministically using CREATE2, without needing to query the factory on-chain.
- IUniswapV3Pool — Interface for calling Uniswap V3's flash() function directly.
- ILendingPool — AAVE V3 Pool interface for calling flashLoanSimple() and querying the flash loan fee.

## Flash loan in action

In this course, we introduce how to implement flash loan contracts in Uniswap V2, Uniswap V3, and AAVE V3.
