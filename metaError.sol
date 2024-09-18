// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract RealEstateAsset {
    struct Property {
        uint256 id;
        string name;
        address owner;
        uint256 value; // Value in Wei
        bool isListed;
    }

    uint256 public propertyCount;
    mapping(uint256 => Property) public properties;

    event PropertyListed(uint256 indexed id, string name, uint256 value);
    event PropertyTransferred(uint256 indexed id, address from, address to);

    // List a new property
    function listProperty(string memory _name, uint256 _value) public {
        // Require that the value is greater than 0
        require(_value > 0, "Property value must be greater than 0");

        propertyCount++;
        properties[propertyCount] = Property(propertyCount, _name, msg.sender, _value, true);

        emit PropertyListed(propertyCount, _name, _value);
    }

    // Transfer ownership of a property
    function transferProperty(uint256 _propertyId, address _newOwner) public {
        Property storage property = properties[_propertyId];

        // Require that the property exists and is listed
        require(property.id != 0, "Property does not exist");
        require(property.isListed, "Property is not listed for sale");
        require(msg.sender == property.owner, "Only the owner can transfer the property");

        // Use assert to ensure the owner is not the new owner
        assert(_newOwner != property.owner);

        property.owner = _newOwner;
        property.isListed = false; // Mark the property as no longer listed

        emit PropertyTransferred(_propertyId, msg.sender, _newOwner);
    }

    // Example of a restricted function
    function removeProperty(uint256 _propertyId) public {
        Property storage property = properties[_propertyId];

        // Require that the property exists and the sender is the owner
        require(property.id != 0, "Property does not exist");
        require(msg.sender == property.owner, "Only the owner can remove the property");

        // Use revert to indicate unauthorized access for a non-owner
        if (!property.isListed) {
            revert("Property is not listed for sale");
        }

        delete properties[_propertyId];
        propertyCount--;
    }
}
