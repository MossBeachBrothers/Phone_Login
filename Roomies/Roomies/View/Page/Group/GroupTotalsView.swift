//
//  GroupTotalsView.swift
//  Roomies
//
//  Created by Akhi Nair on 12/11/23.
//

import SwiftUI

struct GroupTotalsView: View {
  @State var group: RoomiesGroup
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        .navigationBarBackButtonHidden(true)
        .toolbar {
          ToolbarItem(placement: .navigationBarLeading) {
              BackButton()
          }
        }
    }
    
}

struct GroupTotalsView_Previews: PreviewProvider {
    static var previews: some View {
      ContentView()
    }
}
