//
//  GroupBox.swift
//  Roomies
//
//  Created by Akhi Nair on 9/3/23.
//

import SwiftUI
import Firebase
import FirebaseCore
import FirebaseFirestore

struct GroupBox: View {
    
    @State var text : String
    
    var body : some View{
        
        Button(action: {/* */}) {
            
            Text(text)
                .font(GlobalFonts.titleFont)
                .foregroundColor(.white)
                .padding()
        }
        .buttonStyle(RoomiesButtonStyle(color: Color.pink, pad_top: 0,
                        pad_bottom : 0, pad_left : 0, pad_right : 0))
    }
    /*
    @EnvironmentObject var authViewModel: AuthViewModel
    @State private var userData: RoomiesUser? // Store fetched user data
    @State var user1_id: String = ""
    @State var user2_id: String = ""
    var body: some View {
        VStack {
            if let user = userData {
                Text("Welcome, \(user.email)...")
                Button("Add User", action: {})
                    .buttonStyle(RoomiesButtonStyle(color: Color.pink))
                CustomTextField(hint: "User 1", text: $user1_id)
                CustomTextField(hint: "User 2", text: $user2_id)
                Button("Create Group", action: {
                    var members: [String] = [user1_id, user2_id]
                    authViewModel.createGroup(adminID: user.uid, memberIDs: members, groupName: "Test Group 123")
                })
                    .buttonStyle(RoomiesButtonStyle(color: Color.pink))
                Button("Log Out", action: authViewModel.logOut)
            } else {
                Text("Loading user data...")
            }
        }
        .onAppear {
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



struct GroupBox_Previews: PreviewProvider {
    
    static var previews: some View {
        Home()
        //GroupBox()
        //ContentView().environmentObject(AuthViewModel())
    }
}
