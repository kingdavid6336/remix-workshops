We will use Foundry to reproduce the manipulation attack on the Oracle because it is fast and allows us to create a local fork of the mainnet for testing. If you are not familiar with Foundry, you can read [WTF Solidity Tools T07: Foundry](https://github.com/AmazingAng/WTF-Solidity/blob/main/Topics/Tools/TOOL07_Foundry/readme.md).

1. After installing Foundry, start a new project and install the OpenZeppelin library by running the following command in the command line:

```shell
forge init Oracle
cd Oracle
forge install Openzeppelin/openzeppelin-contracts
```

2. Create an `.env` environment variable file in the root directory and add the mainnet rpc to create a local testnet.

```
MAINNET_RPC_URL= https://rpc.ankr.com/eth
```

3. Copy the code from this lesson, `Oracle.sol` and `Oracle.t.sol`, to the `src` and `test` folders respectively in the root directory, and then start the attack script with the following command:

```
forge test -vv --match-test testOracleAttack
```

4. We can see the attack result in the terminal. Before the attack, the oracle `getPrice()` gave a price of `1216 USD` for `ETH`, which is normal. However, after we bought `WETH` in the `WETH-BUSD` pool on UniswapV2 with `1,000,000` BUSD, the price given by the oracle was manipulated to `17,979,841,782,699 USD`. At this point, we can easily exchange `1 ETH` for 17 trillion `oUSD` and complete the attack.

```shell
Running 1 test for test/Oracle.t.sol:OracleTest
[PASS] testOracleAttack() (gas: 356524)
Logs:
  1. ETH Price (before attack): 1216
  2. Swap 1,000,000 BUSD to WETH to manipulate the oracle
  3. ETH price (after attack): 17979841782699
  4. Minted 1797984178269 oUSD with 1 ETH (after attack)

Test result: ok. 1 passed; 0 failed; finished in 262.94ms
```
