pragma solidity ^0.4.13;

contract AbstractMapping {
  function update(bytes32 hash, address registerContract);
}

contract RegisterCar{

    // information of car owner
    string public ownerFirstname;
    string public ownerLastname;
    string public ownerBirthdate;
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
    address public policeLookup;
    //information of
    uint public submitTime;
    uint public updateTime;

    enum State { submitted, incomplete, accepted, declined, canceled }
    State public state;

    // initialize contract with all required information
    function RegisterCar(
      // information of car owner
      string _ownerFirstname,
      string _ownerLastname,
      string _ownerBirthdate,
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
      ownerBirthdate = _ownerBirthdate;
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
      updateTime = now;
      state = State.submitted;
      insuranceLookup = _insuranceLookup;
      AbstractMapping(insuranceLookup).update(sha3(evbNumber), this);
    }

    function setOwnerFirstname(
        string _ownerFirstname){
        ownerFirstname = _ownerFirstname;
    }

    function setOwnerLastname(
        string _ownerLastname){
        ownerLastname = _ownerLastname;
    }

    function setOwnerBirthdate(
        string _ownerBirthdate){
        ownerBirthdate = _ownerBirthdate;
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

    function setEvbNumber(
        string _evbNumber){
        evbNumber = _evbNumber;
        AbstractMapping(insuranceLookup).update(sha3(evbNumber), this);
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

    function accept(
        string _licenseTag,
        address _policeLookup) {
      updateTime = now;
      licenseTag = _licenseTag;
      policeLookup = _policeLookup;
      state = State.accepted;
      AbstractMapping(policeLookup).update(sha3(licenseTag), this);
    }

    function incomplete() {
      updateTime = now;
      state = State.incomplete;
    }

    function decline() {
      updateTime = now;
      state = State.declined;
    }

    function cancel() {
      updateTime = now;
      state = State.canceled;
    }


}
