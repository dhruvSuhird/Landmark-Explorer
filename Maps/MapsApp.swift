//
//  MapsApp.swift
//  Maps
//
//  Created by Dhruv Suhird on 08/04/24.
//

import SwiftUI

@main
struct MapsApp: App {
    
    // A view that creates the LocationViewModel object,
    // and places it into the environment for the
    // navigation stack.
    @StateObject private var vm = LocationViewModel()
    
    var body: some Scene {
        WindowGroup {
            LocationView()
                .environmentObject(vm)
        }
    }
}
