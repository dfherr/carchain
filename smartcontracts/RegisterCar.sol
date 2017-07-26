pragma solidity ^0.4.13;

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

    //information of
    uint public timestamp;

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
        bytes32 _hashHu
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
        timestamp = now;
        state = State.submitted;
    }

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

    function setTimestamp(
        uint _timestamp){
        timestamp = _timestamp;
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
}
