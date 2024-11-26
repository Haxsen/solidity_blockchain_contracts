// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract RestakeContract {
    
    // Define a struct called RestakeOperation to store information for each restake operation.
    // It holds the user ID, amount to be restaked, and whether the operation has been completed.
    struct RestakeOperation {
        uint256 userId;  // The ID of the user initiating the restake operation
        uint256 amount;  // The amount of tokens to restake
        bool completed;  // A flag indicating whether the operation has been completed
    }

    // Mapping that stores each restake operation by its unique operation ID.
    // The key is the operation ID (uint256) and the value is the RestakeOperation struct.
    mapping(uint256 => RestakeOperation) public restakeOperations;

    // A counter to track the next operation ID. This will increment with each new restake operation.
    uint256 public nextOperationId;

    // Event that is emitted when a restake operation is initiated. It provides the operation ID, user ID, and amount.
    event RestakeInitiated(uint256 operationId, uint256 userId, uint256 amount);

    // Event that is emitted when a restake operation is completed. It provides the operation ID.
    event RestakeCompleted(uint256 operationId);

    // Function to initiate a restake operation.
    // Takes in a userId and an amount, creates a new restake operation, and stores it in the restakeOperations mapping.
    // It also emits the RestakeInitiated event to notify external listeners.
    // Returns the unique operation ID for the initiated operation.
    function initiateRestake(uint256 userId, uint256 amount) public returns (uint256) {
        
        // Create a unique operation ID based on the current nextOperationId, then increment it.
        uint256 operationId = nextOperationId++;
        
        // Create a new RestakeOperation struct and store it in the mapping.
        restakeOperations[operationId] = RestakeOperation(userId, amount, false);

        // Emit the RestakeInitiated event to notify that a restake has been initiated.
        emit RestakeInitiated(operationId, userId, amount);

        // Return the unique operation ID for the initiated operation.
        return operationId;
    }

    // Function to complete a restake operation by marking it as "completed."
    // Takes the operationId of the operation to complete.
    // It checks that the operation has not been completed yet and then marks it as completed.
    // The RestakeCompleted event is emitted when the operation is successfully completed.
    function completeRestake(uint256 operationId) public {
        
        // Ensure that the operation has not already been completed.
        require(!restakeOperations[operationId].completed, "Operation already completed");
        
        // Mark the restake operation as completed by setting the "completed" flag to true.
        restakeOperations[operationId].completed = true;

        // Emit the RestakeCompleted event to notify that the restake operation is completed.
        emit RestakeCompleted(operationId);
    }

    // Function to retrieve the details of a specific restake operation by its operationId.
    // It returns the entire RestakeOperation struct for the given operationId.
    function getRestakeOperation(uint256 operationId) public view returns (RestakeOperation memory) {
        // Simply return the RestakeOperation struct from the mapping.
        return restakeOperations[operationId];
    }
}
