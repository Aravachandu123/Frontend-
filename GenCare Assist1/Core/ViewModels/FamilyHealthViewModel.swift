import SwiftUI

class FamilyHealthViewModel: ObservableObject {
    @Published var conditionsByMember: [String: Set<String>] = [
        "Father": [],
        "Mother": [],
        "Grandparents": [],
        "Siblings": []
    ] {
        didSet {
            saveConditions()
        }
    }
    
    init() {
        loadconditions()
        NotificationCenter.default.addObserver(self, selector: #selector(resetData), name: .didDeleteAccount, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func resetData() {
        // Clear all conditions in memory
        conditionsByMember = [
            "Father": [],
            "Mother": [],
            "Grandparents": [],
            "Siblings": []
        ]
        // Also ensure UserDefaults is empty for this key (redundant if SessionManager clears domain, but safe)
        UserDefaults.standard.removeObject(forKey: saveKey)
    }

    // Helper to toggle a condition for a member
    func toggleCondition(member: String, condition: String) {
        if conditionsByMember[member]?.contains(condition) == true {
            conditionsByMember[member]?.remove(condition)
        } else {
            conditionsByMember[member, default: []].insert(condition)
        }
        saveConditions()
    }
    
    // Helper to check if a condition is selected
    func hasCondition(member: String, condition: String) -> Bool {
        return conditionsByMember[member]?.contains(condition) ?? false
    }
    
    // MARK: - Persistence
    private let saveKey = "family_conditions_data"
    
    private func saveConditions() {
        // Convert Set to Array for JSON serialization
        let executableData = conditionsByMember.mapValues { Array($0) }
        if let encoded = try? JSONEncoder().encode(executableData) {
            UserDefaults.standard.set(encoded, forKey: saveKey)
        }
    }
    
    private func loadconditions() {
        if let data = UserDefaults.standard.data(forKey: saveKey),
           let decoded = try? JSONDecoder().decode([String: [String]].self, from: data) {
            // Convert Array back to Set
            self.conditionsByMember = decoded.mapValues { Set($0) }
        }
    }
}
