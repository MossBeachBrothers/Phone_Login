//
//  TabBarView.swift
//  Roomies
//
//  Created by Akhi Nair on 11/29/23.
//

enum Tab: String, CaseIterable {

      case message
      case plus
      case dollarsign
      case person
      case people
      case createGroup
      
  
      
  var title: String {
    switch self {
      case .message:
        return "Groups"
      case .plus:
        return "Request"
      case.person:
        return "Me"
      case .createGroup:
        return "Create Group"
      case .dollarsign:
        return "Get Money"
      case .people:
        return "Pending"
    }
  }
}





import SwiftUI

struct TabBarView: View {
    @Binding var selectedTab: Tab

    // Function to get the image name based on the selected tab
    private func imageName(for tab: Tab) -> String {
        if tab == .plus {
            return tab.rawValue + ".circle" // For "plus", always use the circle image
        }
        
      if tab == .people {
        return "person.2"
      }
      if tab == .dollarsign {
        return tab.rawValue + ".square"
      }
        return selectedTab == tab ? tab.rawValue + ".fill" : tab.rawValue // Use filled or unfilled image based on whether the tab is selected
    }
    var body: some View {
      VStack {
        HStack {
          ForEach([Tab.message, Tab.people, Tab.plus, Tab.dollarsign, Tab.person], id: \.rawValue) { tab in
            Spacer()
            VStack {
              let imgName = imageName(for: tab)
              
              Image(systemName: imgName)
                  .scaleEffect(selectedTab == tab ? 1.25 : 1.0)
                  .foregroundColor(selectedTab == tab ? .red : .gray)
                  .font(.system(size: 22))
                  .onTapGesture {
                      withAnimation(.easeIn(duration: 0.1)) {
                          selectedTab = tab
                      }
                  }
              Text(tab.title)  // Assuming each tab has a title property to display
                .font(.system(size: 10)) // You can customize this font size
                .foregroundColor(selectedTab == tab ? .red : .gray)
                }
              Spacer()
              
            }
            .frame(width: nil, height: 60)
            .background(.thinMaterial)
            .cornerRadius(10)
            .padding()
          }
        }
      }
    }



struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
      TabBarView(selectedTab: )
    }
}
