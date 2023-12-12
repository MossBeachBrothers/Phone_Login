import SwiftUI
import Firebase
import FirebaseCore
import FirebaseFirestore

struct RequestBox: View {
    
    @State private var debtRequest: DebtRequest
    
    // Custom font setup, replace with your actual font names and sizes
    struct GlobalFonts {
        static let titleFont: Font = .system(size: 14)
        static let valueFont: Font = .system(size: 12)
    }
  
    let pinkColor = Color.pink
    let outlineThickness: CGFloat = 5
  
    init(debtRequest: DebtRequest) {
        _debtRequest = State(wrappedValue: debtRequest)
    }
    
    var body : some View {
        
        VStack(alignment: .leading) {
            
          HStack {
              VStack(alignment: .leading) { // Use leading alignment for VStack
                  Text(String(format: "$%.2f", debtRequest.amount))
                      .font(.system(size: 48).bold())
                      .foregroundColor(RoomiesStyle().color)
                  
                  // Add HStack with a Spacer to create indentation for the description
                  HStack {
                      Spacer() // This Spacer pushes the description to the right
                          .frame(width: 50) // Adjust the frame width to increase or decrease the indentation
                      
                      Text(debtRequest.requestDescription)
                          .font(GlobalFonts.titleFont.bold())
                          .foregroundColor(Color.gray)
                  }
              }
          }
          .padding()
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
            }
            Spacer()
        }
        .overlay(RoundedRectangle(cornerRadius: 8).stroke(pinkColor, lineWidth: outlineThickness))
        .background(Color.white)
        .cornerRadius(10)
        .padding()
    }
    
    func MoveToGroupChat() {
        // Navigation logic here
    }
}

// Represents each member's icon in the scrollable list
struct MemberIconView: View {
    var userID: String
    var isSender: Bool
    var value: Int
    let pinkColor = Color.pink
    let outlineThickness: CGFloat = 2
     
    var body: some View {
        VStack {
            // Replace with actual logic to display user's avatar or initials
          Text("U")
            .font(GlobalFonts.titleFont.bold())
            .foregroundColor(pinkColor)
            .frame(width: 50, height: 50) // Adjust size as needed
            .background(Color.white)
          
          Text("\(isSender ? "+" : "-")\(value)")
            .foregroundColor(isSender ? Color.green : Color.red)
            .font(GlobalFonts.titleFont.bold()) // Use the preferred font
        }
        .padding(5)
        .background(Color.white)
        .cornerRadius(8)
        .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: outlineThickness))
        .padding(.horizontal, 4)
    }
}
