import SwiftUI

struct FamilyDataView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var viewModel: FamilyHealthViewModel
    
    // Group condition -> Array of members
    private var conditionsInfluence: [(condition: String, members: [String])] {
        var influenceMap: [String: [String]] = [:]
        for (member, conditions) in viewModel.conditionsByMember {
            if member == "Myself" { continue } // exclude self for family influence
            for condition in conditions {
                influenceMap[condition, default: []].append(member)
            }
        }
        // return sorted by condition name
        return influenceMap.map { (condition: $0.key, members: $0.value.sorted()) }
            .sorted { $0.condition < $1.condition }
    }
    
    var body: some View {
        ZStack {
            Color.appBackground.ignoresSafeArea()
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 24) {
                    
                    // Header Card
                    VStack(spacing: 8) {
                        Image(systemName: "person.3.sequence.fill")
                            .font(.system(size: 48))
                            .foregroundColor(.purple)
                            .padding(.bottom, 8)
                        
                        Text("Family History Influence")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.appText)
                        
                        Text("See how conditions in your family history may influence your personal health risks.")
                            .font(.subheadline)
                            .foregroundColor(.appSecondaryText)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                    }
                    .padding(.top, 20)
                    .padding(.bottom, 10)
                    
                    // Conditions Cards
                    VStack(spacing: 16) {
                        let influences = conditionsInfluence
                        if influences.isEmpty {
                            Text("No significant family history recorded.")
                                .font(.body)
                                .foregroundColor(.appSecondaryText)
                                .padding()
                        } else {
                            let colors: [Color] = [.orange, .blue, .green, .purple, .pink, .red, .teal]
                            let icons: [String] = ["staroflife.fill", "heart.fill", "bolt.fill", "leaf.fill", "waveform.path.ecg"]
                            
                            ForEach(Array(influences.enumerated()), id: \.offset) { index, item in
                                FamilyInfluenceCard(
                                    condition: item.condition,
                                    members: item.members,
                                    icon: icons[index % icons.count],
                                    color: colors[index % colors.count]
                                )
                            }
                        }
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 40)
                }
            }
        }
        .navigationTitle("Family Influence")
        .navigationBarTitleDisplayMode(.inline)
        .standardBackButton()
    }
}

struct FamilyInfluenceCard: View {
    let condition: String
    let members: [String]
    let icon: String
    let color: Color
    
    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            // Icon
            ZStack {
                Circle()
                    .fill(color.opacity(0.15))
                    .frame(width: 54, height: 54)
                
                Image(systemName: icon)
                    .font(.system(size: 24, weight: .semibold))
                    .foregroundColor(color)
            }
            
            // Content
            VStack(alignment: .leading, spacing: 6) {
                HStack {
                    Text(condition)
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(.appText)
                        .lineLimit(1)
                    
                    Spacer()
                    
                    Text("Risk Factor")
                        .font(.caption2)
                        .fontWeight(.bold)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(color.opacity(0.1))
                        .foregroundColor(color)
                        .cornerRadius(8)
                }
                
                Text(membersDescription)
                    .font(.subheadline)
                    .foregroundColor(.appSecondaryText)
                    .lineSpacing(2)
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
        .padding(16)
        .background(Color.appSecondaryBackground)
        .cornerRadius(20)
        .shadow(color: Color.black.opacity(0.04), radius: 6, x: 0, y: 3)
    }
    
    private var membersDescription: String {
        let memberList = members.joined(separator: ", ")
        return "Identified in: \(memberList)"
    }
}

#Preview {
    NavigationStack {
        FamilyDataView()
            .environmentObject(FamilyHealthViewModel())
    }
}