//
//  ContentView.swift
//  Roomies
//
//  Created by Sid Nair on 8/18/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var authViewModel: AuthViewModel = AuthViewModel()
    @StateObject var navigationStateModel: NavigationStateModel = NavigationStateModel()
    @State var loggedIn = false
    var body: some View {
          
          NavigationStack (path: $navigationStateModel.navPath){
            Group {
              if (loggedIn){
                  NavView()
                  Spacer()
              } else {
                  SignInPage()
              }
            }
          }
          .environmentObject(navigationStateModel)
          .environmentObject(authViewModel)
          .onAppear {
              // Initialize loggedIn state when the view appears
              loggedIn = authViewModel.isLoggedIn
          }
          .onChange(of: authViewModel.isLoggedIn) { _ in
              // Update loggedIn when isLoggedIn changes
            loggedIn.toggle()
          }
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {

            ContentView()
              
                
      
    }
}
