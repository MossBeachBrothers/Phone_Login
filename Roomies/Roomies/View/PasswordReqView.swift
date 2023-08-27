//
//  PasswordReqView.swift
//  Roomies
//
//  Created by Akhi Nair on 8/23/23.
//

import SwiftUI

struct PasswordReqView: View {
    
    // Replace this with your actual password binding
    @Binding var password: String
    
    //private var font_size : 
    
    var body: some View {
        
        HStack{
            
            VStack(alignment: .leading, spacing: 4) {
                
                //Text("Password Requirements:")
                //.font(.subheadline)
                
                Text("- At least 8 characters")
                    .foregroundColor(isLengthValid() ? .green : .red)
                    .font(GlobalFonts.captionFont)
                
                Text("- At least one uppercase letter")
                    .foregroundColor(hasUppercaseLetter() ? .green : .red)
                    .font(GlobalFonts.captionFont)
                
                Text("- At least one lowercase letter")
                    .foregroundColor(hasLowercaseLetter() ? .green : .red)
                    .font(GlobalFonts.captionFont)
                
                Text("- At least one digit")
                    .foregroundColor(hasDigit() ? .green : .red)
                    .font(GlobalFonts.captionFont)
                
                Text("- At least one special character")
                    .foregroundColor(hasSpecialCharacter() ? .green : .red)
                    .font(GlobalFonts.captionFont)
            }
            
            Spacer()
        }

    }
    
    // Sample functions to check password requirements
    func isLengthValid() -> Bool {
        
        
        return password.count >= 8
    }
    
    func hasUppercaseLetter() -> Bool {
        
        return password.rangeOfCharacter(from: .uppercaseLetters) != nil
    }
    
    func hasLowercaseLetter() -> Bool {
        
        return password.rangeOfCharacter(from: .lowercaseLetters) != nil
    }
    
    func hasDigit() -> Bool {
        
        return password.rangeOfCharacter(from: .decimalDigits) != nil
    }
    
    func hasSpecialCharacter() -> Bool {
        
        let specialCharacterSet = CharacterSet(charactersIn: "!@#$%^&*()_-+=<>?/,.:;{}[]|")
        return password.rangeOfCharacter(from: specialCharacterSet) != nil
    }
    
    func isPasswordValid() -> Bool {
        
        return isLengthValid() && hasUppercaseLetter() && hasLowercaseLetter() && hasDigit() && hasSpecialCharacter()
    }
    
}
