//
//  SignInBox.swift
//  Roomies
//
//  Created by Akhi Nair on 8/20/23.
//

import SwiftUI
import FirebaseAuth
import FirebaseCore
import GoogleSignIn



struct SignInBox : View {
    
    @State private var email_or_phone : String = ""
    @State private var password : String = ""
    @State private var isPasswordVisible: Bool = false
    @EnvironmentObject var authViewModel: AuthViewModel
    //Whether Email or Phone is chosen
    enum InputType {
        case email
        case phone
    }
    
    // MARK: Function to Sign Users in with Email and Password
    func signInUserWithEmail() {
        authViewModel.signInWithEmail(email: email_or_phone, password: password) { error in
            if let error = error {
                print("Sign-in error: \(error.localizedDescription)")
            } else {
                print("User signed in successfully")
                // Navigate to the next screen or perform additional actions upon successful sign-in
            }
        }
    }


    
    
    @State private var input_type : InputType = .email
    
    var body: some View {
        
        VStack(alignment: .center) {
            
            Text("Sign In")
            
                .foregroundColor(.gray)
                .font(.title)
                .fontWeight(.semibold)
            
            CustomTextField(hint: "Email or Phone", text: $email_or_phone)
            
            PasswordField(hint: "Password", password: $password)
            
            VStack(alignment: .trailing){
                NavigationLink("Forgot Password?",
                               destination: ForgotPasswordPage())
            }

             Button(action: {
                 /* Handle sign-in action here//Firebase Authentication for Sign In*/
                signInUserWithEmail()
                 
                 
             }) {
                
                 
                Text("Sign In")
                     .font(.headline)

             }
             .roomiesButtonStyle()
            
            
            HStack {
                
                Rectangle()
                    .fill(Color.gray)
                    .frame(maxWidth: .infinity, maxHeight: 1)
                
                Text("or")
                    .foregroundColor(.gray)
                
                Rectangle()
                    .fill(Color.gray)
                    .frame(maxWidth: .infinity, maxHeight: 1)
            }
            .padding(.horizontal)
            
            
            //Sign in with Google Button
            Button(action: {/* */}) {
                
                HStack {
                    
                    Image("btn_google_dark_normal_ios")
                        .resizable()
                        .frame(width: 40, height: 40)
                    
                    Text("Sign in with Google")
                        .foregroundColor(.white)
                        .padding()
                }
            }
            .frame(maxWidth: .infinity)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.blue)
                    .shadow(color: Color.blue.opacity(0.5), radius: 5, x: 0, y: 2)
            )
        }
        .padding()
        
    }
}


struct SignInBox_Preview : PreviewProvider {
    
    static var previews: some View {
        
        SignInPage()
    }
}
