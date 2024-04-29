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
              NavigationLink(value: AuthLink.signUpView){
                Text("Sign Up")
              }
                
            }
            .padding()
            .padding()
            .navigationBarBackButtonHidden(true)
            .navigationDestination(for: AuthLink.self){ screen in
              switch screen {
                case .signInView : SignInPage()
                case .signUpView : SignUpPage()
                case .navigationView: NavView()
              }
            }
      }
    }
}

struct SignInPage_Previews: PreviewProvider {
    
    static var previews: some View {
        
        SignInPage()
    }
}
