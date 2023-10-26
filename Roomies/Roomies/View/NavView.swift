//
//  NavView.swift
//  Roomies
//
//  Created by Akhi Nair on 10/26/23.
//


import SwiftUI

struct NavView: View {
    @State private var selectedTab: Tab = .house  // State to manage the selected tab
  
    init() {
        UITabBar.appearance().isHidden = true  // Hiding the default UITabBar
    }
  
    var body: some View {
        ZStack {
            // TabView to manage and display each tab’s content
            TabView(selection: $selectedTab) {
                // Specifying each tab and its associated content
                Home()
                    .padding(.bottom, 25)
                    .padding(.top, 25)// Add padding to prevent overlay with the CustomTabBar
                    .tag(Tab.house)
                // You can add more tabs here following the same pattern
                Settings()
                  .tag(Tab.gearshape)
                  .padding(.bottom, 25)
                  .padding(.top, 25)
              
                FriendsPage()
                  .tag(Tab.person)
                  .padding(.bottom, 25)
                  .padding(.top, 25)
              
                ActiveRequestsPage()
                .tag(Tab.message)
                .padding(.bottom, 25)
                .padding(.top, 25)
                  
            }
            
            VStack {
                Spacer()  // Pushes the next view (CustomTabBar) to the bottom
                CustomTabBar(selectedTab: $selectedTab)  // Custom tab bar for navigation
            }
        }
        .ignoresSafeArea(.keyboard, edges: .bottom)  // Ensures keyboard does not overlay content
    }
}

// Preview for the SwiftUI canvas
struct NavView_Previews: PreviewProvider {
    static var previews: some View {
        NavView()
    }
}

