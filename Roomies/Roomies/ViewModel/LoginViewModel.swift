//
//  LoginViewModel.swift
//  Roomies
//
//  Created by Akhi Nair on 8/18/23.
//

/*

import SwiftUI
import Firebase

class LoginViewModel : ObservableObject {
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
}

//MARK: Extensions

extension UIApplication {
    func closeKeyBoard() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from : nil, for: nil)
    }
}

*/
