Here, we are implementing an extremely simple version of tokenized vault contract:
- The constructor initializes the address of the underlying asset contract, the name, and symbol of the vault shares token. Note that the name and symbol of the vault shares token should be associated with the underlying asset. For example, if the underlying asset is called `WTF`, the vault shares should be called `vWTF`.
- When a user deposits `x` units of the underlying asset into the vault, `x` units (equivalent) of vault shares will be minted.
- When a user withdraws `x` units of vault shares from the vault, `x` units (equivalent) of the underlying asset will be withdrawn as well.

**Note**: In actual use, special care should be taken to consider whether the accounting logic related functions should be rounded up or rounded down.

## `Remix` Demo

**Note:** the demo show below uses the second remix account, which is `0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2`, to deploy and call functions.

1. Deploy an `ERC20` token contract with the token name and symbol both set to `WTF`, and mint yourself `10000` tokens.
![Deploying ERC20 token contract named WTF](https://raw.githubusercontent.com/remix-project-org/remix-workshops/master/SolidityApplications/step21c/img/51-2-1.png)
![Minting 10000 WTF tokens](https://raw.githubusercontent.com/remix-project-org/remix-workshops/master/SolidityApplications/step21c/img/51-2-2.png)

2. Deploy an `ERC4626` token contract with the underlying asset contract address set to the address of `WTF`, and set the name and symbol to `vWTF`.
![Deploying ERC4626 vault contract with WTF as underlying asset](https://raw.githubusercontent.com/remix-project-org/remix-workshops/master/SolidityApplications/step21c/img/51-3.png)

3. Call the `approve()` function of the `ERC20` contract to authorize the `ERC4626` contract.
![Approving ERC4626 contract to spend WTF tokens](https://raw.githubusercontent.com/remix-project-org/remix-workshops/master/SolidityApplications/step21c/img/51-4.png)

4. Call the `deposit()` function of the `ERC4626` contract to deposit `1000` tokens. Then call the `balanceOf()` function to check that your vault share has increased to `1000`.
![Depositing 1000 tokens and checking vault share balance of 1000](https://raw.githubusercontent.com/remix-project-org/remix-workshops/master/SolidityApplications/step21c/img/51-5.png)

5. Call the `mint()` function of the `ERC4626` contract to deposit another `1000` tokens. Then call `balanceOf()` function to check that your vault share has increased to `2000`.
![Minting 1000 more vault shares and checking balance of 2000](https://raw.githubusercontent.com/remix-project-org/remix-workshops/master/SolidityApplications/step21c/img/51-6.png)

6. Call the `withdraw()` function of the `ERC4626` contract to withdraw `1000` tokens. Then call the `balanceOf()` function to check that your vault share has decreased to `1000`.
![Withdrawing 1000 tokens and checking vault share balance of 1000](https://raw.githubusercontent.com/remix-project-org/remix-workshops/master/SolidityApplications/step21c/img/51-7.png)

7. Call the `redeem()` function of the `ERC4626` contract to withdraw `1000` tokens. Then call the `balanceOf()` function to check that your vault share has decreased to `0`.
![Redeeming 1000 vault shares and checking balance of 0](https://raw.githubusercontent.com/remix-project-org/remix-workshops/master/SolidityApplications/step21c/img/51-8.png)

## Summary

In this lesson, we introduced the ERC4626 tokenized vault standard and wrote a simple vault contract that converts underlying assets to 1:1 vault share tokens. The ERC4626 standard improves the liquidity and composability of DeFi and it will gradually become more popular in the future. What applications would you build with ERC4626?
