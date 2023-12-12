//
//  Login.swift
//  Roomies
//
//  Created by Akhi Nair on 8/18/23.
//

import SwiftUI

struct SignUpPage: View {
    
    @State private var currentPage: String = "Login"
    @State private var search: Bool = false
    
    var body: some View {

            VStack(alignment: .center, spacing: 5) { // Increased spacing between title texts
              
                LogoBox()
                
                Spacer().frame(height: 10)
                
                ShadowBox(content: SignUpBox(),
                          width: 300,
                          height: 550)
            }
            .padding()
            .navigationBarBackButtonHidden(true)
            .toolbar {
              ToolbarItem(placement: .navigationBarLeading) {
                BackButton()
              }
            }
                
        }
}

struct SignUpPage_Previews: PreviewProvider {
    static var previews: some View {
        SignUpPage()
    }
}
