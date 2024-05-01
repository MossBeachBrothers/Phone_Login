//
//  Home.swift
//  Roomies
//
//  Created by Akhi Nair on 8/22/23.
//

import SwiftUI
import Firebase
import FirebaseCore
import FirebaseFirestore

struct Home: View {
@State private var searchText: String = ""
@State private var isSearching: Bool = false
@EnvironmentObject var authViewModel: AuthViewModel
  
  var body: some View{

    
      VStack{
        HStack {

            // Left side: "Edit" text as a button to perform an action
            Button(action: {
                // Your action here
              if let currentUser = authViewModel.currentUser {
                authViewModel.createGroup(adminID: currentUser.uid, memberIDs: ["Member 1", "Member 2"], groupName: "Test Group")
              }
            }) {
                Text("Edit")
                    .foregroundColor(.pink) // Color to indicate interactivity
            }
            .padding(.leading, 8) // Adjust padding as needed
            
            Spacer() // To push items to opposite sides
            
          //Navigation Link to Create New page
        NavigationLink(value: HomeLink.createNewPage){
          Image(systemName: Tab.plus.imageName)
            .resizable()
            .foregroundColor(RoomiesStyle().color)
            .frame(width: 45, height: 45)
        }

        }
        SearchBar(text: $searchText, isSearching: $isSearching, startingText: "Search Groups")
          .padding(.bottom, 25)
        Spacer()
        ShadowBox(content: HomeScrollView(searchText: $searchText),
                    width: 350,
                    height: 550)
        
       Spacer()

      }
      
      .navigationDestination(for: HomeLink.self){ screen in
        switch screen {
          case .createNewPage: CreateNewPage()
        }
      }
      .padding()

    }
    
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
    
        ContentView()
            .environmentObject(AuthViewModel()) // Inject an instance of AuthViewModel for preview
        
    }
}

