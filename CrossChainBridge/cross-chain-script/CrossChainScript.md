With the token contract in place, we need a server to handle cross-chain events. We can write an ethers.js script (v6 version) to listen to the `Bridge` event, and when the event is triggered, create the same number of tokens on the target chain. If you don’t know Ethers.js, you can read [WTF Ethers Minimalist Tutorial](https://github.com/WTFAcademy/WTF-Ethers).

## Remix Reappearance

1. Deploy the `CrossChainToken` contract on the Goerli and Sepolia test chains respectively. The contract will automatically mint 10,000 tokens for us.

   ![](https://raw.githubusercontent.com/remix-project-org/remix-workshops/master/54_CrossChainBridge/step1/img/54-4.png)

2. Complete the RPC node URL and administrator private key in the cross-chain script `crosschain.js`, fill in the token contract addresses deployed in Goerli and Sepolia into the corresponding locations, and run the script.

3. Call the `bridge()` function of the token contract on the Goerli chain to cross-chain 100 tokens.

   ![](https://raw.githubusercontent.com/remix-project-org/remix-workshops/master/54_CrossChainBridge/step1/img/54-6.png)

4. The script listens to the cross-chain event and mints 100 tokens on the Sepolia chain.

   ![](https://raw.githubusercontent.com/remix-project-org/remix-workshops/master/54_CrossChainBridge/step1/img/54-7.png)

5. Call `balance()` on the Sepolia chain to check the balance, and find that the token balance has changed to 10,100. The cross-chain is successful!

   ![](https://raw.githubusercontent.com/remix-project-org/remix-workshops/master/54_CrossChainBridge/step1/img/54-8.png)

## Summary

In this lecture, we introduced the cross-chain bridge, which allows digital assets and information to be moved between two or more blockchains, making it convenient for users to operate assets on multiple chains. At the same time, it also carries great risks. Attacks on cross-chain bridges in the past two years have caused more than **2 billion US dollars** in user asset losses. In this tutorial, we build a simple cross-chain bridge and implement ERC20 token transfer between the Goerli testnet and the Sepolia testnet. I believe that through this tutorial, you will have a deeper understanding of cross-chain bridges.
