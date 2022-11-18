// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.6;                //pragma basically tells the compiler that what solidity version code is going to be executed


//-------------------https://docs.soliditylang.org/en/v0.8.17/solidity-by-example.html--------------- "PROJECTS EXAMPLES CODE"



// ----------------- Well Everything You will Ever need to know about solidity is neatly written Here SO REFER THIS ONLY-------------
//               ----------------------https://docs.soliditylang.org----------------------------




/* ----------------------------------- What is Byte COde and ABI ----------------------------------- */
// Well You will surely come across "ABI"(application binary interface) and "Byte code"(which produce opcode) so what are these
// ABI: - is basically a communicator between the account and contract && as well as a communicator between two contracts also (kinda like API)
// Byte code:-  is basically the object code which has all the instruction of the program and which then is converted into "opcode" which clearly shows the instruction like (push0 X 0) etc (don't need to understand btw)
/* ----------------------------------- What is Byte COde and ABI ----------------------------------- */



// Difference between "Memory"  and  "storage" types of memory in evm process.--> (Me TOO)  https://stackoverflow.com/a/33839164/13914357 
// --> ( READ ME) https://stackoverflow.com/a/71773121/13914357
// solidity is completely case sensitive So be carefull
// Ohh btw function can also me made outside like totally open and can be used in any smart contract below.... try it btw



contract basics{


    //--------Some basic concepts of memory type and fun() syntax etc----------

    //by default global/state "var" are private
    string public statevar; //get() is automatically created for public "var" (not set() btw)  
    // three ways of intializing statevar (public and global)
    // 1. by constructor
    // 2. by manual set function
    // 3. at the time of declaration


    // string public statevar = 8;         //---1st way---


    constructor(){                          //---2nd way---
        statevar = "wtf";
    }

    //---3rd way---
    // IMP :- Don't use "MEMORY" with "uint" anywhere "uint[]" is different 
    function setstatevar(string memory string_value) public returns(uint some_value){ //Here the uint in return argument is stored onto stack
        // you can use "pure" "view" "returns"
        // pure for not using (neither reading nor writing) any global shit inside function
        // view for only reading the gloabal or public shit
        // returns() for telling what will be the returned type 
        // "Memory" location can only be specified for array/uint[], struct or mapping types (not for a single uint)
        statevar = string_value;

        some_value = 8;
        return some_value;          //Use "return" in fun to let the returns() work
    }


    //------ARRAYS-------
    uint[] public static_arr = [1,2,3];     //get() is automatically created
    uint[] public dynamic_arr;              //get() is automatically created


    //---function to access static_arr values---
    function static_arrfun() public view returns(uint[] memory){   //Here uint[] is array so "memory"
        return static_arr;      //return fucking everything
    }

    //---function to create dynamic_arr values---
    function dynamic_arrfun() public returns(uint[] memory){
        for(uint i=0; i<10; i++){
            dynamic_arr.push(i*2);
        }
        return dynamic_arr;     //Not sure why its not showing the values for dynamic
    }

    //------Maps-------
    //btw returning "WHOLE" map and dynamic array isn't actually possible
    mapping(uint=>string) public my_map;

    function set_map(uint number, string memory word) public returns(string memory ans){
        
        my_map[number] = word;

        return(my_map[number]);
    }
}



contract variable_scopes_basics_1{
    
    // --- we have three scopes of variables of basically---  
    // State variable (That remains alive withing the contract also their values are stored permenantly inside that contract)
    // Global variable (global namespace basically defined by langugage itself to get info about contracts) 
    // Local variable (which is defined or used inside a function and ofc it remains alive withing the function only)
    

    uint tomato;
    constructor(){
        tomato = 4;
    }
    
    uint stvar  = 1;         //state variable

    uint public publicvar = 2;      //public state variable   (for public variables the get() is automatically created but not set() function is created btw!!

    address public another = 0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2;

    function getstvar() public view returns(uint){          //Here as the stvar isn't public so get function isn't created for it in this case you have to make it
        return stvar;                       //view shows that the function is read only and reduce the gas fees
    }

    function updating_state_var() public returns(uint){
        stvar = 22;                //Here it is changing the value of public statevar variable... But if you have declared it again like (uint stvar = 22) then it would work as local variable... also this term is shadowing and bad practice btw
        // uint r =4;                  this will create a local variable in function btw
        return stvar;
    }

}


