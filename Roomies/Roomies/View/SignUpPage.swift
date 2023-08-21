//
//  Login.swift
//  Roomies
//
//  Created by Akhi Nair on 8/18/23.
//

import SwiftUI

struct SignUpPage: View {
    
    @State private var currentPage: String? = "Login"
    
    var body: some View {
        
        NavigationView {
            
                
            //Image(systemName: "square")
                //.font(.system(size: 30))
                //.foregroundColor(.indigo)
            
            VStack(alignment: .center, spacing: 5) { // Increased spacing between title texts
                
                Text("Roomies")
                    .foregroundColor(.pink)
                    .font(.title)
                    .fontWeight(.semibold)
                
                Text("Share Group Expenses")
                    .foregroundColor(.gray)
                    .font(.title)
                    .fontWeight(.semibold)
                
                ShadowBox(content: SignInBox(),
                          width: 250,
                          height: 450)
            }
                
        }
    }
}
