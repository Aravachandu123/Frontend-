import SwiftUI

struct PastInsightsView: View {
    @Environment(\.dismiss) private var dismiss
    
    // Sample Data
    struct InsightItem: Identifiable {
        let id = UUID()
        let title: String
        let description: String
        let icon: String
        let color: Color
    }
    
    let insights: [InsightItem] = [
        InsightItem(title: "Moderate cardiac risk detected", description: "Analysis of latest arterial markers indicates a score of 64%.", icon: "exclamationmark.triangle.fill", color: .red),
        InsightItem(title: "Risk profile updated", description: "Recent lifestyle and demographic data have been synced with your genetic baseline.", icon: "arrow.triangle.2.circlepath", color: .green),
        InsightItem(title: "Family history analyzed", description: "Inherited patterns from maternal history have been quantified.", icon: "person.3.fill", color: .blue),
        InsightItem(title: "No major risk changes", description: "Periodic re-assessment shows stable metabolic scores.", icon: "checkmark.shield.fill", color: .secondary)
    ]
    
    var body: some View {
        ZStack {
            Color.appBackground.ignoresSafeArea()
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 16) {
                    ForEach(insights) { item in
                        InsightCard(item: item)
                    }
                }
                .padding(.top, 20)
                .padding(.horizontal, 20)
                .padding(.bottom, 40)
            }
        }
        .navigationTitle("Past Insights")
        .navigationBarTitleDisplayMode(.inline)
        .standardBackButton()
    }
}

struct InsightCard: View {
    let item: PastInsightsView.InsightItem
    
    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            // Icon Circle
            ZStack {
                Circle()
                    .fill(item.color.opacity(0.15))
                    .frame(width: 48, height: 48)
                
                Image(systemName: item.icon)
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(item.color)
            }
            
            // Content
            VStack(alignment: .leading, spacing: 6) {
                Text(item.title)
                    .font(.headline)
                    .foregroundColor(.appText)
                
                Text(item.description)
                    .font(.subheadline)
                    .foregroundColor(.appSecondaryText)
                    .lineLimit(3)
                    .lineSpacing(4)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(16)
        .background(Color.appSecondaryBackground)
        .cornerRadius(20)
    }
}

#Preview {
    NavigationView {
        PastInsightsView()
    }
}