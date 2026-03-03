## IERC721Receiver

If a contract does not implement the relevant functions of `ERC721`, the incoming NFT will be stuck and unable to be transferred out, causing a loss of the token. In order to prevent accidental transfers, `ERC721` implements the `safeTransferFrom()` function, and the target contract must implement the `IERC721Receiver` interface in order to receive `ERC721` tokens, otherwise, it will `revert`. The `IERC721Receiver` interface only includes an `onERC721Received()` function.

```solidity
// ERC721 receiver interface: Contracts must implement this interface to receive ERC721 tokens via safe transfers.
interface IERC721Receiver {
    function onERC721Received(
        address operator,
        address from,
        uint tokenId,
        bytes calldata data
    ) external returns (bytes4);
}
```

Let's take a look at how `ERC721` uses `_checkOnERC721Received` to ensure that the target contract implements the `onERC721Received()` function (returning the `selector` of `onERC721Received`).

```solidity
    function _checkOnERC721Received(
        address from,
        address to,
        uint tokenId,
        bytes memory _data
    ) private returns (bool) {
        if (to.isContract()) {
            return
                IERC721Receiver(to).onERC721Received(
                    msg.sender,
                    from,
                    tokenId,
                    _data
                ) == IERC721Receiver.onERC721Received.selector;
        } else {
            return true;
        }
    }
```
