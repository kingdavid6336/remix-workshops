We will deploy the `Pixiu` contract on the `Sepolia` testnet and demonstrate it on the `Uniswap V3` exchange.

1. Deploy the `Pixiu` contract.
   ![](https://raw.githubusercontent.com/remix-project-org/remix-workshops/master/Honeypot/img/S10-2.png)

2. Call the `mint()` function to mint `100000` Pixiu tokens for yourself.
   ![](https://raw.githubusercontent.com/remix-project-org/remix-workshops/master/Honeypot/img/S10-3.png)

3. Go to the [Uniswap V3](https://app.uniswap.org/#/add/ETH) exchange on Sepolia, create a liquidity pool for Pixiu tokens, and provide `10000` Pixiu tokens and `0.1` ETH.
   ![](https://raw.githubusercontent.com/remix-project-org/remix-workshops/master/Honeypot/img/S10-4.png)

4. Sell `100` Pixiu tokens, the operation is successful.
   ![](https://raw.githubusercontent.com/remix-project-org/remix-workshops/master/Honeypot/img/S10-5.png)

5. Switch to another account and buy Pixiu tokens with `0.01` ETH, the operation is successful.
   ![](https://raw.githubusercontent.com/remix-project-org/remix-workshops/master/Honeypot/img/S10-6.png)

6. When selling Pixiu tokens, the transaction cannot be executed.
   ![](https://raw.githubusercontent.com/remix-project-org/remix-workshops/master/Honeypot/img/S10-7.png)
