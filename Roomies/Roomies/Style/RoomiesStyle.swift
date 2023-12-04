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

/*
struct RoomiesButtonStyle: ViewModifier {
    
    func body(content: Content) -> some View {
        
        content
        
            .foregroundColor(Color.white)
        
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
*/

struct RoomiesButtonStyle: ButtonStyle {

    var color: Color = Color.pink
    var pad_top : CGFloat = 15
    var pad_bottom : CGFloat = 15
    var pad_left : CGFloat = 15
    var pad_right : CGFloat = 15

    func makeBody(configuration: Self.Configuration) -> some View {
    
        configuration.label
            .foregroundColor(Color.white)
            .frame(maxWidth: .infinity)
            
            .padding(EdgeInsets(top: pad_top, leading: pad_left, bottom: pad_bottom, trailing: pad_right))
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(color)
                    .shadow(color: Color.pink.opacity(0.5), radius: 5, x: 0, y: 2)
            )
            .contentShape(Rectangle())
            .opacity(configuration.isPressed ? 0.7 : 1.0)
    }
}


struct GlobalFonts {
    
    static let titleFont: Font = .custom("TitleFontName", size: 24)
    static let bodyFont: Font = .custom("BodyFontName", size: 18)
    static let captionFont: Font = .custom("CaptionFontName", size: 14)
}


struct RoomiesVStackStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(5)
            .background(Color.pink.opacity(0.6)) // Light pink background
            .cornerRadius(10)
            .shadow(color: Color.pink.opacity(0.5), radius: 5, x: 0, y: 2)
    }
}

extension View {
    
    func roomiesTextFieldStyle() -> some View {
        
        self.modifier(RoomiesTextFieldStyle())
    }
}
