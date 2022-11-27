// import
// main
// calling of main function

const { deployments } = require("hardhat");
const { networks } = require("../hardhat.config");

// function deployFunc() {
//     console.log("Hi")
// }

// module.exports.default = deployFunc

// nameless function
// module.exports = async (hre) => {
//     const { getNameAccounts, deployments } = hre
//     // hre.getNameAccounts, hre.deployments
//     console.log(getNameAccounts)
// }


module.exports = async ({getNameAccounts, deployments}) = {
    const { deploy, log }  = deployments
    const {deployer} = await getNameAccounts()
    const chianId = network.config.chianId

}