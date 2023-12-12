//
//  TabBarView.swift
//  Roomies
//
//  Created by Akhi Nair on 11/29/23.
//

//enum Tab: String, CaseIterable {
//
//      case message
//      case plus
//      case dollarsign
//      case person
//      case people
//      case createGroup
//      
//  
//      
//  var title: String {
//    switch self {
//      case .message:
//        return "Groups"
//      case .plus:
//        return "Request"
//      case.person:
//        return "Me"
//      case .createGroup:
//        return "Create Group"
//      case .dollarsign:
//        return "Get Money"
//      case .people:
//        return "Pending"
//    }
//  }
//  
//  var imageName: String {
//    switch self {
//      case .message:
//        return "message"
//      case .plus:
//        return "plus.circle"
//      case .person:
//        return "person"
//      case .dollarsign:
//        return "dollarsign.square"
//      case .createGroup:
//        return "createGroup.image"
//      case .people:
//        return "person.2"
//    }
//  }
//  
//  @ViewBuilder
//  var associatedView: some View {
//      switch self {
//      case .message:
//          Home(path: )
//      case .plus:
//          CreateNewPage()
//      case .person:
//          Settings()
//      case .dollarsign:
//          Settings()
//      case .createGroup:
//          CreateNewPage()
//      case .people:
//          PendingRequests()
//      }
//  }
//}
//
//import SwiftUI
//
//struct TabBarView: View {
//  @State var isPresentedCreateNewView = false
//  // Function to get the image name based on the selected tab
//
//  var body: some View {
//
//    VStack {
//      HStack {
//        ForEach([Tab.message, Tab.people, Tab.plus, Tab.dollarsign, Tab.person], id: \.rawValue) { tab in
//          Spacer()
//          NavigationLink {
//            tab.associatedView
//                  } label: {
//                    VStack {
//                      Image(systemName: tab.imageName)
//                      .foregroundColor(.red)
//                      .font(.system(size: 22))
//                      Text(tab.title)  // Assuming each tab has a title property to display
//                        .font(.system(size: 10)) // You can customize this font size
//                        .foregroundColor(.red)
//                    }
//                  }
//          Spacer()
//        }
//      }
//      .frame(width: nil, height: 60)
//      .background(.thinMaterial)
//      .cornerRadius(10)
//      .padding()
//    }
//  }
//}
//
//
//struct TabBarView_Previews: PreviewProvider {
//    static var previews: some View {
//      TabBarView()
//    }
//}
