//
//  GroupBox.swift
//  Roomies
//
//  Created by Akhi Nair on 9/3/23.
//

import SwiftUI
import Firebase
import FirebaseCore
import FirebaseFirestore

struct GroupPreviewBox: View {
      
  @State var group : Group
  @State var membersString : String
  
  init(group : Group) {
    
    self.group = group
    //self.membersString = Array(group.members.keys).joined(separator: ", ")
    
    var membersString : String {
      var result = ""
            
      for (_, data) in group.members {
                if let name = data["Name"] {
                    result += (result.isEmpty ? "" : ", ") + name
                }
            }
            
            return result
        }
    
    self.membersString = membersString
    
    print(self.membersString)
  }

  var body : some View{
      
    Button(action: {/* */}) {
      
      VStack(alignment:.leading){
        
        Text(group.groupName)
            .font(GlobalFonts.titleFont)
            .foregroundColor(.white)
            .padding()
        

        Text(membersString)
          .font(GlobalFonts.titleFont)
          .foregroundColor(.white)
          .padding()
      }
    }
    .buttonStyle(RoomiesButtonStyle(color: Color.pink, pad_top: 0,
                    pad_bottom : 0, pad_left : 0, pad_right : 0))
  }

}



struct GroupPreviewBox_Previews: PreviewProvider {
    
  static var previews: some View {
    
    Home()
    //GroupBox()
    //ContentView().environmentObject(AuthViewModel())
  }
}
