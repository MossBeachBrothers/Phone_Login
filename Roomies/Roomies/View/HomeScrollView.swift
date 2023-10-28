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
    @State private var groups: [Group] = []

    var filteredGroups: [Group] {
        if searchText.isEmpty {
            return groups
        } else {
            return groups.filter { $0.groupName.localizedCaseInsensitiveContains(searchText) }
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
            }
            .padding()
        }
        .onAppear {
            // Fetch the user's groups and store them in the groups array
            fetchGroups()
        }
    }
  
  
      private func fetchGroups() {
//        Task {
//          do {
//            groups = try await authViewModel.fetchGroupsForCurrentUser()
//          } catch {
//            print("Error fetching groups: \(error.localizedDescription)")
//          }
//        }
      }
        

        
      }


struct Home1_Previews: PreviewProvider {
    static var previews: some View {
        
        Home()
        //ContentView()
            //.environmentObject(AuthViewModel()) // Inject an instance of AuthViewModel for preview
    }
}
