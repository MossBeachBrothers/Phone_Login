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

struct RequestBox: View {
      
  @State private var debtRequest: DebtRequest

  init(debtRequest: DebtRequest) {
      _debtRequest = State(wrappedValue: debtRequest)
  }

  var body : some View{
      

      
      VStack(){
        
        Text("Request")
            .font(GlobalFonts.titleFont)
            .background(Color.pink)
            .foregroundColor(.black)
            .padding()
        

        Text("Members")
          .font(GlobalFonts.titleFont)
          .background(Color.pink)
          .foregroundColor(.black)
          .padding()
      }
      .background(Color.pink)

  }
  
  func MoveToGroupChat() -> Void{
    
    /*
     
     
     */
  }

}



