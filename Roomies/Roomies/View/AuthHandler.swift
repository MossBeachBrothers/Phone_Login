//
//  AuthHandler.swift
//  Roomies
//
//  Created by Akhi Nair on 8/21/23.
//

import SwiftUI
import Firebase
import FirebaseCore
import FirebaseAuth


public class AuthHandler : ObservableObject {
    
    /*
    //MARK: View Properties
    @Published var mobileNo: String = ""
    @Published var otpCode: String = ""
    
    @Published var CLIENT_CODE: String = ""
    @Published var showOTPField: Bool = false
    
    
    
    //MARK: Error Properties
    @Published var showError: Bool = false
    @Published var errorMessage: String = ""
    
    //MARK: Firebase API's to Get Phone Number Auth
    func getOTPCode() {
        Task {
            //do everything in do catch block to catch error
            do {
                //MARK: Disable when testing with real device
                Auth.auth().settings?.isAppVerificationDisabledForTesting = true
                
               let code = try await PhoneAuthProvider.provider().verifyPhoneNumber("+\(mobileNo)", uiDelegate: nil)
                await MainActor.run(body: {
                    CLIENT_CODE = code
                    //MARK: Enable the OTP Field when it is a Success
                        withAnimation(.easeInOut){showOTPField = true}
                })
                
            } catch {
                await handleError(error: error)            }
        }
    }
    
    func verifyOTPCode() {
        UIApplication.shared.closeKeyBoard()
        Task {
            do {
                
                let credential = PhoneAuthProvider.provider().credential(withVerificationID: CLIENT_CODE, verificationCode: otpCode)
                
                try await Auth.auth().signIn(with: credential)
                
                //MARK: User Logged in Successfully
            print("Sucess!")
                
                
            } catch {
                await handleError(error: error)
            }
        }
    }
    
    func handleError(error: Error)async{
        await MainActor.run(body: {
            errorMessage = error.localizedDescription
            showError.toggle()
            
        })
    }
     */
    
    static func isValidPhoneNumber(phone : String) -> Bool{
        /*
         Checks if the text within the email or phone field is a phone number
         */
        
        let phoneRegex = "^\\d{10}$" // Assumes a 10-digit number format

        let phonePredicate = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        
        return phonePredicate.evaluate(with: phone)

    }
    
    static func isValidEmail(email : String) -> Bool{
        /*
         Checks if the text within the email or phone field is an email
         */
        
        let emailRegex = "[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"

        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        
        return emailPredicate.evaluate(with: email)

    }
    
    static func createUserEmail(email: String, password: String){
        /*
         Uses a firebase command to create the database log of the
         new user account with the email and password information
         */
        
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                print("success")
            }
        }
    }
    
    static func signInUserEmail(email: String, password: String){
        
        //Function to sign in with Email with Firebase APIs
        
        /*
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
          guard let strongSelf = self else { return }
 
            if let error = error {
                
                print(error.localizedDescription)
                
            }
            else if let authResult = authResult {
                
                print("Signed In Successfully")
                print("User ID: \(authResult.user.uid)")
                print("User Email: \(authResult.user.email ?? "N/A")")
                
            }
        }
         */
    }
}

//MARK: Extensions

extension UIApplication {
    
    func closeKeyBoard() {
        
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from : nil, for: nil)
    }
}



