//
//  DebtRequest.swift
//  Roomies
//
//  Created by Akhi Nair on 9/7/23.
//

import Foundation




struct DebtRequest: Identifiable, Codable, Hashable {
  
    var id: String? // Firebase-generated document ID
    var senderUserID: String // ID of the sender who made the request
    var groupID: String // ID of the group associated with the request
    var receiverUserIDs: [String] // User IDs of the receivers of the request
    var confirmationStatus: [String: Bool] // Stores whether each user has confirmed or not
    var allConfirmed: Bool // Tracks whether all users have confirmed the request
    var amount: Double // Amount of the request
    var requestDescription: String // Description of the request
    var timestamp: Date // Timestamp for when the request was created

    init(
        senderUserID: String,
        groupID: String,
        receiverUserIDs: [String],
        amount: Double,
        requestDescription: String
    ) {
        self.senderUserID = senderUserID
        self.groupID = groupID
        self.receiverUserIDs = receiverUserIDs
        self.confirmationStatus = [:] // Initialize confirmation status
        self.allConfirmed = false // Initialize allConfirmed as false
        self.amount = amount
        self.requestDescription = requestDescription
        self.timestamp = Date() // Set the current timestamp
    }

    // Convert DebtRequest to Firestore data (dictionary)
    func toFirestoreData() -> [String: Any] {
        var data: [String: Any] = [:]
        data["id"] = id // Include the id if it's not nil
        data["senderUserID"] = senderUserID
        data["groupID"] = groupID
        data["receiverUserIDs"] = receiverUserIDs
        data["confirmationStatus"] = confirmationStatus
        data["allConfirmed"] = allConfirmed
        data["amount"] = amount
        data["requestDescription"] = requestDescription
        data["timestamp"] = timestamp

        return data
    }
}
