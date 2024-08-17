//
//  DreamEntry.swift
//  DreamJournal
//
//  Created by Soham Purushan on 4/17/24.
//

import Foundation

struct DreamEntry: Identifiable, Codable {
    var id: UUID // A unique identifier for each entry
    var title: String // The title of the dream
    var content: String // The detailed description of the dream
    var date: Date // The date and time the dream was recorded or occurred
    var interpretation: String // The user's interpretation of the dream
    var category: DreamCategory // A category or type of dream
    var isFavorite: Bool // Whether the user has marked this entry as a favorite
    // Add any additional properties that are relevant to your dream entries

    // Initialization
    init(id: UUID = UUID(), title: String, content: String, date: Date, interpretation: String = "", category: DreamCategory = .general, isFavorite: Bool = false) {
        self.id = id
        self.title = title
        self.content = content
        self.date = date
        self.interpretation = interpretation
        self.category = category
        self.isFavorite = isFavorite
    }
}

// An enumeration for dream categories, which allows for organizing or filtering dreams
enum DreamCategory: String, Codable, CaseIterable {
    case nightmare
    case lucid
    case recurring
    case prophetic
    case healing
    case general // Use this for uncategorized or miscellaneous dreams

    var displayName: String {
        switch self {
        case .nightmare: return "Nightmare"
        case .lucid: return "Lucid"
        case .recurring: return "Recurring"
        case .prophetic: return "Prophetic"
        case .healing: return "Healing"
        case .general: return "General"
        }
    }
}

