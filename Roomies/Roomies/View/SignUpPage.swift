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
            
            VStack(alignment: .center, spacing: 5) { // Increased spacing between title texts
                
                Text("Roomies")
                    .foregroundColor(.pink)
                    .font(.title)
                    .fontWeight(.semibold)
                
                Text("Share Group signup")
                    .foregroundColor(.gray)
                    .font(.title)
                    .fontWeight(.semibold)
                
                ShadowBox(content: SignUpBox(),
                          width: 300,
                          height: 550)
            }
                
        }
    }
}

struct SignUpPage_Previews: PreviewProvider {
    static var previews: some View {
        SignUpPage()
    }
}
