import { ethers } from "hardhat";

async function main() {
    const Ledger = await ethers.getContractFactory("Ledger");
    const ledger = await Ledger.deploy();
    await ledger.waitForDeployment();

    const address = await ledger.getAddress();
    console.log("Ledger deployed to:", address);
}

main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
});
