//
//  LostAndFoundApp.swift
//  LostAndFound
//
//  Created by Remi Pacifico Hansen on 12/6/22.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    return true
  }
}


@main
struct LostAndFoundApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var newpostVM = NewPostViewModel()
    
    
    var body: some Scene {
        WindowGroup {
            LoginView()
                .environmentObject(newpostVM)
        }
    }
}
