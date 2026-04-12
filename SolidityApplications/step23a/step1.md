In this lecture, we introduce an extension of ERC20 tokens, ERC20Permit, which supports the use of signatures for authorization and improves user experience. It was proposed in EIP-2612, has been incorporated into the Ethereum standard, and is used by tokens such as `USDC`, `ARB`, etc.

## ERC20

One of the main reasons for ERC20's popularity is that the two functions `approve` and `transferFrom` are used together so that tokens can not only be transferred between externally owned accounts (EOA) but can also be used by other contracts.

However, the `approve` function of ERC20 is restricted to be called only by the token owner, which means that all initial operations of `ERC20` tokens must be performed by `EOA`. For example, if user A uses `USDT` to exchange `ETH` on a decentralized exchange, two transactions must be completed: in the first step, user A calls `approve` to authorize `USDT` to the contract, and in the second step, user A calls the contract to exchange. Very cumbersome, and users must hold `ETH` to pay for the gas of the transaction.

## ERC20Permit

EIP-2612 proposes ERC20Permit, which extends the ERC20 standard by adding a `permit` function that allows users to modify authorization through EIP-712 signatures instead of through `msg.sender`. This has two benefits:

1. The authorization step only requires the user to sign off the chain, reducing one transaction.
2. After signing, the user can entrust a third party to perform subsequent transactions without holding ETH: User A can send the signature to a third party B who has gas, and entrust B to execute subsequent transactions.

![ERC20Permit workflow diagram](https://raw.githubusercontent.com/remix-project-org/remix-workshops/master/SolidityApplications/step23a/img/53-1.png)

## Contract

### IERC20Permit interface contract

First, let us study the interface contract of ERC20Permit, which defines 3 functions:

- `permit()`: Authorize the ERC20 token balance of `owner` to `spender` according to the signature of `owner`, and the amount is `value`.
- `nonces()`: Returns the current nonce of `owner`. This value must be included every time you generate a signature for the `permit()` function. Each successful call to the `permit()` function will increase the `owner` nonce by 1 to prevent the same signature from being used multiple times.
- `DOMAIN_SEPARATOR()`: Returns the domain separator used to encode the signature of the `permit()` function, such as EIP712.

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/**
 * @dev ERC20 Permit extended interface that allows approval via signatures, as defined in https://eips.ethereum.org/EIPS/eip-2612[EIP-2612].
  */
interface IERC20Permit {
     /**
      * @dev Authorizes `owner`'s ERC20 balance to `spender` based on the owner's signature, the amount is `value`
     */
    function permit(
        address owner,
        address spender,
        uint256 value,
        uint256 deadline,
        uint8 v,
        bytes32 r,
        bytes32 s
    ) external;

    /**
     *@dev Returns the current nonce of `owner`. This value must be included every time you generate a signature for {permit}.
     */
    function nonces(address owner) external view returns (uint256);

    /**
     * @dev Returns the domain separator used to encode the signature of {permit}
     */
    // solhint-disable-next-line func-name-mixedcase
    function DOMAIN_SEPARATOR() external view returns (bytes32);
}
```
