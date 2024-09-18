# RealEstateAsset Smart Contract

## Overview

The `RealEstateAsset` smart contract is a simple implementation of a real estate property management system on the Ethereum blockchain. It allows users to list properties, transfer ownership, and remove properties from the listing.

## Features

- **List Properties**: Users can list a new property with a name and value.
- **Transfer Ownership**: Property owners can transfer ownership of their properties.
- **Remove Properties**: Owners can remove their properties from the listing.

## Smart Contract Functions

### 1. `listProperty(string memory _name, uint256 _value)`

- **Description**: Lists a new property.
- **Parameters**:
  - `_name`: The name of the property.
  - `_value`: The value of the property in Wei.
- **Events**: Emits a `PropertyListed` event.

### 2. `transferProperty(uint256 _propertyId, address _newOwner)`

- **Description**: Transfers ownership of a property to a new owner.
- **Parameters**:
  - `_propertyId`: The ID of the property to be transferred.
  - `_newOwner`: The address of the new owner.
- **Events**: Emits a `PropertyTransferred` event.

### 3. `removeProperty(uint256 _propertyId)`

- **Description**: Removes a property from the listing.
- **Parameters**:
  - `_propertyId`: The ID of the property to be removed.

## Error Handling

- **Require Statements**: Used to validate inputs and conditions (e.g., ensuring the property value is greater than 0).
- **Assert Statements**: Used to check invariants (e.g., ensuring the new owner is different from the current owner).
- **Revert Statements**: Used to provide custom error messages for unauthorized access or invalid states.

## Deployment

To deploy the contract, you can use tools like Remix, Truffle, or Hardhat. Here's how to do it with Remix:

1. Open [Remix IDE](https://remix.ethereum.org/).
2. Create a new file and paste the contract code.
3. Select the appropriate compiler version (0.8.0 or above).
4. Compile the contract.
5. In the "Deploy & Run Transactions" tab, select the contract and click "Deploy".

## Usage

After deploying the contract, you can interact with it through the Remix interface or by integrating it into a web application using Web3.js or ethers.js.

## License

This smart contract is released under the MIT License. See [LICENSE](LICENSE) for details.
