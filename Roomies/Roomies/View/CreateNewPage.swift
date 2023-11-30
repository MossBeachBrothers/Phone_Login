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
    @Binding var selectedTab: Tab  // A binding to manage the selected tab externally
    @State private var searchText: String = ""
    @State private var isSearching: Bool = false
    
    var body: some View {
        VStack{
            HStack {
                Button(action: {
                    withAnimation {
                      selectedTab = .message // Or any default tab you want to return to
                    }
                }) {
                    Image(systemName: "arrow.backward")
                        .foregroundColor(.black)  // Customize color as needed
                }
                .padding(.trailing, 8)  // Adjust padding as needed
                
                // Other elements (e.g., SearchBar) can go here
                
                SearchBar(text: $searchText, isSearching: $isSearching, startingText: "Name, @username, email, phone")
            }
            
            Spacer()
            
            ShadowBox(content: EmptyView(),
                      width: 300,
                      height: 550)
            
            Spacer()
        }
        .padding()
        .animation(.easeInOut(duration: 0.5), value: selectedTab) // Applying an animation for appearance
    }
}



struct CreateNewPage_Previews: PreviewProvider {
  static var previews: some View {
    NavView()
    
  }
}




