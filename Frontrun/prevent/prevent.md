Frontrunning is a common issue on Ethereum and other public blockchains. While we cannot eliminate it entirely, we can reduce the profitability of frontrunning by minimizing the importance of transaction order or time:

- Use a commit-reveal scheme.
- Use dark pools, where user transactions bypass the public mempool and go directly to miners. Examples include Flashbots and TaiChi.

## Summary

In this lesson, we introduced frontrunning on Ethereum, also known as a frontrun. This attack pattern, originating from the traditional finance industry, is easier to execute in blockchain because all transaction information is public. We performed a frontrun on a specific transaction: frontrunning a transaction to mint an NFT. When similar transactions are needed, it is best to support hidden mempools or implement measures such as batch auctions to limit frontrunning. Frontrunning is a common issue on Ethereum and other public blockchains, and while we cannot eliminate it entirely, we can reduce the profitability of frontrunning by minimizing the importance of transaction order or time.