//
//  ContentView.swift
//  Roomies
//
//  Created by Sid Nair on 8/18/23.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
      
        NavigationView {
            
            /*
            if (authViewModel.isLoggedIn){
                Home()
            } else {
                SignInPage()
            }
            */
            SignInPage()
            
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
            ContentView()
                .environmentObject(AuthViewModel()) // Inject an instance of AuthViewModel for preview
        }
}
