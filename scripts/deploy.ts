import { ethers } from "hardhat";

async function main(): Promise<void> {
    // Get the deployer's account
    const [deployer] = await ethers.getSigners();
    console.log("Deploying contracts with the account:", deployer.address);

    // Log the balance of the deployer to ensure they have enough funds to deploy
    const balance = await deployer.provider.getBalance(deployer.address);
    
    console.log("Deployer balance:", ethers.formatEther(balance));

    // Get the contract factory for StakeContract
    const StakeContract = await ethers.getContractFactory("StakeContract");

    // Deploy the contract
    const contract = await StakeContract.deploy();
    
    console.log("Deployment transaction hash:", contract.deploymentTransaction()?.hash);

    // Wait for the deployment transaction to be mined (1 confirmation)
    await contract.deploymentTransaction().wait(1);  // Wait for 1 confirmation

    // Log the contract address after deployment is confirmed
    console.log("Contract deployed to:", contract.target);
}

// Run the main function, handle errors, and exit process accordingly
main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error("Error during deployment:", error);
        process.exit(1);
    });
