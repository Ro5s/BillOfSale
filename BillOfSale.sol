pragma solidity >0.4.23 <0.6.0;

contract BillOfSale {
	address public seller;
	address public buyer;
	string public descr;
	uint256 public price;
	
	event ReceiptConfirmed(address indexed this, address indexed seller);
    
	constructor(
	    string memory _descr, 
	    uint256 _price,
    	address _seller, 
    	address _buyer) 
    	    public {
    	            descr = _descr;
            	    price = _price;
            	    seller = _seller;
            	    buyer = _buyer;
	                 }
                     /**
                      * @dev Throws if called by any account other than the buer.
                      */
                        modifier onlyBuyer() {
                        require(msg.sender == buyer);
                         _;
                           }
	                        function confirmPurchase() public payable onlyBuyer {
    	                    require(price == msg.value);
	                        }
	                         function confirmReceipt() public onlyBuyer {
	                         seller.transfer(address(this).balance);
	                         emit ReceiptConfirmed(address(this), seller);
	                         }
}
