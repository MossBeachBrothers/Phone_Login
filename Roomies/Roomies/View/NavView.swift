//
//  NavView.swift
//  Roomies
//
//  Created by Akhi Nair on 10/26/23.
//


import SwiftUI

struct NavView: View {
    @State private var selectedTab: Tab = .message // State to manage the selected tab
    @State private var hideNavBar: Bool = false
    @State private var buttonAnimation = false
    
    init() {
        UITabBar.appearance().isHidden = false  // Hiding the default UITabBar
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                TabView(selection: $selectedTab) {
                    Settings()
                        .tag(Tab.person)
                    Home()
                        .tag(Tab.message)
                    CreateNewPage(selectedTab: $selectedTab)
                        .tag(Tab.plus)
                    RecentRequests()
                    .tag(Tab.dollarsign)
                    PendingRequests()
                    .tag(Tab.people)
                }
                .padding(.bottom, hideNavBar ? 0 : 50)
                .padding(.top, 0)
                .onChange(of: selectedTab) { newValue in
                    hideNavBar = newValue == .plus // Add conditions for other tabs as needed
                }
                
                if !hideNavBar {
                    VStack {
                        Spacer()  // Pushes the next view (CustomTabBar) to the bottom
                        CustomTabBar(selectedTab: $selectedTab)
                            .padding(.top, 50) // Custom tab bar for navigation
                    }
                }
            }
            .ignoresSafeArea(.keyboard, edges: .bottom)  // Ensures keyboard does not overlay content
        }
    }
}

// Preview for the SwiftUI canvas
struct NavView_Previews: PreviewProvider {
    static var previews: some View {
        NavView()
    }
}

