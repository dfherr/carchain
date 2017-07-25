pragma solidity ^0.4.2;

contract mortal {
    /* Define variable owner of the type address*/
    address owner;

    /* this function is executed at initialization and sets the owner of the contract */
    function mortal() { owner = msg.sender; }

    /* Function to recover the funds on the contract */
    function kill() { if (msg.sender == owner) selfdestruct(owner); }
}

contract greeter is mortal {
    /* define variable greeting of the type string */
    string greeting;

    enum Greetings { Hello, Bye }
    Greetings greetingType;

    /* this runs when the contract is executed */
    function greeter(string _greeting) public {
        greeting = _greeting;
        setGreetingBye();
    }

    function setGreetingHello() {
      greetingType = Greetings.Hello;
    }

    function setGreetingBye() {
      greetingType = Greetings.Bye;
    }

    function getGreetingType() returns (Greetings) {
       return greetingType;
   }

    /* main function */
    function greet() constant returns (string) {
        return greeting;
    }
}
