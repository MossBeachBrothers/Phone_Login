//
//  Login.swift
//  Roomies
//
//  Created by Akhi Nair on 8/18/23.
//

import SwiftUI

struct SignInPage: View {
    
    //@State private var currentPage: String? = "Login"
    
    //@State private var currentPage: Int? = nil // To manage navigation
    var body: some View {
        
        NavigationView {
            
                
            //Image(systemName: "square")
                //.font(.system(size: 30))
                //.foregroundColor(.indigo)
            
            VStack(alignment: .center) {
                
                LogoBox()
                
                Spacer().frame(height: 10)
                
                //Shadowed box containing Sign in entry fields
                ShadowBox(content: SignInBox(),
                          width: 300,
                          height: 500)
                
                
                // For new users, directs to create account page
                HStack {
                    Text("New to Roomies?")
                        .font(.subheadline)
                    //Spacer()
                    NavigationLink("Sign Up", destination: SignUpPage())
                    
                    
                }
                .padding()
                                
            }
            .padding()
        
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct SignInPage_Previews: PreviewProvider {
    
    static var previews: some View {
        
        SignInPage()
    }
}
