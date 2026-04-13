// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

import "../bank/Bank.sol";

contract Attack {
    UncheckedBank public bank; // Bank contract address

    // Initialize the Bank contract address
    constructor(UncheckedBank _bank) {
        bank = _bank;
    }

    // Callback function, transfer will fail
    receive() external payable {
        revert();
    }

    // Deposit function, set msg.value as the deposit amount
    function deposit() external payable {
        bank.deposit{value: msg.value}();
    }

    // Withdraw function, although the call is successful, the withdrawal actually fails
    function withdraw() external payable {
        bank.withdraw();
    }

    // Get the balance of this contract
    function getBalance() external view returns (uint256) {
        return address(this).balance;
    }
}
