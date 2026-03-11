In this lesson, we will introduce the selector clash attack, which is one of the reasons behind the hack of the cross-chain bridge Poly Network. In August 2021, the cross-chain bridge contracts of Poly Network on ETH, BSC, and Polygon were hacked, resulting in a loss of up to $611 million ([summary](https://rekt.news/polynetwork-rekt/)). This is the largest blockchain hack of 2021 and the second-largest in history, second only to the Ronin Bridge hack.

## Selector Clash

In Ethereum smart contracts, the function selector is the first 4 bytes (8 hexadecimal digits) of the hash value of the function signature `"<function name>(<function input types>)"`. When a user calls a function in a contract, the first 4 bytes of the `calldata` represent the selector of the target function, determining which function to call. If you are not familiar with it, you can read the [WTF Solidity 29: Function Selectors](https://github.com/AmazingAng/WTF-Solidity/blob/main/Languages/en/29_Selector_en/readme.md).

Due to the limited length of the function selector (4 bytes), it is very easy to collide: that is, we can easily find two different functions that have the same function selector. For example, `transferFrom(address,address,uint256)` and `gasprice_bit_ether(int128)` have the same selector: `0x23b872dd`. Of course, you can also write a script to brute force it.

![](https://raw.githubusercontent.com/remix-project-org/remix-workshops/master/SelectorClash/img/S02-1.png)

You can use the following websites to find different functions corresponding to the same selector:

1. [https://www.4byte.directory/](https://www.4byte.directory/)
2. [https://sig.eth.samczsun.com/](https://sig.eth.samczsun.com/)

You can also use the "Power Clash" tool below for brute forcing:

1. PowerClash: https://github.com/AmazingAng/power-clash

In contrast, the public key of a wallet is `64` bytes long and the probability of collision is almost `0`, making it very secure.

## `0xAA` Solves the Sphinx Riddle

The people of Ethereum have angered the gods, and the gods are furious. In order to punish the people of Ethereum, the goddess Hera sends down a Sphinx, a creature with the head of a human and the body of a lion, to the cliffs of Ethereum. The Sphinx presents a riddle to every Ethereum user who passes by the cliff: "What walks on four legs in the morning, two legs at noon, and three legs in the evening? It is the only creature that walks on different numbers of legs throughout its life. When it has the most legs, it is at its slowest and weakest." Those who solve this enigmatic riddle will be spared, while those who fail to solve it will be devoured. The Sphinx uses the selector `0x10cd2dc7` to verify the correct answer.

One morning, Oedipus passes by and encounters the Sphinx. He solves the mysterious riddle and says, "It is `function man()`. In the morning of life, he is a child who crawls on two legs and two hands. At noon, he becomes an adult who walks on two legs. In the evening, he grows old and weak and needs a cane to walk, hence he is called three-legged." After guessing the riddle correctly, Oedipus is allowed to live.

Later that afternoon, `0xAA` passes by and encounters the Sphinx. He also solves the mysterious riddle and says, "It is `function peopleLduohW(uint256)`. In the morning of life, he is a child who crawls on two legs and two hands. At noon, he becomes an adult who walks on two legs. In the evening, he grows old and weak and needs a cane to walk, hence he is called three-legged." Once again, the riddle is guessed correctly, and the Sphinx becomes furious. In a fit of anger, the Sphinx slips and falls from the towering cliff to its death.

![](https://raw.githubusercontent.com/remix-project-org/remix-workshops/master/SelectorClash/img/S02-2.png)
