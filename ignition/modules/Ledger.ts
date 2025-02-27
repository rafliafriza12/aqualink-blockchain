import { buildModule } from "@nomicfoundation/hardhat-ignition/modules";

const LedgerModule = buildModule("LedgerModule", (m) => {
        // Deploy the Ledger contract
        const ledger = m.contract("Ledger", []);

        return { ledger };
});

export default LedgerModule;
