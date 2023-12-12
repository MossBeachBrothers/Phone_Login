//
//  GroupSettingsPage.swift
//  Roomies
//
//  Created by Akhi Nair on 12/3/23.
//

import SwiftUI

struct GroupSettingsPage: View {
  @EnvironmentObject var navigationStateModel: NavigationStateModel
  @State var group: RoomiesGroup
  
  init(group: RoomiesGroup) {
      self._group = State(initialValue: group)
  }
    var body: some View {
        EmptyView()
          .navigationBarBackButtonHidden()
          .navigationBarItems(leading: HStack {
              // GroupImage() // Custom view for the group image
              PhotoCircle()
              VStack(alignment: .leading) {
                  Text(group.groupName) // Group Title
                      .font(.headline)
                  Text("Settings") // Users List
                      .font(.subheadline)
                      .lineLimit(1)
              }
          })
          .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
              BackButton()
            }
          }
    }
  
    
    
  
}

struct GroupSettingsPage_Previews: PreviewProvider {
    static var previews: some View {
        NavView()
    }
}
