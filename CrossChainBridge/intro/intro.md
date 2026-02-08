In this lecture, we introduce cross-chain bridges, infrastructure that can transfer assets from one blockchain to another, and implement a simple cross-chain bridge.

## 1. What is a cross-chain bridge?

A cross-chain bridge is a blockchain protocol that allows digital assets and information to be moved between two or more blockchains. For example, an ERC20 token running on the Ethereum mainnet can be transferred to other Ethereum-compatible sidechains or independent chains through cross-chain bridges.

At the same time, cross-chain bridges are not natively supported by the blockchain, and cross-chain operations require a trusted third party to perform, which also brings risks. In the past two years, attacks on cross-chain bridges have caused more than **$2 billion** in user asset losses.

## 2. Types of cross-chain bridges

There are three main types of cross-chain bridges:

- **Burn/Mint**: Destroy (burn) tokens on the source chain, and then create (mint) the same number of tokens on the target chain. The advantage of this method is that the total supply of tokens remains unchanged, but the cross-chain bridge needs to have permission to mint the tokens, which is suitable for project parties to build their own cross-chain bridges.

![](https://raw.githubusercontent.com/remix-project-org/remix-workshops/master/54_CrossChainBridge/step1/img/54-1.png)

- **Stake/Mint**: Lock (stake) tokens on the source chain, and then create (mint) the same number of tokens (certificates) on the target chain. Tokens on the source chain are locked and unlocked when the tokens are moved from the target chain back to the source chain. This is a solution commonly used by cross-chain bridges. It does not require any permissions, but the risk is also high. When the assets of the source chain are hacked, the credentials on the target chain will become air.

  ![](https://raw.githubusercontent.com/remix-project-org/remix-workshops/master/54_CrossChainBridge/step1/img/54-2.png)

- **Stake/Unstake**: Lock (stake) tokens on the source chain, and then release (unstake) the same number of tokens on the target chain. The tokens on the target chain can be exchanged back to the tokens on the source chain at any time. currency. This method requires the cross-chain bridge to have locked tokens on both chains, and the threshold is high. Users generally need to be encouraged to lock up on the cross-chain bridge.

  ![](https://raw.githubusercontent.com/remix-project-org/remix-workshops/master/54_CrossChainBridge/step1/img/54-3.png)
