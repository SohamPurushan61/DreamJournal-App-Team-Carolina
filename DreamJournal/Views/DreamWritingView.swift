//
//  DreamWritingView.swift
//  DreamJournal
//
//  Created by Soham Purushan on 4/10/24.
//

// DreamWritingView.swift
import SwiftUI
import OpenAI

struct DreamWritingView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: CalendarViewModel
    @State var dreamEntry: DreamEntry
    @State private var openAI: OpenAI?
    
    init(viewModel: CalendarViewModel, dreamEntry: DreamEntry? = nil) {
        self.viewModel = viewModel
        _dreamEntry = State(initialValue: dreamEntry ?? DreamEntry(title: "", content: "", date: Date(), interpretation: "", category: .general, isFavorite: false))
        
        openAI = OpenAI(apiToken: "sk-proj-5NiF4BDqcrBAshwyylVrT3BlbkFJ26nK6P3jkc7RNugDeA9V")
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Dream Title")) {
                    TextField("Enter a Title", text: $dreamEntry.title)
                }
                Section(header: Text("Dream Content")) {
                    TextEditor(text: $dreamEntry.content)
                }
                Section {
                    Button("Save Dream") {
                        saveDream()
                    }
                }
            }
            .navigationBarTitle("Dream Entry", displayMode: .inline)
        }
    }
    
    private func saveDream() {
        if let index = viewModel.entries[dreamEntry.date]?.firstIndex(where: { $0.id == dreamEntry.id }) {
            viewModel.entries[dreamEntry.date]?[index] = dreamEntry
        } else {
            let newEntry = DreamEntry(title: dreamEntry.title, content: dreamEntry.content, date: dreamEntry.date)
            viewModel.entries[newEntry.date, default: []].append(newEntry)
        }
        
        // Assuming saveEntries() exists in your ViewModel.
        viewModel.saveEntries()
        
        // Dismiss the view after saving.
        presentationMode.wrappedValue.dismiss()
    }
}


