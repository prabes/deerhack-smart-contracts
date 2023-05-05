/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: {
    version: "0.8.9",
    defaultNetwork: "Sepolia",
    networks: {
      hardhat: {},
      sepolia: {
        url: "https://eth-sepolia.g.alchemy.com/v2/o7P5GnPGynDJafBfv7VOVjij8O2FVhlY",
        accounts: [
          "697747e5b973889cdea4a10f146b28deee673cd6aca8e89c15f08d150cfa9079",
        ],
      },
    },
    settings: {
      optimizer: {
        enabled: true,
        runs: 200,
      },
    },
  },
};
