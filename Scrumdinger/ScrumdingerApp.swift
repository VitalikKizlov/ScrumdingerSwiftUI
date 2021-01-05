//
//  ScrumdingerApp.swift
//  Scrumdinger
//
//  Created by Vitalii Kizlov on 05.01.2021.
//

import SwiftUI

@main
struct ScrumdingerApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ScrumsView(scrums: DailyScrum.data)
            }
        }
    }
}
