//
//  DebtRequest.swift
//  Roomies
//
//  Created by Akhi Nair on 9/7/23.
//

import Foundation




struct DebtRequest: Identifiable, Codable, Hashable {
  
    var id: String? // Firebase-generated document ID
    var senderUserIDs: [String] // ID of the sender who made the request
    var groupID: String // ID of the group associated with the request
    var receiverUserIDs: [String] // User IDs of the receivers of the request
    var confirmationStatus: [String: Bool] // Stores whether each user has confirmed or not
    var allConfirmed: Bool // Tracks whether all users have confirmed the request
    var amount: Double // Amount of the request
    var amountPerReceiver: [String: Int] //Stores how much money each user owes in this transaction
    var amountPerSender: [String: Int] //Stores how much money ecah sender pays in the transaction (if only one sender this is euqal to amount
    var requestDescription: String // Description of the request
    var timestamp: String// Timestamp for when the request was created

    init?(dictionary: [String: Any], id: String) {
        guard let groupID = dictionary["groupID"] as? String,
              let senderUserIDs = dictionary["senderUserIDs"] as? [String],
              let receiverUserIDs = dictionary["receiverUserIDs"] as? [String],
              let amount = dictionary["amount"] as? Double,
              let requestDescription = dictionary["requestDescription"] as? String,
              let amountPerReceiver = dictionary["amountPerReceiver"] as? [String: Int],
              let amountPerSender = dictionary["amountPerSender"] as? [String: Int],
              let confirmationStatus = dictionary["confirmationStatus"] as? [String: Bool],
              let allConfirmed = dictionary["allConfirmed"] as? Bool,
              let timestamp = dictionary["timestamp"] as? String
        else {
            return nil
        }

        self.groupID = groupID
        self.senderUserIDs = senderUserIDs
        self.receiverUserIDs = receiverUserIDs
        self.amount = amount
        self.requestDescription = requestDescription
        self.amountPerReceiver = amountPerReceiver
        self.amountPerSender = amountPerSender
        self.confirmationStatus = confirmationStatus
        self.allConfirmed = allConfirmed
        self.timestamp = timestamp
    }

    init(
        senderUserIDs: [String],
        groupID: String,
        receiverUserIDs: [String],
        amount: Double,
        requestDescription: String,
        amountPerReceiver: [String: Int],
        amountPerSender: [String: Int],
        timestamp: String

    ) {
        self.senderUserIDs = senderUserIDs
        self.groupID = groupID
        self.receiverUserIDs = receiverUserIDs
        self.confirmationStatus = [:] // Initialize confirmation status
        self.allConfirmed = false // Initialize allConfirmed as false
        self.amount = amount
        self.amountPerReceiver = amountPerReceiver
        self.amountPerSender = amountPerSender
        self.requestDescription = requestDescription
        self.timestamp = timestamp // Set the current timestamp
    }

    // Convert DebtRequest to Firestore data (dictionary)
    func toFirestoreData() -> [String: Any] {
        var data: [String: Any] = [:]
        data["id"] = id // Include the id if it's not nil
        data["senderUserIDs"] = senderUserIDs
        data["groupID"] = groupID
        data["receiverUserIDs"] = receiverUserIDs
        data["confirmationStatus"] = confirmationStatus
        data["allConfirmed"] = allConfirmed
        data["amount"] = amount
        data["requestDescription"] = requestDescription
        data["timestamp"] = timestamp
        data["amountPerReceiver"] = amountPerReceiver
        data["amountPerSender"] = amountPerSender

        return data
    }
}
