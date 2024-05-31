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
              GroupFeedView(currentGroup: group)
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
            .labelStyle(RoomiesLabelStyle())
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
      .navigationBarItems(trailing: HStack {
        NavigationLink(value: HomeLink.newRequestPage){
          Image(systemName: Tab.plus.imageName)
            .resizable()
            .foregroundColor(RoomiesStyle().color)
            .frame(width: 45, height: 45)
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
      
      
    }
  
    
    struct GroupChatView_Previews: PreviewProvider {
      static var previews: some View {
        ContentView().environmentObject(AuthViewModel())
      }
    }
  }

