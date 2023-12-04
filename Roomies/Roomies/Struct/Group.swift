//
//  Group.swift
//  Roomies
//
//  Created by Akhi Nair on 9/10/23.
//

import SwiftUI


struct Group: Hashable {
    
    var groupID: String
    var adminID: String
    var groupName: String
    var groupImg: Bool = false
    var groupTotalsUnconfirmed: [String: Int] // UserID : Int
    var groupTotalsConfirmed: [String: Int] // UserID : Int
    var members: [String : [String : String]] // UserID : [Role : String, Timstamp : String, Name : String]
    var timestamp: String // Time of group creation
    var debtRequests: [DebtRequest]
    
  init?(dictionary: [String: Any], id: String) {
        guard let groupID = id as? String,
              let adminID = dictionary["adminID"] as? String,
              let groupName = dictionary["groupName"] as? String,
              let groupImg = dictionary["groupImg"] as? Bool,
              let groupTotalsUnconfirmed = dictionary["groupTotalsUnconfirmed"] as? [String: Int],
              let groupTotalsConfirmed = dictionary["groupTotalsConfirmed"] as? [String: Int],
              let members = dictionary["members"] as? [String: [String: String]],
              let timestamp = dictionary["timestamp"] as? String
        else {
            return nil
        }
        
        self.groupID = groupID
        self.adminID = adminID
        self.groupName = groupName
        self.groupImg = groupImg
        self.groupTotalsUnconfirmed = groupTotalsUnconfirmed
        self.groupTotalsConfirmed = groupTotalsConfirmed
        self.members = members
        self.timestamp = timestamp
        self.debtRequests = []
  }
}
