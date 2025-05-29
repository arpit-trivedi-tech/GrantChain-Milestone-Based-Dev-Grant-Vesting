// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract GrantChain {
    address public funder;
    address public grantee;

    struct Milestone {
        string description;
        uint256 amount;
        bool isReleased;
    }

    Milestone[] public milestones;

    constructor(address _grantee) payable {
        require(msg.value > 0, "Grant funds required");
        funder = msg.sender;
        grantee = _grantee;
    }

    modifier onlyFunder() {
        require(msg.sender == funder, "Only funder");
        _;
    }

    modifier onlyGrantee() {
        require(msg.sender == grantee, "Only grantee");
        _;
    }

    function addMilestone(string memory description, uint256 amount) external onlyFunder {
        require(address(this).balance >= amount, "Insufficient funds");
        milestones.push(Milestone(description, amount, false));
    }

    function releaseMilestone(uint256 index) external onlyFunder {
        Milestone storage m = milestones[index];
        require(!m.isReleased, "Already released");

        m.isReleased = true;
        payable(grantee).transfer(m.amount);
    }

    function getMilestones() external view returns (Milestone[] memory) {
        return milestones;
    }

    function remainingBalance() external view returns (uint256) {
        return address(this).balance;
    }
}
