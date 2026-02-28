**1.** Set the `value` to 10ETH, then deploy the `Bank` contract, and the owner address `owner` is initialized as the deployed contract address.

![](https://raw.githubusercontent.com/remix-project-org/remix-workshops/master/TxOrigin/img/S12-2.jpg)

**2.** Switch to another wallet as the hacker wallet, fill in the address of the bank contract to be attacked, and then deploy the `Attack` contract. The hacker address `hacker` is initialized as the deployed contract address.

![](https://raw.githubusercontent.com/remix-project-org/remix-workshops/master/TxOrigin/img/S12-3.jpg)

**3.** Switch back to the `owner` address. At this point, we were induced to call the `attack()` function of the `Attack` contract. As a result, the balance of the `Bank` contract is emptied, and the hacker's address gains 10ETH.

![](https://raw.githubusercontent.com/remix-project-org/remix-workshops/master/TxOrigin/img/S12-4.jpg)
