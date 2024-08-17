import Foundation

class CalendarViewModel: ObservableObject {
    @Published var selectedDate: Date?
    @Published var isLoggedIn: Bool = false // Ensure this is set based on your login logic
    
    @Published var entries: [Date: [DreamEntry]] = [:] // Holds an array of entries for each date
    
    let calendar = Calendar.current
    
    // Computed property to identify dates with dreams
    var datesWithDreams: Set<Date> {
        Set(entries.keys)
    }
    
    var entriesForSelectedDate: [DreamEntry] {
            entries[selectedDate ?? Date(), default: []]
        }
    
    init() {
        // Set initial selected date to today
        selectedDate = Date()
        // Fetch entries for the current date
        fetchEntries(for: selectedDate)
    }
    
    private func fetchEntries(for date: Date?) {
        guard let date = date else { return }
        let dayStart = calendar.startOfDay(for: date)
        
        // Attempt to fetch stored entries from UserDefaults
        if let data = UserDefaults.standard.data(forKey: "dreamEntries-\(dayStart)"),
           let savedEntries = try? JSONDecoder().decode([DreamEntry].self, from: data) {
            entries[dayStart] = savedEntries
        } else {
            entries[dayStart] = [] // No entries found, initialize with an empty array
        }
    }
    
    func addEntry(_ entry: DreamEntry, to date: Date) {
        let dayStart = calendar.startOfDay(for: date)
        var dayEntries = entries[dayStart, default: []]
        dayEntries.append(entry)
        entries[dayStart] = dayEntries
        
        // Save the updated entries for this day
        if let data = try? JSONEncoder().encode(dayEntries) {
            UserDefaults.standard.set(data, forKey: "dreamEntries-\(dayStart)")
        }
    }
    
    // A function to get the date for a specific day of the current month
    func getDate(for day: Int) -> Date {
        // Calculate the first day of the current month
        let components = calendar.dateComponents([.year, .month], from: Date())
        guard let firstDayOfMonth = calendar.date(from: components) else {
            fatalError("Unable to calculate the first day of the month.")
        }
        return calendar.date(byAdding: .day, value: day - 1, to: firstDayOfMonth)!
    }
    
    
    func removeEntries(at offsets: IndexSet, for date: Date) {
        let dayStart = calendar.startOfDay(for: date)
        guard var dayEntries = entries[dayStart] else { return }
        
        dayEntries.remove(atOffsets: offsets)
        entries[dayStart] = dayEntries
        
        // Update the storage
        if let data = try? JSONEncoder().encode(dayEntries) {
            UserDefaults.standard.set(data, forKey: "dreamEntries-\(dayStart)")
        }
    }
    
    func saveEntries() {
        for (date, entries) in self.entries {
            let key = "dreamEntries-\(calendar.startOfDay(for: date))"
            if let data = try? JSONEncoder().encode(entries) {
                UserDefaults.standard.set(data, forKey: key)
            }
        }
        
        
    }
    
    
    
    
    // The DreamEntry struct should match your actual data model
    
}
