import SwiftUI

struct GroupChatView: View {
  @State var group : Group
  @Binding var path: NavigationPath
  
  @State var debtRequests: [DebtRequest] = [
      DebtRequest(
          senderUserIDs: ["user123"],
          groupID: "group456",
          receiverUserIDs: ["user789", "user456"],
          amount: 50.0,
          requestDescription: "Dinner at Joe's"
      ),
      DebtRequest(
          senderUserIDs: ["user234"],
          groupID: "group456",
          receiverUserIDs: ["user123", "user789"],
          amount: 75.0,
          requestDescription: "Bowling Night"
      ),
      DebtRequest(
          senderUserIDs: ["user345"],
          groupID: "group456",
          receiverUserIDs: ["user234", "user678"],
          amount: 100.0,
          requestDescription: "Concert Tickets"
      ),
      DebtRequest(
          senderUserIDs: ["user456"],
          groupID: "group456",
          receiverUserIDs: ["user345", "user123"],
          amount: 20.0,
          requestDescription: "Taxi Fare"
      ),
      DebtRequest(
          senderUserIDs: ["user567"],
          groupID: "group456",
          receiverUserIDs: ["user456", "user234"],
          amount: 150.0,
          requestDescription: "Gift for Friend"
      )
  ]
  
  init(group: Group, path: Binding<NavigationPath>) {
      self._group = State(initialValue: group)
      _path = path
  }

  var body : some View{
    HStack (spacing: 20){
      ProgressView()
      VStack (alignment: .leading){
        Text("\(group.groupName)")
          .font(.title).bold()
        Text("\(group.members.keys.joined(separator: ", "))")
          
      }
    }
    ShadowBox(content:
      ScrollView{
        VStack
        {
          ForEach(self.debtRequests, id: \.self) { debtRequest in
            
            NavigationLink(value: debtRequest) {
              RequestBox(debtRequest:debtRequest)
            }
            
          }
        }
      }
    ,
              width: 400,
              height: 400)
    .navigationBarBackButtonHidden()
    .toolbar {
      ToolbarItem(placement: .navigationBarLeading) {
        Button(action: {
          path.removeLast()
        }, label: {
          Image(systemName: "arrow.backward")
        })
        .foregroundColor(Color.pink)
      }
      ToolbarItem(placement: .navigationBarTrailing){
        NavigationLink(destination: GroupSettingsPage(group:group, path: $path)) {
          Image(systemName: "line.3.horizontal")
            .foregroundColor(Color.pink)
        }
        
      }
    }
    }
  
    
  }

  
  struct GroupChatView_Previews: PreviewProvider {
      
    static var previews: some View {
      // You should create a Group instance here
        ContentView().environmentObject(AuthViewModel())
      }
      //ContentView().environmentObject(AuthViewModel())
    }

  



