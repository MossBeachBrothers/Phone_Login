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

      HStack{
        
        LogoBox(subtitle: false)


          
        Spacer()
        
        NavigationLink(destination: CreateNewPage()){
          Button(action: {
            authViewModel.logOut()
          }) {
            Image(systemName: "line.horizontal.3")
            .imageScale(.large)
            .font(Font.system(size: 30).weight(.semibold))
            .foregroundColor(.pink)
          }
          .padding(.trailing, 20)
          
        }
        
        
      }

      SearchBar(text: $searchText, isSearching: $isSearching)

      Spacer()

      ShadowBox(content: HomeScrollView(searchText: $searchText),
                  width: 300,
                  height: 550)
      
      Button(action: {
//       Handle settings button tap
        if let user = authViewModel.currentUser {
          print(user.uid)
          authViewModel.createGroup(adminID: user.uid, memberIDs: [], groupName: "TestGroup")
        } else {
          print("Error in creating a group")
        }
        
      }) {
        Image(systemName: "plus.circle")
        .imageScale(.large)
        .font(Font.system(size: 30).weight(.semibold))
        .foregroundColor(.pink)
      }
      .padding(.trailing, 20)

    }
    .padding()

  }
}

/*
struct CreateNewPage: View {
    var body: some View {
        Text("Create New Page")
    }
}

struct SettingsView: View {
    var body: some View {
        Text("Settings Page")
    }
}
 */

struct Home_Previews: PreviewProvider {
    static var previews: some View {

        ContentView()
            .environmentObject(AuthViewModel()) // Inject an instance of AuthViewModel for preview
        
    }
}

