//
//  GroupFeedView.swift
//  Roomies
//
//  Created by Akhi Nair on 12/11/23.
//

import SwiftUI

struct GroupFeedView: View {
  @EnvironmentObject var authViewModel: AuthViewModel
  @State var currentGroup: RoomiesGroup
  @State var debtRequests: [DebtRequest] = []
  
  var body: some View {
    ScrollView {
      VStack {
        ForEach(self.debtRequests, id: \.self) { debtRequest in
          NavigationLink(value: debtRequest) {
            RequestBox(debtRequest: debtRequest)
          }
        }
      }
    }
    .onAppear(perform: fetchRequests)
  }
  
  
  
  //fetch group requests
  private func fetchRequests(){
    guard let currentUser = authViewModel.currentUser else {
      print("No current user found.")
      return
    }
    
    let current_id = currentGroup.groupID
    authViewModel.fetchRequestsForGroup(groupID: current_id) { (requestSnapshots) in
      guard let requestSnapshots = requestSnapshots else {
        print("No requests found for group \(current_id).")
        return
      }
      
      // Process requestSnapshots as needed
      self.debtRequests = requestSnapshots.compactMap { snapshot in
        //ensure the data is not null
        guard let requestData = snapshot.data() else {return nil}
        return DebtRequest(dictionary: requestData, id: snapshot.documentID)
      }
      
      
    }
  }
}
struct GroupFeedView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
