//
//  DealMartApp.swift
//  DealMart
//
//  Created by user215540 on 3/23/22.
//

import SwiftUI
import Firebase

@main
struct DealMartApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
