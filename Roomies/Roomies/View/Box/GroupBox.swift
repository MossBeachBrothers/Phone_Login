import SwiftUI
import Firebase
import FirebaseFirestore

struct GroupBox: View {
    @EnvironmentObject var viewModel: AuthViewModel
    var groupMetaData: RoomiesGroupMetaData
    @State private var group: RoomiesGroup?
    @State private var membersString: String = ""

    var body: some View {
        HStack {
            PhotoCircle()
            VStack(alignment: .leading, spacing: 5) {
                Text(group?.groupName ?? "Loading...")
                    .font(.headline)
                    .foregroundColor(.black)
                Text(membersString)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .lineLimit(1)
            }
            Spacer()
        }
        .padding()
        .background(Color.white)
        .cornerRadius(15)
        .shadow(radius: 5)
        .overlay(
            RoundedRectangle(cornerRadius: 15)
                .stroke(Color.pink, lineWidth: 2)
        )
        .onAppear {
            fetchGroupDetails()
        }
    }

    private func fetchGroupDetails() {
        viewModel.fetchGroupByID(groupID: groupMetaData.groupID) { result in
            switch result {
            case .success(let fetchedGroup):
                self.group = fetchedGroup
                self.membersString = fetchedGroup.members.keys.joined(separator: ", ")
            case .failure(let error):
                print("Error fetching group: \(error)")
                // Handle the error appropriately
            }
        }
    }

    func moveToGroupChat() {
        // Navigation logic to group chat
    }
}

struct GroupBox_Previews: PreviewProvider {
    static var previews: some View {
        let dummyMetaData = RoomiesGroupMetaData(groupID: "dummyID", groupName: "Dummy Group", groupImg: false, members: [:], timestamp: Date())
        GroupBox(groupMetaData: dummyMetaData)
            .environmentObject(AuthViewModel())
    }
}
