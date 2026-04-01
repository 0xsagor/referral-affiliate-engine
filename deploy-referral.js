const hre = require("hardhat");

async function main() {
  const ReferralEngine = await hre.ethers.getContractFactory("ReferralEngine");
  const engine = await ReferralEngine.deploy();

  await engine.waitForDeployment();
  console.log("Referral Engine deployed to:", await engine.getAddress());

  // Example: Registering an influencer
  await engine.registerAsReferrer();
  console.log("Deployer registered as a referrer.");
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
