import SwiftUI
import Firebase
import FirebaseCore
import FirebaseFirestore

struct RequestBox: View {
    
    @State private var debtRequest: DebtRequest?
    
    struct GlobalFonts {
        static let titleFont: Font = .system(size: 14)
        static let valueFont: Font = .system(size: 12)
    }
  
    let pinkColor = Color.pink
    let outlineThickness: CGFloat = 5
  
    init(debtRequest: DebtRequest) {
        _debtRequest = State(wrappedValue: debtRequest)
    }
  
    init() {
        _debtRequest = State(initialValue: nil)
    }

    var body: some View {
            VStack(alignment: .leading) {
              if let debtRequest = debtRequest {
                HStack {
                    VStack(alignment: .leading) {
                        Text(String(format: "$%.2f", debtRequest.amount))
                            .font(.system(size: 48).bold())
                            .foregroundColor(RoomiesStyle().color)
                        
                        HStack {
                            Spacer().frame(width: 25)
                            Text(debtRequest.requestDescription)
                                .font(GlobalFonts.titleFont.bold())
                                .foregroundColor(Color.black)
                        }
                    }
                    
                    Spacer()
                    
                    VStack {
                        HStack {
                            Button(action: {
                                // Add action for the first button
                            }) {
                                Image(systemName: "x.circle")
                                    .resizable()
                                    .frame(width: 40, height: 40)
                                    .foregroundColor(Color.red)
                                    .background(Circle().foregroundColor(Color.white))
                            }
                            
                            Button(action: {
                                // Add action for the second button
                            }) {
                                Image(systemName: "checkmark.circle")
                                    .resizable()
                                    .frame(width: 40, height: 40)
                                    .foregroundColor(Color.green)
                                    .background(Circle().foregroundColor(Color.white))
                            }
                        }
                    }
                    .padding(.trailing, 20)
                }
                .padding(.top)
                .padding(.leading)
                .background(Color.white)
                .cornerRadius(10)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(debtRequest.senderUserIDs, id: \.self) { userID in
                            MemberIconView(userID: userID, isSender: true, value: debtRequest.amountPerSender[userID, default: 0])
                        }
                        
                        ForEach(debtRequest.receiverUserIDs, id: \.self) { userID in
                            MemberIconView(userID: userID, isSender: false, value: debtRequest.amountPerReceiver[userID, default: 0])
                        }
                    }
                    .padding()
                }
                Spacer()
            } else {
                VStack {
                    Text("Hello World")
                }
            }
            }
            .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.black, lineWidth: outlineThickness))
            .background(Color.white)
            .cornerRadius(8)
        
    }
    
    func MoveToGroupChat() {
        // Navigation logic here
    }
}

struct MemberIconView: View {
    var userID: String
    var isSender: Bool
    var value: Int
    let pinkColor = Color.pink
    let outlineThickness: CGFloat = 2
     
    var body: some View {
        VStack {
            Text("R")
                .font(GlobalFonts.titleFont.bold())
                .foregroundColor(Color.black)
                .frame(width: 25, height: 25)
                .background(Circle().foregroundColor(.white))
          
            Text("\(isSender ? "+" : "-")\(value)")
                .foregroundColor(isSender ? Color.green : Color.red)
                .font(GlobalFonts.titleFont.bold())
        }
        .padding()
        .background(Color.white)
        .cornerRadius(15)
        .shadow(radius: 5)
        .overlay(RoundedRectangle(cornerRadius: 15).stroke(Color.black, lineWidth: 2))
    }
}

struct RequestBox_Previews: PreviewProvider {
    static var previews: some View {
        var debtRequest = DebtRequest(
            senderUserIDs: ["user345"],
            groupID: "group456",
            receiverUserIDs: ["user234", "user123"],
            amount: 110.0,
            requestDescription: "House Party",
            amountPerReceiver: ["user234": 55, "user123": 55],
            amountPerSender: ["user345": 110]
        )
      RequestBox(debtRequest: debtRequest)
    }
}
