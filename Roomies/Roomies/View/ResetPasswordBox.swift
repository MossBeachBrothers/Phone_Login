//
//  ResetPasswordBox.swift
//  Roomies
//
//  Created by Akhi Nair on 8/22/23.
//

import Foundation
import SwiftUI


struct ResetPasswordBox: View {
    @State private var emailOrPhone = ""
    @State private var isCodeSent = false
    @State private var verificationCode = ""
    @State private var password = ""
    @State private var repeatPassword = ""
    
    var maskedEmail: String {
        guard isCodeSent else { return "" }
        let email = emailOrPhone
        let maskedEmail = email.prefix(1) + String(repeating: "*", count: email.count - 1)
        return "We've sent you a code to \(maskedEmail)"
    }
    
    var body: some View {
        VStack(alignment: .center) {
            Text("Reset Password")
                .foregroundColor(.gray)
                .font(.title)
                .fontWeight(.semibold)
            
            if !isCodeSent {
                CustomTextField(hint: "Email or Phone", text: $emailOrPhone)
                
                Button(action: {
                    sendCode()
                }) {
                    Text("Get a Code")
                        .font(.headline)
                }
                .roomiesButtonStyle()
                .padding(.top, 10) // Add some spacing between the button and text field
            } else {
                Text(maskedEmail) // Display the masked email text
                    .font(.subheadline)
                    .padding(.bottom, 10)
                
                PasswordField(hint: "Verification Code", password: $verificationCode)
                PasswordField(hint: "Password", password: $password)
                PasswordField(hint: "Repeat Password", password: $repeatPassword)
                
                NavigationLink(destination: SignInPage()) {
                    Button(action: {
                        resetPassword()
                    }) {
                        Text("Reset Password")
                            .font(.headline)
                    }
                    .roomiesButtonStyle()
                    .padding(.top, 10) // Add some spacing between the button and text field
                }
            }
        }
        .padding()
    }
    
    func sendCode() {
        // Your logic to send the verification code
        isCodeSent = true
    }
    
    func resetPassword() {
        // Function to use Firebase API to reset the password
    }
}




struct ResetPasswordBox_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPasswordPage()
    }
}
