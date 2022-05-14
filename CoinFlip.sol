//SPDX-License-Identifier: Unlicense
pragma solidity 0.8.13;

 contract coinFlip{
     //event 
     event gambler(
         address gambler,
         uint amountwon
     );

    // state variables 
    mapping(address=>uint) public balances;
    
    // a struct to manage all bets
    struct Bets{
        uint amt;
        uint value;
        address player;
        bool ongoing;
        bool check;

    } 
    //struct mapped to address
    mapping(address=> Bets) public OnBets;

    //function to add bets
    function addbet(uint betamt, uint val) public {
       if(OnBets[msg.sender].check==false) {balances[msg.sender]=100; OnBets[msg.sender].check=true;}
        require(OnBets[msg.sender].ongoing==false, "Ongoing bet already present");
        OnBets[msg.sender].ongoing=true;
        require(balances[msg.sender]>=betamt, "Balance lesser than amt input");
        balances[msg.sender] -= betamt;
        OnBets[msg.sender].amt=betamt;
        OnBets[msg.sender].player=msg.sender;
        OnBets[msg.sender].value=val;
    }

    //vrf function of harmony that works in solidity
    function vrf() public view returns (uint result) {
        uint[1] memory bn;
        bn[0] = block.number;
        assembly {
         let memPtr := mload(0x40)
         if iszero(staticcall(not(0), 0xff, bn, 0x20, memPtr, 0x20)) {
           invalid()
      }
      result := mload(memPtr)
    }
  }
    //function to calculate if you won bet or not
    function rewardBets() public {
        OnBets[msg.sender].ongoing= false;
        uint toss = vrf();
        toss%=2;
        if (OnBets[msg.sender].value==toss) {
            balances[msg.sender] += OnBets[msg.sender].amt*2;
        }
       emit gambler(msg.sender, OnBets[msg.sender].amt*2);
    }
 }