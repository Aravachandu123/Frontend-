
import SwiftUI

struct InsightsView: View {
    @State private var showExplanation = false
    @State private var showImmediateActions = false
    @State private var showRecommendedScreenings = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.appBackground.ignoresSafeArea()
                
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 32) { // Increased spacing for breathability
                        
                        // 1. Genetic Risk Summary Card (Hero)
                        VStack(alignment: .leading, spacing: 16) {
                            HStack(alignment: .top) {
                                VStack(alignment: .leading, spacing: 8) {
                                    Text("OVERALL RISK")
                                        .font(.caption)
                                        .fontWeight(.bold)
                                        .foregroundColor(.appSecondaryText)
                                        .tracking(1) // Letter spacing
                                    
                                    Text("Moderate")
                                        .font(.system(size: 42, weight: .bold)) // Larger
                                        .foregroundColor(Color.orange)
                                    
                                    HStack(spacing: 6) {
                                        Image(systemName: "checkmark.shield.fill")
                                            .font(.caption)
                                            .foregroundColor(.green)
                                        Text("Confidence: 92%")
                                            .font(.subheadline)
                                            .fontWeight(.semibold)
                                            .foregroundColor(.appText.opacity(0.8))
                                    }
                                }
                                
                                Spacer()
                                
                                // DNA Icon Circle with Pulse Effect (Simulated)
                                ZStack {
                                    Circle()
                                        .fill(Color.orange.opacity(0.1))
                                        .frame(width: 80, height: 80)
                                    
                                    Image(systemName: "waveform.path.ecg")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 36, height: 36)
                                        .foregroundColor(.orange)
                                }
                            }
                            
                            Text("Based on your genetic profile, lifestyle, and family history.")
                                .font(.body)
                                .foregroundColor(.appSecondaryText)
                                .lineLimit(2)
                                .padding(.top, 4)
                            
                            Button(action: {
                                showExplanation = true
                            }) {
                                HStack {
                                    Text("Understand your risk")
                                        .fontWeight(.semibold)
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                }
                                .padding()
                                .background(Color.appBackground)
                                .foregroundColor(.appText)
                                .cornerRadius(12)
                                .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
                            }
                            .padding(.top, 8)
                        }
                        .padding(24)
                        .background(Color.appSecondaryBackground)
                        .cornerRadius(24)
                        .shadow(color: Color.black.opacity(0.03), radius: 10, x: 0, y: 5)
                        .padding(.horizontal, 20)
                        .sheet(isPresented: $showExplanation) {
                            SimpleExplanationView()
                        }
                        
                        // 2. Key Contributors
                        VStack(alignment: .leading, spacing: 16) {
                            SectionHeader(title: "Key Contributors")
                            
                            VStack(spacing: 16) {
                                ContributorRow(title: "Family History", value: 45, icon: "person.3.fill", color: .purple)
                                ContributorRow(title: "Demographic", value: 10, icon: "person.text.rectangle.fill", color: .blue)
                                ContributorRow(title: "Lifestyle", value: 9, icon: "figure.run", color: .green)
                            }
                            .padding(20)
                            .background(Color.appSecondaryBackground)
                            .cornerRadius(20)
                            .shadow(color: Color.black.opacity(0.03), radius: 8, x: 0, y: 4)
                        }
                        .padding(.horizontal, 20)
                        
                        // 3. Susceptibilities
                        VStack(alignment: .leading, spacing: 16) {
                            SectionHeader(title: "Susceptibilities")
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 16) {
                                    NavigationLink(destination: CardiacDetailsView()) {
                                        SusceptibilityCard(title: "Cardiac", risk: "High", icon: "heart.fill", color: .red)
                                    }
                                    
                                    SusceptibilityCard(title: "Metabolic", risk: "Med", icon: "bolt.fill", color: .orange)
                                    
                                    SusceptibilityCard(title: "Oncology", risk: "Low", icon: "circle.hexagongrid.fill", color: .green)
                                }
                                .padding(.horizontal, 20)
                                .padding(.bottom, 20) // For shadow
                            }
                        }
                        
                        // 4. Actions Section
                        VStack(alignment: .leading, spacing: 16) {
                            SectionHeader(title: "Recommended Actions")
                            
                            VStack(spacing: 16) {
                                Button(action: {
                                    showImmediateActions = true
                                }) {
                                    ActionListRow(
                                        icon: "exclamationmark.shield.fill",
                                        iconColor: .orange,
                                        title: "Immediate Actions",
                                        subtitle: "3 actions require attention"
                                    )
                                }
                                
                                Button(action: {
                                    showRecommendedScreenings = true
                                }) {
                                    ActionListRow(
                                        icon: "doc.text.magnifyingglass",
                                        iconColor: .blue,
                                        title: "Screenings",
                                        subtitle: "View recommended tests"
                                    )
                                }
                            }
                        }
                        .padding(.horizontal, 20)
                        
                        // Extra padding at the bottom for scrolling past the TabBar
                        Spacer(minLength: 120) 
                    }
                    .padding(.top, 20)
                }
            }
            .navigationTitle("Insights")
            .navigationBarTitleDisplayMode(.large)
                        .sheet(isPresented: $showImmediateActions) {
                ImmediateActionsView()
            }
            .sheet(isPresented: $showRecommendedScreenings) {
                AllRecommendationsView()
            }
        }
    }
}

