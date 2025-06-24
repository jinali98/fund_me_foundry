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
        // this answer returns with 8 decimal places. then we multiply it by 1e10 to get 18 decimal places
        return uint256(answer * 1e10);
    }

    function getConversionRate(
        uint256 ethAmount
    ) public view returns (uint256) {
        // 1 ETH = 1000_000_000_000_000_000_000 USD
        uint256 ethPrice = getPrice();
        // eth price values has 18 decimal places and 1 eth in wei has 18 decimal places
        uint256 ethAmountInUsd = (ethPrice * ethAmount) / 1e18;
        return ethAmountInUsd;
    }

    function withdraw() public {}
}
