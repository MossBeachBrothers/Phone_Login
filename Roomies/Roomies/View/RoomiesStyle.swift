//
//  RoomiesStyle.swift
//  Roomies
//
//  Created by Akhi Nair on 8/21/23.
//

import SwiftUI

struct RoomiesTextFieldStyle: ViewModifier {
    
    func body(content: Content) -> some View {
        
        content
        

            .foregroundColor(Color.black)
            .background(Color.gray.opacity(0.1))
        
            .frame(maxWidth: .infinity)

            .padding()
            .cornerRadius(10)
    }
}

struct RoomiesButtonStyle: ViewModifier {
    
    func body(content: Content) -> some View {
        
        content

            .foregroundColor(Color.white)
            .background(Color.pink)
        
            .frame(maxWidth: .infinity)
        
            .padding()
            .cornerRadius(10)
        
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.pink)
                    .shadow(color: Color.pink.opacity(0.5), radius: 5, x: 0, y: 2)
           )
    }
}

extension View {
    
    func roomiesTextFieldStyle() -> some View {
        
        self.modifier(RoomiesTextFieldStyle())
    }
    
    func roomiesButtonStyle() -> some View {
        
        self.modifier(RoomiesButtonStyle())
    }
}
