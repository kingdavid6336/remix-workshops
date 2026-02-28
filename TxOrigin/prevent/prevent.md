Currently, there are two main methods to prevent potential `tx.origin` phishing attacks.

### 1. Use `msg.sender` instead of `tx.origin`

`msg.sender` can obtain the address of the direct caller of the current contract. By verifying `msg.sender`, the entire calling process can be protected from external attack contracts.

```solidity
function transfer(address payable _to, uint256 _amount) public {
  require(msg.sender == owner, "Not owner");

  (bool sent, ) = _to.call{value: _amount}("");
  require(sent, "Failed to send Ether");
}
```

### 2. Verify `tx.origin == msg.sender`

If you must use `tx.origin`, you can also verify that `tx.origin` is equal to `msg.sender`. This can prevent external contract calls from interfering with the current contract. However, the downside is that other contracts will not be able to call this function.

```solidity
    function transfer(address payable _to, uint _amount) public {
        require(tx.origin == owner, "Not owner");
        require(tx.origin == msg.sender, "can't call by external contract");
        (bool sent, ) = _to.call{value: _amount}("");
        require(sent, "Failed to send Ether");
    }
```

## Summary

In this lesson, we discussed the `tx.origin` phishing attack in smart contracts. There are two methods to prevent it: using `msg.sender` instead of `tx.origin`, or checking `tx.origin == msg.sender`. It is recommended to use the first method, as the latter will reject all calls from other contracts.