contract Mmory_2{
    // uint public tomato = 30;        //stored in storage     //we can't write memory with uint on function arguments only array, struct, string(default storage) rem
    string public str = "FUCK";

    function storage_fun() view public {
        // uint tomato = 12 ;              //stored in MEMORY just telling  even if that was declared state above (but without uint that would have worked as storage tomato then)

        // callstorage_fun(str);            //after uncommenting the above line the gas level would jump very high for this due to storage memory usage
        memroy_call_fun(str);               // storage--> memory is possible
        // calldata_fun_dup(str);            // As storage--> calldata isn't possible so commented 
        
        // --storage -> storage isn't possible obv same variable going on 
        // --- storage -> calldata isn't possible
    }

    function  memory_fun() public pure{
        string memory tempo = "work";
        // callstorage_fun(tempo);                      // if youre trying storage there that obv that isn't possible for anyone                        
        memroy_call_fun(tempo);                     //memeory->memeory is possible
        // calldata_fun_dup(tempo);                // MEMORY -> CALLDATA isn't possible      
    }

    function calldata_fun(string calldata temp) public pure{
        // string calldata temp = "work";                  // ERROR:- IMplicity converting or assigning to calldata isn't possilbe so calldata won't work here
        
        // callstorage_fun(temp);                       //No usage 
        memroy_call_fun(temp);                          // so calldata-> Memory is totally Possible
        calldata_fun_dup(temp);                         // so calldata-> calldata is also totally Possible
    }

    // function callstorage_fun(string memory x ) public pure returns(string memory){               //the argument can't be in the storage so due to by default storage property of string we must need to use calldata or memory here (very IMportant)
    //     return x;                   // basically this function has no use it was just to tell you that you can't pass the argument by stating that it would be storage in arguments not possible must be memory/calladata
    // //  I mean why to pass either when you can just write teh varible name to access any storage variable here
    // }

    //Now cuz as we know that only memeory and calldata passing of arguments is possible so lets see both's unknown possiblity
    function memroy_call_fun(string memory x) public pure {

    }

    function calldata_fun_dup(string calldata x) public pure{           //we can accept the value as in calldata but can't create a calldata variable inside the function defination like above error 

    }


}


contract data_types{
    bool public booltemp = true;           //boolean

    uint public temp = 243;             //uint is unsigned integer(+ve only's tbh) and has the range of (0 to 2^256 - 1)

    int public temp1 = -143;             // signed integer (-ve and +ve both) and has the range of ( -2^255 to 2^255 -1)

    address public addtemp = 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4;        // it is of size "20 bits" and and store data in hexadecimal form

    bytes32 public str;                 //used on the place of string due to some issue caused by string will take it later (gets default value)

    //Remember there is nothing like NULL in solidity so if you don't intialize the variable then they get default value ofc they are also using gas ("SO IT's far better if you use only those things that are actually going to be used and do not waste so that gas cost can be reduced as much as possible")
}


//Multiline comment issue (bug ig)
contract global_var{
    function owner() public view returns(address){
        return msg.sender;              //global variable   which is alredy defined in solidity to use
    }

    //--------------GLobal variables with their working given below---------------
    /* 
    blockhash(uint blockNumber) returns (bytes32) : hash of the given block when biocknumber is one of the 256 most recent blocks; otherwise returns zero

    block.basefee ( uint ): current block’s base fee (EIP-3198 and EIP-1559)

    block.chainid ( uint ): current chain id

    block.coinbase ( address payable ): current block miner’s address

    block.difficulty ( uint ): current block difficulty

    block.gaslimit ( uint ): current block gaslimit

    block.number ( uint ): current block number

    block.timestamp ( uint ): current block timestamp as seconds since unix epoch

    gasleft() returns (uint256) : remaining gas

    msg.data ( bytes callcate ): complete calldata

    msg.sender_( addepss ): sender of the message (current call)

    msg.sig ( bytesé ): first four bytes of the calldata (i.e. function identifier)

    msg.value ( uint ): number of wei sent with the message

    tx.gasprice ( uint ): gas price of the transaction

    tx.origin (address ): sender of the transaction (full call chain) 
    */
} 
 

