//
//  MessageBox.swift
//  Roomies
//
//  Created by Akhi Nair on 12/12/23.
//

import SwiftUI

import SwiftUI

struct MessageBox: View {
    @State var messageText: String
    @State var timestamp: String
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(messageText)
                    .padding()
                Spacer() // Pushes the timestamp to the right
                Text(timestamp)
                    .font(.caption)
                    .foregroundColor(.gray)
                    .padding([.top, .trailing])
            }
            .padding()
            .background(Color.white)
            .cornerRadius(10)
            .shadow(color: .gray, radius: 5, x: 0, y: 0)
        }
        .padding(10)
        .background(Color.gray.opacity(0.2))
        .cornerRadius(12)
        .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.black, lineWidth: 5))
    }
}

struct MessageBox_Previews: PreviewProvider {
    static var previews: some View {
      let text: String = "lakjsdflkajsdflkajsdflkjasdflkjasdlkjfda"
      let time: String = "12:30 PM"
      MessageBox(messageText: text, timestamp: time)
    }
}
