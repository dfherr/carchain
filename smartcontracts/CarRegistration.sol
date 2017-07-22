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
    string public licenseTag;
    string public brand;
    string public model;
    string public color;
    uint public yearBuilt;

    //information of registration
    uint public applicationTime;
    string public applicationDate;
    enum State {submitted, lacking, accepted, declined, canceled}
    State public state;

    function carRegistration(
        //information of car owner
        string _ownerName,
        string _ownerSurname,
        string _ownerAddress,
        string _ownerBirthday,
        //information of car
        string _licenseTag,
        string _brand,
        string _model,
        string _color,
        uint _yearBuilt
        ){
        //=> address public owner;
        ownerName = _ownerName;
        ownerSurname = _ownerSurname;
        ownerAddress = _ownerAddress;
        ownerBirthday = _ownerBirthday;

        //information of car
        licenseTag = _licenseTag;
        brand = _brand;
        model = _model;
        color =_color;
        yearBuilt = _yearBuilt;

        //information of registration
        //?? need function to get time
        //TODO implement time component
        //applicationTime = now;
        //applicationDate = today;
    }

    //Event not yet in action
    //event stateChange(address from, State state);

    //usecase bureau
    //checking/processing the registration application
    //submitted, lacking, accepted, declined, canceled
    //TODO: give event on change
    function setStateSubmitted(){
      state = State.submitted;
    }

    function setStateLacking(){
      state = State.lacking;
    }

    function setStateAccepted(){
      state = State.accepted;
    }

    function setStateDeclined(){
      state = State.declined;
    }

    function setStateCanceled(){
      state = State.canceled;
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

    //usecase insurance
    //insurance checks state of the application
    //?should insurance also check owner or car details?
    function getState() constant returns(State){
      return state;
    }
}
