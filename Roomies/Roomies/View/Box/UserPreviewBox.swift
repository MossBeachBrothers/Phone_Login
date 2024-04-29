import Foundation
import SwiftUI


struct UserPreviewBox: View {
    @State var userID: String
    @State var userName: String
    @State var timestamp: String
    @State private var selected: Bool = false
    @State private var scale: CGFloat = 1.0

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                // Clickable PhotoCircle
                Group {
                    if selected {
                        // Display a circle with a checkmark when selected
                        Image(systemName: "checkmark.circle.fill")
                        .scaleEffect(2.0)
                    } else {
                        // Regular PhotoCircle
                        PhotoCircle()
                    }
                }

                Text(userName)
                    .padding()
                Spacer() // Pushes the timestamp to the right
                Text(timestamp)
                    .font(.caption)
                    .foregroundColor(.gray)
                    .padding([.top, .trailing])
            }
            .padding()
            .background(Color.white)
            .cornerRadius(10)
            .shadow(color: .gray, radius: 5, x: 0, y: 0)
            .scaleEffect(scale)
            .onTapGesture {
                self.selected.toggle()
                withAnimation(.easeOut(duration: 0.1)) {
                  self.scale = 1.05
                }
                withAnimation(.easeIn(duration: 0.1).delay(0.1)) {
                    self.scale = 1.0
                }
            }
        }
        .padding(10)
        .background(Color.gray.opacity(0.2))
        .cornerRadius(12)
        .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.black, lineWidth: 5))
    }
}

struct UserPreviewBox_Previews: PreviewProvider {
    static var previews: some View {
      UserPreviewBox(userID: "Iaklsdjf", userName: "Mixie", timestamp: "10:30 AM")
    }
}

