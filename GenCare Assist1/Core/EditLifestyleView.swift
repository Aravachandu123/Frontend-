import SwiftUI

struct EditLifestyleView: View {
    @Environment(\.dismiss) private var dismiss
    
    // Persistent Data
    @AppStorage("lifestyleActivity") private var selectedActivity = "Regularly"
    @AppStorage("lifestyleDiet") private var selectedDiet = "Balanced"
    @AppStorage("lifestyleSmoking") private var selectedSmoking = "Never"
    
    // Options
    private let activityOptions = ["Daily", "Regularly", "Moderately", "Never"]
    private let dietOptions = ["Balanced", "Vegetarian", "Vegan"]
    private let smokingOptions = ["Never", "Former", "Occasional", "Regular"]
    
    var body: some View {
        ZStack {
            Color.appBackground.ignoresSafeArea()
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 24) {
                    
                    // Header
                    VStack(spacing: 8) {
                        Image(systemName: "figure.mind.and.body")
                            .font(.system(size: 50))
                            .foregroundColor(.orange)
                            .padding(.top, 20)
                            .padding(.bottom, 10)
                        
                        Text("Edit Lifestyle")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.appText)
                        
                        Text("Select the options that best describe your current habits.")
                            .font(.subheadline)
                            .foregroundColor(.appSecondaryText)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                    }
                    .padding(.bottom, 20)
                    
                    // Habit Cards
                    VStack(spacing: 16) {
                        
                        LifestyleEditCard(
                            title: "Physical Activity",
                            icon: "figure.run",
                            color: .green,
                            selection: $selectedActivity,
                            options: activityOptions
                        )
                        
                        LifestyleEditCard(
                            title: "Dietary Habits",
                            icon: "leaf.fill",
                            color: .orange,
                            selection: $selectedDiet,
                            options: dietOptions
                        )
                        
                        LifestyleEditCard(
                            title: "Smoking Status",
                            icon: "lungs.fill",
                            color: .red,
                            selection: $selectedSmoking,
                            options: smokingOptions
                        )
                    }
                    .padding(.horizontal)
                    
                    // Save Button
                    Button(action: { dismiss() }) {
                        Text("Save Changes")
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.appTint)
                            .cornerRadius(16)
                            .shadow(color: Color.appTint.opacity(0.3), radius: 8, x: 0, y: 4)
                    }
                    .padding(.horizontal)
                    .padding(.top, 20)
                    .padding(.bottom, 40)
                }
            }
        }
        .navigationTitle("Edit Lifestyle")
        .navigationBarTitleDisplayMode(.inline)
        .standardBackButton()
    }
}

struct LifestyleEditCard: View {
    let title: String
    let icon: String // SF Symbol
    let color: Color
    @Binding var selection: String
    let options: [String]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Header
            HStack(spacing: 12) {
                ZStack {
                    Circle()
                        .fill(color.opacity(0.15))
                        .frame(width: 40, height: 40)
                    
                    Image(systemName: icon)
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(color)
                }
                
                Text(title)
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(.appText)
                
                Spacer()
            }
            
            Divider()
                .background(Color.appSecondaryText.opacity(0.2))
            
            // Picker
            Menu {
                ForEach(options, id: \.self) { option in
                    Button(action: { selection = option }) {
                        HStack {
                            Text(option)
                            if selection == option {
                                Image(systemName: "checkmark")
                            }
                        }
                    }
                }
            } label: {
                HStack {
                    Text(selection)
                        .font(.body)
                        .foregroundColor(.appText)
                    
                    Spacer()
                    
                    Image(systemName: "chevron.up.chevron.down")
                        .font(.caption)
                        .foregroundColor(.appSecondaryText)
                }
                .padding()
                .background(Color.appBackground) // Contrast against card bg
                .cornerRadius(12)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.appSecondaryText.opacity(0.1), lineWidth: 1)
                )
            }
        }
        .padding(20)
        .background(Color.appSecondaryBackground)
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.03), radius: 5, x: 0, y: 2)
    }
}

#Preview {
    NavigationStack {
        EditLifestyleView()
    }
}