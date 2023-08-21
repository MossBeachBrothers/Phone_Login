//
//  SignInBox.swift
//  Roomies
//
//  Created by Akhi Nair on 8/20/23.
//

import SwiftUI

struct SignInBox : View {
    
    @State private var email_or_phone : String = ""
    @State private var password : String = ""
    @State private var isPasswordVisible: Bool = false
    
    
    var body: some View {
        
        VStack(alignment: .center, spacing: 20) { // Increased spacing between elements
            
            Text("Sign In")
            
                .foregroundColor(.gray)
                .font(.title)
                .fontWeight(.semibold)
            
            
            TextField("Email or Phone", text: $email_or_phone)
            
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .foregroundColor(.black)
                .padding(.horizontal)
                .background(Color("TextFieldBackground"))
                .cornerRadius(10)
            
            HStack {
                if isPasswordVisible {
                    TextField("Password", text: $password)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                } else {
                    SecureField("Password", text: $password)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }

                Button(action: {
                    isPasswordVisible.toggle()
                }) {
                    Image(systemName: isPasswordVisible ? "eye.slash.fill" : "eye.fill")
                        .foregroundColor(.blue)
                }
            }
            .padding()
            
            NavigationLink("Forgot Password?",
                           destination: ForgotPasswordPage())

             Button(action: {/* Handle sign-in action here//Firebase Authentication for Email*/}) {
                 
                 Text("Sign In")
                 .font(.headline)
                 .foregroundColor(.white)
                 .padding()
                 .frame(maxWidth: .infinity)
                 .background(Color.pink)
                 .cornerRadius(10)
             }
             .padding(.top, 20) // Adding padding above the button
            
            
            HStack {
                Rectangle()
                    .fill(Color.gray)
                    .frame(width: 80, height: 1)
                Text("or")
                    .foregroundColor(.gray)
                Rectangle()
                    .fill(Color.gray)
                    .frame(width: 80, height: 1)
            }
            .padding(.horizontal)
            
            
            //Sign in with Google Button
            Button(action: {/* */}) {
                
                HStack {
                    
                    Image("btn_google_dark_normal_ios")
                        .resizable()
                        .frame(width: 20, height: 20)
                    
                    Text("Sign in with Google")
                        .foregroundColor(.white)
                        .padding()
                }
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.blue)
                        .shadow(color: Color.blue.opacity(0.5), radius: 5, x: 0, y: 2)
                )
            }
            .padding(.top, 20) // Adding padding above the button
            
            
            /*
            //Sign in with Apple Button
            Button(action: {}) {
                
                HStack {
                    
                    Image("btn_google_dark_normal_ios")
                        .resizable()
                        .frame(width: 20, height: 20)
                    
                    Text("Sign in with Apple")
                        .foregroundColor(.white)
                        .padding()
                }
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.black)
                        .shadow(color: Color.blue.opacity(0.5), radius: 5, x: 0, y: 2)
                )
            }
            */
                
        }
        
    }
}


struct SignInBox_Preview : PreviewProvider {
    
    static var previews: some View {
        
        SignInBox()
    }
}
