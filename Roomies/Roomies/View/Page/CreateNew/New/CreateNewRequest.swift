//
//  CreateNewRequest.swift
//  Roomies
//
//  Created by Akhi Nair on 12/11/23.
//

import SwiftUI

struct CreateNewRequest: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @State private var group: RoomiesGroup?
    @State private var isInGroup = false
 
    private var groupMembers: [String] {
        guard let group = group,
              let currentUserUID = authViewModel.currentUser?.uid else {
              // ^ Safely unwrap currentUser and its uid
            return [] // Return an empty array if group or currentUserUID is nil
        }
        return group.members.keys.filter { $0 != currentUserUID } // Exclude current user's UID
    }
      // Custom initializer
    init(group: RoomiesGroup? = nil) {
        self._group = State(initialValue: group)
        self._isInGroup = State(initialValue: group != nil)
    }

    var body: some View {
      NavigationStack {
        NavigationLink(value: "Next"){
          Text("Next Page")
        }
        .navigationDestination(for: String.self){ string in
          FindFriendsView()
        }
      }
      
    }

}

struct CreateNewRequest_Previews: PreviewProvider {
    static var previews: some View {
        CreateNewRequest()
    }
}

