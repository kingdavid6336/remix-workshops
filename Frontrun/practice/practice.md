If you learn front-running, you can consider yourself an entry-level crypto scientist. Next, let's practice front-running a transaction for minting an NFT.

> **Note:** This practice requires running tools **locally on your device**. It cannot be done entirely inside Remix IDE. You will need [Foundry](https://book.getfoundry.sh/getting-started/installation) installed to run the local test chain, and Node.js to run the `frontrun.js` script.

The tools we will use are:

- `Foundry`'s `anvil` tool to set up a local test chain. Please install [foundry](https://book.getfoundry.sh/getting-started/installation) in advance.
- `Remix` for deploying and minting the NFT contract.
- `ethers.js` script to listen to the Mempool and perform front-running.

**1. Start the Foundry Local Test Chain:** After installing `foundry`, enter `anvil --chain-id 1234 -b 10` in the command line to set up a local test chain with a chain ID of 1234 and a block produced every 10 seconds. Once set up, it will display the addresses and private keys of some test accounts, each with 10000 ETH. You can use them for testing.

![](https://raw.githubusercontent.com/remix-project-org/remix-workshops/master/Frontrun/img/S11-2.png)

**2. Connect Remix to the Test Chain:** Open the deployment page in Remix, open the `Environment` dropdown menu in the top left corner, and select `Foundry Provider` to connect Remix to the test chain.

![](https://raw.githubusercontent.com/remix-project-org/remix-workshops/master/Frontrun/img/S11-3.png)

**3. Deploy the NFT Contract:** Deploy a simple freemint NFT contract on Remix. It has a `mint()` function for free NFT minting.

```solidity
// SPDX-License-Identifier: MIT
// By 0xAA
// english translation by 22X
pragma solidity ^0.8.21;
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

// We attempt to frontrun a Free mint transaction
contract FreeMint is ERC721 {
    uint256 totalSupply;

    // Constructor, initializes the name and symbol of the NFT collection
    constructor() ERC721("Free Mint NFT", "FreeMint"){}

    // Mint function
    function mint() external {
        _mint(msg.sender, totalSupply); // mint
        totalSupply++;
    }
}
```

**4. Run the ethers.js front-running script:** In simple terms, the `frontrun.js` script listens to pending transactions in the test chain's mempool, filters out transactions that call `mint()`, and then duplicates and increases the gas to front-run them. If you are not familiar with `ethers.js`, you can read the [WTF Ethers](https://github.com/WTFAcademy/WTF-Ethers) tutorial.

**5. Call the `mint()` function:** Call the `mint()` function of the Freemint contract on the deployment page of Remix to mint an NFT.

**6. The script detects and frontruns the transaction:** We can see in the terminal that the `frontrun.js` script successfully detects the transaction and frontruns it. If you call the `ownerOf()` function of the NFT contract to check the owner of `tokenId` 0, and it matches the wallet address in the frontrun script, it proves that the frontrun was successful!
![](https://raw.githubusercontent.com/remix-project-org/remix-workshops/master/Frontrun/img/S11-4.png)
