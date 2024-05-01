//
//  CreateNewScrollView.swift
//  Roomies
//
//  Created by Akhi Nair on 12/4/23.
//

import SwiftUI

struct CreateNewScrollView: View {
    @EnvironmentObject var navigationStateModel: NavigationStateModel
    @State private var createNewOptions: [String] = ["New Group", "New Request", "New Tally Request", "New Friend"]
    var body: some View {
        List {
          ForEach(createNewOptions, id: \.self) { option in
            NavigationLink("\(option)",value: CreateNewLink.linkType(for: option))
          }
        }
        .navigationDestination(for: CreateNewLink.self){ screen in
          switch screen {
            case .createNewGroup: NewGroupView()
            case .createNewFriend: FindFriendsView()
            case .createNewRequest: NewRequestView()
            default:
              EmptyView()       
          }
        }
    }
}

struct CreateNewScrollView_Previews: PreviewProvider {
    static var previews: some View {
        CreateNewScrollView()
    }
}
