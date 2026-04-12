Now we will write an `ERC20` contract and implement the functions defined in the `IERC20` interface.

### State Variables

We need state variables to record account balances, allowances, and token information. Among them, `balanceOf`, `allowance`, and `totalSupply` are of type `public`, which will automatically generate a same-name `getter` function, implementing `balanceOf()`, `allowance()` and `totalSupply()` functions defined in `IERC20`. `name`, `symbol`, and `decimals` correspond to the name, symbol, and decimal places of tokens.

**Note**: adding `override` modifier to `public` variables will override the same-name `getter` function inherited from the parent contract, such as `balanceOf()` function in `IERC20`.

```solidity
    mapping(address => uint256) public override balanceOf;

    mapping(address => mapping(address => uint256)) public override allowance;

    uint256 public override totalSupply;   // total supply of the token

    string public name;   // the name of the token
    string public symbol;  // the symbol of the token

    uint8 public decimals = 18; // decimal places of the token
```

### Functions

- Constructor Function: Initializes the token name and symbol.

```solidity
    constructor(string memory name_, string memory symbol_){
        name = name_;
        symbol = symbol_;
    }
```

- `transfer()` function: Implements the `transfer` function in `IERC20`, which handles token transfers. The caller deducts `amount` tokens and the recipient receives the corresponding tokens. Some coins will modify this function to include logic such as taxation, dividends, lottery, etc.

```solidity
    function transfer(address recipient, uint amount) external override returns (bool) {
        balanceOf[msg.sender] -= amount;
        balanceOf[recipient] += amount;
        emit Transfer(msg.sender, recipient, amount);
        return true;
    }
```

- `approve()` function: Implements the `approve` function in `IERC20`, which handles token authorization logic. The `spender` specified in the function can spend the authorized `amount` of tokens from the authorizer. The `spender` can be an EOA account or a contract account, for example, when you trade tokens on `Uniswap`, you need to authorize tokens to the `Uniswap` contract.

```solidity
    function approve(address spender, uint amount) external override returns (bool) {
        allowance[msg.sender][spender] = amount;
        emit Approval(msg.sender, spender, amount);
        return true;
    }
```

- `transferFrom()` function: Implements the `transferFrom` function in `IERC20`, which is the logic for authorized transfer. The authorized party transfers `amount` of tokens from `sender` to `recipient`.

```solidity
    function transferFrom(
        address sender,
        address recipient,
        uint amount
    ) external override returns (bool) {
        allowance[sender][msg.sender] -= amount;
        balanceOf[sender] -= amount;
        balanceOf[recipient] += amount;
        emit Transfer(sender, recipient, amount);
        return true;
    }
```

- `mint()` function: Token minting function, not included in the `IERC20` standard. For the sake of the tutorial, anyone can mint any amount of tokens. In actual applications, permission management will be added, and only the `owner` can mint tokens.

```solidity
    function mint(uint amount) external {
        balanceOf[msg.sender] += amount;
        totalSupply += amount;
        emit Transfer(address(0), msg.sender, amount);
    }
```

- `burn()` function: Function to destroy tokens, not included in the `IERC20` standard.

```solidity
    function burn(uint amount) external {
        balanceOf[msg.sender] -= amount;
        totalSupply -= amount;
        emit Transfer(msg.sender, address(0), amount);
    }
```

## Issuing ERC20 Tokens

With the `ERC20` standard in place, it is very easy to issue tokens on the `ETH` chain. Now, let's issue our first token.

Compile the `ERC20` contract in `Remix`, enter the constructor's parameters in the deployment section, set `name_` and `symbol_` to `WTF`, and then click the `transact` button to deploy.

![Deploying the contract](https://raw.githubusercontent.com/remix-project-org/remix-workshops/master/SolidityApplications/step1b/img/31-1.png)

Now, we have created the `WTF` token. We need to run the `mint()` function to mint some tokens for ourselves. Open up the `ERC20` contract in the `Deployed Contract` section, enter `100` in the `mint` function area, and click the `mint` button to mint `100` `WTF` tokens for ourselves.

You can click on the Debug button on the right to view the logs like below.

There are four key pieces of information:

- The `Transfer` event
- The minting address `0x0000000000000000000000000000000000000000`
- The receiving address `0x5B38Da6a701c568545dCfcB03FcB875f56beddC4`
- The token amount `100`

![Minting tokens](https://raw.githubusercontent.com/remix-project-org/remix-workshops/master/SolidityApplications/step1b/img/31-2.png)

We use the `balanceOf()` function to check the account balance. By inputting our current account, we can see the balance of our account is `100` which means minting is successful.

The account information is shown on the left like below image, and the details of the function execution are indicated on the right side.

![Check Balance](https://raw.githubusercontent.com/remix-project-org/remix-workshops/master/SolidityApplications/step1b/img/31-3.png)

## Summary

In this lesson, we learned about the `ERC20` standard and its implementation on the Ethereum network, and issued our own test token. The `ERC20` token standard proposed at the end of 2015 greatly lowered the threshold for issuing tokens on the Ethereum network and ushered in the era of `ICO`. When investing, carefully read the project's token contract to effectively avoid risks and increase investment success rate.
