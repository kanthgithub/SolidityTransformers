# SolidityTransformers

- This repository is all about transformation of solidity datastructures, type conversions.

## String transformations:

## unit256 transformations:

- Example:

  - Given a byteArray , which contains 14 uint256 variables
  - Convert the data in to array of unit256 elements
  
  - input data:
  
     ```
    0x000000000000000000000000000000000000000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000020000000000000000000000000000000000000000000000000000000000000003000000000000000000000000000000000000000000000000000000000000000400000000000000000000000000000000000000000000000000000000000000050000000000000000000000000000000000000000000000000000000000000006000000000000000000000000000000000000000000000000000000000000000700000000000000000000000000000000000000000000000000000000000000080000000000000000000000000000000000000000000000000000000000000009000000000000000000000000000000000000000000000000000000000000000a000000000000000000000000000000000000000000000000000000000000000b000000000000000000000000000000000000000000000000000000000000000c000000000000000000000000000000000000000000000000000000000000000d000000000000000000000000000000000000000000000000000000000000000e
    ```

- Solution:

```js
function convertToArrayOfLength14(bytes memory data) public pure returns (uint256[] memory output)
{
    output = new uint256[](14);
    for (uint256 i=32; i<=output.length*32; i+=32)
    {
        assembly { mstore(add(output, i), mload(add(data, i))) }
    }
}
```

- Explanation:

   1. Prepare 14 slots to store output.
  
      - declare an Array of size 14 and element-type is unit256
   
   2. Iterate through the array in chunks of 32 (32 Bytes = 256 bits)
  
      - For-each chunk of output:
         - load the equivalent length of input (data chunk)
         - store the loaded value to output chunk
    
  - Repeat till end of output chunk length
  
 3. Now, we have transformed the data input to chunks of output (Array) 


## Struct to Bytes:

   - https://ethereum.stackexchange.com/questions/11246/convert-struct-to-bytes-in-solidity
   
## keccak-abi-encodepacked-with-javascript:

- With Javascript: https://blog.8bitzen.com/posts/18-03-2019-keccak-abi-encodepacked-with-javascript/

- With Python example: https://ethereum.stackexchange.com/questions/72199/testing-sha256abi-encodepacked-argument

- contract sample:
```sol
pragma solidity ^0.4.24;

contract Person {

    struct PersonDetails{
        string name;
        string surname;
        uint256 age;
        address someRandomAddress;
    }

    PersonDetails private john = PersonDetails({
        name: "John",
        surname: "Smith",
        age: 33,
        someRandomAddress: 0x06012c8cf97BEaD5deAe237070F9587f8E7A266d
    });

    function personHash() external view returns (bytes32) {
        return keccak256(
            abi.encodePacked(
                john.name,
                john.surname,
                john.age,
                john.someRandomAddress
            )
        );
    }
}
```

- Testing:
```
How do you generate a keccak like this in JavaScript/Web3?
```

```js
const Person = artifacts.require("Person");
const { soliditySha3 } = require("web3-utils");

contract("Person", ([admin]) => {
  let personContract;
  beforeEach(async () => {
    personContract = await Person.new();
  });

  describe("personHash", () => {
    it("should hash the inputs using keccack256", async () => {
      const personHash = await personContract.personHash.call();
      const soliditySha3Expected = soliditySha3(
        "John",
        "Smith",
        33,
        "0x06012c8cf97BEaD5deAe237070F9587f8E7A266d"
      );

      expect(personHash).to.equal(soliditySha3Expected);
    });
  });
});
```

```
If you run this test you will see that it passes without issue. Some things to note about the above setup:

web3-utils: you will need to npm install web3-utils --save to use this.

The documentation for what is in this and some examples can be found at https://web3js.readthedocs.io/en/1.0/web3-utils.html
The documentation specifically for using keccack256 can be found at https://web3js.readthedocs.io/en/1.0/web3-utils.html#soliditysha3

Ordering of Parameters: In a hashing function the order is very important and will result in a different hash if changed.

Random Address: I threw in the cryptokitties address just to illustrate how it works if you have that in your struct.
soliditySha3 parameter type inference: Based on the documentation you do not need to specify the types for the parameters you use - the util infers the types.

These rules are detailed here.
soliditySha3: as I mentioned in the beggining of this post sha3 is the same as keccak in the Ethereum world

The JavaScript util for this also seems abi.encodePacked for you on the JavaScript side.
```



