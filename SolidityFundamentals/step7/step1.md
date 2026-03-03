In this section, we will introduce the hash table in Solidity: `mapping` type.

## Mapping

With `mapping` type, people can query the corresponding `Value` by using a `Key`. For example, a person's wallet address can be queried by their `id`.

The format of declaring the `mapping` is `mapping(_KeyType => _ValueType)`, where `_KeyType` and `_ValueType` are the variable types of `Key` and `Value` respectively. For example:

```solidity
    mapping(uint => address) public idToAddress; // id maps to address
    mapping(address => address) public swapPair; // mapping of token pairs, from address to address
```

## Rules of `mapping`

- **Rule 1**: The `_KeyType` should be selected among default types in `solidity` such as `uint`, `address`, etc. No custom `struct` can be used. However, `_ValueType` can be any custom type. The following example will throw an error, because `_KeyType` uses a custom struct:

```solidity
      // define a struct
      struct Student{
          uint256 id;
          uint256 score;
      }
      mapping(Student => uint) public testVar;
```

- **Rule 2**: The storage location of the mapping must be `storage`: it can serve as the state variable or the `storage` variable inside the function. But it can't be used in arguments or return results of `public` function.

- **Rule 3**: If the mapping is declared as `public` then Solidity will automatically create a `getter` function for you to query for the `Value` by the `Key`.

- **Rule 4**：The syntax of adding a key-value pair to a mapping is `_Var[_Key] = _Value`, where `_Var` is the name of the mapping variable, and `_Key` and `_Value` correspond to the new key-value pair. For example:

```solidity
    function writeMap (uint _Key, address _Value) public {
        idToAddress[_Key] = _Value;
      }
```

## Principle of `mapping`

- **Principle 1**: The mapping does not store any `key` information or length information.

- **Principle 2**: Mapping use `keccak256(key)` as offset to access value.

- **Principle 3**: Since Ethereum defines all unused space as 0, all `key` that are not assigned a `value` will have an initial value of 0.

## Verify on Remix (use `Mapping.sol` as an example)

- Deploy `Mapping.sol`

  ![7-1_en](https://raw.githubusercontent.com/remix-project-org/remix-workshops/master/SolidityFundamentals/step7/img/7-1_en.png)

- Check the initial value of map `idToAddress`.

  ![7-2_en](https://raw.githubusercontent.com/remix-project-org/remix-workshops/master/SolidityFundamentals/step7/img/7-2_en.png)

- Write a new key-value pair

  ![7-3_en](https://raw.githubusercontent.com/remix-project-org/remix-workshops/master/SolidityFundamentals/step7/img/7-3_en.png)

## Summary

In this section， we introduced the `mapping` type in Solidity. So far, we've learned all kinds of common variables.
