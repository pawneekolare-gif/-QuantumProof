
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract QuantumProofWallet {
    // Owner of the wallet
    address public owner;
    
    // Mapping to store user balances
    mapping(address => uint256) public balances;

    // Event to log deposit transactions
    event Deposited(address indexed user, uint256 amount);

    // Event to log withdrawal transactions
    event Withdrawn(address indexed user, uint256 amount);

    // Modifier to restrict actions to the owner of the wallet
    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can perform this action");
        _;
    }

    // Constructor to set the initial owner of the wallet
    constructor() {
        owner = msg.sender;
    }

    // Function to deposit ether into the wallet
    function deposit() external payable {
        require(msg.value > 0, "Deposit amount must be greater than 0");
        balances[msg.sender] += msg.value;
        emit Deposited(msg.sender, msg.value);
    }

    // Function to withdraw ether from the wallet
    function withdraw(uint256 amount) external {
        require(balances[msg.sender] >= amount, "Insufficient balance");
        balances[msg.sender] -= amount;
        payable(msg.sender).transfer(amount);
        emit Withdrawn(msg.sender, amount);
    }

    // Function to check the balance of the wallet
    function checkBalance() external view returns (uint256) {
        return balances[msg.sender];
    }
}
