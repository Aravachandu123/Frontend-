import SwiftUI

struct LifestyleView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var showFamilyHistory = false
    
    // Persistent Data
    @AppStorage("lifestyleActivity") private var selectedActivity = ""
    @AppStorage("lifestyleDiet") private var selectedDiet = ""
    @AppStorage("lifestyleSmoking") private var selectedSmoking = ""
    
    // Options
    private let activityOptions = ["Daily", "Regularly", "Moderately", "Never"]
    private let dietOptions = ["Balanced", "Vegetarian", "Vegan"]
    private let smokingOptions = ["Never", "Former", "Occasional", "Regular"]
    
    var body: some View {
        ZStack {
            Color.appBackground.ignoresSafeArea()
            
            List {
                Section(header: Text("Physical Activity")) {
                    ForEach(activityOptions, id: \.self) { option in
                        SelectionRow(title: option, selectedOption: $selectedActivity)
                    }
                }
                
                Section(header: Text("Dietary Habits")) {
                    ForEach(dietOptions, id: \.self) { option in
                        SelectionRow(title: option, selectedOption: $selectedDiet)
                    }
                }
                
                Section(header: Text("Smoking Status")) {
                    ForEach(smokingOptions, id: \.self) { option in
                        SelectionRow(title: option, selectedOption: $selectedSmoking)
                    }
                }
                
                Section {
                    Button(action: {
                        showFamilyHistory = true
                    }) {
                        Text("Continue")
                            .frame(maxWidth: .infinity)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                    }
                    .listRowBackground(Color.blue)
                }
            }
            .listStyle(.insetGrouped)
            .scrollContentBackground(.hidden)
        }
        .navigationTitle("Lifestyle")
        .navigationBarTitleDisplayMode(.large)
        .navigationDestination(isPresented: $showFamilyHistory) {
            FamilyMedicalHistoryView()
        }
    }
}

struct SelectionRow: View {
    let title: String
    @Binding var selectedOption: String
    
    var body: some View {
        Button(action: {
            selectedOption = title
        }) {
            HStack {
                Text(title)
                    .foregroundColor(.appText)
                Spacer()
                if selectedOption == title {
                    Image(systemName: "checkmark")
                        .foregroundColor(.blue)
                }
            }
        }
    }
}

#Preview {
    LifestyleView()
}