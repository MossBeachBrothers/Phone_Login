//
//  HomeNavigation.swift
//  Roomies
//
//  Created by Akhi Nair on 11/30/23.
//

import Foundation
import SwiftUI


enum HomeNavigation: Hashable {
  case homeScrollView, groupChatView, createNewGroupView
}


enum Tab: String, CaseIterable {
      case message
      case plus
      case dollarsign
      case person
      case people
      case createGroup
      
  
      
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
    }
  }
  
  
  
//  @ViewBuilder
//  var associatedView: some View {
//      switch self {
//      case .message:
//          Home()
//      case .plus:
//          CreateNewPage()
//      case .person:
//          Settings()
//      case .dollarsign:
//          Settings()
//      case .createGroup:
//          CreateNewPage()
//      case .people:
//          PendingRequests()
//      }
//  }

}

class TabNavigationState: ObservableObject {
  @State var homeNavigationStack: [HomeNavigation] = []
}
