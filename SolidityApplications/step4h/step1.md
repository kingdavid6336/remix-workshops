Let's use `ERC721` to write a free minting `WTF APE`, with a total quantity of `10000`. We just need to rewrite the `mint()` and `baseURI()` functions. The `baseURI()` will be set the same as `BAYC`, where the metadata will directly obtain the information of the uninteresting apes, similar to [RRBAYC](https://rrbayc.com/):

```solidity
// SPDX-License-Identifier: MIT
// by 0xAA
pragma solidity ^0.8.21;

import "./ERC721.sol";

contract WTFApe is ERC721{
    uint public MAX_APES = 10000; // total amount

    // the constructor function
    constructor(string memory name_, string memory symbol_) ERC721(name_, symbol_){
    }

    // BAYC's baseURI is ipfs://QmeSjSinHpPnmXmspMjwiXyN6zS4E9zccariGR3jxcaWtq/
    function _baseURI() internal pure override returns (string memory) {
        return "ipfs://QmeSjSinHpPnmXmspMjwiXyN6zS4E9zccariGR3jxcaWtq/";
    }

    // the mint function
    function mint(address to, uint tokenId) external {
        require(tokenId >= 0 && tokenId < MAX_APES, "tokenId out of range");
        _mint(to, tokenId);
    }
}
```

## Issuing `ERC721` NFT

With the `ERC721` standard, issuing NFTs on the `ETH` chain has become very easy. Now, let's issue our own NFT.

After compiling the `ERC721` contract and the `WTFApe` contract in `Remix` (in order), click the button in the deployment column, enter the parameters of the constructor function, set `name_` and `symbol_` to `WTF`, and then click the `transact` button to deploy.

![How to emphasize NFT information](https://raw.githubusercontent.com/remix-project-org/remix-workshops/master/SolidityApplications/step4h/img/34-1.png)
![Deploy contract](https://raw.githubusercontent.com/remix-project-org/remix-workshops/master/SolidityApplications/step4h/img/34-2.png)

This way, we have created the `WTF` NFT. We need to run the `mint()` function to mint some tokens for ourselves. In the `mint` function panel, click the right button to input the account address and token ID, and then click the `mint` button to mint the `0`-numbered `WTF` NFT for ourselves.

You can click the Debug button on the right to view the logs below.

It includes four key pieces of information:
- Event `Transfer`
- Minting address `0x0000000000000000000000000000000000000000`
- Receiving address `0x5B38Da6a701c568545dCfcB03FcB875f56beddC4`
- Token id `0`

![Minting NFTs](https://raw.githubusercontent.com/remix-project-org/remix-workshops/master/SolidityApplications/step4h/img/34-3.png)

We use the `balanceOf()` function to query the account balance. By inputting our current account, we can see that an `NFT` has been successfully minted, as indicated on the right-hand side of the image.

![Querying NFT details](https://raw.githubusercontent.com/remix-project-org/remix-workshops/master/SolidityApplications/step4h/img/34-4.png)

We can also use the `ownerOf()` function to check which account an NFT belongs to. By inputting the `tokenid`, we can see that the address is correct.

![Querying owner details of tokenid](https://raw.githubusercontent.com/remix-project-org/remix-workshops/master/SolidityApplications/step4h/img/34-5.png)

## Summary

In this lesson, I introduced the `ERC721` standard, interface, and implementation, and added English comments to the contract code. We also used `ERC721` to create a free `WTF APE` NFT, with metadata directly called from `BAYC`. The `ERC721` standard is still evolving, with the currently popular versions being `ERC721Enumerable` (improving NFT accessibility) and `ERC721A` (saving `gas` in minting).
