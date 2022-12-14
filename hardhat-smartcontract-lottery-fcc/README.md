<!-- Improved compatibility of back to top link: See: https://github.com/othneildrew/Best-README-Template/pull/73 -->

<a name="readme-top"></a>

<!--
*** Thanks for checking out the Best-README-Template. If you have a suggestion
*** that would make this better, please fork the repo and create a pull request
*** or simply open an issue with the tag "enhancement".
*** Don't forget to give the project a star!
*** Thanks again! Now go create something AMAZING! :D
-->

<!-- PROJECT SHIELDS -->
<!--
*** I'm using markdown "reference style" links for readability.
*** Reference links are enclosed in brackets [ ] instead of parentheses ( ).
*** See the bottom of this document for the declaration of the reference variables
*** for contributors-url, forks-url, etc. This is an optional, concise syntax you may use.
*** https://www.markdownguide.org/basic-syntax/#reference-style-links
-->

<!-- [![Contributors][contributors-shield]][contributors-url]
[![Forks][forks-shield]][forks-url]
[![Stargazers][stars-shield]][stars-url]
[![Issues][issues-shield]][issues-url]
[![MIT License][license-shield]][license-url] -->

<!-- [![LinkedIn][linkedin-shield]][linkedin-url] -->

<!-- PROJECT LOGO -->
<br />
<div align="center">
  <a href="https://github.com/Gknan/fcc-web3-learning">
    <img src="images/logo.png" alt="Logo" width="80" height="80">
  </a>

  <h3 align="center">Web3-Fund-Me-Html</h3>

  <p align="center">
    An begginner Web3 front project!
    <br />
    <a href="https://github.com/Gknan/fcc-web3-learning"><strong>Explore the docs »</strong></a>
    <br />
    <br />
    <a href="https://github.com/Gknan/fcc-web3-learning">View Demo</a>
    ·
    <a href="https://github.com/Gknan/fcc-web3-learning/issues">Report Bug</a>
    ·
    <a href="https://github.com/Gknan/fcc-web3-learning/issues">Request Feature</a>
  </p>
</div>

<!-- TABLE OF CONTENTS -->
<details>
  <summary>Table of Contents</summary>
  <ol>
    <li>
      <a href="#about-the-project">About The Project</a>
      <ul>
        <li><a href="#built-with">Built With</a></li>
      </ul>
    </li>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#prerequisites">Prerequisites</a></li>
        <li><a href="#installation">Installation</a></li>
      </ul>
    </li>
    <li><a href="#usage">Usage</a></li>
    <!-- <li><a href="#roadmap">Roadmap</a></li> -->
    <li><a href="#contributing">Contributing</a></li>
    <li><a href="#license">License</a></li>
    <li><a href="#contact">Contact</a></li>
    <li><a href="#acknowledgments">Acknowledgments</a></li>
  </ol>
</details>

<!-- ABOUT THE PROJECT -->

## About The Project

![Product Name Screen Shot](./images/logo.png)

