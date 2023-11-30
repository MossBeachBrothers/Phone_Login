import SwiftUI

struct NavView: View {
  @State private var path = NavigationPath()
  @State private var selectedTab: Tab = .message
  @State var homeNavigationStack: [HomeNavigation] = []
  var body: some View {
    TabView {
      ForEach([Tab.message, Tab.people, Tab.dollarsign, Tab.person], id:
                \.rawValue){ tab in
        NavigationStack (path: $path) {
          VStack {
            switch tab {
              case .message:
                Home(path: $homeNavigationStack)
              case .plus:
                  CreateNewPage()
              case .person:
                  Settings()
              case .dollarsign:
                  Settings()
              case .createGroup:
                  CreateNewPage()
              case .people:
                  PendingRequests()
              }
            }
        }
        .tabItem {
          Label(tab.title, systemImage: tab.imageName)
        }
      }
    }
    .onAppear() {
      UITabBar.appearance().barTintColor = UIColor(.pink)
      UITabBar.appearance().backgroundColor = .white
      UITabBar.appearance().unselectedItemTintColor = .darkGray
    }
    
  }
}

extension NavView {
  
}

// Preview for the SwiftUI canvas
struct NavView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        .environmentObject(AuthViewModel())
    }
}
