//
//  DreamRowView.swift
//  DreamJournal
//
//  Created by Soham Purushan on 4/21/24.
//

import SwiftUI

struct DreamRowView: View {
    let dreamEntry: DreamEntry

    var body: some View {
        VStack(alignment: .leading) {
            Text(dreamEntry.title)
                .font(.headline)
            Text(dreamEntry.content)
                .font(.subheadline)
                .lineLimit(1)
            Text("\(dreamEntry.date, formatter: itemFormatter)")
                .font(.caption)
                .foregroundColor(.gray)
        }
    }

    private let itemFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        return formatter
    }()
}

struct DreamRowView_Previews: PreviewProvider {
    static var previews: some View {
        DreamRowView(dreamEntry: DreamEntry(title: "Test Dream", content: "This is a test dream content", date: Date()))
    }
}

