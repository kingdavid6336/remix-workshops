Tokens such as `BTC` and `ETH` belong to homogeneous tokens, and the first `BTC` mined is no different from the 10,000th `BTC` mined, and they are equivalent. However, many items in the world are heterogeneous, including real estate, antiques, virtual artworks, and so on. Such items cannot be abstracted using homogeneous tokens. Therefore, the `ERC721` standard was proposed in [Ethereum EIP721](https://eips.ethereum.org/EIPS/eip-721) to abstract non-homogeneous items. In this section, we will introduce the `ERC721` standard and issue an `NFT` based on it.

## ERC721

One point to understand here is that the title of this section is `ERC721`, but `EIP721` also is mentioned here. What is the relationship between the two?

`EIP` stands for `Ethereum Improvement Proposals`, which are improvement suggestions proposed by the Ethereum developer community. They are a series of documents arranged by numbers, similar to IETF's RFC on the Internet.

`EIP` can be any improvement in the Ethereum ecosystem, such as new features, ERC standards, protocol improvements, programming tools, etc.

`ERC` stands for Ethereum Request For Comment and is used to record various application-level development standards and protocols on Ethereum. Typical token standards (`ERC20`, `ERC721`), name registration (`ERC26`, `ERC13`), URI paradigms (`ERC67`), Library/Package formats (`EIP82`), wallet formats (`EIP75`, `EIP85`), etc.

`ERC` protocol standards are important factors affecting the development of Ethereum. ERC20, ERC223, ERC721, ERC777, etc. have had a significant impact on the Ethereum ecosystem.

So the final conclusion: `EIP` contains `ERC`.

**After completing this section of learning, you can understand why we start with `ERC165` rather than `ERC721`. If you want to see the conclusion, you can directly move to the bottom**

Through the [ERC165 standard](https://eips.ethereum.org/EIPS/eip-165), smart contracts can declare the interfaces they support, for other contracts to check. Simply put, `ERC165` is used to check whether a smart contract supports the interfaces of `ERC721` or `ERC1155`.

The interface contract `IERC165` only declares a `supportsInterface` function. When given an `interfaceId` to query, it returns `true` if the contract implements that interface id.

```solidity
interface IERC165 {
    /**
     * @dev Returns true if contract implements the `interfaceId` for querying.
     * See https://eips.ethereum.org/EIPS/eip-165#how-interfaces-are-identified[EIP section] for the definition of what an interface is.
     */
    function supportsInterface(bytes4 interfaceId) external view returns (bool);
}
```

We can see how the `supportsInterface()` function is implemented in `ERC721`:

```solidity
    function supportsInterface(bytes4 interfaceId) external pure override returns (bool)
    {
        return
            interfaceId == type(IERC721).interfaceId ||
            interfaceId == type(IERC165).interfaceId;
    }
```

When querying the interface ID of `IERC721` or `IERC165`, it will return `true`; otherwise, it will return `false`.
