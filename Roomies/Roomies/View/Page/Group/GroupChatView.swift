import SwiftUI

struct GroupChatView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @EnvironmentObject var navigationStateModel: NavigationStateModel
    @State private var showRequestForm = false
    @State var group: RoomiesGroup?
    @State var groupMetaData: RoomiesGroupMetaData
    @State private var message = ""
    
    

      init(groupData: RoomiesGroupMetaData) {
        self.groupMetaData = groupData

      }

    var body: some View {
        VStack {
          if let group {
            Spacer()

            ShadowBox(content: VStack {
                GroupFeedView()
            }, width: 350, height: 650)

            HStack {
                CustomTextField(hint: "Chat to Roomies", text: $message)
                    .padding(.trailing)

                Button(action: {
//                    print("Value before click: \(showRequestForm)")
//                    showRequestForm = true
//                    print("Value after click: \(showRequestForm)")
                  authViewModel.generateAndAddDummyUsers()
                }, label: {
                    Image(systemName: "plus.circle")
                        .foregroundColor(.black)
                        .imageScale(.large)
                        .scaleEffect(1.5)
                })
            }
            .padding(.top)
            .frame(width: 350, height: 50)
            .scaleEffect(0.8)
          } else {
            ProgressView()
          }
        }
        .navigationBarItems(leading: HStack {
          if let group {
            NavigationLink(value: GroupLink.chatSettings(group)) {
                PhotoCircle()
                VStack(alignment: .leading) {
                    Text(group.groupName) // Group Title
                        .font(.headline)
                    Text(group.members.keys.joined(separator: ", ")) // Users List
                        .font(.subheadline)
                        .lineLimit(1)
                }
                .foregroundColor(Color.black)
            }
          }
        })
        .font(.title.bold())
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                BackButton()
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink(value: GroupLink.chatTotalsView(group)) {
                    Image(systemName: "person.2.crop.square.stack")
                        .foregroundColor(.black)
                        .imageScale(.large)
                }
            }
        }
        .onAppear {
            UITabBar.appearance().barTintColor = UIColor(.pink)
            UITabBar.appearance().backgroundColor = .white
            UITabBar.appearance().unselectedItemTintColor = .darkGray
        }
        .sheet(isPresented: $showRequestForm) {
          CreateNewRequest(group: group)
              .presentationDetents([.height(700)])
        }
    }
    
    private func fetchGroup() {
            authViewModel.fetchGroupByID(groupID: groupMetaData.groupID) { result in
                switch result {
                case .success(let fetchedGroup):
                    self.group = fetchedGroup
                case .failure(let error):
                    print("Error fetching group: \(error)")
                    // Handle the error appropriately
                }
            }
  }
}

struct GroupChatView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(AuthViewModel())
    }
}
