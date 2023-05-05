// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

contract PatentContract {

	enum PatentStatus {Pending,Approved,Rejected}

	// event MyStructUpdated(uint256 indexed timestamp, Patent myStruct);

  struct Patent {
    uint256 id;
		string description;
		address currentOwner;
		address newOwner;
		bool buyerSigned;
		bool sellerSigned;
		bool govermentSigned;
		PatentStatus status;
		string ipfsHash;
  }
	
	mapping(uint256 => Patent) public patents;
	mapping(uint256 => Patent[]) public patentVersions;
	uint256 public patentCount;

	function validatePatentData (string memory _description, address _currentOwner, string memory _ipfsHash) public {
		patentCount++;
		patents[patentCount] = Patent(patentCount, _description, _currentOwner, address(0), false, false, false, PatentStatus.Pending, _ipfsHash);	
		// emit MyStructUpdated(block.timestamp, patents[patentCount]);
		patentVersions[patentCount].push(patents[patentCount]);
	}

	function approvePatentData (uint256 _id) public {
		// check if ID does exist
		require(patents[_id].id != 0, "Data ID does not exist");
    //check if data is validated
		require(patents[_id].status == PatentStatus.Pending, "Patent data is already validated");
		// approve current patent 
		patents[_id].status = PatentStatus.Approved;
		// #TODO Add proper authorization for government roles:
		patents[_id].govermentSigned = true;

		patentVersions[_id].push(patents[_id]);
	}

	function rejectPatentData (uint256 _id) public {
		require(patents[_id].id != 0, "Data ID does not exist"); // check if ID does exist
		require(patents[_id].status == PatentStatus.Pending, "Patent data is already validated");  //check if data is validated
		patents[_id].status = PatentStatus.Rejected;  // approve current patent 
		patents[_id].govermentSigned = true; 		// #TODO Add proper authorization for government roles
		patentVersions[_id].push(patents[_id]);
	}

	// retrive all activities on a particular patent
	function getPatentActivities(uint256 id) public view returns (Patent[] memory) {
		return patentVersions[id];
	}

	// retrive all patents
 	function getAllPatents() public view returns (Patent[] memory) {
  	Patent[] memory result = new Patent[](patentCount);
        for (uint256 i = 1; i <= patentCount; i++) {
            result[i - 1] = patents[i];
        }
        return result;
    }
	
	// retrive all approved patents
	function getApprovedPatents() public view returns (Patent[] memory) {
        Patent[] memory result = new Patent[](patentCount);
        uint256 counter = 0;
        for (uint256 i = 1; i <= patentCount; i++) {
            if (patents[i].status == PatentStatus.Approved) {
                result[counter] = patents[i];
                counter++;
            }
        }
        //remove if there is any unused elements
        assembly {
            mstore(result, counter)
        }
        return result;
    } 

	// retrive all rejected patents
	function getRejectedPatents() public view returns (Patent[] memory) {
		Patent[] memory result = new Patent[](patentCount);
    	uint256 counter = 0;

      for (uint256 i = 1; i <= patentCount; i++) {
        if (patents[i].status == PatentStatus.Rejected) {
          result[counter] = patents[i];
            counter++;
          }
        }
        // remove if there is any unused elements
        assembly {
            mstore(result, counter)
        }
        return result;
    }

	// retrive patent of specific Id
	function getPatentById(uint256 _id) public view returns (Patent memory) {
    require(patents[_id].id != 0, "Data ID does not exist"); // check if id does exist
    return patents[_id];

	}

	// retrive patents of an specific user address
	function getPatentByAddress() public view returns (Patent[] memory) {
    Patent[] memory result = new Patent[](patentCount);
    uint256 counter = 0;

		for (uint256 i = 1; i <= patentCount; i++) {
        if (patents[i].currentOwner == msg.sender) {
          result[counter] = patents[i];
            counter++;
          }
        }
		// remove if there is any unused elements
    assembly {
    	mstore(result, counter)
    }
		return result;
	}

}