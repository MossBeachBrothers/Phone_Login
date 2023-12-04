//
//  BackButton.swift
//  Roomies
//
//  Created by Akhi Nair on 12/3/23.
//

import SwiftUI

struct BackButton: View {
    var body: some View {
      VStack {
        Image(systemName: "chevron.left.circle")
          .font(GlobalFonts.titleFont.bold())
          .foregroundColor(Color.white)
          
      }
      .modifier(RoomiesVStackStyle())
      
      
    }
}

struct BackButton_Previews: PreviewProvider {
    static var previews: some View {
        BackButton()
    }
}
