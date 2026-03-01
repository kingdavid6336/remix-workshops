Follow the steps below to reproduce on Remix:

1. Deploy the `UncheckedBank` contract.

2. Deploy the `Attack` contract, and fill in the `UncheckedBank` contract address in the constructor.

3. Call the `deposit()` deposit function of the `Attack` contract to deposit `1 ETH`.

4. Call the `withdraw()` withdrawal function of the `Attack` contract to withdraw, the call is successful.

5. Call the `balanceOf()` function of the `UncheckedBank` contract and the `getBalance()` function of the `Attack` contract respectively. Although the previous call was successful and the depositor's balance was cleared, the withdrawal failed.