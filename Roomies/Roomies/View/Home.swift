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
    @EnvironmentObject var authViewModel: AuthViewModel
    @State private var userData: RoomiesUser? // Store fetched user data
    
    var body: some View {
        VStack {
            if let user = userData {
                Text("Welcome, \(user.firstName) \(user.lastName)...")
                Text("Email: \(user.email)")
                Text("Phone: \(user.phoneNumber)")
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
}


struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(AuthViewModel()) // Inject an instance of AuthViewModel for preview
    }
}
