//
//  ScrumdingerApp.swift
//  Scrumdinger
//
//  Created by Vitalii Kizlov on 05.01.2021.
//

import SwiftUI

@main
struct ScrumdingerApp: App {
    
    @State private var scrums = DailyScrum.data
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ScrumsView(scrums: $scrums)
            }
        }
    }
}
