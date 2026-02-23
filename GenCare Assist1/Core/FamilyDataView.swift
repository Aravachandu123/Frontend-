import SwiftUI

struct FamilyDataView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var viewModel: FamilyHealthViewModel
    
    var body: some View {
        ZStack {
            Color.appBackground.ignoresSafeArea()
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 24) {
                    
                    // Header Card
                    VStack(spacing: 12) {
                        Image(systemName: "person.3.sequence.fill")
                            .font(.system(size: 50))
                            .foregroundColor(.purple)
                            .padding(.bottom, 8)
                        
                        Text("Medical Heritage")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.appText)
                        
                        Text("A record of conditions identified in your immediate family.")
                            .font(.subheadline)
                            .foregroundColor(.appSecondaryText)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                    }
                    .padding(.vertical, 30)
                    .frame(maxWidth: .infinity)
                    .background(Color.appSecondaryBackground)
                    .cornerRadius(20)
                    .padding(.horizontal)
                    
                    // Family Members Grid/List
                    VStack(spacing: 16) {
                        FamilyMemberCard(
                            relation: "Father",
                            icon: "person.bust.fill",
                            color: .blue,
                            conditions: Array(viewModel.conditionsByMember["Father", default: []]).sorted()
                        )
                        
                        FamilyMemberCard(
                            relation: "Mother",
                            icon: "person.bust.fill",
                            color: .pink,
                            conditions: Array(viewModel.conditionsByMember["Mother", default: []]).sorted()
                        )
                        
                        FamilyMemberCard(
                            relation: "Grandparents",
                            icon: "person.2.fill", // Two people
                            color: .orange,
                            conditions: Array(viewModel.conditionsByMember["Grandparents", default: []]).sorted()
                        )
                        
                        FamilyMemberCard(
                            relation: "Siblings",
                            icon: "person.2.wave.2.fill",
                            color: .green,
                            conditions: Array(viewModel.conditionsByMember["Siblings", default: []]).sorted()
                        )
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 40)
                }
                .padding(.top, 10)
            }
        }
        .navigationTitle("Family Data")
        .navigationBarTitleDisplayMode(.inline)
        .standardBackButton()
    }
}

struct FamilyMemberCard: View {
    let relation: String
    let icon: String
    let color: Color
    let conditions: [String]
    
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
                
                Text(relation)
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(.appText)
                
                Spacer()
            }
            
            // Conditions List
            if !conditions.isEmpty {
                ForEach(conditions, id: \.self) { condition in
                    HStack(spacing: 10) {
                        Image(systemName: "circle.fill")
                            .font(.system(size: 6))
                            .foregroundColor(.appSecondaryText)
                        
                        Text(condition)
                            .font(.body)
                            .foregroundColor(.appText)
                    }
                    .padding(.leading, 8)
                }
            } else {
                Text("No significant conditions recorded.")
                    .font(.subheadline)
                    .italic()
                    .foregroundColor(.appSecondaryText)
                    .padding(.leading, 8)
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
        FamilyDataView()
            .environmentObject(FamilyHealthViewModel())
    }
}