pragma solidity ^0.4.13;

contract carRegistration{

//structs not yet supported to be passed to functions
//    struct date{
//        uint day;
//        uint month;
//        uint year;
//    }

//    struct postalCode{
//        bytes32 street;  // bytes32 identical to string param
//        bytes32 number;  //string: cases like street number 11a
//        bytes32 add;     //additional information
//    }

    //information of car owner
    //?should owner be a person with information inside the chain?
    //=> address public owner;
    string public ownerName;
    string public ownerSurname;
    string public ownerAddress;
    string public ownerBirthday;

    //information of car
    string public licenseTag;               //Kennzeichen
    string public vehicleNumber;            //Fahrzeugnummer
    bytes32 public hashCOC;                 //EG-UebereinstimmungsbescheinigungE
    bytes32 public hashEVB;                 //elektronische Versicherungsbestaetigung
    bytes32 public hashVehicleCertificate;  //Fahrzeugschein/Zulassungsbescheinigung Teil 1
    bytes32 public hashVehicleTitle;        //Fahrzeugbrief/Zulassungsbescheinigung Teil 2
    bytes32 public hashHU;                  //HU-Bericht

    //information of registration
    string public timestamp;
    string public state;                    //submitted, incomplete, accepted, declined, canceled

    function carRegistration(
        //information of car owner
        string _ownerName,
        string _ownerSurname,
        string _ownerAddress,
        string _ownerBirthday,
        //information of car
        string _licenseTag,             //Kennzeichen
        string _vehicleNumber,          //Fahrzeugnummer
        bytes32 _hashCOC,                  //EG-UebereinstimmungsbescheinigungEg
        bytes32 _hashEVB,                  //elektronische Versicherungsbestaetigung
        bytes32 _hashVehicleCertificate,   //Fahrzeugschein/Zulassungsbescheinigung Teil 1
        bytes32 _hashVehicleTitle,         //Fahrzeugbrief/Zulassungsbescheinigung Teil 2
        bytes32 _hashHU
        ){
        //=> address public owner;
        ownerName = _ownerName;
        ownerSurname = _ownerSurname;
        ownerAddress = _ownerAddress;
        ownerBirthday = _ownerBirthday;

        //information of car
        licenseTag = _licenseTag;
        vehicleNumber =_vehicleNumber;
        hashCOC =_hashCOC;
        hashEVB = _hashEVB;
        hashVehicleCertificate = _hashVehicleCertificate;
        hashVehicleTitle = _hashVehicleTitle;
        hashHU = _hashHU;
        state = "submitted";

    }


    //usecase police
    //checking for owner data
    //TODO: by spcific platenummer missing
    function getOwnerData() returns(
        string _ownerName,
        string _ownerSurname,
        string _ownerAddress,
        string _ownerBirthday){
        _ownerName = ownerName;
        _ownerSurname = ownerSurname;
        _ownerAddress = ownerAddress;
        _ownerBirthday = ownerBirthday;
    }

    function getOwnerName() returns(
        string _ownerName){
        _ownerName = ownerName;
    }

    function setOwnerName(
        string _ownerName){
        ownerName = _ownerName;
    }

    function getOwnerSurname() returns(
        string _ownerSurname){
        _ownerSurname = ownerSurname;
    }

    function setOwnerSurname(
        string _ownerSurname){
        ownerSurname = _ownerSurname;
    }

    function getOwnerAddress() returns(
        string _ownerAddress){
        _ownerAddress = ownerAddress;
    }

    function setOwnerAddress(
        string _ownerAddress){
        ownerAddress = _ownerAddress;
    }

    function getOwnerBirthday() returns(
        string _ownerBirthday){
        _ownerBirthday = ownerBirthday;
    }

    function setOwnerBirthday(
        string _ownerBirthday){
        ownerBirthday = _ownerBirthday;
    }

    function getLicenseTag() returns(
        string _licenseTag){
        _licenseTag = licenseTag;
    }

    function setLicenseTag(
        string _licenseTag){
        licenseTag = _licenseTag;
    }

    function getVehicleNumber() returns(
        string _vehicleNumber){
        _vehicleNumber = vehicleNumber;
    }

    function setVehicleNumber(
        string _vehicleNumber){
        vehicleNumber = _vehicleNumber;
    }

    function getHashCOC() returns(
        bytes32 _hashCOC){
        _hashCOC = hashCOC;
    }

    function setHashCOC(
        bytes32 _hashCOC){
        hashCOC = _hashCOC;
    }

    function getHashEVB() returns(
        bytes32 _hashEVB){
        _hashEVB = hashEVB;
    }

    function setHashEVB(
        bytes32 _hashEVB){
        hashEVB = _hashEVB;
    }

    function getHashVehicleCertificate() returns(
        bytes32 _hashVehicleCertificate){
        _hashVehicleCertificate = hashVehicleCertificate;
    }

    function setHashVehicleCertificate(
        bytes32 _hashVehicleCertificate){
        hashVehicleCertificate = _hashVehicleCertificate;
    }

    function getHashVehicleTitle() returns(
        bytes32 _hashVehicleTitle){
        _hashVehicleTitle = hashVehicleTitle;
    }

    function setHashVehicleTitle(
        bytes32 _hashVehicleTitle){
        hashVehicleTitle = _hashVehicleTitle;
    }

    function getHashHU() returns(
        bytes32 _hashHU){
        _hashHU = hashHU;
    }

    function setHashHU(
        bytes32 _hashHU){
        hashHU = _hashHU;
    }

    function getTimestamp() returns(
        string _timestamp){
        _timestamp = timestamp;
    }

    function setTimestamp(
        string _timestamp){
        timestamp = _timestamp;
        }

   function getState() returns(
        string _state){
        _state = state;
    }

    function setState(
        string _state){
        state = _state;
    }
}
