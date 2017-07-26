pragma solidity ^0.4.13;

contract InsuranceMapping {
  function update(bytes32 hashOwnerData, address registerContract);
}

contract RegisterCar{

    // information of car owner
    string public ownerFirstname;
    string public ownerLastname;
    string public ownerBirthday;
    string public ownerStreet;
    string public ownerStreetNumber;
    string public ownerZipcode;
    string public ownerCity;

    //information of car
    string public licenseTag;               // Kennzeichen
    string public vehicleNumber;            // Fahrzeugnummer
    bytes32 public hashIdentidyCard;        // Personalausweis
    bytes32 public hashCoc;                 // EG-Uebereinstimmungsbescheinigung
    string public evbNumber;                 // elektronische Versicherungsbestaetigung
    bytes32 public hashCertRegistration;    // Fahrzeugschein/Zulassungsbescheinigung Teil 1
    bytes32 public hashCertTitle;           // Fahrzeugbrief/Zulassungsbescheinigung Teil 2
    bytes32 public hashHu;                  // Hu-Bericht

    address public insuranceLookup;
    //information of
    uint public submitTime;

    enum State { submitted, incomplete, accepted, declined, canceled }
    State public state;

    // initialize contract with all required information
    function RegisterCar(
      // information of car owner
      string _ownerFirstname,
      string _ownerLastname,
      string _ownerBirthday,
      string _ownerStreet,
      string _ownerStreetNumber,
      string _ownerZipcode,
      string _ownerCity,
      // information of car
      string _vehicleNumber,          // Fahrzeugnummer
      string _evbNumber,              // elektronische Versicherungsbestaetigung
      bytes32 _hashIdentidyCard,      // Personalausweis
      bytes32 _hashCoc,               // EG-UebereinstimmungsbescheinigungEg
      bytes32 _hashCertRegistration,  // Fahrzeugschein/Zulassungsbescheinigung Teil 1
      bytes32 _hashCertTitle,         // Fahrzeugbrief/Zulassungsbescheinigung Teil 2
      bytes32 _hashHu,
      address _insuranceLookup
      ){
      ownerFirstname = _ownerFirstname;
      ownerLastname = _ownerLastname;
      ownerBirthday = _ownerBirthday;
      ownerStreet = _ownerStreet;
      ownerStreetNumber = _ownerStreetNumber;
      ownerZipcode = _ownerZipcode;
      ownerCity = _ownerCity;

      // information of car
      vehicleNumber =_vehicleNumber;
      hashIdentidyCard = _hashIdentidyCard;
      hashCoc =_hashCoc;
      evbNumber = _evbNumber;
      hashCertRegistration = _hashCertRegistration;
      hashCertTitle = _hashCertTitle;
      hashHu = _hashHu;
      submitTime = now;
      state = State.submitted;
      // everything in one call as constructor does not allow me to declare a 16th variable "stack level too deep"
      // AbstractMapping(insuranceLookup).update(sha3(
      //   strConcat(
      //     strConcat(
      //       strConcat(
      //         strConcat(
      //           strConcat(
      //             strConcat(ownerFirstname,
      //               ownerLastname
      //             ),
      //             ownerBirthday
      //           ),
      //           ownerStreet
      //         ),
      //         ownerStreetNumber
      //       ),
      //       ownerZipcode
      //     ),
      //     ownerCity
      //   )
      // ), this);
      insuranceLookup = _insuranceLookup;
      InsuranceMapping(insuranceLookup).update(sha3(ownerFirstname), this);
    }

    // function stringToBytes32(string memory source) returns (bytes32 result) {
    //   assembly {
    //       result := mload(add(source, 32))
    //   }
    // }

    function setOwnerFirstname(
        string _ownerFirstname){
        ownerFirstname = _ownerFirstname;
    }

    function setOwnerLastname(
        string _ownerLastname){
        ownerLastname = _ownerLastname;
    }

    function setOwnerBirthday(
        string _ownerBirthday){
        ownerBirthday = _ownerBirthday;
    }

    function setOwnerStreet(
        string _ownerStreet){
        ownerStreet = _ownerStreet;
    }

    function setOwnerStreetNumber(
        string _ownerStreetNumber){
        ownerStreetNumber = _ownerStreetNumber;
    }

    function setOwnerZipcode(
        string _ownerZipcode){
        ownerZipcode = _ownerZipcode;
    }

    function setOwnerCity(
        string _ownerCity){
        ownerCity = _ownerCity;
    }

    function setLicenseTag(
        string _licenseTag){
        licenseTag = _licenseTag;
    }

    function setVehicleNumber(
        string _vehicleNumber){
        vehicleNumber = _vehicleNumber;
    }

    function setHashIdentidyCard(
        bytes32 _hashIdentidyCard){
        hashIdentidyCard = _hashIdentidyCard;
    }

    function setHashCoc(
        bytes32 _hashCoc){
        hashCoc = _hashCoc;
    }

    function setHashEvb(
        string _evbNumber){
        evbNumber = _evbNumber;
    }

    function setHashCertRegistration() returns(
        bytes32 _hashCertRegistration){
        hashCertRegistration = _hashCertRegistration;
    }

    function setHashCertTitle() returns(
        bytes32 _hashCertTitle){
        hashCertTitle = _hashCertTitle;
    }

    function setHashHu(
        bytes32 _hashHu){
        hashHu = _hashHu;
    }

    function setSubmitTime(
        uint _submitTime){
        submitTime = _submitTime;
    }

    function setSubmitted() {
      state = State.submitted;
    }

    function setIncomplete() {
      state = State.incomplete;
    }

    function setAccepted() {
      state = State.accepted;
    }

    function setDeclined() {
      state = State.declined;
    }

    function setCanceled() {
      state = State.canceled;
    }

    function accept(
        string _licenseTag) {
      licenseTag = _licenseTag;
      state = State.accepted;
    }

    // function strConcat(string _a, string _b) internal returns (string){
    //   bytes memory _ba = bytes(_a);
    //   bytes memory _bb = bytes(_b);
    //   string memory ab = new string(_ba.length + _bb.length);
    //   bytes memory bab = bytes(ab);
    //   uint k = 0;
    //   for (uint i = 0; i < _ba.length; i++) bab[k++] = _ba[i];
    //   for (i = 0; i < _bb.length; i++) bab[k++] = _bb[i];
    //   return string(bab);
    // }
}
