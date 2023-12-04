//
//  LogoBox.swift
//  Roomies
//
//  Created by Akhi Nair on 9/4/23.
//

import SwiftUI


struct LogoBox : View{
  
  @State var subtitle : Bool = true
    
    var body: some View{
        
        VStack(alignment: .leading, spacing: 5) { // Increased spacing between title texts
            
            Text("Roomies")
                .foregroundColor(.pink)
                .font(.title)
                .fontWeight(.semibold)
            
          if subtitle{
            Text("Share Group Expenses")
                .foregroundColor(.gray)
                .font(.title)
                .fontWeight(.semibold)
          }
            
        }
    }
}
