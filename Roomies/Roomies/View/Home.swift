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

  var body: some View{

    VStack{

      HStack{

        LogoBox(subtitle: false)


          
        Spacer()
        

        Button(action: {
        // Handle settings button tap
        }) {
          Image(systemName: "line.horizontal.3")
          .imageScale(.large)
          .font(Font.system(size: 30).weight(.semibold))
          .foregroundColor(.pink)
        }
        .padding(.trailing, 20)
        
      }

      SearchBar(text: $searchText, isSearching: $isSearching)

      Spacer()

      ShadowBox(content: HomeScrollView(searchText: $searchText),
                  width: 300,
                  height: 550)
      
      Button(action: {
      // Handle settings button tap
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
/*
@EnvironmentObject var authViewModel: AuthViewModel
@State private var userData: RoomiesUser? // Store fetched user data
@State var user1_id: String = ""
@State var user2_id: String = ""
@State private var isCreateNewPageVisible = false // To toggle the CreateNewPage view

var body: some View {
NavigationView {
VStack(alignment: .center, spacing: 5) {
Text("Roomies")
.foregroundColor(.pink)
.font(.title)
.fontWeight(.semibold)

Text("Share Group Expenses")
.foregroundColor(.gray)
.font(.title)
.fontWeight(.semibold)

Spacer().frame(height: 10)

if let user = userData {
Text("Welcome, \(user.email)...")
  .font(GlobalFonts.titleFont) // Thematic font
  .foregroundColor(.pink) // Thematic color
Button("Add User", action: {
  authViewModel.addFriend(userID: user1_id)
})
  .buttonStyle(RoomiesButtonStyle(color: Color.pink))
CustomTextField(hint: "User 1", text: $user1_id)
CustomTextField(hint: "User 2", text: $user2_id)
NavigationLink(destination: CreateNewPage(), isActive: $isCreateNewPageVisible) {
  ZStack {
      Image(systemName: "plus.circle")
          .imageScale(.large)
          .font(Font.system(size: 30).weight(.semibold)) // Thematic font
          .foregroundColor(Color.pink) // Thematic color
  }
}
Button("Log Out", action: authViewModel.logOut)
  .buttonStyle(RoomiesButtonStyle(color: Color.pink))
} else {
Text("Loading user data...")
}
}
.navigationBarItems(trailing: NavigationLink(destination: SettingsView()) {
ZStack {
Image(systemName: "line.horizontal.3")
  .imageScale(.large)
  .font(Font.system(size: 30).weight(.semibold)) // Thematic font
  .foregroundColor(.pink) // Thematic color
}
})
}
.onAppear {
// Fetch user data when the view appears
if let uid = authViewModel.currentUser?.uid {
authViewModel.fetchUserData(for: uid) { result in
switch result {
case .success(let user):
  userData = user
case .failure(let error):
  print("Error fetching user data: \(error.localizedDescription)")
}
}
}
}
}
*/
}

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

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        
        Home()
        //ContentView()
            //.environmentObject(AuthViewModel()) // Inject an instance of AuthViewModel for preview
    }
}

