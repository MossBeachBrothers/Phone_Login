import SwiftUI

struct HomeScrollView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @Binding var searchText: String
    @State private var userGroupsMetaData: [RoomiesGroupMetaData] = []
    @State private var userGroups: [RoomiesGroup] = []
    @State private var selectedGroup: RoomiesGroup?
    @State private var isGroupSelected = false

    var filteredGroups: [RoomiesGroup] {
        if searchText.isEmpty {
            return userGroups
        } else {
            return userGroups.filter { $0.groupName.localizedCaseInsensitiveContains(searchText) }
        }
    }
  
  var filteredGroupBoxes: [RoomiesGroupMetaData] {
    if searchText.isEmpty {
      return userGroupsMetaData
    } else {
      return userGroupsMetaData.filter {
        $0.groupName.localizedCaseInsensitiveContains(searchText)
      }
    }
  }

  init(searchText: Binding<String>) {
        _searchText = searchText
    }

    var body: some View {
      ScrollView {
          LazyVStack {
//              ForEach(filteredGroups, id: \.self) { group in
//                NavigationLink(value: GroupLink.chatView(group)) {
//                        GroupBox(group: group)
//                    }
//              }
                
            ForEach(filteredGroupBoxes, id: \.self) { groupData in
              NavigationLink(value: GroupMetaDataLink.chatView(groupData)) {
                GroupBox(groupMetaData: groupData)
              }
              
            }
          }
          .padding()

      }
      .onAppear(perform: fetchGroups)
      .navigationDestination(for: GroupLink.self) { screen in
        switch screen {
          case .chatSettings(let group): GroupSettingsPage(group: group)
          case .createNewRequest(let group): CreateNewRequest(group: group)
          case .chatFeedView(let group): GroupFeedView(group: group)
          case .chatTotalsView(let group): GroupTotalsView(group: group)
        }
      }
      .navigationDestination(for: GroupMetaDataLink.self) {screen in
        switch screen {
          case .chatView(let groupData): GroupChatView(groupData: groupData)
        }
      }

    }

    private func fetchGroups() {
        guard let currentUser = authViewModel.currentUser else {
            print("No current user found.")
            return
        }

        authViewModel.getAllGroupsForUser(userID: currentUser.uid) { (groupSnapshots) in
            guard let groupSnapshots = groupSnapshots else {
                print("No groups found.")
                return
            }

            self.userGroups = groupSnapshots.compactMap { snapshot in
                guard let groupData = snapshot.data() else { return nil }
                return RoomiesGroup(dictionary: groupData, id: snapshot.documentID)
            }
        }
      
        authViewModel.getGroupMetadataForUser(userID: currentUser.uid) { result in
            switch result {
            case .success(let groups):
                for group in groups {
                  self.userGroupsMetaData.append(group)
                }
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
}


struct HomeScrollView_Previews: PreviewProvider {
    static var previews: some View {
      ContentView()
        .environmentObject(AuthViewModel())
        // Provide necessary environment objects or bindings for the preview
      
//      HomeScrollView(searchText: .constant(""))
//            .environmentObject(AuthViewModel())
    }
}

