//
//  PasswordField.swift
//  Roomies
//
//  Created by Akhi Nair on 8/21/23.
//


import SwiftUI


struct PasswordField: View {
    
    var hint : String
    @State private var isPasswordVisible = false
    @Binding var password: String

    var body: some View {
        
        HStack {
            
            ZStack {
                
                TextField(hint, text: $password)
                    .textContentType(.password)
                    .opacity(isPasswordVisible ? 0 : 1)
                    .autocapitalization(.none)
                
                
                SecureField(hint, text: $password)
                    .opacity(isPasswordVisible ? 1 : 0)
                    .autocapitalization(.none)
                
            }
            
            Button(action: { isPasswordVisible.toggle() }) {
                
                Image(systemName: isPasswordVisible ? "eye.slash.fill" : "eye.fill")
                    .foregroundColor(.blue)
            }
        }
        .padding()
        .background(Color.gray.opacity(0.1)) // Add background to visually separate the field
        .cornerRadius(10)
    }
}
