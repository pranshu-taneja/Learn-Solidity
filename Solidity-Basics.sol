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


/* 
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
*/

/* 
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
 */

/* 
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
 */

/* 
contract data_types{
    bool public booltemp = true;           //boolean

    uint public temp = 243;             //uint is unsigned integer(+ve only's tbh) and has the range of (0 to 2^256 - 1)

    int public temp1 = -143;             // signed integer (-ve and +ve both) and has the range of ( -2^255 to 2^255 -1)

    address public addtemp = 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4;        // it is of size "20 bits" and and store data in hexadecimal form

    bytes32 public str;                 //used on the place of string due to some issue caused by string will take it later (gets default value)

    //Remember there is nothing like NULL in solidity so if you don't intialize the variable then they get default value ofc they are also using gas ("SO IT's far better if you use only those things that are actually going to be used and do not waste so that gas cost can be reduced as much as possible")
}
 */

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
 
/* 
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
 */


/* 
contract constant_and_constructer{
    // deploy hone ke baad contract ka sabse pehle constructor call hota hai automatically. That's why if if you have some kind of parameters for constructer then before deploying you have to pass them in with the deploy button so that they get passed into constructor
    uint public tomato = 12;
    constructor(uint value){                      //deploy hone se pehle ab ye ek mangega as input
        tomato = value;
    }

    // Constant takes less gas and store value permemnantly means immutable   
    uint public constant const_value = 34;          //takes less gas but immutable

}
 */

/* 
contract default_value{
    
    // default values of all printing------
    uint public val;                // 0 as there is no value
    address public ad;              // 20bit hexadecimal address as you know already        //0x0000000000000000000000000000000000000000
    uint[] public arr;           //transaction revert due to inputting obv the whole won't be returned but tha'ts another thing
    bytes public one;           // due to nothing with byte so (0x)
    bytes32 public two;         //32*2 = 64 hexadecimal values--- due to 1 byte = 2hexadecimal values
    string public shit;         //nothing
}
 */

/* 
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
 */
/* 
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
 */
/* 
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
 */

/* 
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
 */


//  -------------working on struct user defined varialbe------------------------
struct my_struct{                       //creating user defined data types i.e: structs
    //Many ways of defining struct obj or their values --down in the contract
    string name;
    uint roll_n;
}
//  -------------working on struct user defined varialbe------------------------

/* 
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
 */

/* 
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
*/

//  -------------working done on struct user defined varialbe------------------------

/* 
//-------------------Mapping in solidity------------------------
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
 */