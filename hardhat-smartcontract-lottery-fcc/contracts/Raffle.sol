// Raffle

// Enter the lottery (paying some amount)
// Pick a random winner (varifialbly random)
// Winner to be selected every X minutes -> completly automated

// Chainlink Oracle -> Randomness, Automated Execution(Chainlink Keeper)

// SPDX-Licence-Identifier: MIT

// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.7;

Raffle__NotEnouthETHEntered();

contract Raffle {
    /** state variables */
    uint256 private immutable i_entranceFee;
    address[] payable private s_players;

    /* Event */
    event RaffelEnter(address indexed player);

    constructor(uint256 entranceFee) {
        i_entranceFee = entranceFee;
    }

    function enterRaffle() public payable {
        // require msg.value > i_entranceFee, "Not enougth ETH!"
        if (msg.value < i_entranceFee) {
            revert Raffle__NotEnouthETHEntered();
        }
        s_players.push(payable(msg.sender));
        // Emit an event when we update a dynamic array or mapping
        // Named event with the fnnction name reversed
        emit RaffelEnter(msg.sender);
    }

    function pickRandomWinner() {

    }

    function getEntranceFee() public view returns (uint256) {
        return i_entranceFee;
    }

    function getPlayer(unit256 index) public view returns(address) {
        return s_players[index];
    }
}
