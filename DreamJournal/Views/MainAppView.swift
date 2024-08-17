//
//  MainAppView.swift
//  DreamJournal
//
//  Created by Kate Song on 4/22/24.
//
import SwiftUI

struct MainAppView: View {
   
   @StateObject var viewModel = CalendarViewModel()
   @State private var showingDreamEntry = false
   @State private var editingDreamEntry: DreamEntry?
   
   var body: some View {
       NavigationView {
           VStack {
               Text("Dream Journal")
                   .font(.largeTitle)
                   .foregroundColor(.white)
               CalendarViewRepresentable(selectedDate: $viewModel.selectedDate, showingDreamEntry: $showingDreamEntry, viewModel: viewModel)
                   .frame(height: UIScreen.main.bounds.height * 0.4)
               
               List {
                   ForEach(viewModel.entries[viewModel.selectedDate ?? Date()] ?? [], id: \.id) { dreamEntry in
                       DreamRowView(dreamEntry: dreamEntry)
                           .onTapGesture {
                               self.editingDreamEntry = dreamEntry
                               self.showingDreamEntry = true
                           }
                   }
                   .onDelete(perform: deleteDreams)
               }
               Spacer()
           }
           .background(.black)
           .navigationBarTitle(Text("Dream Journal").foregroundColor(.white))
           .navigationBarItems(trailing: addButton)
       }
       .sheet(isPresented: $showingDreamEntry, onDismiss: resetEditingState) {
           if let dreamEntry = editingDreamEntry {
               DreamWritingView(viewModel: viewModel, dreamEntry: dreamEntry)
           } else {
               DreamWritingView(viewModel: viewModel, dreamEntry: DreamEntry(title: "", content: "", date: Date()))
           }
       }
   }
   
   private func resetEditingState() {
       self.editingDreamEntry = nil
   }
   
   private var addButton: some View {
       Button("Add Dream") {
           self.editingDreamEntry = nil
           self.showingDreamEntry = true
       }
       .foregroundColor(.white)
   }
   
   private func deleteDreams(at offsets: IndexSet) {
       guard let selectedDate = viewModel.selectedDate else { return }
       viewModel.entries[selectedDate]?.remove(atOffsets: offsets)
   }
}

struct MainAppView_Previews: PreviewProvider {
    static var previews: some View {
        MainAppView()
    }
}
