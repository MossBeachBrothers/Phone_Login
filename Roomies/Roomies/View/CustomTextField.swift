//
//  CustomTextField.swift
//  Roomies
//
//  Created by Akhi Nair on 8/18/23.
//


import SwiftUI


struct CustomTextField: View {
    
    var hint: String
    @Binding var text: String

    var body: some View {
        
        HStack() {
            
            TextField(hint, text: $text)
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(10)
                .autocapitalization(.none)
        }

    }
}


struct CustomTextField_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


