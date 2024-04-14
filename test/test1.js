
const Transit = artifacts.require("Transit");

contract("Transit", (accounts) => {
    it("should create a transit"), async () => {
        const instance = await Transit.deployed();
        const createTranistReceipt = await instance.createTranist(1234, accounts[0], accounts[1]);
        const data = await instance.getTransitbyID(1234);
        assert.equal(data.status, '0', "transit wasn't created"); 
    }
});