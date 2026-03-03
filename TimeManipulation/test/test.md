Attackers only need to manipulate the block timestamp and set it to a number that can be divided by 170, and they can successfully mint NFTs. We chose Foundry to reproduce this attack because it provides a cheat code to modify the block timestamp. If you are not familiar with Foundry/cheatcode, you can read the [Foundry tutorial](https://github.com/AmazingAng/WTF-Solidity/blob/main/Topics/Tools/TOOL07_Foundry/readme.md) and [Foundry Book](https://book.getfoundry.sh/forge/cheatcodes).

1. Create a `TimeManipulation` contract variable `nft`.
2. Create a wallet address `alice`.
3. Use the cheatcode `vm.warp()` to change the block timestamp to 169, which cannot be divided by 170, and the minting fails.
4. Use the cheatcode `vm.warp()` to change the block timestamp to 17000, which can be divided by 170, and the minting succeeds.

After installing Foundry, start a new project and install the openzeppelin library by entering the following command on the command line:

```shell
forge init TimeMnipulation
cd TimeMnipulation
forge install Openzeppelin/openzeppelin-contracts
```

Copy the code of this lesson to the `src` and `test` directories respectively, and then start the test case with the following command:

```shell
forge test -vv --match-test testMint
```

The test result is as follows:

```shell
Running 1 test for test/TimeManipulation.t.sol:TimeManipulationTest
[PASS] testMint() (gas: 94666)
Logs:
  Condition 1: block.timestamp % 170 != 0
  block.timestamp: 169
  alice balance before mint: 0
  alice balance after mint: 0
  Condition 2: block.timestamp % 170 == 0
  block.timestamp: 17000
  alice balance before mint: 0
  alice balance after mint: 1

Test result: ok. 1 passed; 0 failed; finished in 7.64ms
```

We can see that when we modify `block.timestamp` to 17000, the minting is successful.