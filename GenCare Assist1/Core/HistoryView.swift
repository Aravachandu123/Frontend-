import SwiftUI

struct HistoryView: View {
    @EnvironmentObject var languageManager: LanguageManager
    
    var body: some View {
        ZStack {
            Color.appBackground.ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Custom Header
                HStack {
                    Text("History")
                        .font(.system(size: 34, weight: .bold))
                        .foregroundColor(.appText)
                    Spacer()
                }
                .padding(.horizontal, 24)
                .padding(.top, 20)
                .padding(.bottom, 10)
                
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 32) {
                        
                        // MARK: - Recent Activity
                        VStack(alignment: .leading, spacing: 16) {
                            Text("Recent Activity")
                                .font(.headline)
                                .foregroundColor(.appSecondaryText)
                                .padding(.horizontal, 24)
                            
                            VStack(spacing: 16) {
                                ActivityCard(
                                    icon: "checkmark.circle.fill",
                                    color: .green,
                                    title: "Assessment Completed",
                                    subtitle: "Your comprehensive risk analysis is ready."
                                )
                                
                                ActivityCard(
                                    icon: "person.2.fill",
                                    color: .blue,
                                    title: "Family History Updated",
                                    subtitle: "New maternal health data added."
                                )
                                
                                ActivityCard(
                                    icon: "heart.fill",
                                    color: .red,
                                    title: "Lifestyle Details Synced",
                                    subtitle: "Dietary and activity inputs recorded."
                                )
                            }
                            .padding(.horizontal, 20)
                        }
                        
                        // MARK: - Past Reports
                        VStack(alignment: .leading, spacing: 16) {
                            Text("Reports")
                                .font(.headline)
                                .foregroundColor(.appSecondaryText)
                                .padding(.horizontal, 24)
                            
                            NavigationLink(destination: PersonalHealthReportView()) {
                                HStack(spacing: 16) {
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 12)
                                            .fill(Color.appTint.opacity(0.15))
                                            .frame(width: 50, height: 50)
                                        
                                        Image(systemName: "doc.text.fill")
                                            .font(.title2)
                                            .foregroundColor(.appTint)
                                    }
                                    
                                    VStack(alignment: .leading, spacing: 4) {
                                        Text("Personal Health Report")
                                            .font(.headline)
                                            .foregroundColor(.appText)
                                        
                                        Text("Tap to view details")
                                            .font(.caption)
                                            .foregroundColor(.appSecondaryText)
                                    }
                                    
                                    Spacer()
                                    
                                    Image(systemName: "chevron.right")
                                        .foregroundColor(.appSecondaryText)
                                }
                                .padding(16)
                                .background(Color.appSecondaryBackground)
                                .cornerRadius(16)
                                .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
                            }
                            .padding(.horizontal, 20)
                            
                            // Link to Past Insights
                             NavigationLink(destination: PastInsightsView()) {
                                HStack(spacing: 16) {
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 12)
                                            .fill(Color.purple.opacity(0.15))
                                            .frame(width: 50, height: 50)
                                        
                                        Image(systemName: "clock.arrow.circlepath")
                                            .font(.title2)
                                            .foregroundColor(.purple)
                                    }
                                    
                                    VStack(alignment: .leading, spacing: 4) {
                                        Text("Past Insights")
                                            .font(.headline)
                                            .foregroundColor(.appText)
                                        
                                        Text("Review previous alerts")
                                            .font(.caption)
                                            .foregroundColor(.appSecondaryText)
                                    }
                                    
                                    Spacer()
                                    
                                    Image(systemName: "chevron.right")
                                        .foregroundColor(.appSecondaryText)
                                }
                                .padding(16)
                                .background(Color.appSecondaryBackground)
                                .cornerRadius(16)
                                .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
                            }
                            .padding(.horizontal, 20)
                        }
                        
                        Spacer(minLength: 40)
                    }
                    .padding(.top, 10)
                }
            }
        }
    }
}

struct ActivityCard: View {
    let icon: String
    let color: Color
    let title: String
    let subtitle: String
    
    var body: some View {
        HStack(spacing: 16) {
            ZStack {
                Circle()
                    .fill(color.opacity(0.15))
                    .frame(width: 44, height: 44)
                
                Image(systemName: icon)
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(color)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.body.weight(.semibold))
                    .foregroundColor(.appText)
                
                Text(subtitle)
                    .font(.subheadline)
                    .foregroundColor(.appSecondaryText)
                    .lineLimit(2)
            }
            
            Spacer()
        }
        .padding(16)
        .background(Color.appSecondaryBackground)
        .cornerRadius(16)
        // Subtle shadow for depth
        .shadow(color: Color.black.opacity(0.03), radius: 5, x: 0, y: 2)
    }
}

// MARK: - Components

struct WaveShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let width = rect.width
        let height = rect.height
        
        // Start point
        path.move(to: CGPoint(x: 0, y: height * 0.8))
        
        // Smooth curves approximating the user's image
        path.addCurve(
            to: CGPoint(x: width * 0.15, y: height * 0.3),
            control1: CGPoint(x: width * 0.05, y: height * 0.3),
            control2: CGPoint(x: width * 0.1, y: height * 0.2)
        )
        
        path.addCurve(
            to: CGPoint(x: width * 0.3, y: height * 0.7),
            control1: CGPoint(x: width * 0.2, y: height * 0.4),
            control2: CGPoint(x: width * 0.25, y: height * 0.7)
        )
        
        path.addCurve(
            to: CGPoint(x: width * 0.5, y: height * 0.4),
            control1: CGPoint(x: width * 0.35, y: height * 0.7),
            control2: CGPoint(x: width * 0.4, y: height * 0.4)
        )
        
        path.addCurve(
            to: CGPoint(x: width * 0.7, y: height * 0.8),
            control1: CGPoint(x: width * 0.6, y: height * 0.4),
            control2: CGPoint(x: width * 0.65, y: height * 0.9)
        )
        
        path.addCurve(
            to: CGPoint(x: width * 0.85, y: height * 0.2),
            control1: CGPoint(x: width * 0.75, y: height * 0.7),
            control2: CGPoint(x: width * 0.8, y: height * 0.1)
        )
        
         path.addCurve(
            to: CGPoint(x: width, y: height * 0.4),
            control1: CGPoint(x: width * 0.9, y: height * 0.3),
            control2: CGPoint(x: width * 0.95, y: height * 0.4)
        )
        
        return path
    }
}

struct UpdateLogRow: View {
    let icon: String
    let title: String
    let time: String
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(.white)
                .frame(width: 24)
            Text(title)
                .foregroundColor(.white)
            Spacer()
            Text(time)
                .font(.caption)
                .foregroundColor(.gray)
        }
    }
}

struct ReportRow: View {
    let title: String
    
    var body: some View {
        HStack {
            Image(systemName: "doc")
                .foregroundColor(.white)
            Text(title)
                .foregroundColor(.white)
            Spacer()
            Image(systemName: "doc")
                .foregroundColor(.white)
        }
    }
}

#Preview {
    HistoryView()
}