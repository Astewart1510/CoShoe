//import truffle assertions
const truffleAssert = require('truffle-assertions')

// import the contract artifact
const CoShoe = artifacts.require('CoShoe.sol')

contract('CoShoe', function (accounts) {
    // predefine the contract instance
    // 
    let CoShoeInstance
  
    // before each test, create a new contract instance
    beforeEach(async function () { //before every test is run it createes a new instance of the coin
      CoShoeInstance = await CoShoe.new()
    })
  
    // first test: define what it should do in the string
    it('test 100 tokens are minted on execution', async function () {
      let count =  await CoShoeInstance.getshoecount()
      assert.equal(count.toNumber(), 100, "Tokens count is not equal to 100")
  })

 it('buyShoe​ correctly transfers ownership, sets the name and the image, sets sold, and updates ​soldShoes​ count', async function () {
    // 0.5 ether
    let price = 500000000000000000
    let shoetransfer = await CoShoeInstance.buyShoe("defaultname", "image1",{ 'from': accounts[1], 'value': price})
    //                 ^await

    
    //0xf17f52151ebef6c7334fad080c5704d77216b732 - from 
    //0x9fbda871d559710256a2502a2517b794b482db40 - to
    // I tried to run tests and print out the array of buyShoe but couldnt get it to work..

    //console.log(ContractInstance.Array.call(j)); j++;var l = x.length}
    //contract.deployed().then(() => console.log('test'))
    //new Promise((CoShoeInstance) => console.log(shoetransfer)


    //console.log(CoShoeInstance.shoetransfer)

    assert.equal(shoetransfer[0], accounts[1] ,"address not equal?")
    // truffleAssert.revert doesnt let the function go through.
    //await truffleAssert.reverts(CoShoeInstance.mint("Execution1", { 'from': accounts[0] })) // this line should fail 
})

it('BuyShoe reverts if the price is not equal to 0.5 ether', async function () {
    
    let price = 600000000000000000
    await truffleAssert.reverts(CoShoeInstance.buyShoe("defaultname", "image1",{ 'from': accounts[1], 'value': price})) // this line should fail 
})

it('Checkpurchases returns the correct number of ​true​s', async function () {
    
    let price = 500000000000000000
    let buyshoe = await CoShoeInstance.buyShoe("defaultname", "image1",{ 'from': accounts[1], 'value': price})

    let soldShoes =  await CoShoeInstance.checkPurchases({ 'from': accounts[1]})
    let count = 0
    //iterate through solshoes to count only 1 true.
    for (i=0; i < soldShoes.length; i++) {
        if (soldShoes[i] == true) {
            count++
        }
    }

    assert.equal(count, 1, "not correct amount of trues")
    // truffleAssert.revert doesnt let the function go through
})

})
  
  