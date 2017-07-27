pragma solidity ^0.4.13;

// Mapping contract for insurance search. Maps hash of the evb_number to RegisterCar contrac
contract InsuranceMapping{
  mapping(bytes32 => address) insuranceLookup;

  function lookupRegisterContract(bytes32 hashEvbNumber) returns (address){
    return insuranceLookup[hashEvbNumber];
  }

  function update(bytes32 hashEvbNumber, address registerContract){
    insuranceLookup[hashEvbNumber] = registerContract;
  }
}
