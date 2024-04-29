//
//  Link.swift
//  Roomies
//
//  Created by Akhi Nair on 12/11/23.
//

import Foundation

enum AuthLink: Hashable {
  case navigationView
  case signInView
  case signUpView
}

enum GroupLink : Hashable {
  case chatSettings(RoomiesGroup)
  case createNewRequest(RoomiesGroup)
  case chatFeedView(RoomiesGroup)
  case chatTotalsView(RoomiesGroup)
}

enum GroupMetaDataLink : Hashable {
  case chatView(RoomiesGroupMetaData)
}

enum HomeLink: Hashable {
  case createNewPage
}

enum CreateNewLink: Hashable {
  case createNewFriend
  case createNewGroup
  
  static func linkType(for option: String) -> CreateNewLink? {
      switch option {
      case "New Friend":
          return .createNewFriend
      case "New Group":
          return .createNewGroup
      // ... handle other cases
      default:
          return nil
      }
  }
}
