//
//  RoomiesGroupMetaData.swift
//  Roomies
//
//  Created by Akhi Nair on 12/14/23.
//

import Foundation

struct RoomiesGroupMetaData : Hashable {
    var groupID: String
    var groupName: String
    var groupImg: Bool
    var members: [String: [String: String]] // Assuming members are stored as a dictionary
    var timestamp: Date
}
