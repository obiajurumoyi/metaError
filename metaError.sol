// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract VendingMachine {
    address public owner;
    uint256 public itemPrice;
    mapping(address => uint256) public balances;
    mapping(uint256 => Item) public items;

    struct Item {
        string name;
        uint amount;
    }

    event ItemPurchased(address indexed buyer, uint256 itemId);
    event FundsDeposited(address indexed depositor, uint256 amount);
    event FundsWithdrawn(address indexed withdrawer, uint256 amount);

    constructor() {
        owner = msg.sender;
        itemPrice = 1 ether; // Set the price of each item
        items[1] = Item("Drinks", 25);
        items[2] = Item("Chips", 25);
        items[3] = Item("Candy", 25);
        items[4] = Item("Biscuits", 25);
    }

    function depositFunds() external payable {
        require(msg.value > 0, "Must send Ether to deposit funds");
        balances[msg.sender] += msg.value;
        emit FundsDeposited(msg.sender, msg.value);
    }

    function purchaseItem(uint256 itemId, uint256 amount) external {
        require(amount > 0, "Amount must be greater than 0");
        require(balances[msg.sender] >= itemPrice, "Insufficient funds");
        require(bytes(items[itemId].name).length > 0, "Item does not exist");
        
        // Use assert to check that item amount does not go negative
        assert(items[itemId].amount >= amount); 
        
        if (items[itemId].amount < amount) {
            revert("Item out of stock"); // Use revert to handle out of stock
        }
        
        balances[msg.sender] -= itemPrice;
        items[itemId].amount -= amount;
        emit ItemPurchased(msg.sender, itemId);
    }

    function checkBalance() external view returns (uint256) {
        return balances[msg.sender];
    }

    function withdrawFunds(uint256 amount) external {
        require(amount > 0, "Amount must be greater than 0");
        require(balances[msg.sender] >= amount, "Insufficient balance");
        
        // Use assert to check that the contract balance is sufficient before transfer
        assert(address(this).balance >= amount);
        
        payable(msg.sender).transfer(amount);
        balances[msg.sender] -= amount;
        emit FundsWithdrawn(msg.sender, amount);
    }

    function setItemPrice(uint256 newPrice) external {
        require(msg.sender == owner, "Only owner can set the item price");
        itemPrice = newPrice;
    }
}
