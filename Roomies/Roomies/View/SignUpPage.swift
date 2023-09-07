//
//  Login.swift
//  Roomies
//
//  Created by Akhi Nair on 8/18/23.
//

import SwiftUI

struct SignUpPage: View {
    
    @State private var currentPage: String? = "Login"
    var body: some View {
        
        NavigationView {
            
            VStack(alignment: .center, spacing: 5) { // Increased spacing between title texts
                
                LogoBox()
                
                Spacer().frame(height: 10)
                
                ShadowBox(content: SignUpBox(),
                          width: 300,
                          height: 550)
            }
            .padding()
                
        }
    }
}

struct SignUpPage_Previews: PreviewProvider {
    static var previews: some View {
        SignUpPage()
    }
}
