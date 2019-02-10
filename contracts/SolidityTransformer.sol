pragma solidity ^0.5.0;

/**
 * @title SolidityTransformer
 * @dev The SolidityTransformer contract is the main interface for serializing data using the TypeToBytes, BytesToType
 */
 
import "./BytesToTypes.sol";
import "./TypesToBytes.sol";

contract SolidityTransformer is BytesToTypes, TypesToBytes {

    constructor() public {

    }
}