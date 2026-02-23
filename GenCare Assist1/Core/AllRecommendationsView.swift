
import SwiftUI

struct AllRecommendationsView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            Color.appBackground.ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Header (Navigation Bar)
                HStack {
                    Button(action: { dismiss() }) {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundColor(.appText)
                            .frame(width: 40, height: 40)
                            .background(Color.appSecondaryBackground)
                            .clipShape(Circle())
                            .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
                    }
                    
                    Spacer()
                    
                    Text("Recommendations")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(.appText)
                    
                    Spacer()
                    
                    // Invisible spacer for balance
                    Color.clear.frame(width: 40, height: 40)
                }
                .padding(.horizontal)
                .padding(.top, 10) // Added top padding for better spacing
                .padding(.bottom, 10)
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 24) {
                        
                        // Intro Text
                        Text("Personalized actions created by GenCare Assist based on your risk profile.")
                            .font(.subheadline)
                            .foregroundColor(.appSecondaryText)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                            .padding(.bottom, 10)
                        
                        // 1. High Priority Section
                        RecommendationSectionView(
                            title: "High Priority",
                            icon: "exclamationmark.triangle.fill",
                            color: .red,
                            items: [
                                "Schedule Cardiovascular Screening within 30 days",
                                "Consult a Cardiologist regarding family history"
                            ]
                        )
                        
                        // 2. Moderate Priority
                        RecommendationSectionView(
                            title: "Moderate Priority",
                            icon: "stethoscope",
                            color: .orange,
                            items: [
                                "Monitor Glucose Levels Weekly",
                                "Track Blood Pressure Daily (AM/PM)"
                            ]
                        )
                        
                        // 3. Lifestyle Advice
                        RecommendationSectionView(
                            title: "Lifestyle Advice",
                            icon: "leaf.fill",
                            color: .green,
                            items: [
                                "Start Sodium Reduction Plan (<2300mg/day)",
                                "Incorporate 30 min of Aerobic Exercise daily"
                            ]
                        )
                        
                        // 4. Maintenance
                        RecommendationSectionView(
                            title: "Maintenance",
                            icon: "brain.head.profile",
                            color: .blue,
                            items: [
                                "Maintain Neurological Wellness Habits (Diet rich in antioxidants)",
                                "Ensure Quality Sleep Schedule (7-9 hours)"
                            ]
                        )
                        
                        // 5. Follow Up
                        RecommendationSectionView(
                            title: "Follow-Up",
                            icon: "calendar.badge.clock",
                            color: .purple,
                            items: ["Quarterly Data Reassessment via App"]
                        )
                        
                        // Disclaimer Footer
                        Text("This tool provides suggestions based on data points and is not a substitute for professional medical advice.")
                            .font(.caption)
                            .foregroundColor(.appSecondaryText)
                            .multilineTextAlignment(.center)
                            .padding(.top, 20)
                            .padding(.bottom, 40)
                            .padding(.horizontal)
                    }
                    .padding(.horizontal)
                    .padding(.top, 10)
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct RecommendationSectionView: View {
    let title: String
    let icon: String // SF Symbol Name
    let color: Color
    let items: [String]
    
    var body: some View {
        VStack(spacing: 0) {
            // Card Header
            HStack(spacing: 12) {
                ZStack {
                    Circle()
                        .fill(color.opacity(0.15))
                        .frame(width: 40, height: 40)
                    
                    Image(systemName: icon)
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(color)
                }
                
                Text(title)
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(.appText)
                
                Spacer()
            }
            .padding()
            .background(Color.appSecondaryBackground) // Header bg matches content bg or distinct?
            // Let's make entire card appSecondaryBackground to stand out from appBackground
            
            Divider()
                .background(Color.appText.opacity(0.05))
            
            // Items Loop
            VStack(alignment: .leading, spacing: 0) {
                ForEach(items.indices, id: \.self) { index in
                    HStack(alignment: .top, spacing: 12) {
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(color)
                            .font(.system(size: 18))
                            .padding(.top, 2)
                        
                        Text(items[index])
                            .font(.subheadline) // Slightly larger than caption
                            .foregroundColor(.appText)
                            .fixedSize(horizontal: false, vertical: true)
                            .lineSpacing(4) // Better readability
                        
                        Spacer()
                    }
                    .padding()
                    
                    if index < items.count - 1 {
                        Divider()
                            .padding(.leading, 44) // Indent divider
                            .background(Color.appText.opacity(0.05))
                    }
                }
            }
        }
        .background(Color.appSecondaryBackground)
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.05), radius: 8, x: 0, y: 2) // Soft shadow
    }
}

#Preview {
    AllRecommendationsView()
}
