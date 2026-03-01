You can use the following methods to prevent the unchecked low-level call vulnerability:

1. Check the return value of the low-level call. In the bank contract above, we can correct `withdraw()`:
    ```solidity
    bool success = payable(msg.sender).send(balance);
    require(success, "Failed Sending ETH!")
    ```

2. When transferring `ETH` in the contract, use `call()` and do reentrancy protection.
   
3. Use the `Address` [library](https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/Address.sol) of `OpenZeppelin`, which encapsulates the low-level call that checks the return value.

## Summary

We introduced the vulnerability of unchecked low-level calls and how to prevent them. Ethereum's low-level calls (`call`, `delegatecall`, `staticcall`, `send`) will return a boolean value `false` when they fail, but they will not cause the entire transaction to revert. If the developer does not check it, an accident will occur.