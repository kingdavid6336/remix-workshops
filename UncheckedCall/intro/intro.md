In this lesson, we will discuss the unchecked low-level calls in smart contracts. Failed low-level calls will not cause the transaction to roll back. If the contract forgets to check its return value, serious problems will often occur.

## Low-Level Calls

Low-level calls in Ethereum include `call()`, `delegatecall()`, `staticcall()`, and `send()`. These functions are different from other functions in Solidity. When an exception occurs, they do not pass it to the upper layer, nor do they cause the transaction to revert; they only return a boolean value `false` to indicate that the call failed. Therefore, if the return value of the low-level function call is not checked, the code of the upper-layer function will continue to run regardless of whether the low-level call fails or not. For more information about low-level calls, please read [WTF Solidity 20-23](https://github.com/AmazingAng/WTF-Solidity)

Calling `send()` is the most error-prone: some contracts use `send()` to send `ETH`, but `send()` limits the gas to be less than 2300, otherwise it will fail. When the callback function of the target address is more complicated, the gas spent will be higher than 2300, which will cause `send()` to fail. If the return value is not checked in the upper layer function at this time, the transaction will continue to execute, and unexpected problems will occur. In 2016, there was a chain game called `King of Ether`, which caused the refund to fail to be sent normally due to this vulnerability (["autopsy" report](https://www.kingoftheether.com/postmortem.html)).

![](https://raw.githubusercontent.com/remix-project-org/remix-workshops/master/UncheckedCall/img/S13-1.png)
