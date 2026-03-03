## IERC721

`IERC721` is an interface contract for the `ERC721` standard, which specifies the basic functions that `ERC721` must implement. It uses `tokenId` to represent specific non-fungible tokens, and authorization or transfer requires an explicit `tokenId`; while `ERC20` only requires an explicit transfer amount.

```solidity
/**
 * @dev ERC721 standard interface.
 */
interface IERC721 is IERC165 {
    event Transfer(address indexed from, address indexed to, uint256 indexed tokenId);
    event Approval(address indexed owner, address indexed approved, uint256 indexed tokenId);
    event ApprovalForAll(address indexed owner, address indexed operator, bool approved);

    function balanceOf(address owner) external view returns (uint256 balance);

    function ownerOf(uint256 tokenId) external view returns (address owner);

    function safeTransferFrom(
        address from,
        address to,
        uint256 tokenId,
        bytes calldata data
    ) external;

    function safeTransferFrom(
        address from,
        address to,
        uint256 tokenId
    ) external;

    function transferFrom(
        address from,
        address to,
        uint256 tokenId
    ) external;

    function approve(address to, uint256 tokenId) external;

    function setApprovalForAll(address operator, bool _approved) external;

    function getApproved(uint256 tokenId) external view returns (address operator);

    function isApprovedForAll(address owner, address operator) external view returns (bool);
}
```

### IERC721 Events
`IERC721` has three events, `Transfer` and `Approval` events are also in `ERC20`.
- `Transfer` event: emitted during transfer, records the sender `from` address, receiver `to` address, and token `tokenid`.
- `Approval` event: emitted during approval, records the owner `owner` of the approval, the approved `approved` address, and the `tokenid`.
- `ApprovalForAll` event: emitted during bulk approval, records the sender `owner` of the bulk approval, the `operator` address to be authorized, and the flag `approved` to identify whether the `operator` is approved or not.

### IERC721 Functions
- `balanceOf`: returns the NFT holding `balance` of an address.
- `ownerOf`: returns the `owner` of a certain `tokenId`.
- `transferFrom`: normal transfer, with the parameters of the sender `from`, receiver `to` and `tokenId`.
- `safeTransferFrom`: safe transfer, which requires the implementation of the `ERC721Receiver` interface if the destination address is a contract address. With the parameters of the sender `from`, receiver `to` and `tokenId`.
- `approve`: authorizes another address to use your NFT. With the parameters of the authorized `to` address and `tokenId`.
- `getApproved`: returns the address to which the `tokenId` is approved.
- `setApprovalForAll`: authorizes the `operator` address to hold the NFTs owned by the sender in batch.
- `isApprovedForAll`: returns whether a certain address's NFTs are authorized to be held by another `operator` address.
- `safeTransferFrom`: an overloaded function for safe transfer, with `data` included in the parameters.
