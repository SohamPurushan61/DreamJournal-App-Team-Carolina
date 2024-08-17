//
//  CalenderView.swfit.swift
//  DreamJournal
//
//  Created by Soham Purushan on 4/17/24.
//

import SwiftUI

struct CalendarView: View {
    @ObservedObject var calendarModel = CalendarViewModel()
    @Binding var showingDreamEntry: Bool

    var body: some View {
        CalendarViewRepresentable(selectedDate: $calendarModel.selectedDate, showingDreamEntry: $showingDreamEntry, viewModel: calendarModel)

    }
}
