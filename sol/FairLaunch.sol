// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./ERC20.sol";
import "./Ownable.sol";

contract FairLaunchERC20 is ERC20, Ownable {
    uint256 public totalSupplyCap;
    uint256 public amountPerAddress;
    uint256 public remainingAddresses;
    uint256 public totalPer;
    uint256 public creationBlock;
    address public creator;

    constructor(
        string memory name,
        string memory symbol,
        uint256 _totalPer,
        uint256 _amountPerAddress
    ) ERC20(name, symbol) Ownable(msg.sender){
        require(_totalPer > 0, "Number of addresses must be positive");
        require(_amountPerAddress > 0, "Amount per address must be positive");
        totalPer=_totalPer;
        remainingAddresses = _totalPer;
        amountPerAddress = _amountPerAddress * (10 ** decimals());
        totalSupplyCap = _totalPer * amountPerAddress;
        creationBlock = block.number;
        creator = msg.sender;
    }

    function claimTokens() public {
        require(remainingAddresses > 0, "No more addresses can claim tokens.");
        require(totalSupply() + amountPerAddress <= totalSupplyCap, "Claim would exceed total supply cap.");
        remainingAddresses -= 1;
        _mint(msg.sender, amountPerAddress);

    }

    function getContractDetails() public view returns (
        string memory _name,
        string memory _symbol,
        uint256 _totalSupplyCap,
        uint256 _amountPerAddress,
        uint256 _remainingAddresses,
        uint256 _totalPer,
        uint256 _creationBlock,
        address _creator,
        address _owner
    ) {
        return (
        name(),
        symbol(),
        totalSupplyCap,
        amountPerAddress,
        remainingAddresses,
        totalPer,
        creationBlock,
        creator,
        owner()
        );
    }
}
