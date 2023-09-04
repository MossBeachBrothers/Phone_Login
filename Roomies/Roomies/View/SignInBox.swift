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
    
    @State private var emailPhoneErrorMessage : String = ""
    @State private var passwordErrorMessage : String = ""
    
    @State private var input_type : InputType = .email
    
    var body: some View {
        
        VStack(alignment: .center) {
            
            Text("Sign In")
            
                .foregroundColor(.gray)
                .font(.title)
                .fontWeight(.semibold)
            
            CustomTextField(hint: "Email or Phone", text: $email_or_phone)
                .onTapGesture {
                    emailPhoneErrorMessage = ""
                }
            
            Text(emailPhoneErrorMessage)
                .font(GlobalFonts.captionFont)
                .foregroundColor(Color.red)
            
            PasswordField(hint: "Password", password: $password)
                .onTapGesture {
                    passwordErrorMessage = ""
                }
            
            Text(passwordErrorMessage)
                .font(GlobalFonts.captionFont)
                .foregroundColor(Color.red)
            
            HStack{
                
                Spacer()
                
                NavigationLink("Forgot Password?",
                               destination: ForgotPasswordPage())
                .font(GlobalFonts.captionFont)
            }

             Button(action: {signInUser()}) {
                
                Text("Sign In")
                     .font(.headline)
             }
            .buttonStyle(RoomiesButtonStyle(color: Color.pink))
            
            
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
            .buttonStyle(RoomiesButtonStyle(color: Color.blue, pad_top: 0,
                            pad_bottom : 0, pad_left : 0, pad_right : 0))
        }
        .padding()
        .navigationBarBackButtonHidden(true)
        
    }
    
    func signInUser(){
        
        emailPhoneErrorMessage = ""
        passwordErrorMessage = ""
        
        let email = authViewModel.isValidEmail(email: email_or_phone)
        let phone = authViewModel.isValidPhoneNumber(phone: email_or_phone)
        
        if email_or_phone.isEmpty{
            emailPhoneErrorMessage = "Please enter an email or phone number"
        }
        
        else if !email && !phone{
            emailPhoneErrorMessage = "Invalid Email or Phone"
            return
        }
        
        
        if password.isEmpty{
            passwordErrorMessage = "Please enter a password"
            return
        }
        
        //if email{
        authViewModel.checkIfUserExists(email: email_or_phone){ exists in
            if (!exists && email){
                emailPhoneErrorMessage = "Email is not associated with an account"
            }
            
            else if (!exists && phone){
                emailPhoneErrorMessage = "Email is not associated with an account"
            }

            else{
                signInUserWithEmail()
            }
        }
        //}
        /*
        else if phone{
            authViewModel.checkIfUserExists(phone: email_or_phone){ exists in
                if (!exists && phone){
                    emailPhoneErrorMessage = "Phone number is not associated with an account"
                }
                else{
                    signInUserWithEmail()
                }
            }
        }
        */
    }
    
    func signInUserWithEmail() {
        
        do{
            AuthViewModel.signInWithEmail(email: email_or_phone, password: password) {error in
                if let error = error {
                    if error.localizedDescription.contains("The password is invalid"){
                        passwordErrorMessage = "Incorrect password"
                    }
                    print(error.localizedDescription)
                } else {
                    print("Success")
                }
            }
        }
        
        catch {
            print("An error occurred while signing in: \(error.localizedDescription)")
        }

    }
}


struct SignInBox_Preview : PreviewProvider {
    
    static var previews: some View {
        
        ContentView()
            .environmentObject(AuthViewModel())
    }
}
