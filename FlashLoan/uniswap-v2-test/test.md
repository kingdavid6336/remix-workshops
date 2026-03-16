Foundry test contract `UniswapV2Flashloan.t.sol`:

> **Note:** These tests cannot be run inside Remix IDE. You need to run them **locally on your device** using [Foundry](https://book.getfoundry.sh/getting-started/installation). Make sure Foundry is installed before proceeding.

In the test contract, we tested the cases of sufficient and insufficient handling fees respectively. You can use the following command line to test after installing Foundry (you can change the RPC to another Ethereum RPC):

```shell
FORK_URL=https://singapore.rpc.blxrbdn.com
forge test  --fork-url $FORK_URL --match-path test/UniswapV2Flashloan.t.sol -vv
```