contract array_fixed_and_dynamic{
    //below i will tell you that doing any dynamic process in the function makes it unreturnable well that is truel but not just that is true... actually when you do both read and write operation in function then it becomes unreturnable and obv that would be unreturnable cuz you are writing storage array values... so its not restriced to dynamic process only its restricted to read and write operation understood.?!

    //Complicated and typical to understand be practice worker too
    
    // about dynamic array (rem when you explicitly give size uint[5] then its static but when you don't then its dynamic i.e push pop possible)

    // 1. its size not need to be defined like uint[]
    // 2. it has two functions -- push -- and -- pop--
    // 3. It can't be created into memory but can be created in storage only


    uint[5] fixedarr = [1,2,3,4,5];              //rem here needed square brackets to intialize []       //use public to create default getter
    uint[] public dynamic_arr = [1,2,3,4,5];        // dynamic array completely return isn't possible [very IMP]
    // Here in public too it accepts teh paramenter to return the exact index value not full array
    
    //dynamic has some specific functionalites to call ( update-->(assign), delete-->(delete arr[1]--> the value changed to default(0)), length, push, pop)
   
    function get_arr() public view returns(uint[5] memory, uint){             //well here you are just returning the array which actuallly is a bad practice cuz returning array cost high amount of gas so avoid it
    // One thing to notice that if you define the array as dynamic in returns(type) then it wont' work so you must have to define the exact size for fixed size array just the same returning tbh
        uint length = fixedarr.length;
        return (fixedarr,length);            //Here I am returning two variable just to show that multiple returns are possible (well dynamic arr and map can't be returned completely like fixed array)
    }

    function cant_get_dyn_arr() public view returns(uint,uint){           //keep in mind to use memory with uint[] array cuz its default is storage as its location
        // uint length = dynamic_arr.length;
        // dynamic_arr.push(6);                     //well one more thing is that doing anything dynamically in function makes it unreturnable like any dynamic process makes function unreturnalbe (the button would be yellow)
        // dynamic_arr.push(7);
        return (dynamic_arr.length,dynamic_arr[1]);             //try-- it won't return the whole array its just how it is you can't do this for dynamic array and map
        //dynamic arrays can't be created in memory they have to be declared at least in storage 
        //although fixed array can be created in memory 
    }
    // well the dynamic not returning thing is my upaj so be carefull cuz it might be a little wrong 

    //-----------Now this below function is very typical (most typical)---------
    function dynamic_create_() view public returns(uint[] memory){ //so imp to understand
        //above i told you that dynamic array isn't possible in memory but i rem that we can actually create a dynamic array in returns[uint[] memory] but ofc we can't return it though
        // so i got to a conclusion that you can actually create dynamic one in memory but the operations like push pop etc are just not availabe like below it can be made equal to storage array  
        uint[] memory arr ;             
        arr = dynamic_arr;          //well do you see that awesome!! // this is possible
        arr[0] = 3;
        // arr.push(1);               // THis isn't poosible
        return arr;                     // well here is a catch that you can do return dynamic array if they are intialized to some another array also if you remove the line of intializing it to fixedarr then it won't work and the ttransaction would be reverted  
    }

    function changing_fixed_for_loop(uint j) public{
        for(uint i=0; i<5; i++){                    //using for loop to change array values
            fixedarr[i] = i+j;
        }
    }
}




contract constant_and_constructer{
    // deploy hone ke baad contract ka sabse pehle constructor call hota hai automatically. That's why if if you have some kind of parameters for constructer then before deploying you have to pass them in with the deploy button so that they get passed into constructor
    uint public tomato = 12;
    constructor(uint value){                      //deploy hone se pehle ab ye ek mangega as input
        tomato = value;
    }

    // Constant takes less gas and store value permemnantly means immutable   
    uint public constant const_value = 34;          //takes less gas but immutable

}



contract default_value{
    
    // default values of all printing------
    uint public val;                // 0 as there is no value
    address public ad;              // 20bit hexadecimal address as you know already        //0x0000000000000000000000000000000000000000
    uint[] public arr;           //transaction revert due to inputting obv the whole won't be returned but tha'ts another thing
    bytes public one;           // due to nothing with byte so (0x)
    bytes32 public two;         //32*2 = 64 hexadecimal values--- due to 1 byte = 2hexadecimal values
    string public shit;         //nothing
}


 
contract strings_byte{
    
    // strings are the only data type which cause syntactical problem while using in function it doesn't work like another variable i.e: on writing (string val = "HELLO") won't store the value in memory and will give errror. THe only main reason is it by default store values in storage whatever happens. But to bypass that you have to use memory keyword. same happens in uint[]


    //     WHat are bytes datatype in solidity

    // Basically in bytes solidity datatype there is basically hexadecimal values are stored but how see here byte is real btw now 1byte = 8bit and 1byte = 2hexadecimal cuz 1hexadecimal = 4bit 
    // so 1 byte = 2hexadecimal

    // and making a byte array byte[5] means that you have 5 blocks where each block can have two decimal values right so its ascii value must be somewere around 10digits right.. just to let you know abt it
    // basically 1byte me ek dabbe me 2 hexadecimal digit hoti hai

    // and the default value will remain 0 on both places btw

    // well they have capacity of string type storing but they will be shown in ascii hexadecimal format while returning

    bytes5 val = "one";     //where byte5 shows the 5 times 2 i.e 10bits.. which eventually combine to form hexadecimal form and then to asci characters
    bytes7 val_1 = "two";           //where val_1 is of size 14bits     //0x multiple shows that its in hexa form

    function get_both() public view returns(bytes5, bytes7){
        return (val, val_1);
    }

    //why and when to use bytesX when you need a specific size string only and also you need it in memory rather than storage automatically

}


