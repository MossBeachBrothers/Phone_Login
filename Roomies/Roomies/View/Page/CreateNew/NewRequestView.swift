//
//  NewRequestView.swift
//  Roomies
//
//  Created by Akhi Nair on 5/1/24.
//

import SwiftUI

struct NewRequestView: View {
  @EnvironmentObject var authViewModel: AuthViewModel
  @State private var amount: String = ""
  @State private var description: String = ""
  @State private var requestMembers: [String] = ["Userx", "User Y"]
  @State private var expanded: Bool = false
  var body: some View {
    VStack {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: expanded ? 20 : -30) {
                ForEach(requestMembers, id: \.self) { member in
                  CircleImage(member: member, expanded: $expanded)
                }
                
                // Plus icon at the end of the circle
                Button(action: {
                    // Add new member dynamically
                    self.requestMembers.append("NewMember")
                }) {
                    Image(systemName: "plus.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 40)
                        .background(Color.white)
                        .clipShape(Circle())
                        .foregroundColor(RoomiesStyle().color)
                        
                        
                }
            }
            .padding(.horizontal, expanded ? 20 : 10)
            .frame(height: 100)
      }
      .frame(height: 120) // Set the height of the ScrollView
            Spacer()
            HStack {
                Text("$")
                    .font(.title)
                TextField("Amount", text: $amount)
                    .font(.title)
                    .keyboardType(.decimalPad)
            }
            .padding()
            .padding(.leading, 100)
            Spacer()
            TextField("Description", text: $description)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(5.0)
                .padding(.horizontal)
            
            HStack {
                Button(action: requestMoney) {
                    Text("Request")
                        .foregroundColor(.white)
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                
                Button(action: requestMoney) {
                    Text("Pay")
                        .foregroundColor(.white)
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .padding()
                        .background(Color.green)
                        .cornerRadius(10)
                }
            }
            .padding()
        }
        .padding()
    }
    
  func requestMoney() {
      guard let amountDouble = Double(amount) else {
          print("Invalid amount")
          return
      }
      var senderIDs: [String] = []  // This could be fetched from a logged-in user session or similar.

      if let currentUser = authViewModel.currentUser {
          senderIDs.append(currentUser.uid)
      }

      let receiverIDs = requestMembers.filter { $0 != "user1" }  // Assuming 'user1' is the sender.
      let groupID = "group123"  // This should be dynamically determined based on the context.

      let newDebtRequest = DebtRequest(
          senderUserIDs: senderIDs,
          groupID: groupID,
          receiverUserIDs: receiverIDs,
          amount: amountDouble,
          requestDescription: description,
          amountPerReceiver: receiverIDs.reduce(into: [:]) { $0[$1] = Int(amountDouble) / receiverIDs.count },
          amountPerSender: [senderIDs.first!: Int(amountDouble)],
          timestamp: Date().description
      )

      // Assuming `AuthViewModel` has a method `addDebtRequest` which takes a `DebtRequest` and a completion handler
    authViewModel.addDebtRequest(requestData: newDebtRequest.toFirestoreData()) { result in
          switch result {
          case .success():
              print("Request successfully added.")
          case .failure(let error):
              print("Error adding request: \(error.localizedDescription)")
          }
      }
  }

  
}

struct CircleImage: View {
    var member: String
    @Binding var expanded: Bool
    var body: some View {
      VStack {
        Image(systemName: "circle") // Ensure you have proper image handling logic
            .resizable()
            .scaledToFit()
            .frame(width: 80, height: 80)
            .background(Color.white)
            .clipShape(Circle())
            .overlay(Circle().stroke(RoomiesStyle().color, lineWidth: 2))
            .shadow(radius: 5)
            .onTapGesture {
                withAnimation {
                    self.expanded.toggle()
                }
            }
      }

    }
}
      


struct NewRequestView_Previews: PreviewProvider {
    static var previews: some View {
        NewRequestView()
    }
}