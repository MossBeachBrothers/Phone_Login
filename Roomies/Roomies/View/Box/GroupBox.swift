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
      
  @State var group: RoomiesGroup
      @State var membersString: String
      
      init(group: RoomiesGroup) {
          self.group = group
          self.membersString = group.members.keys.joined(separator: ", ")
      }


  var body : some View{
      

    HStack{
      PhotoCircle()
      VStack(alignment: .leading, spacing: 5) {
          Text(group.groupName)
              .font(.headline)
              .foregroundColor(.black)
          Text(membersString)
              .font(.subheadline)
              .foregroundColor(.gray)
              .lineLimit(1)
      }
      Spacer()
    }
    .padding()
            .background(Color.white)
            .cornerRadius(15)
            .shadow(radius: 5)
            .overlay(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(Color.pink, lineWidth: 2)
    )

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

