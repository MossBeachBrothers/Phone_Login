//
//  SignInBox.swift
//  Roomies
//
//  Created by Akhi Nair on 8/20/23.
//

import SwiftUI

struct ForgotPasswordPage : View {
    
    @EnvironmentObject var authViewModel: AuthViewModel
    var body: some View {
        NavigationView {
            VStack(alignment: .center, spacing: 5) { // Increased spacing between title texts
                
                Text("Roomies")
                    .foregroundColor(.pink)
                    .font(.title)
                    .fontWeight(.semibold)
                
                Text("Share Group Expenses")
                    .foregroundColor(.gray)
                    .font(.title)
                    .fontWeight(.semibold)
                
                ShadowBox(content: ResetPasswordBox(),
                          width: 300,
                          height: 550)
            }
        }
    }
}


struct ForgotPasswordPage_Preview : PreviewProvider {
    
    static var previews: some View {
        
        ForgotPasswordPage()
    }
}
