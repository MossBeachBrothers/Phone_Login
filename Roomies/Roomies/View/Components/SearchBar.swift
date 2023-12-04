//
//  SearchBar.swift
//  Roomies
//
//  Created by Akhi Nair on 9/4/23.
//

import SwiftUI

struct SearchBar: View {
    
    @Binding var text: String 
    @Binding var isSearching: Bool
    @State var startingText: String
    var body: some View {
        
        HStack {
            
            TextField(startingText, text: $text)
                .padding(.leading, 24)
                .onChange(of: text) { newValue in
                    isSearching = !text.isEmpty
                }

            if isSearching {
                Button(action: {
                    text = ""
                    isSearching = false
                }) {
                    Image(systemName: "multiply.circle.fill")
                        .foregroundColor(.gray)
                }
                .padding(.trailing)
            }
        }
        .padding(.vertical)
        .background(Color.gray.opacity(0.1))
        .cornerRadius(10)
    }
}
