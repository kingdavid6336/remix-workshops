In this section, we will use on-chain and off-chain random numbers to create a `tokenId` randomly minted `NFT`. The `Random` contract inherits from both the `ERC721` and `VRFConsumerBase` contracts.

```Solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

import "https://github.com/AmazingAng/WTF-Solidity/blob/main/34_ERC721/ERC721.sol";
import "@chainlink/contracts/src/v0.8/VRFConsumerBase.sol";

contract Random is ERC721, VRFConsumerBase{
```

### State Variables

- `NFT` related
    - `totalSupply`: Total supply of `NFT`.
    - `ids`: Array used for calculating `tokenId`s that can be `minted`, see `pickRandomUniqueId()` function.
    - `mintCount`: Number of NFTs that have been `minted`.
- `Chainlink VRF` related
    - `keyHash`: Unique identifier for `VRF`.
    - `fee`: `VRF` fee.
    - `requestToSender`: Records the user address that applied for `VRF` for minting.

```solidity
    // NFT Related
    uint256 public totalSupply = 100; // Total supply
    uint256[100] public ids; // Used to calculate the tokenId that can be minted
    uint256 public mintCount; // Number of minted tokens
    // Chainlink VRF Related
    bytes32 internal keyHash; // Key hash for Chainlink VRF
    uint256 internal fee; // Fee for Chainlink VRF
    // Records the mint address corresponding to the VRF request identifier
    mapping(bytes32 => address) public requestToSender;
```

### Constructor

Initialize the relevant variables of the inherited `VRFConsumerBase` and `ERC721` contracts.

```
/**
  * Using Chainlink VRF, the constructor needs to inherit from VRFConsumerBase
  * Different chain parameters are filled differently
  * Network: Rinkeby Testnet
  * Chainlink VRF Coordinator address: 0xb3dCcb4Cf7a26f6cf6B120Cf5A73875B7BBc655B
  * LINK token address: 0x01BE23585060835E02B77ef475b0Cc51aA1e0709
  * Key Hash: 0x2ed0feb3e7fd2022120aa84fab1945545a9f2ffc9076fd6156fa96eaff4c1311
**/
constructor()
    VRFConsumerBase(
        0xb3dCcb4Cf7a26f6cf6B120Cf5A73875B7BBc655B, // VRF Coordinator
        0x01BE23585060835E02B77ef475b0Cc51aA1e0709  // LINK Token
    )
    ERC721("WTF Random", "WTF")
{
    keyHash = 0x2ed0feb3e7fd2022120aa84fab1945545a9f2ffc9076fd6156fa96eaff4c1311;
    fee = 0.1 * 10 ** 18; // 0.1 LINK (VRF usage fee, Rinkeby test network)
}
```

### Other Functions

In addition to the constructor function, the contract defines 5 other functions:

- `pickRandomUniqueId()`: takes in a random number and returns a `tokenId` that can be used for minting.
- `getRandomOnchain()`: returns an on-chain random number (insecure).
- `mintRandomOnchain()`: mints an NFT using an on-chain random number, and calls `getRandomOnchain()` and `pickRandomUniqueId()`.
- `mintRandomVRF()`: requests a random number from `Chainlink VRF` to mint an NFT.
- `fulfillRandomness()`: the callback function for `VRF`, which is automatically called by the `VRF` contract after verifying the authenticity of the random number.

## `remix` Verification

### 1. Deploy the `Random` contract on the `Rinkeby` testnet
![Contract deployment](https://raw.githubusercontent.com/remix-project-org/remix-workshops/master/SolidityApplications/step9b/img/39-2.png)

### 2. Get `LINK` and `ETH` on the `Rinkeby` testnet using `Chainlink` faucet
![Get LINK and ETH on the Rinkeby testnet](https://raw.githubusercontent.com/remix-project-org/remix-workshops/master/SolidityApplications/step9b/img/39-3.png)

### 3. Transfer `LINK` tokens into the `Random` contract

After the contract is deployed, copy the contract address, and transfer `LINK` to the contract address just as you would for a normal transfer.
![Transfer LINK tokens](https://raw.githubusercontent.com/remix-project-org/remix-workshops/master/SolidityApplications/step9b/img/39-4.png)

### 4. Mint NFTs using on-chain random numbers

In the `remix` interface, click on the orange function `mintRandomOnchain` on the left side![mintOnchain](https://raw.githubusercontent.com/remix-project-org/remix-workshops/master/SolidityApplications/step9b/img/39-5-1.png), then click confirm in the pop-up `Metamask` to start minting the transaction using on-chain random numbers.

![Mint NFTs using onchain random numbers](https://raw.githubusercontent.com/remix-project-org/remix-workshops/master/SolidityApplications/step9b/img/39-5.png)

### 5. Mint NFTs using `Chainlink VRF` off-chain random numbers

Similarly, in the `remix` interface, click on the orange function `mintRandomVRF` on the left and click confirm in the pop-up little fox wallet. The transaction of minting an `NFT` using `Chainlink VRF` off-chain random number has started.

Note: when using `VRF` to mint `NFT`, initiating the transaction and the success of minting is not in the same block.

![Transaction start for VRF minting](https://raw.githubusercontent.com/remix-project-org/remix-workshops/master/SolidityApplications/step9b/img/39-6.png)
![Transaction success for VRF minting](https://raw.githubusercontent.com/remix-project-org/remix-workshops/master/SolidityApplications/step9b/img/39-7.png)

### 6. Verify that the `NFT` has been minted

From the above screenshots, it can be seen that in this example, the `NFT` with `tokenId=87` has been randomly minted on-chain, and the `NFT` with `tokenId=77` has been minted using `VRF`.

## Conclusion

Generating a random number in `Solidity` is not as straightforward as in other programming languages. In this tutorial, we introduced two methods of generating random numbers on-chain (using hash functions) and off-chain (`Chainlink` oracle), and used them to create an `NFT` with a randomly assigned `tokenId`. Both methods have their advantages and disadvantages: using on-chain random numbers is efficient but insecure while generating off-chain random numbers relies on third-party Oracle services, which is relatively safe but not as easy and economical. Project teams should choose the appropriate method according to their specific business needs.
