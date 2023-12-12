//
//  CreateNewPage.swift
//  Roomies
//
//  Created by Akhi Nair on 10/26/23.
//

import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseCore

struct CreateNewPage: View {
    @State private var searchText: String = ""
    @State private var isSearching: Bool = false
    @EnvironmentObject var navigationStateModel: NavigationStateModel
  
    init() {
      
    }

    var body: some View {
        VStack{
            ShadowBox(content: CreateNewScrollView(),
                      width: 400,
                      height: 650)
        }
        .padding()
        .navigationBarBackButtonHidden()
        .toolbar {
          ToolbarItem(placement: .navigationBarLeading) {
            BackButton()
          }
        }
        
    }
}



// Preview for the SwiftUI canvas
struct CreateNewPageView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        .environmentObject(AuthViewModel())
    }
}





