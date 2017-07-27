pragma solidity ^0.4.13;

contract PoliceMapping{
  mapping(bytes32 => address) policeLookup;

  function lookupRegisterContract(bytes32 hashLicenseTag) returns (address){
    return policeLookup[hashLicenseTag];
  }

  function update(bytes32 hashLicenseTag, address registerContract){
    policeLookup[hashLicenseTag] = registerContract;
  }
}
