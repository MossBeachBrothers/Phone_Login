//
//  NavigationStateModel.swift
//  Roomies
//
//  Created by Akhi Nair on 12/11/23.
//

import Foundation
import SwiftUI


class NavigationStateModel : ObservableObject {
    @Published var navPath : NavigationPath
    
    init() {
      self.navPath = NavigationPath()
    }
  
    func goBack() {
      self.navPath.removeLast()
    }
    
}



