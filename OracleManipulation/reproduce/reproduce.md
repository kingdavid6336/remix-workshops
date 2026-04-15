# Reproduce with Foundry

> **Note:** This step requires running Foundry locally on your machine. It cannot be run inside Remix. Install Foundry from [https://getfoundry.sh](https://getfoundry.sh) before proceeding.

We will use Foundry to reproduce the manipulation attack on the Oracle because it is fast and allows us to create a local fork of the mainnet for testing. If you are not familiar with Foundry, you can read [WTF Solidity Tools T07: Foundry](https://github.com/AmazingAng/WTF-Solidity/blob/main/Topics/Tools/TOOL07_Foundry/readme.md).

1. After installing Foundry, start a new project, install the OpenZeppelin library, and generate the import remappings by running the following commands in the command line:

```shell
forge init Oracle
cd Oracle
forge install OpenZeppelin/openzeppelin-contracts
forge remappings > remappings.txt
```

2. Create an `.env` environment variable file in the root directory and add the mainnet rpc to create a local testnet.

```
MAINNET_RPC_URL=https://rpc.ankr.com/eth
```

3. Copy the code from this lesson, `Vulnerability.sol` and `OracleTest.sol`, to the `src` and `test` folders respectively in the root directory, and then start the attack script with the following command:

```shell
forge test -vv --match-test testOracleAttack
```

4. We can see the attack result in the terminal. Before the attack, the oracle `getPrice()` returned a normal price of `1216 USD` per `ETH`. After buying `WETH` with `1,000,000 BUSD`, the pool's reserves are so imbalanced that the oracle reports a price of `17,979,841,782,699 USD` per `ETH`. The `swap()` function uses that inflated price directly, so `1 ETH` mints trillions of `oUSD` tokens.

> **Note:** The exact output values may differ slightly depending on your environment and RPC block state.

```
Running 1 test for test/OracleTest.sol:OracleTest
[PASS] testOracleAttack() (gas: 356524)
Logs:
  1. ETH Price (before attack): 1216
  2. Swap 1,000,000 BUSD to WETH to manipulate the oracle
  3. ETH price (after attack): 17979841782699
  4. Minted 1797984178269 oUSD with 1 ETH (after attack)

Test result: ok. 1 passed; 0 failed; finished in 262.94ms
```
