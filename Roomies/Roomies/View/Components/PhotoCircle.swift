//
//  PhotoCircle.swift
//  Roomies
//
//  Created by Akhi Nair on 12/4/23.
//

import SwiftUI

struct PhotoCircle: View {
    var body: some View {
      VStack {
        Image(systemName: "person.2.circle.fill")
          .font(GlobalFonts.titleFont.bold())
          .foregroundColor(Color.gray)
          
      }
    }
}

struct PhotoCircle_Previews: PreviewProvider {
    static var previews: some View {
        PhotoCircle()
    }
}