contract enums_{
    // ENUMS are basically datatype which can be used to multiple bool value like bool have two have but like what if you have more than two status like in shipping product (requested->out for delevry->shipped->local store->received->calcel) you get it right so that's why we use them
    // NOw it is also true that it is used to name integer constants so think aboout it the same way you are naming states for something for multiple possiblites

    enum status{               ///Now this is actually a datatype created so while returning in any function you will use its datatype for same type value
        Pending,
        Success,
        Unsuccess,
        Rejected, 
        Cancel
    }

    status obj;             // by default the status will be zero i mean obj will be zero. YOu can cahnge it by assigning it to "status.reject" etc

    function getstatus() public view returns(status){           // so basically we are just making a fun to return the value of obj of status type it might be (0,1,2,3,4) each one will show the status right.
        return obj;                 // so firstly its has stored default so 0 but after setstatus you define it to (success, pending or whatever) and then it will show the value of it (0,1,2,3)
    }

    function setstatus() public{
        obj = status.Cancel;                // You assigned it "cancel" means that the result would be 4 right?
    }

    function reset_obj() public{            // It resets it to the default value (0)
        delete obj;
    }

}


contract dynamic_byte{
    bytes public temp;              //not writing any size like (bytes5) with it will make it dynamic

    constructor(){
        temp = "12345blah";         //Here as you know its fixed right and normally in bytes you have bytes_X where you explicity gives sized by X
    }

    function dynamic_push() public{
        temp.push('c');         //to push dynamically
    }

    function dynamic_pop() public returns(uint){
        temp.pop();                 //to pop dynamically
        return temp.length;         //to get the length 
    }

    function get_element(uint i) view public returns(bytes1){       //bytes1 cuz we are returning only one bytes here
        return temp[i];
    }

}



contract location_types_or_memory_types{
    // TEMP -- So this is about memory storage types in  solidity when the process happens at evm (Etherum Virtual Machine). 
    // 1. Storage :- Where the contract is stored Permenantly (much like harddrive). Variable such as (statevariables) are stored into this location. And this is very expensive
    // ---------IMP POINT:- Just to give you a understanding try running the array with the same name of state array(storage array) and write "storage "rather than "Memory" keyword in the Function. You will see that the resulting var array will end up referencing that global or static array made above (EXAMPLE:- https://stackoverflow.com/a/71773121/13914357)
    // 2. Memory :- Now this is the memory where the temp values are stored and its basically is used to tell that YOu have to  store this in temp memory (which is cheaper and stays till the task/function). and is way more cheaper. Its not used for single "UNIT" But yes must used for array's inside function, struct variables etc
    // 3. Call Data:-  Calldata can be used to pass a variable as read-only stored in ram or evm stack btw. and by using calldata the same copy is used everytimes which means everytimes a new copy of variable is not created.
    // SO basically use calldata when you have to pass a const value and it is going to be used in another contracts also but it will be constant througout its lifespan

    // Why use memory with string inside function:- Some of the variable types are by default made to work in storage memory only for example : "STRING" and to make them work in our local memroy "MEMORY" we need to use "MEMORY" keyword with them. 

    // Memory -> Memory/calldata not possible why:- Also one more thing to know that (first contract)"MEMORY" to (second contract)"MEMORY "or (second contract)"CALLDATA" isn't actually possible the reason is that its actually gets destroyed after function dying.

    // storage -> anyone possible why:- BUT (first contract)"STORAGE" to (second contract)"MEMORY" or (second contract)"CALLDATA" is totally possible

    // calldata to anyone possible why:- also CALLDATA(first contract) to CALLDATA(second contract) or STORAGE(second contract) or MEMORY(second contract) is totally possible cuz calldata is also stored somewhere to reference for usage  anytime.

    // https://stackoverflow.com/a/71773121/13914357
}



//  -------------working on struct user defined varialbe------------------------
struct my_struct{                       //creating user defined data types i.e: structs
    //Many ways of defining struct obj or their values --down in the contract
    string name;
    uint roll_n;
}
//  -------------working on struct user defined varialbe------------------------


contract practice2{
    
    my_struct public s1;

    //1st way is by using contructor
    constructor(){
        s1.name = "Pranshu";
        s1.roll_n = 1914355;
    }

    //2nd way is by using function 
    function change(string memory name_, uint roll_n_) pure public returns(my_struct memory){
        my_struct memory object = my_struct({
            name: name_,
            roll_n: roll_n_
        });

        return object;
    }

    //3rd way is fuck it directly
    my_struct public object_11 = my_struct("Fuck it", 777); 


    //function to get the info about block
    function getter() public view returns(uint block_n, uint block_stamp, address add){
        // block.number for block number 
        // block.timestamp for when it was mined
        // msg.sender for the address of the block
        return(block.number, block.timestamp, msg.sender);
    }

}



