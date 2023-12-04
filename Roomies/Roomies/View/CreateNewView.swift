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

struct CreateNewView: View {

    @State private var searchText: String = ""
    @State private var isSearching: Bool = false
    
    var body: some View {
        VStack{
          //Button(text="New Group")
          
          //Button(text="New Contact")
          
          
            
            Spacer()
            
            ShadowBox(content: EmptyView(),
                      width: 300,
                      height: 550)
            
            Spacer()
        }
        .padding()
        
    }
}



// Preview for the SwiftUI canvas
struct CreateNewViewView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        .environmentObject(AuthViewModel())
    }
}





