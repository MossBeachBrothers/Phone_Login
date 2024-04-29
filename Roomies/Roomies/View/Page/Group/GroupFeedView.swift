//
//  GroupFeedView.swift
//  Roomies
//
//  Created by Akhi Nair on 12/11/23.
//

import SwiftUI

struct GroupFeedView: View {
  @State var group: RoomiesGroup?
  @State var debtRequests: [DebtRequest] = [
      DebtRequest(
          senderUserIDs: ["user123"],
          groupID: "group456",
          receiverUserIDs: ["user789", "user456"],
          amount: 50.0,
          requestDescription: "Dinner at Joe's",
          amountPerReceiver: ["user789": 25, "user456": 25],
          amountPerSender: ["user123": 50]
      ),
      DebtRequest(
          senderUserIDs: ["user234"],
          groupID: "group456",
          receiverUserIDs: ["user123", "user789"],
          amount: 75.0,
          requestDescription: "Bowling Night",
          amountPerReceiver: ["user123": 37, "user789": 38],
          amountPerSender: ["user234": 75]
      ),
      DebtRequest(
          senderUserIDs: ["user345"],
          groupID: "group456",
          receiverUserIDs: ["user234", "user678"],
          amount: 100.0,
          requestDescription: "Concert Tickets",
          amountPerReceiver: ["user234": 50, "user678": 50],
          amountPerSender: ["user345": 100]
      ),
      DebtRequest(
          senderUserIDs: ["user456"],
          groupID: "group456",
          receiverUserIDs: ["user345", "user123"],
          amount: 20.0,
          requestDescription: "Taxi Fare",
          amountPerReceiver: ["user345": 10, "user123": 10],
          amountPerSender: ["user456": 20]
      ),
      DebtRequest(
          senderUserIDs: ["user567"],
          groupID: "group456",
          receiverUserIDs: ["user456", "user234"],
          amount: 150.0,
          requestDescription: "Gift for Friend",
          amountPerReceiver: ["user456": 75, "user234": 75],
          amountPerSender: ["user567": 150]
      ),
      // Additional 5 dummy requests
      DebtRequest(
          senderUserIDs: ["user678"],
          groupID: "group456",
          receiverUserIDs: ["user123", "user345"],
          amount: 60.0,
          requestDescription: "Groceries",
          amountPerReceiver: ["user123": 30, "user345": 30],
          amountPerSender: ["user678": 60]
      ),
      DebtRequest(
          senderUserIDs: ["user789"],
          groupID: "group456",
          receiverUserIDs: ["user567", "user678"],
          amount: 40.0,
          requestDescription: "Movie Night",
          amountPerReceiver: ["user567": 20, "user678": 20],
          amountPerSender: ["user789": 40]
      ),
      DebtRequest(
          senderUserIDs: ["user123"],
          groupID: "group456",
          receiverUserIDs: ["user456", "user789"],
          amount: 30.0,
          requestDescription: "Lunch at Cafe",
          amountPerReceiver: ["user456": 15, "user789": 15],
          amountPerSender: ["user123": 30]
      ),
      DebtRequest(
          senderUserIDs: ["user234"],
          groupID: "group456",
          receiverUserIDs: ["user567", "user345"],
          amount: 85.0,
          requestDescription: "Birthday Party",
          amountPerReceiver: ["user567": 42, "user345": 43],
          amountPerSender: ["user234": 85]
      ),
      DebtRequest(
          senderUserIDs: ["user345"],
          groupID: "group456",
          receiverUserIDs: ["user234", "user123","user236", "user127"],
          amount: 110.0,
          requestDescription: "House Party",
          amountPerReceiver: ["user234": 55, "user123": 55,"user236": 55, "user127": 55],
          amountPerSender: ["user345": 220]
      )
  ]
    var body: some View {
        ScrollView {
            VStack {
                ForEach(self.debtRequests, id: \.self) { debtRequest in
                    Spacer()
                    NavigationLink(value: debtRequest) {
                        RequestBox(debtRequest: debtRequest)
                        .padding(.leading)
                        .padding(.trailing)
                    }
                    Spacer()
                }
            }
        }
    }
}

struct GroupFeedView_Previews: PreviewProvider {
    static var previews: some View {
        GroupFeedView()
    }
}
