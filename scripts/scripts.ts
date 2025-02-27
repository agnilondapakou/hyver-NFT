import { ethers } from "hardhat";

async function main() {
  const [deployer] = await ethers.getSigners();

  console.log(`Deploying our NFT samrt contract: ${deployer.address}`);

  // Deploy Pakou NFT
  const Nft = await ethers.getContractFactory("MyNFT");
  const nft = await Nft.deploy(deployer.address);
  await nft.waitForDeployment();
  console.log(`Hyver NFT deployed at: ${await nft.getAddress()}`);
}

// Run the script
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});