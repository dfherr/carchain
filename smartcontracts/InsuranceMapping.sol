pragma solidity ^0.4.13;

contract InsuranceMapping{
  mapping(bytes32 => address) insuranceLookup;

  function lookupRegisterContract(bytes32 hashOwnerData) returns (address){
    return insuranceLookup[hashOwnerData];
  }

  function update(bytes32 hashOwnerData, address registerContract){
    insuranceLookup[hashOwnerData] = registerContract;
  }
}
