const { ethers } = require("hardhat")

async function main() {
    const contractFactory= await ethers.getContractFactory("librery");
    const contract=await contractFactory.deploy();
    await contract.deployed();
    console.log("Contract Deployed in the address > ",contract.address);
}

main().then(() => process.exit(0)).catch((error) => {
    console.error("Error:", error);
    process.exit(1);
    });