import SwiftUI

struct GroupChatView: View {
    var group: Group
    
    init(group: Group) {
        self.group = group
        
        // Set the navigation bar title
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.black]
        UINavigationBar.appearance().tintColor = .black
        
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.black]
        UINavigationBar.appearance().backgroundColor = .white
    }

    var body: some View {
        VStack(alignment: .leading) {
            Text("Group Name: \(group.groupName)")
                .font(.headline)
                .padding(.bottom, 8)
            
            Text("Admin: \(group.adminID)")
                .font(.subheadline)
                .padding(.bottom, 8)
            
            Text("Members:")
                .font(.subheadline)
                .padding(.bottom, 4)
            
            // Display the list of members
            List(group.members.keys.sorted(), id: \.self) { memberID in
                if let memberInfo = group.members[memberID],
                   let memberName = memberInfo["Name"],
                   let memberRole = memberInfo["Role"] {
                    Text("\(memberName) - \(memberRole)")
                        .font(.caption)
                }
            }
            
            // Add more details as needed, e.g., groupImg, groupTotalsUnconfirmed, groupTotalsConfirmed, debtRequests, etc.
            
            Spacer()
        }
        .padding()
        .navigationBarTitle(group.groupName, displayMode: .inline)
    }
}

