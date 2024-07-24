//
//  userAuthApp.swift
//  userAuth
//
//  Created by Caleb Nartey on 7/23/24.
//

import SwiftUI
import FirebaseCore

@main
struct userAuthApp: App {
    
    init(){
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            LoginView()
        }
    }
}
