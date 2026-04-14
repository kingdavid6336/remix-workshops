We will deploy the `HoneyPot` contract on the `Sepolia` testnet and demonstrate it on the `Uniswap V3` exchange.

1. Deploy the `HoneyPot` contract.
   ![](https://raw.githubusercontent.com/remix-project-org/remix-workshops/master/Honeypot/img/S10-2.png)

2. Call the `mint()` function with your wallet address as the `to` parameter and `100000000000000000000000` (100,000 tokens × 10¹⁸, since ERC20 uses 18 decimals) as the `amount` parameter to mint 100,000 HoneyPot tokens for yourself.
   ![](https://raw.githubusercontent.com/remix-project-org/remix-workshops/master/Honeypot/img/S10-3.png)

3. Go to the [Uniswap V3](https://app.uniswap.org/add/ETH) exchange on Sepolia, create a liquidity pool for HoneyPot tokens, and provide `10000` HoneyPot tokens and `0.1` ETH.
   ![](https://raw.githubusercontent.com/remix-project-org/remix-workshops/master/Honeypot/img/S10-4.png)

4. As the owner, sell `100` HoneyPot tokens — the operation is successful.
   ![](https://raw.githubusercontent.com/remix-project-org/remix-workshops/master/Honeypot/img/S10-5.png)

5. Switch to another account and buy HoneyPot tokens with `0.01` ETH — the operation is successful.
   ![](https://raw.githubusercontent.com/remix-project-org/remix-workshops/master/Honeypot/img/S10-6.png)

6. As the non-owner account, attempt to sell HoneyPot tokens — the transaction cannot be executed.
   ![](https://raw.githubusercontent.com/remix-project-org/remix-workshops/master/Honeypot/img/S10-7.png)
