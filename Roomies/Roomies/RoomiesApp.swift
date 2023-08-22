//
//  RoomiesApp.swift
//  Roomies
//
//  Created by Sid Nair on 8/18/23.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    return true
  }
    //MARK: Phone Auth Intialize Remote Notifications
    func application(_application: UIApplication, didReceivedRemoteNotifcation userInfo: [AnyHashable: Any]) async ->
    UIBackgroundFetchResult {
        return .noData
    }
}



@main
struct RoomiesApp: App {
    //register app for firebase setup
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    @StateObject private var authViewModel = AuthViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(authViewModel)
        }
    }
}





