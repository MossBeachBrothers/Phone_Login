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
  case chatView(RoomiesGroup)
  case chatSettings(RoomiesGroup)
}

enum HomeLink: Hashable {
  case createNewPage
}

enum CreateNewLink: Hashable {
  case createNewFriend
  case createNewGroup
  case createNewRequest
  
  static func linkType(for option: String) -> CreateNewLink? {
      switch option {
      case "New Friend":
          return .createNewFriend
      case "New Group":
          return .createNewGroup
      // ... handle other cases
        case "New Request":
          return .createNewRequest
      default:
          return nil
      }
  }
}
