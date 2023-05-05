// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

contract PatentContract {

	enum PatentStatus {Pending,Approved,Rejected}

  struct Patent {
    uint256 id;
		string description;
		address currentOrder;
		address newOwner;
		bool buyerSigned;
		bool sellerSigned;
		bool govermentSigned;
		PatentStatus status;
		string ipfsHash;
  }
	
	mapping(uint256 => Patent) public patents;
	uint256 public patentCount;

	function validatePatentData (string memory _description, address _currentOwner, string memory _ipfsHash) public {
		patentCount++;
		patents[patentCount] = Patent(patentCount, _description, _currentOwner, address(0), false, false, false, PatentStatus.Pending, _ipfsHash);	
	}

	function approvePatentData (uint256 _id) public {
		// check if ID does exist
		require(patents[_id].id != 0, "Data ID does not exist");
    //check if data is validated
		require(patents[_id].status == PatentStatus.Pending, "Patent data is already validated");
		// approve current patent 
		patents[_id].status = PatentStatus.Approved;
	}
}