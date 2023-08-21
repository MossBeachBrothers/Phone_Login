//
//  LoginPhoneNumber.swift
//  Roomies
//
//  Created by Akhi Nair on 8/20/23.
//
/*
 import SwiftUI
 
 
 struct LoginPhoneNumber : View {
 
 @Binding var currentPage: String?
 @StateObject var loginModel: LoginViewModel = .init()
 
 var body: some View {
 
 ScrollView(.vertical, showsIndicators: false){
 
 VStack(alignment: .leading, spacing: 15){
 Image(systemName: "square")
 .font(.system(size: 30))
 .foregroundColor(.indigo)
 
 (Text("Roomies")
 .foregroundColor(.pink
 ) +
 Text("\nLogin to Continue")
 .foregroundColor(.gray)
 )
 .font(.title)
 .fontWeight(.semibold)
 .lineSpacing(10)
 .padding(.top, 20)
 .padding(.trailing, 15)
 
 //MARK: Custom Text Field
 CustomTextField(hint: "+1 6505551234", text: $loginModel.mobileNo)
 .disabled(loginModel.showOTPField)
 .opacity(loginModel.showOTPField ? 0.4 : 1)
 .padding(.top, 50)
 
 CustomTextField(hint: "OTP Code", text: $loginModel.otpCode)
 .disabled(!loginModel.showOTPField)
 .opacity(!loginModel.showOTPField ? 0.4 : 1)
 .padding(.top, 20)
 
 Button (action: loginModel.showOTPField ? loginModel.verifyOTPCode : loginModel.getOTPCode){
 HStack(spacing: 15){
 Text(loginModel.showOTPField ? "Verify Code" : "Get Code")
 .fontWeight(.semibold)
 .contentTransition(.identity)
 Image(systemName: "line.diagonal.arrow")
 .font(.title3)
 .rotationEffect(.init(degrees: 45))
 
 }
 .foregroundColor(.black)
 .padding(.horizontal, 25)
 .padding(.vertical)
 .background {
 RoundedRectangle(cornerRadius: 10, style: .continuous)
 .fill(.black.opacity(0.05))
 }
 }
 .padding(.top, 30)
 Button("Back to Login") {
 currentPage = "Login"
 }
 
 }
 .padding(.leading, 60)
 .padding(.vertical, 15)
 
 }
 .alert(loginModel.errorMessage, isPresented: $loginModel.showError){
 
 }
 
 
 }
 }
 
 
 struct LoginPhoneNumber_Previews: PreviewProvider {
 static var previews : some View {
 Login()
 }
 }
 
 */
