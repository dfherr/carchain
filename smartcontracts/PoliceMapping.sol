pragma solidity ^0.4.13;

// Mapping contract for police search. Maps hash of the license_tag to RegisterCar contrac
contract PoliceMapping{
  mapping(bytes32 => address) policeLookup;

  function lookupRegisterContract(bytes32 hashLicenseTag) returns (address){
    return policeLookup[hashLicenseTag];
  }

  function update(bytes32 hashLicenseTag, address registerContract){
    policeLookup[hashLicenseTag] = registerContract;
  }
}
