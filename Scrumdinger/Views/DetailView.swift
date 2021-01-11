//
//  DetailView.swift
//  Scrumdinger
//
//  Created by Vitalii Kizlov on 06.01.2021.
//

import SwiftUI

struct DetailView: View {
    
    @Binding var scrum: DailyScrum
    @State private var data = DailyScrum.Data()
    @State private var isPresented = false
    
    var body: some View {
        List {
            Section(header: Text("Meeting Info")) {
                NavigationLink(destination: MeetingView(scrum: $scrum)) {
                        Label("Start Meeting", systemImage: "timer")
                            .font(.headline)
                            .foregroundColor(.accentColor)
                            .accessibilityLabel(Text("Start meeting"))
                }
                HStack {
                    Label("Lenghth", systemImage: "clock")
                    .accessibilityLabel(Text("Meeting length"))
                    Spacer()
                    Text("\(scrum.lengthInMinutes)")
                }
                HStack {
                    Label("Color", systemImage: "paintpalette")
                    Spacer()
                    Image(systemName: "checkmark.circle.fill")
                    .foregroundColor(scrum.color)
                }
                .accessibilityElement(children: .ignore)
            }
            
            Section(header: Text("Attendees")) {
                ForEach(scrum.attendees, id: \.self) { attendee in
                    Label(attendee, systemImage: "person")
                        .accessibilityLabel(Text("Person"))
                        .accessibilityValue(Text(attendee))
                }
            }
        }
        .listStyle(InsetGroupedListStyle())
        .navigationBarItems(trailing: Button("Edit", action: {
            isPresented = true
            data = scrum.data
        }))
        .navigationTitle(scrum.title)
        .fullScreenCover(isPresented: $isPresented, content: {
            NavigationView {
                EditView(scrumData: $data)
                    .navigationTitle(scrum.title)
                    .navigationBarItems(leading: Button("Cancel", action: {
                        isPresented = false
                    }), trailing: Button("Done", action: {
                        isPresented = false
                        scrum.update(from: data)
                    }))
            }
        })
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DetailView(scrum: .constant(DailyScrum.data[0]))
        }
    }
}
