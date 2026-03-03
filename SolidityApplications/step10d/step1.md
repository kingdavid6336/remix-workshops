## Main Contract `ERC1155`

The `ERC1155` main contract implements the functions specified by the `IERC1155` interface contract, as well as the functions for minting and burning single/multiple tokens.

### Variables in `ERC1155`

The `ERC1155` main contract contains `4` state variables:

- `name`: token name
- `symbol`: token symbol
- `_balances`: token ownership mapping, which records the token balance `balances` of address `account` for token `id`
- `_operatorApprovals`: batch approval mapping, which records the approval situation of the holder address to another address.

### Functions in `ERC1155`

The `ERC1155` main contract contains `16` functions:

- Constructor: Initializes state variables `name` and `symbol`.
- `supportsInterface()`: Implements the `ERC165` standard to declare the interfaces supported by it, which can be checked by other contracts.
- `balanceOf()`: Implements `IERC1155`'s `balanceOf()` to query the token balance. Unlike the `ERC721` standard, it requires the address for which the balance is queried (`account`) and the token `id` to be provided.
- `balanceOfBatch()`: Implements `balanceOfBatch()` of `IERC1155`, which allows for batch querying of token balances.
- `setApprovalForAll()`: Implements `setApprovalForAll()` of `IERC1155`, which allows for batch authorization, and emits the `ApprovalForAll` event.
- `isApprovedForAll()`: Implements `isApprovedForAll()` of `IERC1155`, which allows for batch query of authorization information.
- `safeTransferFrom()`: Implements `safeTransferFrom()` of `IERC1155`, which allows for safe transfer of a single type of token, and emits the `TransferSingle` event.
- `safeBatchTransferFrom()`: Implements `safeBatchTransferFrom()` of `IERC1155`, which allows for safe transfer of multiple types of tokens, and emits the `TransferBatch` event.
- `_mint()`: Function for minting a single type of token.
- `_mintBatch()`: Function for minting multiple types of tokens.
- `_burn()`: Function for burning a single type of token.
- `_burnBatch()`: Function for burning multiple types of tokens.
- `_doSafeTransferAcceptanceCheck()`: Safety check for single type token transfers, ensures that the recipient has implemented `onERC1155Received()` when the recipient is a contract.
- `_doSafeBatchTransferAcceptanceCheck()`: Safety check for multiple types of token transfers, ensures that the recipient has implemented `onERC1155BatchReceived()` when the recipient is a contract.
- `uri()`: Returns the URL where the metadata of the token of type `id` is stored for `ERC1155`, similar to `tokenURI` for `ERC721`.
- `baseURI()`: Returns the `baseURI`. `uri` is simply `baseURI` concatenated with `id`, and can be overwritten by developers.
