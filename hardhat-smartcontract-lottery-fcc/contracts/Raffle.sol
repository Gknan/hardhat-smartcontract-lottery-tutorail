// Raffle

// Enter the lottery (paying some amount)
// Pick a random winner (varifialbly random, VRP)
// Winner to be selected every X minutes -> completly automated(Chainlink keeper)

// Chainlink Oracle -> Randomness, Automated Execution(Chainlink Keeper)

// SPDX-Licence-Identifier: MIT

// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.7;

import "@chainlink/contracts/src/v0.8/VRFConsumerBaseV2.sol";
import "@chainlink/contracts/src/v0.8/interfaces/VRFCoordinatorV2Interface.sol";
import "@chainlink/contracts/src/v0.8/interfaces/AutomationCompatibleInterface.sol";

error Raffle__NotEnouthETHEntered();
error Raffle__TransferFailed();
error Raffle__NotOpen();
error Raffle_UpkeepNotNeeded(uint256 currentBalance, uint256 numPlayers, uint256 raffleState);

/**
 * @title A sample Raffle Contract
 * @author Simon Win
 * @notice This contract is for creating an unstamperable decentralized smart contract
 * @dev This implements VRFConsumerBaseV2, AutomationCompatibleInterface interfaces.
 */
contract Raffle is VRFConsumerBaseV2, AutomationCompatibleInterface {
    /* Type declarations */
    enum RaffleState {
        OPEN,
        CALCULATING
    } // unit256 0=OPEN, 1=CALCULATING

    /** state variables */
    uint256 private immutable i_entranceFee;
    address payable[] private s_players;
    VRFCoordinatorV2Interface private immutable i_vrfCoordinator;
    bytes32 private immutable i_gasLane;
    uint64 private immutable i_subscriptionId;
    uint32 private immutable i_callbackGasLimit;

    uint16 private constant REQUEST_CONFIRMATIONS = 2; // Confirmation time is how many blocks the VRF service waits before writing a fulfillment to the chain to make potential rewrite attacks unprofitable in the context of your application and its value-at-risk
    uint32 private constant NUM_WORDS = 2;

    // Lottery varaibles
    address private s_recentWinner;
    RaffleState private s_raffleState;
    uint256 private s_lastTimeStamp;
    uint256 private immutable i_interval;

    /* Event */
    event RaffleEnter(address indexed player);
    event RequestRaffleWinner(uint256 indexed requestId);
    event WinnerPicked(address indexed winner);

    constructor(
        address vrfCoordinatorV2,
        uint256 entranceFee,
        bytes32 gasLane,
        uint64 subscriptionId,
        uint32 callbackGasLimit,
        uint256 interval
    ) VRFConsumerBaseV2(vrfCoordinatorV2) {
        i_entranceFee = entranceFee;
        i_vrfCoordinator = VRFCoordinatorV2Interface(vrfCoordinatorV2);
        i_gasLane = gasLane;
        i_subscriptionId = subscriptionId;
        i_callbackGasLimit = callbackGasLimit;
        s_raffleState = RaffleState.OPEN;
        s_lastTimeStamp = block.timestamp;
        i_interval = interval;
    }

    /* Functions */
    function enterRaffle() public payable {
        // require msg.value > i_entranceFee, "Not enougth ETH!"
        if (msg.value < i_entranceFee) {
            revert Raffle__NotEnouthETHEntered();
        }
        if (s_raffleState != RaffleState.OPEN) {
            revert Raffle__NotOpen();
        }
        s_players.push(payable(msg.sender));
        // Emit an event when we update a dynamic array or mapping
        // Named event with the fnnction name reversed
        emit RaffleEnter(msg.sender);
    }

    /**
     * @dev This is the function that chianlink nodes call, they look for the `upkeepNeeded` to return
     * true. The following should be true in order to return true.
     * 1. Out time interval should have passed.
     * 2. The lottery should have at least one player, and have some ETH
     * 3. Our subscription is funded with LINK
     * 4. The lottery should be "open" state
     *
     */
    function checkUpkeep(
        bytes memory /*checkData */
    ) public override returns (bool upkeepNeeded, bytes memory /* performData */) {
        bool isOpen = (RaffleState.OPEN == s_raffleState);
        // block.timestamp - last block.timestamp > interval
        bool timePassed = ((block.timestamp - s_lastTimeStamp) > i_interval);
        bool hasPlayers = (s_players.length > 0);
        bool hasBalance = address(this).balance > 0;
        upkeepNeeded = (isOpen && timePassed && hasPlayers && hasBalance);
    }

    function performUpkeep(bytes calldata /* performData */) external override {
        // Request the random number
        // requestId to slove multi requests to VRF for random https://docs.chain.link/docs/vrf/v2/security/#fulfillrandomwords-must-not-revert
        (bool upkeepNeeded, ) = checkUpkeep("");
        if (!upkeepNeeded) {
            revert Raffle_UpkeepNotNeeded(
                address(this).balance,
                s_players.length,
                uint256(s_raffleState)
            );
        }
        s_raffleState = RaffleState.CALCULATING;
        uint256 requestId = i_vrfCoordinator.requestRandomWords(
            i_gasLane, // gas lane
            i_subscriptionId,
            REQUEST_CONFIRMATIONS,
            i_callbackGasLimit,
            NUM_WORDS
        );
        // once we get it, do something with it
        emit RequestRaffleWinner(requestId);
        //
    }

    function fulfillRandomWords(
        uint256 /*requestId*/,
        uint256[] memory randomWords
    ) internal override {
        // random words module operation
        // get winner index from randomWords
        uint256 indexOfWinner = randomWords[0] % s_players.length;
        // set recent winner address
        address payable recentWinner = s_players[indexOfWinner];
        s_recentWinner = recentWinner;
        // Update raffle state
        s_raffleState = RaffleState.OPEN;
        // reset player array
        s_players = new address payable[](0);
        // reset last time stamp
        s_lastTimeStamp = block.timestamp;
        // send all the money to winner
        (bool success, ) = recentWinner.call{value: address(this).balance}(""); // send all money to winner
        // require(success)
        if (!success) {
            revert Raffle__TransferFailed();
        }
        emit WinnerPicked(recentWinner);
    }

    /* View / Pure functions */
    function getEntranceFee() public view returns (uint256) {
        return i_entranceFee;
    }

    function getPlayer(uint256 index) public view returns (address) {
        return s_players[index];
    }

    function getRecentWinner() public view returns (address) {
        return s_recentWinner;
    }

    function getRaffleState() public view returns (RaffleState) {
        return s_raffleState;
    }

    function getNumWords() public pure returns (uint256) {
        return NUM_WORDS;
    }

    function getNumberOfPlalyers() public view returns (uint256) {
        return s_players.length;
    }

    function getLastTimeStamp() public view returns (uint256) {
        return s_lastTimeStamp;
    }

    function getRequestConfirmations() public pure returns (uint256) {
        return REQUEST_CONFIRMATIONS;
    }
}
