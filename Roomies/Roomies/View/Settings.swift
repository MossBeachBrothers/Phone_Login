//
//  Settings.swift
//  Roomies
//
//  Created by Akhi Nair on 10/26/23.
//

import SwiftUI

struct Settings: View {
  @EnvironmentObject var authViewModel: AuthViewModel
  
  var body: some View {
    Button(action: {
      authViewModel.logOut()
    }, label: {
      Text("Log Out")
    })
  }
}
