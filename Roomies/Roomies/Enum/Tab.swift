//
//  HomeNavigation.swift
//  Roomies
//
//  Created by Akhi Nair on 11/30/23.
//

import Foundation
import SwiftUI



enum Tab: String, CaseIterable {
  case message
  case plus
  case dollarsign
  case person
  case people
  case createGroup
  case groupFeed
  case groupTotals
  
  
  var title: String {
    switch self {
      case .message:
        return "Groups"
      case .plus:
        return "Request"
      case.person:
        return "Me"
      case .createGroup:
        return "Create Group"
      case .dollarsign:
        return "Get Money"
      case .people:
        return "Pending"
      case .groupFeed:
        return "Requests"
      case .groupTotals:
        return "Totals"
    }
  }
  
  var imageName: String {
    switch self {
      case .message:
        return "message"
      case .plus:
        return "plus.circle"
      case .person:
        return "person"
      case .dollarsign:
        return "dollarsign.square"
      case .createGroup:
        return "createGroup.image"
      case .people:
        return "person.2"
      case .groupTotals:
        return "person.line.dotted.person"
      case .groupFeed:
        return "plus.bubble"
    }
  }
  
}
