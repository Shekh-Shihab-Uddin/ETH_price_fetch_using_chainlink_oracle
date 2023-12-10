// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";
//imported the interface of chainlink so that e can follow the oracle standard chailink has provided us
//chainlink will use many different smartcontracts and will give us different functions.
//By using the interface of chainlink we will get those functionality indirectly
//AggregatorV3Interface defines that all v3 Aggregators have the function latestRoundData

contract DataConsumerV3 {
    AggregatorV3Interface internal dataFeed;

    /**
     * Network: Sepolia
     * Aggregator: BTC/USD
     * Address: 0x694AA1769357215DE4FAC081bf1f309aDC325306
     */
    constructor() {
//dataFeed that uses AggregatorV3Interface and connects specifically to a proxy aggregator contract 
//that is already deployed at 0x1b44F3514812d835EB1BDB0acB33d3fA3351Ee43. 
//The interface allows your contract to run functions on that deployed aggregator contract
        dataFeed = AggregatorV3Interface(
            0x694AA1769357215DE4FAC081bf1f309aDC325306
        );
    }

//The getChainlinkDataFeedLatestAnswer() function calls your dataFeed object and runs the latestRoundData() function. 
//When you deploy the contract, it initializes the dataFeed object to point to the aggregator at 0x1b44F3514812d835EB1BDB0acB33d3fA3351Ee43, 
//which is the proxy address for the Sepolia ETH / USD data feed. 
//our contract connects to that address and executes the function.
//The aggregator connects with several oracle nodes and aggregates the pricing data from those nodes. 
//The response from the aggregator includes several variables, but getChainlinkDataFeedLatestAnswer() returns only the answer variable.
    function getChainlinkDataFeedLatestAnswer() public view returns (int) {
        (
            /* uint80 roundID */,
            int answer,
            /*uint startedAt*/,
            /*uint timeStamp*/,
            /*uint80 answeredInRound*/
        ) = dataFeed.latestRoundData();
        return answer;
    }
}