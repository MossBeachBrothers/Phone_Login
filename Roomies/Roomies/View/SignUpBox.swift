//
//  SignUpBox.swift
//  Roomies
//
//  Created by Akhi Nair on 8/21/23.
//

import SwiftUI
import FirebaseAuth
import FirebaseCore
import GoogleSignIn

struct SignUpBox : View {
    
    @State private var first_name : String = ""
    @State private var last_name : String = ""
    
    //Whether Email or Phone is chosen
    enum InputType {
        case email
        case phone
    }
    
    @State private var input_type : InputType = .email
    
    @State private var email_or_phone : String = ""
    
    @State private var password : String = ""
    @State private var repeat_password : String = ""
    
    @State private var isPasswordVisible: Bool = false
    
    var body: some View {
        
        VStack(alignment: .center) {
            
            Text("Sign Up")
            
                .foregroundColor(.gray)
                .font(.title)
                .fontWeight(.semibold)
            
            CustomTextField(hint: "First Name", text: $first_name)
            
            CustomTextField(hint: "Last Name", text: $last_name)
            
            CustomTextField(hint: "Email or Phone", text: $email_or_phone)
            
            PasswordField(hint: "Password", password: $password)
            

            
            PasswordField(hint: "Repeat Password", password: $repeat_password)
            

            Button(action: {}) {
                 
                Text("Sign Up")
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
            Button(action: {}) {
                
                HStack {
                    
                    Image("btn_google_dark_normal_ios")
                        .resizable()
                        .frame(width: 40, height: 40)
                    
                    Text("Sign Up with Google")
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
    
    func passwordsMatch() -> Bool{
        /*
         Check if the two passwords match each other
         */
        if (password == repeat_password){
            print("Passwords match")
            return true
        }
        print("Passwords do NOT match")
        return false
        
    }
    
    
    func send_email_code() {
        
    }
    
    func send_phone_code() {
        
    }
    
    func signInWithGoogle(){
        /*
         Signs the User in with Google
         */
        
    }
}


struct SignUpBox_Preview : PreviewProvider {
    
    static var previews: some View {
        
        ContentView()
    }
}
