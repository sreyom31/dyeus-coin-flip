# **Coin Flip Game**
## Harmony Testnet Contract Deployment Address
```0x2B671C45E34c390aa44739Eb6Abf0752b0ac97d3```

## Question Constraints
* Coin Flip Game is to be a smart contract using Harmony VRF function
* Allows a user to place a bet on a particular outcome of a coin flip using a function that accepts amount = integer and bet = 0 or 1 representing heads or tails
    * Store the user’s balance in a mapping. By default, each address gets 100 points free to start.
    * Store the user’s bet in the smart contract using mappings / arrays and structs as seems best 
        * Deduct their balance based on the bet amount
        * Do not allow a bet more than the balance they have
    * Allow multiple bets to be placed using the same function, i.e., different wallet can interact with the smart contract to place different bets
    * Don’t allow the same user to place multiple bets if they have an existing undecided bet
* Some time later, another function “rewardBets” is used to generate random num and conclude all bets with win/loss
    * Use VRF to generate a random number and decide heads or tails
    * Go through all bets
        * If win, double the user’s bet amount and add it to their balance (i.e. they got 2x on their money)
        * If loss, no balance to be transferred (as balance already deducted at time of making bet)
        * In either case, conclude the bet by setting a flag or moving the bet to a different mapping “completedBets” which is separate from “ongoingBets”
        * Emit an event containing gambler address and bet amount for every win

## Transaction Explanation
1. At First contract was deployed in harmony testnet.
1. I created two test accounts with ethers from harmony faucet.
1. From account 1 I called the addBet function with amount = 20 and val = 0
1. Again From account 2 I called the addBet function with amount = 20 and val = 1
1. Now I called rewardBets function to generate random number and conclude bets of msg.sender account 1.
1. Now I called rewardBets function to generate random number and conclude bets of msg.sender account 2.
1. And finally using the balances funtion I checked the balances of both accounts.
1. Also events are being successfully emitted with each transaction.

## Limitations
1. I was not able to implement reward bet function which would generate random number and conclude bets in one transaction only.
1. The reason being I wanted to have optimised code and that could only happen without using loops.
1. I was not able to find any other way to implement the same.
