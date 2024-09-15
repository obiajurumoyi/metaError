# Functions and Errors

# VendingMachine Contract

## Overview

The `VendingMachine` contract is a simple Ethereum smart contract that simulates a vending machine. It allows users to deposit Ether, purchase items from the vending machine, and withdraw their funds. The contract owner can set the price of each item.

## Features

- **Deposit Funds**: Users can deposit Ether into their account.
- **Purchase Items**: Users can buy items from the vending machine if they have enough funds.
- **Withdraw Funds**: Users can withdraw their deposited Ether.
- **Check Balance**: Users can check their account balance.
- **Set Item Price**: The owner of the contract can set the price for each item.

## Contract Details

### Contract Variables

- `address public owner`: The address of the contract owner.
- `uint256 public itemPrice`: The price of each item.
- `mapping(address => uint256) public balances`: Tracks the balance of each user.
- `mapping(uint256 => Item) public items`: Stores information about each item.

### Structs

- `Item`: Represents an item in the vending machine.
  - `string name`: The name of the item.
  - `uint amount`: The quantity of the item available.

### Events

- `event ItemPurchased(address indexed buyer, uint256 itemId)`: Emitted when an item is purchased.
- `event FundsDeposited(address indexed depositor, uint256 amount)`: Emitted when funds are deposited.
- `event FundsWithdrawn(address indexed withdrawer, uint256 amount)`: Emitted when funds are withdrawn.

## Functions

### `constructor()`

Initializes the contract with the owner and sets up initial items with their names and quantities.

### `function depositFunds() external payable`

Allows users to deposit Ether into their account. The deposited amount is added to the user's balance.

### `function purchaseItem(uint256 itemId, uint256 amount) external`

Allows users to purchase items from the vending machine. The user must have sufficient funds, and the item must be in stock. If the item is out of stock, the transaction is reverted.

### `function checkBalance() external view returns (uint256)`

Returns the balance of the calling user.

### `function withdrawFunds(uint256 amount) external`

Allows users to withdraw a specified amount of Ether from their balance. The contract balance must be sufficient for the withdrawal.

### `function setItemPrice(uint256 newPrice) external`

Allows the contract owner to set a new price for each item.

## Error Handling

- **`require`**: Used to validate input and state conditions, such as ensuring non-zero amounts and sufficient balances.
- **`assert`**: Used for internal consistency checks, ensuring that item amounts and contract balance are as expected.
- **`revert`**: Used to revert transactions with custom error messages when conditions fail, such as when an item is out of stock.

## Deployment and Usage

1. **Deploy the Contract**: Use an Ethereum development environment like Remix, Hardhat, or Truffle to deploy the contract.

2. **Interact with the Contract**:
   - **Deposit Funds**: Call `depositFunds` with Ether.
   - **Purchase Items**: Call `purchaseItem` with the item ID and quantity.
   - **Withdraw Funds**: Call `withdrawFunds` with the amount to withdraw.
   - **Check Balance**: Call `checkBalance` to view your balance.
   - **Set Item Price**: Use `setItemPrice` to update the price of items (only accessible by the owner).

## Notes

- The contract uses `require`, `assert`, and `revert` for error handling to ensure the proper functioning of the vending machine.
- Ensure that the contract has sufficient Ether for withdrawals.
- The `itemPrice` is set to `1 ether` by default but can be changed by the owner.

## License

This smart contract is released under the MIT License. See [LICENSE](LICENSE) for details.
