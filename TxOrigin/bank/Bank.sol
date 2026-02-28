contract Bank {
    address public owner; // Records the owner of the contract

    // Assigns the value to the owner variable when the contract is created
    constructor() payable {
        owner = msg.sender;
    }

    function transfer(address payable _to, uint _amount) public {
        // Check the message origin !!! There may be phishing risks if the owner is induced to call this function!
        require(tx.origin == owner, "Not owner");
        // Transfer ETH
        (bool sent, ) = _to.call{value: _amount}("");
        require(sent, "Failed to send Ether");
    }
}
