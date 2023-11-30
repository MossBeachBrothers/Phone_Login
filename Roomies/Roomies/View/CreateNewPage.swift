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
    
    var body: some View {
        VStack{
            HStack {
                
                SearchBar(text: $searchText, isSearching: $isSearching, startingText: "Name, @username, email, phone")
            }
            
            Spacer()
            
            ShadowBox(content: EmptyView(),
                      width: 300,
                      height: 550)
            
            Spacer()
        }
        .padding()
        
    }
}



struct CreateNewPage_Previews: PreviewProvider {
  static var previews: some View {
    NavView()
    
  }
}




