//
//  BasicMacOsAppApp.swift
//  BasicMacOsApp
//
//  Created by Gregorius Yuristama Nugraha on 16/03/23.
//

import SwiftUI

@main
struct CBroApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .fixedSize()
                
        }
        .windowResizability(.contentSize)
//        MenuBarExtra("1", systemImage: "\("1").circle") {
//            ContentView()
//        }
    }
}


