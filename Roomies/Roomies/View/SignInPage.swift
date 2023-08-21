//
//  Login.swift
//  Roomies
//
//  Created by Akhi Nair on 8/18/23.
//

import SwiftUI

struct SignInPage: View {
    
    @State private var currentPage: String? = "Login"
    
    //@State private var currentPage: Int? = nil // To manage navigation
    
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
                
                //Shadowed box containing Sign in entry fields
                ShadowBox(content: SignInBox(),
                          width: 250,
                          height: 450)
                
                
                // For new users, directs to create account page
                HStack {
                    Text("New to Roomies?")
                        .font(.subheadline)
                    //Spacer()
                    NavigationLink("Sign Up", destination: SignUpPage())
                }
                .padding()
                                
            
            }
                
        }
    }
}

struct SignInPage_Previews: PreviewProvider {
    
    static var previews: some View {
        
        SignInPage()
    }
}
