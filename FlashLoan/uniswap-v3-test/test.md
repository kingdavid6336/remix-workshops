Foundry test contract `UniswapV3Flashloan.t.sol`:

In the test contract, we tested the cases of sufficient and insufficient handling fees respectively. You can use the following command line to test after installing Foundry (you can change the RPC to other Ethereum RPC):

```shell
FORK_URL=https://singapore.rpc.blxrbdn.com
forge test  --fork-url $FORK_URL --match-path test/UniswapV3Flashloan.t.sol -vv
```
