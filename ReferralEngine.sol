// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/access/Ownable.sol";

/**
 * @title ReferralEngine
 * @dev Manages affiliate relationships and commission distribution.
 */
contract ReferralEngine is Ownable {
    struct Referrer {
        bool isRegistered;
        uint256 totalEarned;
        uint256 referralCount;
    }

    mapping(address => Referrer) public referrers;
    mapping(address => address) public userToReferrer;
    
    uint256 public commissionBps = 500; // 5% default

    event ReferrerRegistered(address indexed referrer);
    event ReferralRecorded(address indexed user, address indexed referrer);
    event CommissionPaid(address indexed referrer, uint256 amount);

    constructor() Ownable(msg.sender) {}

    function registerAsReferrer() external {
        require(!referrers[msg.sender].isRegistered, "Already registered");
        referrers[msg.sender].isRegistered = true;
        emit ReferrerRegistered(msg.sender);
    }

    /**
     * @dev Records a referral. Should be called by the main dApp contract.
     */
    function recordReferral(address _user, address _referrer) external {
        require(referrers[_referrer].isRegistered, "Referrer not registered");
        require(userToReferrer[_user] == address(0), "Referral already set");
        require(_user != _referrer, "Cannot refer yourself");

        userToReferrer[_user] = _referrer;
        referrers[_referrer].referralCount++;
        
        emit ReferralRecorded(_user, _referrer);
    }

    function getCommission(uint256 _totalAmount) public view returns (uint256) {
        return (_totalAmount * commissionBps) / 10000;
    }

    function setCommission(uint256 _newBps) external onlyOwner {
        require(_newBps <= 2000, "Max 20%");
        commissionBps = _newBps;
    }
}
