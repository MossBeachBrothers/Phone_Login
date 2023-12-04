//
//  ShadowBox.swift
//  Roomies
//
//  Created by Akhi Nair on 8/20/23.
//

import SwiftUI

struct ShadowBox<Content: View>: View {
    
    /*
     Reusable structure for creating a shadowed border around
     the input structure object
     */
    var content: Content // Input as a View
    let width : Int32
    let height : Int32
    
    init(content: Content, width: Int32, height: Int32) {
        self.content = content
        self.width = width
        self.height = height
    }
    
    var body: some View {
        
        RoundedRectangle(cornerRadius: 10) // Use any corner radius you prefer
            .fill(Color.white)
            .frame(width: CGFloat(width), height: CGFloat(height))
            //.frame(maxWidth: .infinity, maxHeight: .infinity)
            .shadow(color: Color.gray.opacity(1), radius: 10, x: 0, y: 0)
            .overlay(content)
    }
}

// For emulator purposes

struct ShadowBox_Preview : PreviewProvider {
    
    static var previews: some View {
        
        ShadowBox(content: SignInBox(),
                  width: 250,
                  height: 450)
    }
}
