// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract StakeContract {
    
    // Mapping to store the balance of each user (indexed by their address)
    mapping(address => uint256) public balances;

    // Event to notify when a deposit is made
    event Deposited(address indexed user, uint256 amount);

    // Event to notify when a withdrawal is made
    event Withdrawn(address indexed user, uint256 amount);

    // Function to deposit ETH into the contract
    // It increases the balance of the sender by the amount they sent
    function deposit() public payable {
        require(msg.value > 0, "You must send some ETH");

        // Increase the balance of the sender (msg.sender)
        balances[msg.sender] += msg.value;

        // Emit the deposit event
        emit Deposited(msg.sender, msg.value);
    }

    // Function to withdraw ETH from the contract
    // It reduces the balance of the sender and sends the ETH back to them
    function withdraw(uint256 amount) public {
        require(balances[msg.sender] >= amount, "Insufficient balance");

        // Reduce the balance of the sender
        balances[msg.sender] -= amount;

        // Send the specified amount of ETH to the sender
        payable(msg.sender).transfer(amount);

        // Emit the withdrawal event
        emit Withdrawn(msg.sender, amount);
    }

    // Function to check the balance of the sender
    function checkBalance() public view returns (uint256) {
        return balances[msg.sender];
    }
}
