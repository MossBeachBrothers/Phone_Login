import SwiftUI

struct HomeScrollView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @Binding var searchText: String
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

  init(searchText: Binding<String>) {
        _searchText = searchText
    }

    var body: some View {
      ScrollView {
          LazyVStack {
              ForEach(filteredGroups, id: \.self) { group in
                NavigationLink(value: GroupLink.chatView(group)) {
                        GroupBox(group: group)
                    }
              }
          }
          .padding()

      }
      .onAppear(perform: fetchGroups)
      .navigationDestination(for: GroupLink.self) { screen in
        switch screen {
          case .chatView(let group): GroupChatView(group: group)
          case .chatSettings(let group): GroupSettingsPage(group: group)
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

