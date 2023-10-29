//
//  HomeScrollView.swift
//  Roomies
//
//  Created by Akhi Nair on 9/4/23.
//

import SwiftUI

struct HomeScrollView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @Binding var searchText: String
    @State private var userGroups: [Group] = []

    var filteredGroups: [Group] {
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
            VStack {
                ForEach(filteredGroups, id: \.self) { group in
                    GroupPreviewBox(group: group)
                }
              Button(action: {
                fetchGroups()
              }, label: {
                Text("Fetch Groups")
              })
            }
            .padding()
        }

    }
  
  
  private func fetchGroups() {
      if let currentUser = authViewModel.currentUser {
          authViewModel.getAllGroupsForUser(userID: currentUser.uid) { (groups) in
              if let groups = groups {
                
                if groups.isEmpty {
                  print("No Groups")
                }
                  for group in groups {
                      print("Group ID: \(group.documentID), Group Data: \(group.data() ?? [:])")
                    userGroups.append(group.data())
                  }
              }
          }
      } else {
          print("No current user found.")
      }
  }
        

        
      }


struct Home1_Previews: PreviewProvider {
    static var previews: some View {
        
        Home()
        //ContentView()
            //.environmentObject(AuthViewModel()) // Inject an instance of AuthViewModel for preview
    }
}
