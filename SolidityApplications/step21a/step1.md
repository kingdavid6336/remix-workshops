We often say that DeFi is like LEGO blocks, where you can create new protocols by combining multiple protocols. However, due to the lack of standards in DeFi, its composability is severely affected. ERC4626 extends the ERC20 token standard and aims to standardize yield vaults. In this talk, we will introduce the new generation DeFi standard - ERC4626 and write a simple vault contract.

## Vault

The vault contract is the foundation of DeFi LEGO blocks. It allows you to stake basic assets (tokens) to the contract in exchange for certain returns, including the following scenarios:

- Yield farming: In Yearn Finance, you can stake USDT to earn interest.
- Borrow/Lend: In AAVE, you can supply ETH to earn deposit interest and get a loan.
- Stake: In Lido, you can stake ETH to participate in ETH 2.0 staking and obtain stETH that can be used to earn interest.

## ERC4626

![](https://raw.githubusercontent.com/remix-project-org/remix-workshops/master/SolidityApplications/step21a/img/51-1.png)

Since the vault contract lacks standards, there are various ways of implementation. A yield aggregator needs to write many interfaces to connect with different DeFi projects. The ERC4626 Tokenized Vault Standard has emerged to enable easy expansion of DeFi with the following advantages:

1. Tokenization: ERC4626 inherits ERC20. When depositing to the vault, you will receive vault shares that are also compliant with the ERC20 standard. For example, when staking ETH, you will automatically get stETH as your share.

2. Better liquidity: Due to tokenization, you can use vault shares to do other things without withdrawing the underlying assets. For example, you can use Lido's stETH to provide liquidity or trade on Uniswap, without withdrawing any ETH.

3. Better composability: With the standard in place, a single set of interfaces can interact with all ERC4626 vaults, making it easier to develop applications, plugins, and tools based on vaults.

In summary, the importance of ERC4626 for DeFi is no less than that of ERC721 for NFTs.

### Key Points of ERC4626

The ERC4626 standard mainly implements the following logic:

1. ERC20: ERC4626 inherits ERC20, and the vault shares are represented by ERC20 tokens.
2. Deposit logic: allows users to deposit underlying assets and mint the corresponding number of vault shares. Related functions are `deposit()` and `mint()`.
3. Withdrawal logic: allows users to destroy vault share tokens and withdraw the corresponding number of underlying assets from the vault. Related functions are `withdraw()` and `redeem()`.
4. Accounting and limit logic: other functions for asset accounting in the vault, deposit and withdrawal limits and the number of underlying assets and vault shares for deposit and withdrawal.

### IERC4626 Interface Contract

The IERC4626 interface contract includes a total of `2` events:
- `Deposit` event: triggered when depositing.
- `Withdraw` event: triggered when withdrawing.

The IERC4626 interface contract also includes `16` functions, classified into `4` categories:

- Metadata
    - `asset()`: returns the address of the underlying asset token of the vault.
- Deposit/Withdrawal Logic
    - `deposit()`: allows users to deposit underlying assets and mint vault shares.
    - `mint()`: a minting function that deposits underlying assets and mints vault shares.
    - `withdraw()`: burns vault shares and sends corresponding underlying assets to receiver.
    - `redeem()`: burns vault shares and sends corresponding underlying assets to receiver.
- Accounting Logic
    - `totalAssets()`, `convertToShares()`, `convertToAssets()`, `previewDeposit()`, `previewMint()`, `previewWithdraw()`, `previewRedeem()`
- Deposit/Withdrawal Limit Logic
    - `maxDeposit()`, `maxMint()`, `maxWithdraw()`, `maxRedeem()`
