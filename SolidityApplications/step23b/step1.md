Next, let us write a simple ERC20Permit contract, which implements all interfaces defined by IERC20Permit. The contract contains 2 state variables:

- `_nonces`: `address -> uint` mapping, records the current nonce values of all users.
- `_PERMIT_TYPEHASH`: Constant, records the type hash of the `permit()` function.

The contract contains 5 functions:

- Constructor: Initialize the `name` and `symbol` of the token.
- **`permit()`**: The core function of ERC20Permit, which implements the `permit()` of IERC20Permit. It first checks whether the signature has expired, then restores the signed message using `_PERMIT_TYPEHASH`, `owner`, `spender`, `value`, `nonce`, and `deadline` and verifies whether the signature is valid. If the signature is valid, the `_approve()` function of ERC20 is called to perform the authorization operation.
- `nonces()`: Implements the `nonces()` function of IERC20Permit.
- `DOMAIN_SEPARATOR()`: Implements the `DOMAIN_SEPARATOR()` function of IERC20Permit.
- `_useNonce()`: A function that consumes `nonce`, returns the user's current `nonce`, and increases it by 1.

```solidity
// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./IERC20Permit.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/utils/cryptography/ECDSA.sol";
import "@openzeppelin/contracts/utils/cryptography/EIP712.sol";

contract ERC20Permit is ERC20, IERC20Permit, EIP712 {
    mapping(address => uint) private _nonces;

    bytes32 private constant _PERMIT_TYPEHASH =
        keccak256("Permit(address owner,address spender,uint256 value,uint256 nonce,uint256 deadline)");

    constructor(string memory name, string memory symbol) EIP712(name, "1") ERC20(name, symbol){}

    function permit(
        address owner,
        address spender,
        uint256 value,
        uint256 deadline,
        uint8 v,
        bytes32 r,
        bytes32 s
    ) public virtual override {
        require(block.timestamp <= deadline, "ERC20Permit: expired deadline");

        bytes32 structHash = keccak256(abi.encode(_PERMIT_TYPEHASH, owner, spender, value, _useNonce(owner), deadline));
        bytes32 hash = _hashTypedDataV4(structHash);

        address signer = ECDSA.recover(hash, v, r, s);
        require(signer == owner, "ERC20Permit: invalid signature");

        _approve(owner, spender, value);
    }

    function nonces(address owner) public view virtual override returns (uint256) {
        return _nonces[owner];
    }

    function DOMAIN_SEPARATOR() external view override returns (bytes32) {
        return _domainSeparatorV4();
    }

    function _useNonce(address owner) internal virtual returns (uint256 current) {
        current = _nonces[owner];
        _nonces[owner] += 1;
    }
}
```

## Remix Reappearance

1. Deploy the `ERC20Permit` contract and set both `name` and `symbol` to `WTFPermit`.

2. Run `signERC20Permit.html` and change the `Contract Address` to the deployed `ERC20Permit` contract address. Other information is given below. Then click the `Connect Metamask` and `Sign Permit` buttons in sequence to sign, and obtain `r`, `s`, and `v` for contract verification. To sign, use the wallet that deploys the contract, such as the Remix test wallet:

    ```js
    owner: 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4    spender: 0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2
    value: 100
    deadline: 115792089237316195423570985008687907853269984665640564039457584007913129639935
    private_key: 503f38a9c967ed597e47fe25643985f032b072db8075426a92110f82df48dfcb
    ```

![Signing the ERC20Permit authorization with owner, spender, and value fields visible](https://raw.githubusercontent.com/remix-project-org/remix-workshops/master/SolidityApplications/step23b/img/53-2.png)

3. Call the `permit()` method of the contract, enter the corresponding parameters, and authorize.

4. Call the `allowance()` method of the contract, enter the corresponding `owner` and `spender`, and you can see that the authorization is successful.

## Safety Note

ERC20Permit uses off-chain signatures for authorization, which brings convenience to users but also brings risks. Some hackers will use this feature to conduct phishing attacks to deceive user signatures and steal assets. A signature phishing attack targeting USDC in April 2023 caused a user to lose 228w u of assets.

**When signing, be sure to read the signature carefully!**

## Summary

In this lecture, we introduced ERC20Permit, an extension of the ERC20 token standard, which supports users to use off-chain signatures for authorization operations, improves user experience, and is adopted by many projects. But at the same time, it also brings greater risks, and your assets can be swept away with just one signature. Everyone must be more careful when signing.
