// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Ledger {
    struct Transaction {
        uint256 userId;
        uint256 receiverId;
        uint256 amount;
        string description;
        uint256 timestamp;
    }

    Transaction[] public transactions;
    
    event TransactionCreated(
        uint256 indexed userId,
        uint256 indexed receiverId,
        uint256 amount,
        string description,
        uint256 timestamp
    );

    function createTransaction(
        uint256 _userId,
        uint256 _receiverId,
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
        uint256 userId,
        uint256 receiverId,
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

    function getTransactionsByUser(uint256 _userId) public view returns (Transaction[] memory) {
        uint256 count = 0;
        
        for (uint256 i = 0; i < transactions.length; i++) {
            if (transactions[i].userId == _userId) {
                count++;
            }
        }
        
        Transaction[] memory userTransactions = new Transaction[](count);
        uint256 index = 0;
        
        for (uint256 i = 0; i < transactions.length; i++) {
            if (transactions[i].userId == _userId) {
                userTransactions[index] = transactions[i];
                index++;
            }
        }
        
        return userTransactions;
    }
}