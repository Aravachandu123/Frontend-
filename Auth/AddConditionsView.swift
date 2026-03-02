import SwiftUI

struct ConditionCategory: Identifiable {
    let id = UUID()
    let name: String
    let conditions: [String]
}

struct AddConditionsView: View {
    private let categories = [
        ConditionCategory(name: "No Known Conditions", conditions: [
            "None"
        ]),
        ConditionCategory(name: "Cardiovascular", conditions: [
            "Coronary Artery Disease",
            "Hypertension",
            "Hypercholesterolemia (Familial Hypercholesterolemia)",
            "Cardiomyopathy (Hypertrophic cardiomyopathy)"
        ]),
        ConditionCategory(name: "Oncology (Cancers)", conditions: [
            "Breast Cancer (BRCA1/BRCA2)",
            "Ovarian Cancer",
            "Colorectal Cancer (Lynch syndrome)",
            "Prostate Cancer",
            "Pancreatic Cancer"
        ]),
        ConditionCategory(name: "Neurological Disorders", conditions: [
            "Alzheimer’s Disease",
            "Parkinson’s Disease",
            "Huntington’s Disease"
        ]),
        ConditionCategory(name: "Blood & Respiratory", conditions: [
            "Sickle Cell Anemia",
            "Thalassemia",
            "Hemophilia",
            "G6PD Deficiency",
            "Cystic Fibrosis",
            "Alpha-1 Antitrypsin Deficiency"
        ]),
        ConditionCategory(name: "Metabolic & Endocrine", conditions: [
            "Type 2 Diabetes Mellitus",
            "Thyroid Disorders (Autoimmune)",
            "PCOS"
        ])
    ]

    @Binding var selectedConditions: Set<String>
    let memberName: String

    @State private var otherConditionText = ""
    @Environment(\.dismiss) private var dismiss

    init(selectedConditions: Binding<Set<String>>, memberName: String) {
        self._selectedConditions = selectedConditions
        self.memberName = memberName
    }

    var body: some View {
        ZStack {
            Color.appBackground.ignoresSafeArea()
            
            List {
                ForEach(categories) { category in
                    Section(header: Text(category.name)) {
                        ForEach(category.conditions, id: \.self) { condition in
                            ConditionRow(condition: condition, selectedConditions: $selectedConditions)
                        }
                    }
                }
                
                Section(header: Text("Other Condition")) {
                    HStack {
                        TextField("Enter condition...", text: $otherConditionText)
                            .foregroundColor(.appText)
                        
                        Button(action: addOtherCondition) {
                            Text("Add")
                                .fontWeight(.medium)
                        }
                        .disabled(otherConditionText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                    }
                }
            }
            .listStyle(.insetGrouped)
            .scrollContentBackground(.hidden)
        }
        .navigationTitle("Add Conditions")
        .navigationBarTitleDisplayMode(.inline)
    }

    private func toggleCondition(_ condition: String) {
        if selectedConditions.contains(condition) {
            selectedConditions.remove(condition)
        } else {
            selectedConditions.insert(condition)
        }
    }
    
    private func addOtherCondition() {
        let trimmed = otherConditionText.trimmingCharacters(in: .whitespacesAndNewlines)
        if !trimmed.isEmpty {
            selectedConditions.remove("None")
            selectedConditions.insert(trimmed)
            otherConditionText = ""
        }
    }
}

#Preview {
    NavigationStack {
        AddConditionsView(selectedConditions: .constant([]), memberName: "Father")
    }
}



struct ConditionRow: View {
    let condition: String
    @Binding var selectedConditions: Set<String>
    
    var body: some View {
        Button(action: {
            if condition == "None" {
                // If "None" is selected, clear everything else and just set "None"
                // If it was already selected, and user taps it again, we can just leave it or toggle it off (toggling it off means empty list)
                if selectedConditions.contains("None") {
                    selectedConditions.remove("None")
                } else {
                    selectedConditions.removeAll()
                    selectedConditions.insert("None")
                }
            } else {
                // If a real condition is selected, remove "None"
                selectedConditions.remove("None")
                
                if selectedConditions.contains(condition) {
                    selectedConditions.remove(condition)
                } else {
                    selectedConditions.insert(condition)
                }
            }
        }) {
            HStack {
                Text(condition)
                    .foregroundColor(.appText)
                Spacer()
                if selectedConditions.contains(condition) {
                    Image(systemName: "checkmark")
                        .foregroundColor(.blue)
                }
            }
            .contentShape(Rectangle())
        }
    }
}

#Preview {
    AddConditionsView(selectedConditions: .constant([]), memberName: "Father")
}