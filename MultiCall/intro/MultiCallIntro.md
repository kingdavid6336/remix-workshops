In this lecture, we will introduce the MultiCall multi-call contract, which is designed to execute multiple function calls in one transaction, which can significantly reduce transaction fees and improve efficiency.

## MultiCall

In Solidity, the MultiCall (multiple call) contract is designed to allow us to execute multiple function calls in one transaction. Its advantages are as follows:

1. Convenience: MultiCall allows you to call different functions of different contracts in one transaction, and these calls can also use different parameters. For example, you can query the ERC20 token balances of multiple addresses at one time.

2. Save gas: MultiCall can combine multiple calls into a single transaction, thereby saving gas.

3. Atomicity: MultiCall allows users to perform all operations in one transaction, ensuring that all operations either succeed or fail, thus maintaining atomicity. For example, you can conduct a series of token transactions in a specific order.
