import SwiftUI

struct GroupChatView: View {
    @EnvironmentObject var navigationStateModel: NavigationStateModel
    @State var group: RoomiesGroup
    private var usersString: String {
        group.members.keys.joined(separator: ", ")
    }


    init(group: RoomiesGroup) {
        self._group = State(initialValue: group)
    }

  var body: some View {
    TabView {
      ForEach([Tab.groupFeed, Tab.groupTotals], id: \.rawValue) { groupTab in
        ShadowBox(content:
            VStack {
                switch groupTab {
                case .groupFeed:
                    GroupFeedView()
                case .groupTotals:
                    GroupTotalsView()
                  default:
                    EmptyView()
                }
            }
            ,
            width: 400,
            height: 600
        )
        .tabItem {
            Label(groupTab.title, systemImage: groupTab.imageName)
        }
      }
      }
      .navigationBarItems(leading: HStack {
        NavigationLink(value: GroupLink.chatSettings(group)) {
          PhotoCircle()
          VStack(alignment: .leading) {
              Text(group.groupName) // Group Title
                  .font(.headline)
              Text(usersString) // Users List
                  .font(.subheadline)
                  .lineLimit(1)
          }
          .foregroundColor(Color.black)
        }
        
      })
      .font(.title.bold())
      .navigationBarBackButtonHidden()
      .toolbar {
          ToolbarItem(placement: .navigationBarLeading) {
              BackButton()
          }
          ToolbarItem(placement: .navigationBarTrailing) {

          }
      }
      .onAppear() {
        UITabBar.appearance().barTintColor = UIColor(.pink)
        UITabBar.appearance().backgroundColor = .white
        UITabBar.appearance().unselectedItemTintColor = .darkGray
        
      }

    }
  /*    TabView {
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
   }
 }*/

    struct GroupChatView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView().environmentObject(AuthViewModel())
        }
    }
}
