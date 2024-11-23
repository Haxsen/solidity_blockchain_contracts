import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";

const config: HardhatUserConfig = {
  solidity: "0.8.27",
  networks: {
      holesky: {
          url: "https://holesky.infura.io/v3/<project>",
          accounts: [`<walletaccprivkey>`]
      }
  },
};

export default config;
