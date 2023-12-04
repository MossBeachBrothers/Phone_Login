import SwiftUI

struct NavView: View {
  @State private var path = NavigationPath()
  @State private var selectedTab: Tab = .message
  var body: some View {
    TabView {
      ForEach([Tab.message, Tab.people, Tab.person], id:
                \.rawValue){ tab in
        NavigationStack (path: $path) {
          Text("\(path.count)")
          VStack {
            switch tab {
              case .message:
                Home(path: $path)
              case .plus:
                CreateNewPage(path: $path)
              case .person:
                  Settings()
              case .dollarsign:
                  Settings()
              case .createGroup:
                  ProgressView()
              case .people:
                ProgressView()
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
