# On-Chain Referral & Affiliate Engine

A professional-grade marketing primitive for decentralized applications. This repository enables "Word-of-Mouth" growth by allowing users to generate unique referral links on-chain. When a referred user interacts with a target contract (e.g., mints an NFT or swaps tokens), a percentage of the fee is automatically routed to the referrer.

## Core Features
* **Multi-Tier Attribution:** Support for direct referrals and secondary "influencer" tiers.
* **Non-Custodial Rewards:** Commissions are calculated and distributed instantly during the transaction.
* **Sybil Resistance:** Optional checks to ensure referrers meet minimum holding requirements.
* **Flat Structure:** Single-directory layout for the tracking logic and reward vault.

## Logic Flow
1. **Register:** User A registers as a referrer.
2. **Refer:** User B joins using User A's address as a parameter.
3. **Action:** User B spends 1 ETH. The engine identifies User A as the referrer.
4. **Payout:** 0.05 ETH is sent to User A, and 0.95 ETH goes to the protocol.

## Setup
1. `npm install`
2. Deploy `ReferralEngine.sol`.
3. Integrate the `recordReferral` function into your primary dApp logic.
