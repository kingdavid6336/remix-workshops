AAVE is a decentralized lending platform. Its [Pool contract](https://github.com/aave/aave-v3-core/blob/master/contracts/protocol/pool/Pool.sol#L424) passes `flashLoan The two functions ()` and `flashLoanSimple()` support single-asset and multi-asset flash loans. Here, we only use `flashLoan()` to implement a flash loan of a single asset (`WETH`).

Next, we complete the flash loan contract `AaveV3Flashloan.sol`. We let it inherit `IFlashLoanSimpleReceiver` and write the core logic of flash loan in the callback function `executeOperation`.

The overall logic is similar to that of V2. In the flash loan function `flashloan()`, we borrow `WETH` from the `WETH` pool of AAVE V3. After the flash loan is triggered, the callback function `executeOperation` will be called by the Pool contract. We do not perform arbitrage and only return the flash loan after calculating the interest. The handling fee of AAVE V3 flash loan defaults to `0.05%` per transaction, which is lower than that of Uniswap.

**Note**: The callback function must have permission control to ensure that only AAVE's Pool contract can be called, and the initiator is this contract, otherwise the funds in the contract will be stolen by hackers.
