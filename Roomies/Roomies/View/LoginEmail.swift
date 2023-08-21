//
//  LoginEmail.swift
//  Roomies
//
//  Created by Akhi Nair on 8/19/23.
//

/*
import SwiftUI

struct LoginEmail : View {
    
    @State private var email : String = ""
    @State private var password : String = ""
    @Binding var currentPage: String?
    
    var body: some View {
        
        NavigationView {
            
            ScrollView(.vertical, showsIndicators: false) {
                
                VStack(alignment: .leading, spacing: 20) { // Increased spacing between elements
                    
                    Image(systemName: "square")
                        .font(.system(size: 30))
                        .foregroundColor(.indigo)
                    
                    VStack(alignment: .leading, spacing: 5) { // Increased spacing between title texts
                        Text("Roomies")
                            .foregroundColor(.pink)
                            .font(.title)
                            .fontWeight(.semibold)
                        
                        Text("Login with Email")
                            .foregroundColor(.gray)
                            .font(.title)
                            .fontWeight(.semibold)
                    }
                    .lineSpacing(10)
                    .padding(.top, 20)
                    .padding(.trailing, 15)
                    
                    TextField("Email", text: $email)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .foregroundColor(.black)
                        .padding(.horizontal)
                        .background(Color("TextFieldBackground"))
                        .cornerRadius(10)
                    
                    SecureField("Password", text: $password)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .foregroundColor(.black)
                        .padding(.horizontal)
                        .background(Color("TextFieldBackground"))
                        .cornerRadius(10)
                    
                    Button(action: {
                        // Handle sign-in action here
                        //Firebase Authentication for Email
                    }) {
                        Text("Sign In")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.pink)
                            .cornerRadius(10)
                    }
                    .padding(.top, 20) // Adding padding above the button
                    
                    NavigationLink(destination: CreateEmailView(currentPage : $currentPage)) {
                        
                                Text("Create an Account")
                                    .font(.headline)
                                    .foregroundColor(.blue) // Set the link color
                                    .underline() // Underline the text
                                    .padding()
                                    .frame(maxWidth: .infinity)
                            }
                            .padding(.top, 20)
                    
                 Button("Back to Login") {
                     currentPage = "Login"
                 }
                 .font(.headline)
                 .foregroundColor(.blue) // Set the link color
                 .underline() // Underline the text
                 .padding()
                 .frame(maxWidth: .infinity)
                
                }
                .padding()
                .background(Color("Background").ignoresSafeArea())
                .navigationBarBackButtonHidden(true)
                
            }
        }
        
    }
}





struct LoginEmail_Previews : PreviewProvider {
    static var previews: some View {
        Login()
    }
}
*/
