// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

// import the AggregatorV3Interface from the chainlink contracts
import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

uint256 constant MINIMUM_USD = 1;

contract FundMe {
    function fund() public payable {
        require(
            msg.value > 0.00001 ether,
            "You need to send at least 0.00001 ETH"
        );
    }

    function getPrice() public view returns (uint256) {
        AggregatorV3Interface dataFeed = AggregatorV3Interface(
            0x1b44F3514812d835EB1BDB0acB33d3fA3351Ee43
        );
        (, int256 answer, , , uint80 answeredInRound) = dataFeed
            .latestRoundData();
        return uint256(answeredInRound);
    }

    function getConversionRate(
        uint256 ethAmount
    ) public view returns (uint256) {}

    function withdraw() public {}
}
