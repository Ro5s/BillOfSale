pragma solidity >0.4.23 <0.6.0;

// ------------------------------------------------------------------------
// deploy a BOS Generator Contract
// ------------------------------------------------------------------------

contract BOSGen {
    address[] public contracts;
    address public lastContractAddress;
    
    event newBillOfSaleContract (
       address contractAddress
    );

    constructor()
        public
    {

    }

    function getContractCount()
        public
        constant
        returns(uint contractCount)
    {
        return contracts.length;
    }

    // ------------------------------------------------------------------------
    // deploy a new BOS contract
    // ------------------------------------------------------------------------
    
    function newBillOfSale(string contractHash)
        public
        returns(address newContract)
    {
        BillOfSale c = (new BillOfSale)();
        contracts.push(c);
        lastContractAddress = address(c);
        emit newBillOfSaleContract(c);
        return c;
    }

    // ------------------------------------------------------------------------
    //tell me a position and I will tell you its address  
    // ------------------------------------------------------------------------
    
    function seeBillOfSale(uint pos)
        public
        constant
        returns(address contractAddress)
    {
        return address(contracts[pos]);
    }
}

contract BillOfSale {
	address public seller;
	address public buyer;
	string public descr;
	uint public price;
    
	function recordContract(string _descr, uint _price,
    	address _seller, address _buyer) public {
    	descr = _descr;
    	price = _price;
    	seller = _seller;
    	buyer = _buyer;
	}
    
	function confirmPurchase() public payable {
    	require(msg.sender == buyer, "only buyer can fund price");
    	require(price == msg.value);
	}
    
	function confirmReceipt() public {
    	require(msg.sender == buyer, "only buyer can confirm");
    	seller.transfer(address(this).balance);
	}
}
