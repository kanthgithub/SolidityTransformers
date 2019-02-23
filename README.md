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


