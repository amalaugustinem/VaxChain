const Migrations = artifacts.require("Transit");
module.exports = function (deployer) {
    deployer.deploy(Migrations)
}