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
        
//        let group1 = Group(
//            groupID: "1",
//            adminID: "admin1",
//            groupName: "Group 1",
//            groupImg: false,
//            groupTotalsUnconfirmed: ["user1": 10, "user2": 5],
//            groupTotalsConfirmed: ["user1": 20, "user2": 10],
//            members: [
//                "user1": ["Role": "Admin", "Timestamp": "2023-10-11", "Name": "User 1"],
//                "user2": ["Role": "Member", "Timestamp": "2023-10-11", "Name": "User 2"]
//            ],
//            timestamp: "2023-10-11",
//            debtRequests: []
//        )
//
//        let group2 = Group(
//            groupID: "2",
//            adminID: "admin2",
//            groupName: "Group 2",
//            groupImg: true,
//            groupTotalsUnconfirmed: ["user2": 8, "user3": 15],
//            groupTotalsConfirmed: ["user2": 16, "user3": 25],
//            members: [
//                "user2": ["Role": "Admin", "Timestamp": "2023-10-11", "Name": "User 2"],
//                "user3": ["Role": "Member", "Timestamp": "2023-10-11", "Name": "User 3"]
//            ],
//            timestamp: "2023-10-11",
//            debtRequests: []
//        )
//
//        let group3 = Group(
//            groupID: "3",
//            adminID: "admin3",
//            groupName: "Group 3",
//            groupImg: true,
//            groupTotalsUnconfirmed: ["user1": 12, "user3": 6],
//            groupTotalsConfirmed: ["user1": 22, "user3": 12],
//            members: [
//                "user1": ["Role": "Admin", "Timestamp": "2023-10-11", "Name": "User 1"],
//                "user3": ["Role": "Member", "Timestamp": "2023-10-11", "Name": "User 3"]
//            ],
//            timestamp: "2023-10-11",
//            debtRequests: []
//        )
//
//        let group4 = Group(
//            groupID: "4",
//            adminID: "admin4",
//            groupName: "Group 4",
//            groupImg: false,
//            groupTotalsUnconfirmed: ["user4": 20],
//            groupTotalsConfirmed: ["user4": 30],
//            members: [
//                "user4": ["Role": "Admin", "Timestamp": "2023-10-11", "Name": "User 4"]
//            ],
//            timestamp: "2023-10-11",
//            debtRequests: []
//        )
//
//        groups = [group1, group2, group3, group4]
        
      }


struct Home1_Previews: PreviewProvider {
    static var previews: some View {
        
        Home()
        //ContentView()
            //.environmentObject(AuthViewModel()) // Inject an instance of AuthViewModel for preview
    }
}
