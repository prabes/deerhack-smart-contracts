// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

contract PatentContract {
  struct Patent {
    uint256 id;
		string description;
		address currentOrder;
		address newOwner;
		bool buyerSigned;
		bool sellerSigned;
		bool govermentSigned;
		string ipfsHash;
  }
	
	mapping(uint256 => Patent) public patents;
	uint256 public patentCount;

	function createPatent(string memory _description, address _currentOwner, string memory _ipfsHash ) public {
		patentCount++;
		patents[patentCount] = Patent(patentCount, _description, _currentOwner, address(0), false, false, false, _ipfsHash);
	}


  function hello() public pure returns (uint256) {
    return 1;
  }
}