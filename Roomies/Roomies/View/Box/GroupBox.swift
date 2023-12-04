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

struct GroupBox: View {
      
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
      .background(Color.pink)

  }
  
  func MoveToGroupChat() -> Void{
    
    /*
     
     
     */
  }

}



struct GroupBox_Previews: PreviewProvider {
    
  static var previews: some View {
    // You should create a Group instance here
      ContentView().environmentObject(AuthViewModel())
    }
    //ContentView().environmentObject(AuthViewModel())
  }

