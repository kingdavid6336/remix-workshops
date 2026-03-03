In this lecture, we will introduce the ERC20 token standard on Ethereum and issue our test tokens.

## ERC20

ERC20 is a token standard on Ethereum, which originated from the `EIP20` proposed by Vitalik Buterin in November 2015. It implements the basic logic of token transfer:

- Account balance
- Transfer
- Approve transfer
- Total token supply
- Token Information (optional): name, symbol, decimal

## IERC20

`IERC20` is the interface contract of the `ERC20` token standard, which specifies the functions and events that `ERC20` tokens need to implement. The reason for defining an interface is that with the standard, there are universal function names and input and output parameters for all `ERC20` tokens. In the interface functions, only the function name, input parameters, and output parameters need to be defined, and it does not matter how the function is implemented internally. Therefore, the functions are divided into two contents: internal implementation and external interface, focusing on the implementation and agreement of shared data between interfaces. This is why we need two files `ERC20.sol` and `IERC20.sol` to implement a contract.

### Event

The `IERC20` defines `2` events: the `Transfer` event and the `Approval` event, which are emitted during token transfers and approvals, respectively.

```solidity
    /**
     * @dev Triggered when `value` tokens are transferred from `from` to `to`.
     */
    event Transfer(address indexed from, address indexed to, uint256 value);

    /**
     * @dev Triggered whenever `value` tokens are approved by `owner` to be spent by `spender`.
     */
    event Approval(address indexed owner, address indexed spender, uint256 value);
```

### Functions

`IERC20` defines `6` functions, providing basic functionalities for transferring tokens, and allowing tokens to be approved for use by other third parties on the chain.

- `totalSupply()` returns the total token supply.

```solidity
    /**
     * @dev Returns the total amount of tokens.
     */
    function totalSupply() external view returns (uint256);
```

`balanceOf()` returns the account balance.

```solidity
    /**
     * @dev Returns the amount of tokens owned by `account`.
     */
    function balanceOf(address account) external view returns (uint256);
```

- `transfer()` means transfer of funds.

```solidity
    /**
     * @dev Transfers `amount` tokens from the caller's account to the recipient `to`.
     *
     * Returns a boolean value indicating whether the operation succeeded or not.
     *
     * Emits a {Transfer} event.
     */
    function transfer(address to, uint256 amount) external returns (bool);
```

The `allowance()` function returns the authorized amount.

```solidity
    /**
     * @dev Returns the amount authorized by the `owner` account to the `spender` account, default is 0.
     *
     * When {approve} or {transferFrom} is invoked，`allowance` will be changed.
     */
    function allowance(address owner, address spender) external view returns (uint256);
```

- `approve()` Authorization

```solidity
/**
 * @dev Allows `spender` to spend `amount` tokens from caller's account.
 *
 * Returns a boolean value indicating whether the operation succeeded or not.
 *
 * Emits an {Approval} event.
 */
function approve(address spender, uint256 amount) external returns (bool);
```

- `transferFrom()` authorized transfer.

```solidity
/**
 * @dev Transfer `amount` of tokens from `from` account to `to` account, subject to the caller's
 * allowance. The caller must have allowance for `from` account balance.
 *
 * Returns `true` if the operation is successful.
 *
 * Emits a {Transfer} event.
 */
function transferFrom(
    address from,
    address to,
    uint256 amount
) external returns (bool);
```