This is my first Web3 front project. You can learn more details from [Free Code Camp](https://www.youtube.com/watch?v=gyMwXuJrbJQ&t=45177s).

<p align="right">(<a href="#readme-top">back to top</a>)</p>

### Built With

This section should list any major frameworks/libraries used to bootstrap your project. Leave any add-ons/plugins for the acknowledgements section. Here are a few examples.

-   [![Javascript][javascript.js]][javascript-url]
-   [![Ethers][ethers.js]][ethers-url]
-   [![Prettier][prettier.js]][prettier-url]

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- GETTING STARTED -->

## Getting Started

<!-- This is an example of how you may give instructions on setting up your project locally.
To get a local copy up and running follow these simple example steps. -->

You can follow next rules to start!

### Prerequisites

This is an example of how to list things you need to use the software and how to install them.
Add hardhat to project

-   Add hardhat
    ```sh
    yarn add --dev hardhat
    ```
-   Init hardhat project
    ```sh
    yarn hardhat
    ```
    choose `Create en empty hardhat.config.js` selection
-   Add all dependencies

    ```sh
    yarn add --dev @nomiclabs/hardhat-ethers@npm:hardhat-deploy-ethers ethers @nomiclabs/hardhat-etherscan @nomiclabs/hardhat-waffle chai ethereum-waffle hardhat hardhat-contract-sizer hardhat-deploy hardhat-gas-reporter prettier prettier-plugin-solidity solhint solidity-coverage dotenv
    ```

-   Import dependencies to `hardhat.config.js`

    ```js
    require("@nomiclabs/hardhat-waffle")
    require("@nomiclabs/hardhat-etherscan")
    require("hardhat-deploy")
    require("solidity-coverage")
    require("hardhat-gas-reporter")
    require("hardhat-contract-sizer")
    require("dotenv").config()
    ```

-   Create `.prettierrc` file

    ```json
    {
        "tabWidth": 4,
        "useTabs": false,
        "semi": false,
        "singleQuote": false,
        "printWidth": 100
    }
    ```

### Installation

\_Below is an example of how you can build your lottery project.

1.  Create folder `contracts`
2.  Create a file named `Raffle.sol` under folder `contracts`

    ```solidity
    pragma solidity ^0.8.7;

    Raffle_NotEnouthETHEntered();

    contract Raffle {
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

    ```

3.  Interact with [ChainlinkVRP](https://docs.chain.link/docs/vrf/v2/subscription/examples/get-a-random-number/)

    ```javascript
    import "@chainlink/contracts/src/v0.8/VRFConsumerBaseV2.sol"

    function fulfillRandomWords(
        uint256 requestId,
        uint256[] memory randomWords
    ) internal override {}
    ```

    run `yarn add --dev @chainlink/contracts` on console

4.  `yarn hardhat compile` on console, check codes
5.  Add `hardhat-shorthand` plugin. `sudo npm install --global hardhat-shorthan`
6.  Raffle getRandomWords, pick winner

    ```js
        function requestRandomWinner() external {
        // Request the random number
        // requestId to slove multi requests to VRF for random https://docs.chain.link/docs/vrf/v2/security/#fulfillrandomwords-must-not-revert
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
        // send all the money to winner
        (bool success, ) = recentWinner.call{value: address(this).balance}(""); // send all money to winner
        // require(success)
        if (!success) {
            revert Raffle__TransferFailed();
        }
        emit WinnerPicked(recentWinner);
    }
    ```

7.  Interract with Chainlink VRF
    implements checkUpkeep, Chainlink node call this function to decide whether return a random varaible

    ```js
    import "@chainlink/contracts/src/v0.8/interfaces/AutomationCompatibleInterface.sol";
    contract Raffle is VRFConsumerBaseV2, AutomationCompatibleInterface {

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
          bytes calldata /*checkData */
      ) external override returns (bool upkeepNeeded, bytes memory /* performData */) {
          bool isOpen = (RaffleState.OPEN == s_raffleState);
          // block.timestamp - last block.timestamp > interval
          bool timePassed = ((block.timestamp - s_lastTimeStamp) > i_interval);
          bool hasPlayers = (s_players.length > 0);
          bool hasBalance = address(this).balance > 0;
          upkeepNeeded = (isOpen && timePassed && hasPlayers && hasBalance);
      }
    }
    ```

8.  Implement `performUpkeep` function. Actually, out `requestRandomWinner` is `performUpkeep` funciton. Change name. Make checkUpkeep to public, so we can call it in performUpkeep.

    ```js
    function checkUpkeep(
        bytes calldata /*checkData */
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
            revert Raffle_UpkeepNotNeeded(address(this).balance, s_players.length, uint256(s_raffleState));
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
    ```

9.  Add comments for your contracts, variables, functions, views, etc. Be professional.
10. Deploy Raffle.sol

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- USAGE EXAMPLES -->

## Usage

<!-- Use this space to show useful examples of how a project can be used. Additional screenshots, code examples and demos work well in this space. You may also link to more resources. -->

_For more examples, please refer to the [Documentation](https://github.com/Gknan/fcc-web3-learning)_

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- ROADMAP -->

<!-- ## Roadmap

-   [x] Add Changelog
-   [x] Add back to top links
-   [ ] Add Additional Templates w/ Examples
-   [ ] Add "components" document to easily copy & paste sections of the readme
-   [ ] Multi-language Support
    -   [ ] Chinese
    -   [ ] Spanish

See the [open issues](https://github.com/othneildrew/Best-README-Template/issues) for a full list of proposed features (and known issues).

<p align="right">(<a href="#readme-top">back to top</a>)</p> -->

<!-- CONTRIBUTING -->

## Contributing

Contributions are what make the open source community such an amazing place to learn, inspire, and create. Any contributions you make are **greatly appreciated**.

If you have a suggestion that would make this better, please fork the repo and create a pull request. You can also simply open an issue with the tag "enhancement".
Don't forget to give the project a star! Thanks again!

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- LICENSE -->

## License

Distributed under the MIT License. See `LICENSE.txt` for more information.

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- CONTACT -->

## Contact

Your Name - [@SheapWin](https://twitter.com/SheapWin) - shipengwang1201@gmail.com

Project Link: [https://github.com/Gknan/html-fund-me-fcc](https://github.com/Gknan/html-fund-me-fcc)

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- ACKNOWLEDGMENTS -->

## Acknowledgments

Use this space to list resources you find helpful and would like to give credit to. I've included a few of my favorites to kick things off!

-   [Choose an Open Source License](https://choosealicense.com)
<!-- -   [GitHub Emoji Cheat Sheet](https://www.webpagefx.com/tools/emoji-cheat-sheet)
-   [Malven's Flexbox Cheatsheet](https://flexbox.malven.co/)
-   [Malven's Grid Cheatsheet](https://grid.malven.co/) -->
-   [Img Shields](https://shields.io)
<!-- -   [GitHub Pages](https://pages.github.com)
-   [Font Awesome](https://fontawesome.com)
-   [React Icons](https://react-icons.github.io/react-icons/search) -->

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
<!-- [contributors-shield]: https://img.shields.io/github/contributors/othneildrew/Best-README-Template.svg?style=for-the-badge
[contributors-url]: https://github.com/othneildrew/Best-README-Template/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/othneildrew/Best-README-Template.svg?style=for-the-badge
[forks-url]: https://github.com/othneildrew/Best-README-Template/network/members
[stars-shield]: https://img.shields.io/github/stars/othneildrew/Best-README-Template.svg?style=for-the-badge
[stars-url]: https://github.com/othneildrew/Best-README-Template/stargazers
[issues-shield]: https://img.shields.io/github/issues/othneildrew/Best-README-Template.svg?style=for-the-badge
[issues-url]: https://github.com/othneildrew/Best-README-Template/issues
[license-shield]: https://img.shields.io/github/license/othneildrew/Best-README-Template.svg?style=for-the-badge
[license-url]: https://github.com/othneildrew/Best-README-Template/blob/master/LICENSE.txt
[linkedin-shield]: https://img.shields.io/badge/-LinkedIn-black.svg?style=for-the-badge&logo=linkedin&colorB=555
[linkedin-url]: https://linkedin.com/in/othneildrew -->

<!-- [product-screenshot]: images/screenshot.png -->
<!-- [next.js]: https://img.shields.io/badge/next.js-000000?style=for-the-badge&logo=nextdotjs&logoColor=white
[next-url]: https://nextjs.org/
[react.js]: https://img.shields.io/badge/React-20232A?style=for-the-badge&logo=react&logoColor=61DAFB
[react-url]: https://reactjs.org/
[vue.js]: https://img.shields.io/badge/Vue.js-35495E?style=for-the-badge&logo=vuedotjs&logoColor=4FC08D
[vue-url]: https://vuejs.org/
[angular.io]: https://img.shields.io/badge/Angular-DD0031?style=for-the-badge&logo=angular&logoColor=white
[angular-url]: https://angular.io/
[svelte.dev]: https://img.shields.io/badge/Svelte-4A4A55?style=for-the-badge&logo=svelte&logoColor=FF3E00
[svelte-url]: https://svelte.dev/
[laravel.com]: https://img.shields.io/badge/Laravel-FF2D20?style=for-the-badge&logo=laravel&logoColor=white
[laravel-url]: https://laravel.com
[bootstrap.com]: https://img.shields.io/badge/Bootstrap-563D7C?style=for-the-badge&logo=bootstrap&logoColor=white -->

[prettier-url]: https://prettier.io/
[javascript-url]: https://www.javascript.com
[ethers-url]: https://docs.ethers.io/v5/
