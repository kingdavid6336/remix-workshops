In this section, we introduce `event` in Solidity, using transfer events in ERC20 tokens as an example.

## Events

The events in `solidity` are the transaction logs stored on the `EVM` (Ethereum Virtual Machine). They can be emitted during function calls and are accessible with the contract address. Events have two characteristics：

- Responsive: Applications (e.g. [`ether.js`](https://learnblockchain.cn/docs/ethers.js/api-contract.html#id18)) can subscribe and listen to these events through `RPC` interface and respond at frontend.
- Economical: It is cheap to store data in events, costing about 2,000 `gas` each. In comparison, storing a new variable on-chain takes at least 20,000 `gas`.

### Declare events

The events are declared with the `event` keyword, followed by the event name, and then the type and name of each parameter to be recorded. Let's take the `Transfer` event from the `ERC20` token contract as an example：

```solidity
event Transfer(address indexed from, address indexed to, uint256 value);
```

`Transfer` event records three parameters: `from`，`to`, and `value`， which correspond to the address where the tokens are sent, the receiving address, and the number of tokens being transferred. Parameters `from` and `to` are marked with `indexed` keywords, which will be stored in a special data structure known as `topics` and easily queried by programs.

### Emit events

We can emit events in functions. In the following example, each time the `_transfer()` function is called, `Transfer` events will be emitted and corresponding parameters will be recorded.

```solidity
    // define _transfer function， execute transfer logic
    function _transfer(
        address from,
        address to,
        uint256 amount
    ) external {

        _balances[from] = 10000000; // give some initial tokens to transfer address

        _balances[from] -=  amount; // "from" address minus the number of transfer
        _balances[to] += amount; // "to" address adds the number of transfer

        // emit event
        emit Transfer(from, to, amount);
    }
```

## EVM Log

EVM uses `Log` to store Solidity events. Each log contains two parts: `topics` and `data`.

![EVM log structure showing topics and data fields](https://raw.githubusercontent.com/remix-project-org/remix-workshops/master/SolidityFundamentals/step12/img/12-3.jpg)

### `Topics`

`Topics` is used to describe events. Each event contains a maximum of 4 `topics`. Typically, the first `topic` is the event hash: the hash of the event signature. The event hash of the `Transfer` event is calculated as follows:

```solidity
keccak256("Transfer(address,address,uint256)")

//0xddf252ad1be2c89b69c2b068fc378daa952ba7f163c4a11628f55a4df523b3ef
```

Besides event hash, `topics` can include 3 `indexed` parameters, such as the `from` and `to` parameters in the `Transfer` event. The anonymous event is special: it does not have an event name and can have 4 `indexed` parameters at maximum.

`indexed` parameters can be understood as the indexed "key" for events, which can be easily queried by programs. The size of each `indexed` parameter is 32 bytes. For the parameters larger than 32 bytes, such as `array` and `string`, the hash of the underlying data is stored.

### `Data`

Non-indexed parameters will be stored in the `data` section of the log. They can be interpreted as the "value" of the event and can't be retrieved directly. But they can store data with larger sizes. Therefore, the `data` section can be used to store complex data structures, such as `array` and `string`. Moreover, `data` consumes less gas compared to `topic`.

## Remix Demo

Let's take `Event.sol` contract as an example.

1. Deploy the `Event` contract.

2. Call `_transfer` function to emit `Transfer` event.

![Remix console showing the Transfer event emitted after calling _transfer](https://raw.githubusercontent.com/remix-project-org/remix-workshops/master/SolidityFundamentals/step12/img/12-1_en.jpg)

3. Check transaction details to check the emitted event.

![Remix transaction details showing the decoded Transfer event topics and data](https://raw.githubusercontent.com/remix-project-org/remix-workshops/master/SolidityFundamentals/step12/img/12-2_en.jpg)

### Query event on etherscan

Etherscan is a block explorer that lets you view public data on transactions, smart contracts, and more on the Ethereum blockchain. To try this yourself: deploy the contract to an Ethereum testnet (e.g. Sepolia), call the `_transfer` function to transfer 100 tokens, then look up the transaction on [Sepolia Etherscan](https://sepolia.etherscan.io) to inspect the emitted event.

Click `Logs` button to check the details of the event：

![details of event](https://images.mirror-media.xyz/publication-images/gx6_wDMYEl8_Gc_JkTIKn.png?height=980&width=1772)

There are 3 elements in `Topics`: `[0]` is the hash of the event, `[1]` and `[2]` are the `indexed` parameters defined in the `Transfer` event (`from` and `to`). The element in `Data` is the non-indexed parameter `amount`.

## Summary

In this lecture, we introduced how to use and query events in `solidity`. Many on-chain analysis tools are based on solidity events, such as `Dune Analytics`.
