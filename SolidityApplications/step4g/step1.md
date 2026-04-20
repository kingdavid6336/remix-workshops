The `ERC721` main contract implements all the functionalities defined by `IERC721`, `IERC165` and `IERC721Metadata`. It includes `4` state variables and `17` functions. The implementation is rather simple, the functionality of each function is explained in the code comments:

```solidity
// SPDX-License-Identifier: MIT
// by 0xAA
pragma solidity ^0.8.21;

import "./IERC165.sol";
import "./IERC721.sol";
import "./IERC721Receiver.sol";
import "./IERC721Metadata.sol";
import "./Address.sol";
import "./String.sol";

contract ERC721 is IERC721, IERC721Metadata{
    using Address for address; // Uses Address library and uses isContract to check whether an address is a contract
    using Strings for uint256; // Uses String library

    // Token name
    string public override name;
    // Token symbol
    string public override symbol;
    // Mapping from token ID to owner address
    mapping(uint => address) private _owners;
    // Mapping owner address to balance of the token
    mapping(address => uint) private _balances;
    // Mapping from tokenId to approved address
    mapping(uint => address) private _tokenApprovals;
    //  Mapping from owner to operator addresses' batch approvals
    mapping(address => mapping(address => bool)) private _operatorApprovals;
    // ...
}
```

## ERC165 and ERC721 explained

As mentioned earlier, in order to prevent an NFT from being transferred to a contract that is incapable of handling NFTs, the destination address must correctly implement the ERC721TokenReceiver interface:

```solidity
interface ERC721TokenReceiver {
    function onERC721Received(address _operator, address _from, uint256 _tokenId, bytes _data) external returns(bytes4);
}
```

Expanding into the world of programming languages, whether it's Java's interface or Rust's Trait (of course, in solidity, it's more like a library than a trait), whenever it relates to interfaces, it implies that an interface is a collection of certain behaviours (in solidity, interfaces are equivalent to a collection of function selectors). If a certain type implements a certain interface, it means that the type has a certain functionality. Therefore, as long as a certain contract type implements the above `ERC721TokenReceiver` interface (specifically, it implements the `onERC721Received` function), the contract type indicates to the outside world that it has the ability to manage NFTs. Of course, the logic of operating NFTs is implemented in other functions of the contract.

When executing `safeTransferFrom` in the ERC721 standard, it will check whether the target contract implements the `onERC721Received` function, which is an operation based on the `ERC165` idea.

So, what exactly is `ERC165`?

`ERC165` is a technical standard to indicate which interfaces have been implemented externally. As mentioned above, implementing an interface means that the contract has a special ability. When some contracts interact with other contracts, they expect the target contract to have certain capabilities, so that contracts can query each other through the `ERC165` standard to check whether the other party has the corresponding abilities.

Taking the `ERC721` contract as an example, how does it check whether a contract implements `ERC721`? According to [how-to-detect-if-a-contract-implements-erc-165](https://eips.ethereum.org/EIPS/eip-165#how-to-detect-if-a-contract-implements-erc-165), the checking steps should be to first check whether the contract implements `ERC165`, and then check specific interfaces implemented by the contract. At this point, the specific interface is `IERC721`. `IERC721` is the basic interface of `ERC721` (why say basic? Because there are other extensions, such as `ERC721Metadata` and `ERC721Enumerable`).

```solidity
/// Please note this **0x80ac58cd**
///  **⚠⚠⚠ Note: the ERC-165 identifier for this interface is 0x80ac58cd. ⚠⚠⚠**
interface ERC721 /* is ERC165 */ {
    event Transfer(address indexed _from, address indexed _to, uint256 indexed _tokenId);
    event Approval(address indexed _owner, address indexed _approved, uint256 indexed _tokenId);
    event ApprovalForAll(address indexed _owner, address indexed _operator, bool _approved);

    function balanceOf(address _owner) external view returns (uint256);
    function ownerOf(uint256 _tokenId) external view returns (address);
    function safeTransferFrom(address _from, address _to, uint256 _tokenId, bytes data) external payable;
    function safeTransferFrom(address _from, address _to, uint256 _tokenId) external payable;
    function transferFrom(address _from, address _to, uint256 _tokenId) external payable;
    function approve(address _approved, uint256 _tokenId) external payable;
    function setApprovalForAll(address _operator, bool _approved) external;
    function getApproved(uint256 _tokenId) external view returns (address);
    function isApprovedForAll(address _owner, address _operator) external view returns (bool);
}
```

The value **0x80ac58cd** is obtained by calculating `bytes4(keccak256(ERC721.Transfer.selector) ^ keccak256(ERC721.Approval.selector) ^ ··· ^keccak256(ERC721.isApprovedForAll.selector))`, which is the computation method specified by `ERC165`.

Similarly, one can calculate the interface of `ERC165` itself (which contains only one function `function supportsInterface(bytes4 interfaceID) external view returns (bool);`) by using `bytes4(keccak256(supportsInterface.selector))`, which results in **0x01ffc9a7**. Additionally, ERC721 defines some extended interfaces, such as `ERC721Metadata`. It looks like this:

```solidity
///  Note: the ERC-165 identifier for this interface is 0x5b5e139f.
interface ERC721Metadata /* is ERC721 */ {
    function name() external view returns (string _name);
    function symbol() external view returns (string _symbol);
    function tokenURI(uint256 _tokenId) external view returns (string); // This is very important as the urls of NFT's images showing in the website are returned by this function.
}
```

The calculation of **0x5b5e139f** is:

```solidity
IERC721Metadata.name.selector ^ IERC721Metadata.symbol.selector ^ IERC721Metadata.tokenURI.selector
```

How does the ERC721.sol implemented by Solmate fulfil these features required by `ERC165`?

```solidity
function supportsInterface(bytes4 interfaceId) public view virtual returns (bool) {
        return
            interfaceId == 0x01ffc9a7 || // ERC165 Interface ID for ERC165
            interfaceId == 0x80ac58cd || // ERC165 Interface ID for ERC721
            interfaceId == 0x5b5e139f; // ERC165 Interface ID for ERC721Metadata
}
```

Yes, it's that simple. When the outside world follows the steps in [link1](https://eips.ethereum.org/EIPS/eip-165#how-to-detect-if-a-contract-implements-erc-165) to perform the check, if they want to check whether this contract implements 165, it's easy. The `supportsInterface` function must return true when the input parameter is `0x01ffc9a7`, and false when the input parameter is `0xffffffff`. The above implementation perfectly meets the requirements.

When the outside world wants to check whether this contract is `ERC721`, it's easy. When the input parameter is **0x80ac58cd**, it indicates that the outside world wants to do this check. Return true.

When the outside world wants to check whether this contract implements the `ERC721` extension `ERC721Metadata` interface, the input parameter is `0x5b5e139f`. It's easy, just return true.

And because this function is virtual, users of the contract can inherit the contract and then continue to implement the `ERC721Enumerable` interface. After implementing functions like `totalSupply`, they can re-implement the inherited `supportsInterface` as:

```solidity
function supportsInterface(bytes4 interfaceId) public view virtual returns (bool) {
        return
            interfaceId == 0x01ffc9a7 || // ERC165 Interface ID for ERC165
            interfaceId == 0x80ac58cd || // ERC165 Interface ID for ERC721
            interfaceId == 0x5b5e139f || // ERC165 Interface ID for ERC721Metadata
            interfaceId == 0x780e9d63;   // ERC165 Interface ID for ERC721Enumerable
}
```

**Elegance, conciseness, and scalability are maximized.**
