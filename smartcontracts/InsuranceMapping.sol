pragma solidity ^0.4.13;

contract InsuranceMapping{
  mapping(bytes32 => address) insuranceLookup;

  function lookupRegisterContract(bytes32 hashEvbNumber) returns (address){
    return insuranceLookup[hashEvbNumber];
  }

  function update(bytes32 hashEvbNumber, address registerContract){
    insuranceLookup[hashEvbNumber] = registerContract;
  }
}
