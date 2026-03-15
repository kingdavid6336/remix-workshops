Let's take a look at an example of a vulnerable contract. The `SelectorClash` contract has one state variable `solved`, initialized as `false`, which the attacker needs to change to `true`. The contract has `2` main functions, named after the Poly Network vulnerable contract.

1. `putCurEpochConPubKeyBytes()`: After calling this function, the attacker can change `solved` to `true` and complete the attack. However, this function checks `msg.sender == address(this)`, so the caller must be the contract itself. We need to look at other functions.

2. `executeCrossChainTx()`: This function allows calling functions within the contract, but the function parameters are slightly different from the target function: the target function takes `(bytes)` as parameters, while this function takes `(bytes, bytes, uint64)`.

### How to Attack

Our goal is to use the `executeCrossChainTx()` function to call the `putCurEpochConPubKeyBytes()` function in the contract. The selector of the target function is `0x41973cd9`. We observe that the `executeCrossChainTx()` function calculates the selector using the `_method` parameter and `"(bytes,bytes,uint64)"` as the function signature. Therefore, we just need to choose the appropriate `_method` so that the calculated selector matches `0x41973cd9`, allowing us to call the target function through selector collision.

In the Poly Network hack, the hacker collided the `_method` as `f1121318093`, which means the first `4` bytes of the hash of `f1121318093(bytes,bytes,uint64)` is also `0x41973cd9`, successfully calling the function. Next, we need to convert `f1121318093` to the `bytes` type: `0x6631313231333138303933`, and pass it as a parameter to `executeCrossChainTx()`. The other `3` parameters of `executeCrossChainTx()` are not important, so we can fill them with `0x`, `0x`, and `0`.

## Reproduce on `Remix`

1. Deploy the `SelectorClash` contract.
2. Call `executeCrossChainTx()` with the parameters `0x6631313231333138303933`, `0x`, `0x`, and `0`, to initiate the attack.
3. Check the value of the `solved` variable, which should be modified to `true`, indicating a successful attack.

## Summary

In this lesson, we introduced the selector clash attack, which is one of the reasons behind the $611 million hack of the Poly Network cross-chain bridge. This attack teaches us:

1. Function selectors are easily collided, even when changing parameter types, it is still possible to construct functions with the same selector.

2. Manage the permissions of contract functions properly to ensure that functions of contracts with special privileges cannot be called by users.