contract practice3{
    my_struct[] public arr;         /// you just won't get whole array but you can get individual values

    function set_1() public{
        // three ways of creating variables or object of user defined data types using struct

        //1st way 
        my_struct memory obj1 = my_struct("Pranshu",21);                //you created one obj1 like one variable tbh

        //2nd way 
        my_struct memory obj2 = my_struct({name:"Tomato", roll_n:39});      //now you created second object like variable2

        //3rd way 
        my_struct memory obj3;                  // Here you have obj3 where i am explicity defining each property individually

        obj3.name = "Potato";
        obj3.roll_n = 94;

        //now adding these all to the array
        arr.push(obj1);
        arr.push(obj2);
        arr.push(obj3);

        //4th way
        arr.push(my_struct({name:"one", roll_n:387}));              //another object getting added 

        //another way of using user defined datatype
        my_struct memory obj_stor = obj1;
        delete obj_stor;
    }

} 


//  -------------working done on struct user defined varialbe------------------------


//-------------------Mapping in solidity------------------------
//keys can be of following types :- normal datatypes, enums and "contract" and addresss
struct donor_dts{           //created a struct variable type for ngo donation
    string name;
    uint age;
    string add;
    uint don;
}

contract advMapping{
    // SYntax and usage--
    mapping(address=>donor_dts) public acc_info;            //created a map to store values of "who" donated "how" much money

    function set(string memory _name, uint _age, string memory _add, uint _don) public {            //to set values     
        acc_info[msg.sender] = donor_dts(_name, _age, _add, acc_info[msg.sender].don+_don);             // I will actually be creating map values whenever a new address send some amount to ngo cuz new address will go in acc_info(parameter) and well that will create another hash value for it you get it right
    }

    function delete_info() public{                      //this will basically delete all the account details related also the account which donated anything 
        delete acc_info[msg.sender];                    //this will specifically delete stored accout address and their stored values too 
    }
}
//-------------------Mapping in solidity------------------------

/* 
contract visiblity{
    video - visibility		(know about public private and external internal keyword easy and important)

    1. Potential call
    --> mycontract:-  within the contract itself
    --> derived Contract:- from the derived contract 
    --> another cotnract:- from the not derived or another contract calling for accessing variable or function
    --> outside world-> like when we are calling them just like remix create button for them and we simply click them to call this is from outside world

    ---State variable can't be external

    2. visiblity 
    --> public				// ALL calling is possible		
    --> private			// only potential caller is "my contract"
    --> internal			// my contract and derived contract
    --> external			//  only another contract and outside world		(by creating object of contract)

    3. --State varialbe are by default INTERNAL
    ---function are by default PUBLIC (but after 8.0 version you have to explicity write them must with function)


    4. And to inherit a contract (inheriting A for B here )
    contract B is A{}

    5. just telling you can do something like "return fun();" which will return the fun() result

    6. Also gas used is decreased in the series given below so that you know what to do when for less gas usage as requirement filling

    Public		//maximum gas		//Security risk is more
    external
    Internal
    Private		// Minimum gas usage 	// security risk is less
} 
*/


// ------ -------------- INHERITANCE-------------- -------------------

// ------------inheritance  -------------	// Learn about inheritance and virtual and override keyword

// 1. You know aall about inheritance already
// -- Just write Contract B is A; 		//to inherit Contract A for B

// 2. Virtual :- It actually gives the permit to override or redefine it in another derived function only. By that it has its own copy but the derived contract has his own another working copy but with the sam name (function or variable you can say)

// 3. Override :- It basically redefine the pre permitted virtual keyword functions inside the another derived contract.


	
contract A{
    uint public x = 100;
    address public owner = msg.sender;

    function fun1() public pure returns(string memory){
        return "I am in contract A";
    }
    function fun2() public pure returns(string memory){
        return "I am in contract A";
    }
    function fun3() public pure virtual returns(string memory){             //Virtual keyword gives the function permit to get overrided in any derived contract  
        return "I am in contract A";
    }
    function fun4() public pure virtual returns(string memory){
        return "I am in contract A";
    }
}


contract B is A{
    function fun3() override public pure returns(string memory){            //overrided keyword override or can redefine for the the current derived contract
        return "I am in contract B";
    }
    function fun4() virtual override public pure returns(string memory){        //well you are going to both override for curretn contract and giving permission it to get overrided in another contract too using virtual
        return "I am in contract B";
    }
}

contract C is B{            // Here you might think what it will print for fu   n3 and fun4  and the simple answer is : It only looks for the functionalites of Its only Parent ONly THat means COntract B right? SO contract B has overrided and some inherited properites and C will get the same  
    function fun4() override public pure returns(string memory){        // Here we overrided something also so its value would be chagned for This contract
        return "I am in contract C";
    }
}

// ------ -------------- INHERITANCE-------------- -------------------

