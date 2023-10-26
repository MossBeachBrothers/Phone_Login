//
//  CustomTabBar.swift
//  Roomies
//
//  Created by Akhi Nair on 10/26/23.
//


import SwiftUI

enum Tab: String, CaseIterable {
    case house
    case person
    case plus
    case message
    case gearshape
}

struct CustomTabBar: View {
    @Binding var selectedTab: Tab
  
    // Function to get the image name based on the selected tab
    private func imageName(for tab: Tab) -> String {
        if tab == .plus {
            return tab.rawValue + ".circle" // For "plus", always use the circle image
        }
        return selectedTab == tab ? tab.rawValue + ".fill" : tab.rawValue // Use filled or unfilled image based on whether the tab is selected
    }
  
    var body: some View {
        VStack {
            HStack {
                ForEach(Tab.allCases, id: \.rawValue) { tab in
                    Spacer()
                    
                    // Get the image name using the defined function
                    let imgName = imageName(for: tab)
                    
                    Image(systemName: imgName)
                        .scaleEffect(selectedTab == tab ? 1.25 : 1.0)
                        .foregroundColor(selectedTab == tab ? .red : .gray)
                        .font(.system(size: 22))
                        .onTapGesture {
                            withAnimation(.easeIn(duration: 0.1)) {
                                selectedTab = tab
                            }
                        }
                    Spacer()
                }
            }
            .frame(width: nil, height: 60)
            .background(.thinMaterial)
            .cornerRadius(10)
            .padding()
        }
    }
}



struct CustomTabBar_Previews: PreviewProvider {
  static var previews: some View {
    CustomTabBar(selectedTab: .constant(.message))
  }
}
