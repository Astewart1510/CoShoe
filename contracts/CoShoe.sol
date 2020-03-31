
pragma solidity >=0.5.0;
//assume I must import Ownable.sol to make it non-fungible?
import "./Ownable.sol";
//create contract with non-fungible tokens
contract CoShoe {

    address public owner;
    //create struct in contract
    struct Shoe {
        address owner;
        string name;
        string image;
        bool sold;
    }
    //Define a state variable called ​price​ and set it to 0.5 Ether, converted to Wei
    //??
    uint price = 0.5 ether ;

    //Define a state variable called ​shoesSold​ that
    //holds the number of shoes that have already been sold. Set it to 0.
    // ??
    uint shoeSold = 0;

    //Define a public array called ​shoes​ that holds instances of ​Shoe
    Shoe[] public shoes;

    //Implement a constructor that mints 100 ​CoShoe​ tokens. The ​owner​ of each
    //token is the address deploying the contract, ​name​ and ​image​
    //are empty strings (​“”​), and ​sold​ is equal to ​false​.
    //Add the instances of ​Shoe​ to the array shoes​.
    // not sure about this one?
    function mint(uint amount) public {
        require(msg.sender == owner, "Only Onwer can Mint");
        require(amount == 100, "Amount is not 100 tokens.");
        for (uint i = 0; i < amount; i++) {
            string memory name = string("");
            string memory image = string("");
            bool sold = false;
            shoes.push(Shoe(owner, name, image, sold));
        }

    }

    constructor () public payable {
        owner = msg.sender;
        mint(100);
    }

    function getshoecount() public view returns(uint) {
        return shoes.length;
    }

    //f. Implement a function called ​buyShoe​ that
        //i. Takes the input parameters ​name​, i​mage
        //ii. Checks that there is still a pair of shoes left that has not been sold yet, otherwise it throws an error
        //iii. Checks that the value that is attached to the function call equal the price​, otherwise it throws an error
        //iv. Transfers the ownership of a ​Shoe​ to the caller of the function by setting owner​ within the ​Shoe​ struct, setting ​name​ and ​image​ to the input variables, and changing ​sold​ to ​true
        //v. Don’t forget to update soldShoes

    function buyShoe(string memory name, string memory image) public payable returns(address, string memory, string memory, bool, uint ) {
        require(shoeSold < shoes.length, "No shoes left.");
        require(msg.value == price, "Not enough money");
        Shoe storage shoe = shoes[shoeSold];
        shoe.name = name;
        shoe.image = image;
        shoe.owner = msg.sender;
        shoe.sold = true;
        shoeSold++;
        return(shoe.owner, shoe.name, shoe.image, shoe.sold, shoeSold);
        }
    // Implement a function called that
        //i.returns an array of bools that are set to true if the
        //equivalent index in shoes​ belongs to caller of this function
        //ii.Remember to implement it in a gas saving manor
    // not sure about this one either

    function checkPurchases() public view returns(bool[] memory){
        bool[] memory soldshoes = new bool[](shoes.length);
        for (uint i=0; i < shoes.length; i++) {
            if (shoes[i].owner == msg.sender) {
            soldshoes[i] = true;
            }
            else {
                soldshoes[i] = false;
            }
        }
        return soldshoes;
    }

}