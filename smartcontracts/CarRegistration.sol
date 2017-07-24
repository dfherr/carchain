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
    string public licenseTag;           //Kennzeichen
    string public vehicleNumber;        //Fahrzeugnummer 
    bytes32 public hashCOC;                //EG-UebereinstimmungsbescheinigungE
    bytes32 public hashEVB;                //elektronische Versicherungsbestaetigung
    bytes32 public hashVehicleCertificate; //Fahrzeugschein/Zulassungsbescheinigung Teil 1
    bytes32 public hashVehicleTitle;       //Fahrzeugbrief/Zulassungsbescheinigung Teil 2
    bytes32 public hashHU;                 //HU-Bericht
    
    //information of registration
    string public timestamp;
    enum State {submitted, incomplete, accepted, declined, canceled}
    State public state;
    
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
        setStateSubmitted();

    }
    
    //Event not yet in action
    //event stateChange(address from, State state);

    //usecase bureau
    //checking/processing the registration application
    //submitted, lacking, accepted, declined, canceled
    //TODO: give event on change
    function setStateSubmitted() internal{
      state = State.submitted;
    }
    
    function setStateIncomplete() internal{
      state = State.incomplete;
    }
    
    function setStateAccepted() internal{
      state = State.accepted;
    }
    
    function setStateDeclined() internal{
      state = State.declined;
    }
    
    function setStateCanceled() internal{
      state = State.canceled;
    }

    //usecase insurance
    //insurance checks state of the application
    //?should insurance also check owner or car details?
    function getState() returns(State){
        return state;
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
}