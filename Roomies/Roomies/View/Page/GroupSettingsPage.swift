//
//  GroupSettingsPage.swift
//  Roomies
//
//  Created by Akhi Nair on 12/3/23.
//

import SwiftUI

struct GroupSettingsPage: View {
  @State var group: Group
  @Binding var path: NavigationPath
  
  init(group: Group, path: Binding<NavigationPath>) {
      self._group = State(initialValue: group)
      _path = path
  }
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
          .navigationBarBackButtonHidden()
          .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
              Button(action: {
                path.removeLast()
              }, label: {
                Image(systemName: "arrow.backward")
              })
              .foregroundColor(Color.pink)
            }
          }
    }
    
    
  
}

struct GroupSettingsPage_Previews: PreviewProvider {
    static var previews: some View {
        NavView()
    }
}
