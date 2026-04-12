In this lecture, we will learn about the `ERC1155` standard, which allows a contract to contain multiple types of tokens. We will also issue a modified version of the Boring Ape Yacht Club (BAYC) called `BAYC1155`, which contains 10,000 types of tokens with metadata identical to BAYC.

## ERC1155

Both the `ERC20` and `ERC721` standards correspond to a single token contract. For example, if we wanted to create a large game similar to World of Warcraft on Ethereum, we would need to deploy a contract for each piece of equipment. Deploying and managing thousands of contracts is very cumbersome. Therefore, the [Ethereum EIP1155](https://eips.ethereum.org/EIPS/eip-1155) proposes a multi-token standard called `ERC1155`, which allows a contract to contain multiple homogeneous and heterogeneous tokens. `ERC1155` is widely used in GameFi applications, and well-known blockchain games such as Decentraland and Sandbox use it.

In simple terms, `ERC1155` is similar to the previously introduced non-fungible token standard `ERC721`: In `ERC721`, each token has a `tokenId` as a unique identifier, and each `tokenId` corresponds to only one token; in `ERC1155`, each type of token has an `id` as a unique identifier, and each `id` corresponds to one type of token. This way, the types of tokens can be managed heterogeneously in the same contract, and each type of token has a URL `uri` to store its metadata, similar to `tokenURI` in `ERC721`. The following is the metadata interface contract `IERC1155MetadataURI` for `ERC1155`:

```solidity
/**
 * @dev Optional ERC1155 interface that adds the uri() function for querying metadata
 */
interface IERC1155MetadataURI is IERC1155 {
    /**
     * @dev Returns the URI of the token type `id`.
     */
    function uri(uint256 id) external view returns (string memory);
```

How to distinguish whether a type of token in `ERC1155` is a fungible or a non-fungible token? It's actually simple: if the total amount of a token corresponding to a specific `id` is `1`, then it is a non-fungible token, similar to `ERC721`; if the total amount of a token corresponding to a specific `id` is greater than `1`, then it is a fungible token because these tokens share the same `id`, similar to `ERC20`.

## ERC1155 (IERC1155)

The `IERC1155` interface contract abstracts the functionalities required for `EIP1155` implementation, which includes `4` events and `6` functions. Unlike `ERC721`, since `ERC1155` includes multiple types of tokens, it implements batch transfer and batch balance query, allowing for simultaneous operation on multiple types of tokens.

### `IERC1155` Events
- `TransferSingle` event: released during the transfer of a single type of token in a single token transfer.
- `TransferBatch` event: released during the transfer of multiple types of tokens in a multi-token transfer.
- `ApprovalForAll` event: released during a batch approval of tokens.
- `URI` event: released when the metadata address changes during a change of the `uri`.

### `IERC1155` Functions
- `balanceOf()`: checks the token balance of a single type returned as the amount of tokens owned by `account` for an `id`.
- `balanceOfBatch()`: checks the token balances of multiple types returned as amounts of tokens owned by `account` for an array of `ids`.
- `setApprovalForAll()`: grants approvals to an `operator` of all tokens owned by the caller.
- `isApprovedForAll()`: checks the authorization status of an `operator` for a given `account`.
- `safeTransferFrom()`: performs the transfer of a single type of safe `ERC1155` token from the `from` address to the `to` address. If the `to` address is a contract, it must implement the `onERC1155Received()` function.
- `safeBatchTransferFrom()`: similar to the `safeTransferFrom()` function, but allows for transfers of multiple types of tokens. The `amounts` and `ids` arguments are arrays with a length equal to the number of transfers. If the `to` address is a contract, it must implement the `onERC1155BatchReceived()` function.