// EVENT -----INDEXING -------

// 1. USage of events:- 

// --> Jab hame kisi value of contract ko na to read karana ho or na hi write karana ho in future and we just want it to be stored on blochain that's the only thing we want then event do this thing at a very low gas cost. Btw all data stored on blockchian can be seen on transaction log

// --> Button click karne par dapp me kya show hoga is decided by event

// 2. while defining event do write the argument names (good practice)

// 3. when you are manipulating state variable or lets say blockchain materials then you don't have to use view or pure cuz you are writing things on blockchain OKAY!!
// Types of function PROCESSING :- VIEW 		PURE		SIMPLE  (simple don't return anything btw REM)

// 4. index is somethign that lets your process remind that how many times the communcation happended bw two of contracts to use this functionality you use indexed. (which can only be used at max with three arguments in event defining)

// SImple means we are going to access read and write operation both

contract event_{            //look at the logs for confirmation of uploaded data on blockchain
    event balance(address account, string message, uint value);     //creating event when there will be emit then this will be called

    function setdata(uint _val) public {
        emit balance(msg.sender, "I am setdata", _val);     // this will make the event store these value on blockchain (application of event tbh) in low gas price and as you can see we didn't want to write and not read too
    } 
}

contract chatapp{
    event chat(address indexed from, address to, string message);   //Now here listen if you want to get how many times you send msgs from one contract to another cuz there can be many contracts and you wanna know individual about two contract communication details (amount of msgs) then you use index for that
    //one more thing to understnad here is you can only use indexed for at max three arguments but not more than that


    function sendmsg(address sender) public{            
        emit chat(msg.sender, sender, "HELLO!");        //write event name with emit too btw
    }
}
// ----------------------EVENTS---------------------------


// ----------------------REQUIRE (error handling)---------------------------

// Require keyword (mostly used for error handling)

// 1. application
// --> Input validation	(input dali jo hai kya vo sahi hai using error handling)
// --> access control	(means that only owner can access it)

// 2. Advantage
// --> Gas refund (lets say you are doing error handling by using require keyword and lets suppose that the condition failed so from 1000 gas 800 will be reverted back cuz only 200 got used 
// --> state variables are reverted back on condtion false in require uk error handling catch kinda like


// ASSERT has same advantage btw


contract require__{
    address public owner = msg.sender;      //storing owner address (rem owner is the one who deploy the contract) the other working in the meantime later are calling not the owner they are the "another contract"

    uint public age = 25;       //storing age as 25 but remember the another contract can access it
    
    // also when the require fails or lets say error came then teh gas is not wasted and reverted back to you (expected 1000 - used till execution 200 = 800 reverted back to you) saved gas = 800 in error handling

    //remember in this function the anotehr function can also alter the variable values there isn't written here that onwer must call this function (down one is the fun youre looking for)
    function checkrequire(uint _x) public{      //if you pass _x as more than 2 then age will be changed but 
        age = age+5;                            //if you don't then even when it has been passed already even then it would show the reverted or intial i.e before callin this function value that was stored into it right that is it revert the value to its intial value.
        require(_x > 2, " value of x is less than 2");  // Now here is the error handling require working on
    }

    function onlyowner() public{        // HERe we have asked the caller of this function to be the owner only otherwise it won't work (owner :- who deployed the contract )
        require(owner == msg.sender, "Yes!! You are the owner!!");      // Now it will verify 
        age = age-2;
    }
}

// ----------------------REQUIRE (error handling)---------------------------



// ----------------------REVERT AND ASSERT (error handling)---------------------------
// revert and assert ---- used in error handling to revert back variable and save gas

// 1. revert is used for custom errors although it gives almost same functionaliy like require but you can pass custom error even multiple errors as acc to requirments

// revert throwerr_fun(string, address)		//can pass multiple argument for error

// 2. assert is used for security purpose verification

contract revert__{
    uint public age = 4;

    error throwerr(string, address);           //THROWERROR CAN BE USED FORM NOW       //Here you only write types  

    function fun(uint _x) public{
        age += 5;
        
        if(_x < 3){
            revert throwerr("Someone tried to make request to your account", 0x78731D3Ca6b7E34aC0F824c42a7cC18A495cabaB);          //can return multiple errors the most advantage when uk maybe you want to returns the address that is trying to process something related to your account
        }
    }

    function funny() view public{
        address owner = msg.sender;
        assert(owner == 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4);            //used to check at any time that eitehr this condition is working or not (like checking is the req coming from owner or not) not used too much btw

    }
}

// ----------------------REVERT AND ASSERT (error handling)---------------------------


// ----------------------MOdifier---------------------------
// Take a look at this again not sure about all this crap

