pragma solidity ^0.4.24;

contract DynamicArrayFromInteger {

	//return as an opcode and return as a Solidity statement are very different. 
	//The opcode causes the entire contract execution to return at that point, 
	//with the return value that you designate in memory.
	// The Solidity return just pops off the call frame and returns to the calling function

    function f(uint a, uint b) pure public returns (uint[] memory memOffset) {
        assembly {
             // Create an dynamic sized array manually.
             // Don't need to define the data type here as the EVM will prefix it
             memOffset := msize() // Get the highest available block of memory
             mstore(add(memOffset, 0x00), 2) // Set size to 2
             mstore(add(memOffset, 0x20), a) // array[0] = a
             mstore(add(memOffset, 0x40), b) // array[1] = b
             mstore(0x40, add(memOffset, 0x60)) // Update the msize offset to be our memory reference plus the amount of bytes we're using
        }
    }

    function get_f(uint a, uint b) public returns(uint){
        uint[] memory ret = f(a,b);
        return ret[0];
    }
}