We have made some modifications to the boring apes `BAYC` by changing it to `BAYC1155` which now follows the `ERC1155` standard and allows for free minting. The `_baseURI()` function has been modified to ensure that the `uri` for `BAYC1155` is the same as the `tokenURI` for `BAYC`. This means that `BAYC1155` metadata will be identical to that of boring apes.

```solidity
// SPDX-License-Identifier: MIT
// by 0xAA
pragma solidity ^0.8.21;

import "./ERC1155.sol";

contract BAYC1155 is ERC1155 {
    uint256 constant MAX_ID = 10000;

    // Constructor
    constructor() ERC1155("BAYC1155", "BAYC1155") {}

    // BAYC's baseURI is ipfs://QmeSjSinHpPnmXmspMjwiXyN6zS4E9zccariGR3jxcaWtq/
    function _baseURI() internal pure override returns (string memory) {
        return "ipfs://QmeSjSinHpPnmXmspMjwiXyN6zS4E9zccariGR3jxcaWtq/";
    }

    // Mint function
    function mint(address to, uint256 id, uint256 amount) external {
        // id cannot exceed 10,000
        require(id < MAX_ID, "id overflow");
        _mint(to, id, amount, "");
    }

    // Batch mint function
    function mintBatch(
        address to,
        uint256[] memory ids,
        uint256[] memory amounts
    ) external {
        // id cannot exceed 10,000
        for (uint256 i = 0; i < ids.length; i++) {
            require(ids[i] < MAX_ID, "id overflow");
        }
        _mintBatch(to, ids, amounts, "");
    }
}
```

## Remix Demo

### 1. Deploy the `BAYC1155` Contract
![Deploy](https://raw.githubusercontent.com/remix-project-org/remix-workshops/master/SolidityApplications/step10e/img/40-1.jpg)

### 2. View Metadata `URI`
![View metadata](https://raw.githubusercontent.com/remix-project-org/remix-workshops/master/SolidityApplications/step10e/img/40-2.jpg)

### 3. `mint` and view position changes
In the `mint` section, enter the account address, `id`, and quantity, and click the `mint` button to mint. If the quantity is `1`, it is a non-fungible token; if the quantity is greater than `1`, it is a fungible token.

![mint1](https://raw.githubusercontent.com/remix-project-org/remix-workshops/master/SolidityApplications/step10e/img/40-3.jpg)

In the `blanceOf` section, enter the account address and `id` to view the corresponding position.

![mint2](https://raw.githubusercontent.com/remix-project-org/remix-workshops/master/SolidityApplications/step10e/img/40-4.jpg)

### 4. Batch `mint` and view position changes

In the "mintBatch" section, input the "ids" array and the corresponding quantity to be minted. The length of both arrays must be the same.
To view the recently minted token "id" array, input it as shown.

Similarly, in the "transfer" section, we transfer tokens from an address that already owns them to a new address. This address can be a normal address or a contract address; if it is a contract address, it will be verified whether it has implemented the "onERC1155Received()" receiving function.
Here, we transfer tokens to a normal address by inputting the "ids" and corresponding "amounts" arrays.
To view the changes in holdings of the address to which tokens were just transferred, select "view balances".

## Summary

In this lesson, we learned about the `ERC1155` multi-token standard proposed by Ethereum's `EIP1155`. It allows for a contract to include multiple homogeneous or heterogeneous tokens. Additionally, we created a modified version of the Bored Ape Yacht Club (BAYC) - `BAYC1155`: an `ERC1155` token containing 10,000 tokens with the same metadata as BAYC. Currently, `ERC1155` is primarily used in GameFi. However, I believe that as metaverse technology continues to develop, this standard will become increasingly popular.
