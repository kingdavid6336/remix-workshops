In this lesson, we will introduce the block timestamp manipulation attack on smart contracts and reproduce it using Foundry. Before the merge, Ethereum miners can manipulate the block timestamp. If the pseudo-random number of the lottery contract depends on the block timestamp, it may be attacked.

## Block Timestamp

Block timestamp is a `uint64` value contained in the Ethereum block header, which represents the UTC timestamp (in seconds) when the block was created. Before the merge, Ethereum adjusts the block difficulty according to the computing power, so the block time is not fixed, and an average of 14.5s per block. Miners can manipulate the block timestamp; after the merge, it is changed to a fixed 12s per block, and the validator cannot manipulate the block timestamp.

In Solidity, developers can get the current block timestamp through the global variable `block.timestamp`, which is of type `uint256`.
