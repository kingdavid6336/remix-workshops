`IERC721Metadata` is an extended interface of `ERC721`, which implements `3` commonly used functions for querying `metadata`:

- `name()`: Returns the name of the token.
- `symbol()`: Returns the symbol of the token.
- `tokenURI()`: Returns the URL of the `metadata` by querying through `tokenId`, a unique function of `ERC721`.

```solidity
interface IERC721Metadata is IERC721 {
    function name() external view returns (string memory);

    function symbol() external view returns (string memory);

    function tokenURI(uint256 tokenId) external view returns (string memory);
}
```
