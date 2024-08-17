import SwiftUI
import FSCalendar

struct CalendarViewRepresentable: UIViewRepresentable {
    @Binding var selectedDate: Date?
        @Binding var showingDreamEntry: Bool
        var viewModel: CalendarViewModel // Add this property if it's missing


    func makeCoordinator() -> Coordinator {
        Coordinator(self, viewModel: viewModel)
    }

    func makeUIView(context: Context) -> FSCalendar {
        let calendar = FSCalendar()
        calendar.delegate = context.coordinator
        calendar.dataSource = context.coordinator
        setupCalendarAppearance(calendar)
        return calendar
    }

    func updateUIView(_ uiView: FSCalendar, context: Context) {
        if let selectedDate = selectedDate {
            uiView.select(selectedDate)
        }
        uiView.reloadData()
    }
    
    // Custom appearance setup for FSCalendar
    private func setupCalendarAppearance(_ calendar: FSCalendar) {
        calendar.appearance.headerDateFormat = "MMMM yyyy"
        calendar.appearance.weekdayTextColor = .white
        calendar.appearance.headerTitleColor = .white
        calendar.appearance.titleDefaultColor = .white
        calendar.appearance.titleTodayColor = .white
        calendar.appearance.selectionColor = UIColor.systemPurple
        calendar.appearance.titleSelectionColor = .white
        calendar.appearance.titlePlaceholderColor = UIColor.lightGray
        calendar.appearance.eventDefaultColor = .white
        calendar.appearance.eventSelectionColor = .white
        calendar.appearance.borderRadius = 0.2
        calendar.firstWeekday = 1
        calendar.appearance.borderDefaultColor = UIColor.white
        calendar.appearance.borderSelectionColor = UIColor.white
        calendar.backgroundColor = UIColor.black
    }

    class Coordinator: NSObject, FSCalendarDelegate, FSCalendarDataSource {
        var parent: CalendarViewRepresentable
        var viewModel: CalendarViewModel
        
        init(_ parent: CalendarViewRepresentable, viewModel: CalendarViewModel) {
            self.parent = parent
            self.viewModel = viewModel
        }

        func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
            let dayStart = Calendar.current.startOfDay(for: date)
            return viewModel.entries[dayStart]?.count ?? 0
        }

        func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
            parent.viewModel.selectedDate = date
            //parent.showingDreamEntry.toggle() // This should trigger the sheet to display
        }

    }
}
