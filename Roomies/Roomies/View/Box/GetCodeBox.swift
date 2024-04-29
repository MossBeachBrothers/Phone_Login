//
//  GetCodeBox.swift
//  Roomies
//
//  Created by Akhi Nair on 8/26/23.
//

import SwiftUI

struct GetCodeBox: View {

    @State var correct_verificationCode : Int32
    @State var errorMessage : String = ""
    @State var verificationCode : String = ""

    let email_or_phone : String
    let input_type : InputType
    let exitFunc: () -> Void

    init(input_type : InputType, email_or_phone : String, exitFunc: @escaping () -> Void) {

        // Assign the random 6 digit code
        self.input_type = input_type
        self.email_or_phone = email_or_phone
        self.correct_verificationCode = Int32(arc4random_uniform(UInt32(999_999 - 100_000))) + 100_000
        self.exitFunc = exitFunc

        if input_type == .email{
            AuthViewModel.sendOTPCodeEmail(email: email_or_phone, code: correct_verificationCode)
        }

        else if input_type == .phone{
            AuthViewModel.sendOTPCodePhone(phone: email_or_phone, code: correct_verificationCode)
        }

    }

    var body: some View {

        VStack(alignment: .center) {

            PasswordField(hint: "Verification Code", password: $verificationCode)
                .keyboardType(.numberPad)

            Text(errorMessage)
                .font(GlobalFonts.captionFont)

            NavigationLink(destination: SignInPage()) {
                /*
                 Button to Reset Password, then go back to Sign Up
                 */
                Button(action: {
                    verify()
                }) {
                    Text("Verify")
                        .font(GlobalFonts.bodyFont)
                }
                .buttonStyle(RoomiesButtonStyle())
            }
        }
        .padding()
    }

    func verify(){

        print(correct_verificationCode)

        if verificationCode != String(correct_verificationCode){

            errorMessage = "Invalid Code"
            return
        }

        exitFunc()

    }
}
