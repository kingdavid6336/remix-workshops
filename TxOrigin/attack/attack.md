Next is the attack contract, which has a simple attack logic. It constructs an `attack()` function to perform phishing and transfer the balance of the bank contract owner to the hacker. It has two state variables, `hacker` and `bank`, to record the hacker's address and the address of the bank contract to be attacked.

It includes `2` functions:

- Constructor: Initializes the `bank` contract address.
- `attack()`: The attack function that requires the `owner` address of the bank contract to call. When the `owner` calls the attack contract, the attack contract calls the `transfer()` function of the bank contract. After confirming `tx.origin == owner`, it transfers the entire balance from the bank contract to the hacker's address.