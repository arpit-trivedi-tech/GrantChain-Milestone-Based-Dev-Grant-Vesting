const hre = require("hardhat");

async function main() {
  const granteeAddress = "0xYourGranteeAddressHere"; // Replace with actual grantee address

  const GrantChain = await hre.ethers.getContractFactory("GrantChain");
  const grantChain = await GrantChain.deploy(granteeAddress, {
    value: hre.ethers.utils.parseEther("10"), // initial grant fund
  });

  await grantChain.deployed(); 
  console.log("GrantChain deployed to:", grantChain.address);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
}); 
