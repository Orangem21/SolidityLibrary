pragma solidity ^0.4.18;


/**
 * @title Ownable
 * @dev The Ownable contract has an owner address, and provides basic authorization control
 * functions, this simplifies the implementation of "user permissions".
 */
contract Ownable {
    address public owner;


    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);


    /**
    * @dev The Ownable constructor sets the original `owner` of the contract to the sender
    * account.
    */
    function Ownable() public {
        owner = msg.sender;
    }

    /**
    * @dev Throws if called by any account other than the owner.
    */
    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }

    /**
    * @dev Allows the current owner to transfer control of the contract to a newOwner.
    * @param newOwner The address to transfer ownership to.
    */
    function transferOwnership(address newOwner) public onlyOwner {
        require(newOwner != address(0));
        OwnershipTransferred(owner, newOwner);
        owner = newOwner;
    }
}
contract Manageable is Ownable {
    event ProviderUpdated (uint8 name, address hash);

    // this is used to hold the addresses of the providers.
    mapping (uint8 => address) public subContracts;

    function setProvider(uint8 _name, address _providerAddress) public onlyOwner returns (bool success) {
        require(_providerAddress != address(0));
        subContracts[_name] = _providerAddress;
        ProviderUpdated(_name, _providerAddress);

        return true;
    }
}