contract MOdifier__{

    uint public _x = 5;

    modifier for_loop(){            //modifier without parameter
        for(uint i=0; i<10; i++){                   
            _x +=  i;
        }
        _;                          // wrting this will stop the focus here and after execution also comes here nothing much  
    }

    function two() public for_loop returns(uint){           // only found a way to make them reusable in function starting 
            return _x;
    }

    //Need to take a look at with variable modifier btw
}
// ----------------------MOdifier---------------------------



// ----------------------PAYABLE FOR addresses and functions---------------------------
// payable can be used for addresses and function..

// --> for payalbe address they can accept amounts

// --> for payble function their same cantract can accept payments

// ---> WHile writing payable be very careful that you write payable before public keyword and in function its ok to write after public 

// --> ALso as you know that modifier needs to be written before returns

// -->well when you make a function payable and at the end you receive some ether lets say then actually at that point your contract is actually storing those ethers... also later thet get added to your address as according to the contract functionalities

// --> YOu need to convert or typecast addresses to payable type... (for example if you are trying to make owner payable then you gotta do this typecast too{ add payable owner = payable(msg.sender) //did typecast here ---}

// --> red button shows the payable in remix
// --> orange shows that the function is of simple type actually both reading and writing functionality type
// ---> BLue button shows that either the variable is state or the function is either pure or view (read or write type)

// -->and btw 1 ether == 10^18 wei
// -> wei is the smallest unit of ether just a measument tool tbh

//--------------- DIff between owner and currently interacting address
        //  MSG.sender :- SO basically msg.sender is the owner of the contract (basically the one who actually deployed the contract)      (it will be same always after deploying)
        // Address(this): - Address(this) leaves teh one hwo is currently interacting with the contract it can be anyone in the world
//--------------- DIff between owner and currently interacting address


contract payable__{

    address payable public owner  = payable(msg.sender);        //can't write payable after public

    function geteth() public payable{           //can write payabe after public         

    }

    constructor() payable{              // YOu might come across "construct e r" and "contruct o r" may be --just saying-- the second one is real 
        // If you want the contract to be payalbe only intially and then never
    }

    function getadd() public view returns(address, address){
        return(msg.sender, address(this));                          // HERE its very imp to understand that what's msg.sender and whats address(this)
        // SO basically msg.sender is the owner of the contract (basically the one who actually deployed the contract)      (it will be same always after deploying)
        // Address(this) leaves teh one hwo is currently interacting with the contract it can be anyone in the world
    }


    function checkbal() public view returns(uint){
        return address(this).balance;
    }
}
// ----------------------PAYABLE FOR addresses and functions---------------------------


// ----------------------Fallback And Receive---------------------------
// #FALLBACK
// It is executed when a non existent function is called on the contract 
// It is required to be marked external
//  It has no arguments
//  It can not return any thing
//  It can be defined one per contract 
// If not marked payable, It will throw exception if contract receives ether.
//  It's main use is to directly send the ETH contract.

// #RECEIVE
// Its main purpose is to send ehter only.
// It can't send data but fallback can send data and ether both but recieve can only send ether only
// ------------------------------Some Notes to consider while reading-------------------

contract fallback_and_receive{

    // fallback() external payable{                             //MUst have to be external payable isn't important
    //         //The only diff between fallback and receive is that
    //         //fallback focus on both data receiving and ether receiving
    //         // You can get the low level form after deploying 
    // }

    // receive() external payable{             
    //     //Some important points to take care of
    //     // receive must be payable and external uk the reason behind it already
    //     // i.e it only receives ether so payable is must and it is called by someone outside so external neither from the contract too so external( read more about visiblity fro more)

    // }

    // Now here there might a doubt occur that what if there are both of them present who will recieive ether 
    //so the concept is if you have both and sending both data and ether then obv fallback will receive 
    // if you are inputting only ether then the ethers will be received by recevive that's it
    //Now if fallback is only present now it will simply accept both data and ether.

    function checkbaln() public view returns(uint){
        return (address(this).balance);
    }

}
// ----------------------Fallback And Receive---------------------------



// ----------------------SEND TRANSFER & CALL---------------------------
/* 
There are three mehtods to send ether using send methods (send, transfer, call)

-> ether can be send to contract or a address of account also

#SEND
-->send has some limit of 2300gas if gas cost goes high the transaction would fail

--> send function always returns a bool value which ofc is true on succedd and false on fail

--> required --> When using send must use require cuz 
1.) it doesn't revert back state variables on failing and 
2.) also the gas remained after failed gets also used which is a huge issue so better use require(error handling) with it

#TRANSFER
--> in transfer basically again 2300 gas limit
--> doesn't returns anything
--> it has inbuilt require functionality so it revert gas as well as state variables state also

# CALL 
--> It don't have gas limit
--> it returns bool value and some byte data
--> It doesn't have require functionlaity 
*/


// ----------------------SEND TRANSFER & CALL---------------------------




