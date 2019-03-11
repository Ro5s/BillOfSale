pragma solidity >0.4.23 <0.6.0;

contract BillOfSaleGenerator {
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
        view
        returns(uint contractCount)
    {
        return contracts.length;
    }

    function newBillOfSale(string descr, uint price, address seller, address buyer)
        public
        returns(address newContract)
    {
        BillOfSale c = new BillOfSale(descr, price, seller, buyer);
        contracts.push(c);
        lastContractAddress = address(c);
        emit newBillOfSaleContract(c);
        return c;
    }

    function seeBillOfSale(uint pos)
        public
        view
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
	bool public confirmed;
    
	constructor(string memory _descr, uint _price,
    	address _seller, address _buyer) public {
    	descr = _descr;
    	price = _price;
    	seller = _seller;
    	buyer = _buyer;
	}
    
	function () external payable { }
    
	function confirmReceipt() public payable  {
    	require(msg.sender == buyer, "only buyer can confirm");
    	require(address(this).balance == price, "purchase price must be funded");
    	address(seller).transfer(address(this).balance);
    	confirmed = true;
	}
}
