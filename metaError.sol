// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SportsBetting {
    address public owner;
    uint256 public eventId;
    uint256 public betAmount;
    mapping(address => uint256) public bets;
    bool public eventResolved;
    uint256 public winningTeam; // 1 or 2

    enum BetStatus { Pending, Won, Lost }
    mapping(address => BetStatus) public betStatus;

    event BetPlaced(address indexed bettor, uint256 amount, uint256 team);
    event BetResolved(address indexed bettor, BetStatus status);
    event FundsWithdrawn(address indexed withdrawer, uint256 amount);

    constructor() {
        owner = msg.sender;
        eventId = 1; // Example event ID
        betAmount = 1 ether; // Minimum bet amount
        eventResolved = false;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can perform this action");
        _;
    }

    modifier onlyWhenNotResolved() {
        require(!eventResolved, "Event has already been resolved");
        _;
    }

    function placeBet(uint256 team) external payable onlyWhenNotResolved {
        require(msg.value == betAmount, "Incorrect bet amount");
        require(team == 1 || team == 2, "Invalid team selection");

        // Using assert to check for invariant
        assert(bets[msg.sender] == 0); // Each address can only place one bet

        bets[msg.sender] = msg.value;
        betStatus[msg.sender] = BetStatus.Pending;

        emit BetPlaced(msg.sender, msg.value, team);
    }

    function resolveEvent(uint256 _winningTeam) external onlyOwner {
        require(!eventResolved, "Event has already been resolved");
        require(_winningTeam == 1 || _winningTeam == 2, "Invalid winning team");

        winningTeam = _winningTeam;
        eventResolved = true;

        // Resolve bets
        for (address bettor : getAllBettors()) {
            if (bets[bettor] > 0) {
                if (betStatus[bettor] == BetStatus.Pending) {
                    if (team == winningTeam) {
                        betStatus[bettor] = BetStatus.Won;
                        payable(bettor).transfer(bets[bettor] * 2); // Return winnings
                        emit BetResolved(bettor, BetStatus.Won);
                    } else {
                        betStatus[bettor] = BetStatus.Lost;
                        emit BetResolved(bettor, BetStatus.Lost);
                    }
                    bets[bettor] = 0; // Reset bet amount
                }
            }
        }
    }

    function withdrawFunds() external {
        uint256 amount = address(this).balance;
        require(amount > 0, "No funds available for withdrawal");

        // Using assert to ensure correct balance
        assert(amount <= address(this).balance);

        payable(owner).transfer(amount);
        emit FundsWithdrawn(owner, amount);
    }

    function getAllBettors() private view returns (address[] memory) {
        // This function is a placeholder. Implement a real way to get all bettors.
        return new address ;
    }

    receive() external payable {}
}
