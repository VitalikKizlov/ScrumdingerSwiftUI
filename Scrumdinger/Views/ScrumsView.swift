//
//  ScrumsView.swift
//  Scrumdinger
//
//  Created by Vitalii Kizlov on 05.01.2021.
//

import SwiftUI

struct ScrumsView: View {
    
    @Environment(\.scenePhase) private var scenePhase
    @Binding var scrums: [DailyScrum]
    @State private var isPresented = false
    @State private var newScrumData = DailyScrum.Data()
    
    let saveAction: () -> Void
    
    var body: some View {
        List {
            ForEach(scrums) { scrum in
                NavigationLink(destination: DetailView(scrum: binding(for: scrum))) {
                    CardView(scrum: scrum)
                }
                .listRowBackground(scrum.color)
            }
        }
        .navigationTitle("Daily Scrums")
        .navigationBarItems(trailing: Button(action: {
            isPresented = true
        }, label: {
            Image(systemName: "plus")
        }))
        .sheet(isPresented: $isPresented) {
            NavigationView {
                EditView(scrumData: $newScrumData)
                    .navigationBarItems(leading: Button("Dismiss") {
                        isPresented = false
                    }, trailing: Button("Add") {
                        isPresented = false
                        scrums.append(DailyScrum.createNewScrum(from: newScrumData))
                    })
            }
        }
        .onChange(of: scenePhase, perform: { value in
            if value == .inactive {
                saveAction()
            }
        })
    }
    
    
    private func binding(for scrum: DailyScrum) -> Binding<DailyScrum> {
        guard let scrumIndex = scrums.firstIndex(where: { $0.id == scrum.id }) else {
            fatalError("Can't find scrum")
        }
        return $scrums[scrumIndex]
    }
}

struct ScrumsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ScrumsView(scrums: .constant(DailyScrum.data), saveAction: {})
        }
    }
}
