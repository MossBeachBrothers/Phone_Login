import SwiftUI

struct NavView: View {
  @EnvironmentObject var navigationStateModel: NavigationStateModel
  @State private var selectedTab: Tab = .message
  var body: some View {
    TabView {
      ForEach([Tab.message, Tab.people, Tab.person], id:
                \.rawValue){ tab in
        VStack {
          Text("\(navigationStateModel.navPath.count)")
          VStack {
            switch tab {
              case .message:
                Home()
              case .person:
                  Settings()
              case .people:
                RecentRequests()
              default:
                ProgressView()
              }
            }
        }
        
        .tabItem {
          Label(tab.title, systemImage: tab.imageName)
        }
        .foregroundColor(Color.gray)
      }
    }
    .onAppear() {
      UITabBar.appearance().barTintColor = UIColor(.pink)
      UITabBar.appearance().backgroundColor = .white
      UITabBar.appearance().unselectedItemTintColor = .darkGray
      
    }
    
  }
}

/*
 TabView {
    ForEach([Tab.
 
 
 }
 
 */

extension NavView {
  
}

// Preview for the SwiftUI canvas
struct NavView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        .environmentObject(AuthViewModel())
    }
}
