Let's take a look at a vulnerable bank contract. It is very simple and includes an `owner` state variable to record the contract owner. It has a constructor and a `public` function:

- Constructor: Assigns a value to the `owner` variable when the contract is created.
- `transfer()`: This function takes two parameters, `_to` and `_amount`. It first checks `tx.origin == owner` and then transfers `_amount` ETH to `_to`. **Note: This function is vulnerable to phishing attacks!**

