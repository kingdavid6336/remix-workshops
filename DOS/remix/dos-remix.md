Follow the steps below to reproduce on Remix:

**1.** Deploy the `DoSGame` contract.
**2.** Call the `deposit()` function of the `DoSGame` contract to make a deposit and participate in the game.
![](https://raw.githubusercontent.com/remix-project-org/remix-workshops/master/DoS/img/S09-2.png)
**3.** At this point, if the game is over and `refund()` is called, the refund will be executed successfully.
![](https://raw.githubusercontent.com/remix-project-org/remix-workshops/master/DoS/img/S09-3.jpg)
**4.** Redeploy the `DoSGame` contract and deploy the `Attack` contract.
**5.** Call the `attack()` function of the `Attack` contract to make a deposit and participate in the game.
![](https://raw.githubusercontent.com/remix-project-org/remix-workshops/master/DoS/img/S09-4.jpg)
**6.** Call the `refund()` function of the `DoSGame` contract to initiate a refund, but it fails to execute properly, indicating a successful attack.
![](https://raw.githubusercontent.com/remix-project-org/remix-workshops/master/DoS/img/S09-5.jpg)
