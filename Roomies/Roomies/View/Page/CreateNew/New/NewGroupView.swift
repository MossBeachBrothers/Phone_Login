//
//  NewGroupView.swift
//  Roomies
//
//  Created by Akhi Nair on 12/4/23.
//

import SwiftUI

struct NewGroupView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    var body: some View {
      Button(action: {
          if let currentUser = authViewModel.currentUser {
              authViewModel.createGroup(adminID: currentUser.uid, memberIDs: [], groupName: "Test Group")
          }
      }, label: {
          Text("Create Group")
      })
    }
}

struct NewGroupView_Previews: PreviewProvider {
    static var previews: some View {
        NewGroupView()
    }
}
