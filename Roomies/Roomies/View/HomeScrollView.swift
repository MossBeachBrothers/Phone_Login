import SwiftUI

struct HomeScrollView: View {
    @Binding var path: NavigationPath
    @EnvironmentObject var authViewModel: AuthViewModel
    @Binding var searchText: String
    @State private var userGroups: [Group] = []
    @State private var selectedGroup: Group?
    @State private var isGroupSelected = false

    var filteredGroups: [Group] {
        if searchText.isEmpty {
            return userGroups
        } else {
            return userGroups.filter { $0.groupName.localizedCaseInsensitiveContains(searchText) }
        }
    }

  init(searchText: Binding<String>, path: Binding<NavigationPath>) {
        _searchText = searchText
        _path = path
    }

    var body: some View {
      ScrollView {
          LazyVStack {
              Button(action: {
                  if let currentUser = authViewModel.currentUser {
                      authViewModel.createGroup(adminID: currentUser.uid, memberIDs: [], groupName: "Test Group")
                  }
              }, label: {
                  Text("Create Group")
              })

              ForEach(filteredGroups, id: \.self) { group in
                    NavigationLink(value: group) {
                        GroupBox(group: group)
                    }

              }
          }
          .padding()

      }
      .onAppear(perform: fetchGroups)
      .navigationDestination(for: Group.self) { group in
          GroupChatView(group: group, path: $path)
            .toolbar(.hidden, for: .tabBar)
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
                return Group(dictionary: groupData, id: snapshot.documentID)
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

