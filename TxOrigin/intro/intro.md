In this lesson, we will discuss the `tx.origin` phishing attack and prevention methods in smart contracts.

## `tx.origin` Phishing Attack

When I was in middle school, I loved playing games. However, the game developers implemented an anti-addiction system that only allowed players who were over 18 years old, as verified by their ID card number, to play without restrictions. So, what did I do? I used my parent's ID card number to bypass the system and successfully circumvented the anti-addiction measures. This example is similar to the `tx.origin` phishing attack.

In Solidity, `tx.origin` is used to obtain the original address that initiated the transaction. It is similar to `msg.sender`. Let's differentiate between them with an example.

If User A calls Contract B, and then Contract B calls Contract C, from the perspective of Contract C, `msg.sender` is Contract B, and `tx.origin` is User A. If you are not familiar with the `call` mechanism, you can read [WTF Solidity 22: Call](https://github.com/AmazingAng/WTF-Solidity/blob/main/Languages/en/22_Call_en/readme.md).

![](https://raw.githubusercontent.com/remix-project-org/remix-workshops/master/TxOrigin/img/S12_1.jpg)

Therefore, if a bank contract uses `tx.origin` for identity authentication, a hacker can deploy an attack contract and then induce the owner of the bank contract to call it. Even if `msg.sender` is the address of the attack contract, `tx.origin` will be the address of the bank contract owner, allowing the transfer to succeed.
