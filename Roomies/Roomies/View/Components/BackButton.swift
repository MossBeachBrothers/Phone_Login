//
//  BackButton.swift
//  Roomies
//
//  Created by Akhi Nair on 12/3/23.
//

import SwiftUI

struct BackButton: View {
  @EnvironmentObject var navigationStateModel: NavigationStateModel
    var body: some View {
      Button {
        navigationStateModel.goBack()
      } label : {
        Image(systemName: "arrow.backward")
      }
      .foregroundColor(Color.pink)
    }
}

struct BackButton_Previews: PreviewProvider {
    static var previews: some View {
        BackButton()
    }
}
