import SwiftUI

struct AddConditionsView: View {
    private let conditions = [
        "Huntington’s Disease",
        "Alzheimer’s Disease",
        "Parkinson’s Disease",
        "Sickle Cell Anemia",
        "Thalassemia",
        "Hemophilia",
        "G6PD Deficiency",
        "Cystic Fibrosis",
        "Alpha-1 Antitrypsin Deficiency",
        "Breast Cancer (BRCA1/BRCA2)",
        "Ovarian Cancer",
        "Colorectal Cancer (Lynch syndrome)",
        "Prostate Cancer",
        "Pancreatic Cancer",
        "Type 2 Diabetes Mellitus",
        "Thyroid Disorders (Autoimmune)",
        "Coronary Artery Disease",
        "Hypertension",
        "Hypercholesterolemia (Familial Hypercholesterolemia)",
        "Cardiomyopathy (Hypertrophic cardiomyopathy)",
        "PCOS"
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
                Section(header: Text("Common Conditions")) {
                    ForEach(conditions, id: \.self) { condition in
                        ConditionRow(condition: condition, selectedConditions: $selectedConditions)
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
            if selectedConditions.contains(condition) {
                selectedConditions.remove(condition)
            } else {
                selectedConditions.insert(condition)
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