// MARK: - Subviews

struct SectionHeader: View {
    let title: String
    var body: some View {
        Text(title.uppercased())
            .font(.footnote)
            .fontWeight(.bold)
            .foregroundColor(.appSecondaryText)
            .tracking(1)
            .padding(.leading, 4)
    }
}

struct ContributorRow: View {
    let title: String
    let value: Double
    let icon: String // Added icon
    let color: Color
    
    var body: some View {
        VStack(spacing: 8) {
            HStack {
                Image(systemName: icon)
                    .foregroundColor(color)
                    .frame(width: 20)
                
                Text(title)
                    .font(.body)
                    .fontWeight(.medium)
                    .foregroundColor(.appText)
                
                Spacer()
                
                Text("\(Int(value))%")
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(color)
            }
            
            // Modern thin progress bar
            GeometryReader { geo in
                ZStack(alignment: .leading) {
                    Capsule()
                        .fill(color.opacity(0.1))
                        .frame(height: 6)
                    
                    Capsule()
                        .fill(color)
                        .frame(width: geo.size.width * (CGFloat(value) / 100.0), height: 6)
                }
            }
            .frame(height: 6)
        }
    }
}

struct SusceptibilityCard: View {
    let title: String
    let risk: String
    let icon: String
    let color: Color
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack(alignment: .top) {
                ZStack {
                    Circle()
                        .fill(color.opacity(0.15))
                        .frame(width: 44, height: 44)
                    
                    Image(systemName: icon)
                        .font(.title3)
                        .foregroundColor(color)
                }
                
                Spacer()
                
                Text(risk)
                    .font(.caption)
                    .fontWeight(.bold)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .background(color.opacity(0.1))
                    .foregroundColor(color)
                    .cornerRadius(20)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(.appText)
                
                Text("Genetic predisposition")
                    .font(.caption)
                    .foregroundColor(.appSecondaryText)
            }
        }
        .padding(16)
        .frame(width: 170, height: 160) // Slightly larger
        .background(Color.appSecondaryBackground)
        .cornerRadius(20)
        .shadow(color: Color.black.opacity(0.05), radius: 8, x: 0, y: 4)
    }
}

struct ActionListRow: View {
    let icon: String
    let iconColor: Color
    let title: String
    let subtitle: String
    
    var body: some View {
        HStack(spacing: 16) {
            ZStack {
                Circle()
                    .fill(iconColor.opacity(0.1)) // Lighter background
                    .frame(width: 50, height: 50)
                
                Image(systemName: icon)
                    .font(.title3)
                    .foregroundColor(iconColor)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.headline)
                    .foregroundColor(.appText)
                Text(subtitle)
                    .font(.caption)
                    .foregroundColor(.appSecondaryText)
            }
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .font(.caption)
                .foregroundColor(.appSecondaryText)
        }
        .padding(16)
        .background(Color.appSecondaryBackground)
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.03), radius: 6, x: 0, y: 3)
    }
}

#Preview {
    InsightsView()
}