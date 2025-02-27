import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";
import * as dotenv from "dotenv";

dotenv.config();

const config: HardhatUserConfig = {
        solidity: "0.8.28",
        defaultNetwork: "mainnet",
        networks: {
                mainnet: {
                        url: process.env.API,
                        accounts: process.env.PRIVATE_KEY ? [process.env.PRIVATE_KEY] : [],
                },
                localhost: {
                        url: "http://127.0.0.1:8545",
                },
                hardhat: {
                        chainId: 31337,
                },
        },
};

export default config;
