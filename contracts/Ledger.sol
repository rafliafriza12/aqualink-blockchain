// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Ledger {
    struct Transaction {
        string userId;
        string receiverId;
        uint256 amount;
        string description;
        uint256 timestamp;
    }

    Transaction[] public transactions;
    
    event TransactionCreated(
        string indexed userId,
        string indexed receiverId,
        uint256 amount,
        string description,
        uint256 timestamp
    );

    function createTransaction(
        string memory _userId,
        string memory _receiverId,
        uint256 _amount,
        string memory _description
    ) public {
        Transaction memory newTransaction = Transaction({
            userId: _userId,
            receiverId: _receiverId,
            amount: _amount,
            description: _description,
            timestamp: block.timestamp
        });
        
        transactions.push(newTransaction);
        
        emit TransactionCreated(
            _userId,
            _receiverId,
            _amount,
            _description,
            block.timestamp
        );
    }

    function getTransaction(uint256 _index) public view returns (
        string memory userId,
        string memory receiverId,
        uint256 amount,
        string memory description,
        uint256 timestamp
    ) {
        require(_index < transactions.length, "Transaction does not exist");
        Transaction memory transaction = transactions[_index];
        
        return (
            transaction.userId,
            transaction.receiverId,
            transaction.amount,
            transaction.description,
            transaction.timestamp
        );
    }

    function getTransactionCount() public view returns (uint256) {
        return transactions.length;
    }

    function getTransactionsByUser(string memory _userId) public view returns (Transaction[] memory) {
        uint256 count = 0;
        
        for (uint256 i = 0; i < transactions.length; i++) {
            if (keccak256(abi.encodePacked(transactions[i].userId)) == keccak256(abi.encodePacked(_userId))) {
                count++;
            }
        }
        
        Transaction[] memory userTransactions = new Transaction[](count);
        uint256 index = 0;
        
        for (uint256 i = 0; i < transactions.length; i++) {
            if (keccak256(abi.encodePacked(transactions[i].userId)) == keccak256(abi.encodePacked(_userId))) {
                userTransactions[index] = transactions[i];
                index++;
            }
        }
        
        return userTransactions;
    }
}