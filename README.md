# Functions and Errors

## Sports Betting Smart Contract

## Overview

The Sports Betting Smart Contract is an Ethereum smart contract for placing bets on a sports event. It allows users to place bets on one of two teams and lets the event owner resolve the event and distribute winnings. The contract includes `require()`, `assert()`, and `revert()` statements for robust error handling.

## Features

- **Place a Bet**: Users can place a bet on one of two teams by sending a fixed amount of Ether.
- **Resolve the Event**: The event owner can resolve the event, declare the winning team, and distribute winnings.
- **Withdraw Funds**: The contract owner can withdraw remaining funds after the event is resolved.
- **Error Handling**: Utilizes `require()`, `assert()`, and `revert()` for error handling and ensuring contract integrity.

## License

This smart contract is released under the MIT License. See [LICENSE](LICENSE) for details.
