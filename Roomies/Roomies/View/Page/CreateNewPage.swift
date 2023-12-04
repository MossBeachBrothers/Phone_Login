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
    @Binding var path: NavigationPath
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
//          Button({
//            path.removeLst()
//          }, label: <#T##() -> View#>)
        }
        .padding()
        .navigationBarBackButtonHidden()
        .toolbar {
          ToolbarItem(placement: .navigationBarLeading) {
            Button {
              path.removeLast()
            } label : {
              Image(systemName: "chevron.left.circle")
            }
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