// ----------------------SEND TRANSFER & CALL PRACTICAL---------------------------
contract send_eth{              
    receive() payable external{

    }

    // constructor() payable{              //See it makes the whole deploying with ether payment starting 
        
    // } 

    // address payable getter = payable(0xdD870fA1b7C4700F2BD7f44238821C26f7392148);               //In this code we are telling you to send to a specific address but later we will tell you for anyone        //uncommenting it and removing parameter from function below will make it wokring
    
    function checkbal() public view returns(uint){
        return address(this).balance;
    }

    function usage_send(address payable getter) payable public {
        bool result = getter.send(1000000000000000000);                 //Here remember your contract is actullay sending these 1ether to someone you described in getter OKAY!! Just telling so don't have a misconception regarding that your contract cheanging might affect this /// it won't cuz you have added ether into contract from some account and now you are sending ether from this contract only
    
        require(result, "Transaction Just  Fucked by send");             //Only fail when gas limit goes higher than 2300        ///always use require with send functions
    } 

    function usage_transfer(address payable getter) payable public{
        getter.transfer(1000000000000000000);               //automatic error handling capability       //don't return anything for transfer
    }

    //Well its the typical one and the most used one due to customized usage of gas
    function usage_call(address payable getter) payable public{                    //You decide the gas amount //Here it is using the default set by remix btw     //well it does require you  input for sending to which address 
        
        (bool msg_,) = getter.call{value:1000000000000000000}("");              //just cramp this syntax cuz it call accepts two parameters (value, msg) which are basically bool and byte type             //take a look carefully at the (bool, msg__,) kinda very weird
        require(msg_, "transaction got failed for call");               //require cuz it might fail and in that case to revert state variable and saving gas is essential so here we go
    }
}

// ----------------------SEND TRANSFER & CALL PRACTICAL---------------------------


// ----------------------Well what if you directly want something that passes the ether from "account --> contract --> another" account in one go---------------------------
contract send_eth_extended{           
    //Just change the amount of ether you specified for sending to another address from 10^18 to (msg.value) It will automatically handle everything   
    //and change the fuction to payable cuz they are gonna do something bad shit this time by their own ok UK 
    //NOw you don't need to send to contract first and then ask contract to send it to anohter just tell the value you want to send from one account to another account and that specified value would be gone just by one clcick of fucntions given below 


    receive() payable external{                 //just to receive payment from low level transaction (i.e directly from calldata form transaction buttoon)

    }

    // constructor() payable{              //See it makes the whole deploying with ether payment starting 
        
    // } 

    // address payable getter = payable(0xdD870fA1b7C4700F2BD7f44238821C26f7392148);               //In this code we are telling you to send to a specific address but later we will tell you for anyone        //uncommenting it and removing parameter from function below will make it wokring
    
    event log(uint value);      //just to show you the working thats it             //look at the logs in terminal you will get to know about the msg.value functionality

    function checkbal() public view returns(uint){
        
        return address(this).balance;
    }
    
    function usage_send(address payable getter) payable public {
        emit log(msg.value);

        bool result = getter.send(msg.value);                 //Here remember your contract is actullay sending these 1ether to someone you described in getter OKAY!! Just telling so don't have a misconception regarding that your contract cheanging might affect this /// it won't cuz you have added ether into contract from some account and now you are sending ether from this contract only
    
        require(result, "Transaction Just  Fucked by send");             //Only fail when gas limit goes higher than 2300        ///always use require with send functions
    } 

    function usage_transfer(address payable getter) payable public{
        emit log(msg.value);

        getter.transfer(msg.value);               //automatic error handling capability       //don't return anything for transfer
    }

    //Well its the typical one and the most used one due to customized usage of gas
    function usage_call(address payable getter) payable public{                    //You decide the gas amount //Here it is using the default set by remix btw     //well it does require you  input for sending to which address 
        emit log(msg.value);
       
        (bool msg_,) = getter.call{value:msg.value}("");              //just cramp this syntax cuz it call accepts two parameters (value, msg) which are basically bool and byte type             //take a look carefully at the (bool, msg__,) kinda very weird
        require(msg_, "transaction got failed for call");               //require cuz it might fail and in that case to revert state variable and saving gas is essential so here we go
    }
}
// ----------------------Well what if you directly want something that passes the ether from "account --> contract --> another" account in one go---------------------------



// ----------------------How to receive ehter to another contract rather than a account address (here solution)---------------------------
contract get_ether{
    receive() external payable{}                //receive if you remeber is used for low level transaction that means it permits the cotnract to recieive payments from outside resources either from "(calldata form) or any other account or contract "also
    //recieve is mainly used to receive payment only not data btw uk
}
// ----------------------How to receive ehter to another contract rather than a account address (here solution)---------------------------