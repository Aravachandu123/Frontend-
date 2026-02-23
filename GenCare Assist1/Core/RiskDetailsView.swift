import SwiftUI

struct RiskDetailsView: View {
    @Environment(\.dismiss) var dismiss
    @State private var showFamilyHistory = false
    @State private var showRecommendations = false
    @State private var animatedProgress: CGFloat = 0.0
    
    var body: some View {
        ZStack {
            Color.appBackground.ignoresSafeArea()
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 30) {
                    
                    // MARK: - 1. Overall Score Header
                    VStack(spacing: 16) {
                        ZStack {
                            // Background Circle
                            Circle()
                                .stroke(Color.gray.opacity(0.15), lineWidth: 15)
                                .frame(width: 140, height: 140)
                            
                            // Progress Circle
                            Circle()
                                .trim(from: 0, to: animatedProgress)
                                .stroke(
                                    LinearGradient(
                                        gradient: Gradient(colors: [Color.orange, Color.red]),
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    ),
                                    style: StrokeStyle(lineWidth: 15, lineCap: .round)
                                )
                                .rotationEffect(.degrees(-90))
                                .frame(width: 140, height: 140)
                                .animation(.easeOut(duration: 1.5), value: animatedProgress)
                            
                            VStack(spacing: 4) {
                                Text("64%")
                                    .font(.system(size: 36, weight: .bold))
                                    .foregroundColor(.appText)
                                
                                Text("Moderate")
                                    .font(.system(size: 14, weight: .semibold))
                                    .foregroundColor(.orange)
                            }
                        }
                        .padding(.top, 20)
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                animatedProgress = 0.64
                            }
                        }
                        
                        Text("Overall Risk Assessment")
                            .font(.headline)
                            .foregroundColor(.appSecondaryText)
                    }
                    
                    // MARK: - 2. Detailed Risk Breakdown
                    VStack(spacing: 20) {
                        HStack {
                            Text("Risk Breakdown")
                                .font(.title3)
                                .fontWeight(.bold)
                                .foregroundColor(.appText)
                            Spacer()
                        }
                        .padding(.horizontal)
                        
                        // Cardiac Risk
                        NavigationLink(destination: CardiacDetailsView()) {
                            ModernRiskDetailCard(
                                icon: "heart.fill",
                                title: "Cardiac Risk",
                                description: "Family history & sodium intake contribution",
                                riskLabel: "High Risk",
                                riskValue: "72%",
                                color: .red,
                                progress: 0.72
                            )
                        }
                        .buttonStyle(PlainButtonStyle())
                        
                        // Metabolic Risk
                        ModernRiskDetailCard(
                            icon: "bolt.fill", // Using consistent icon from Home
                            title: "Metabolic Risk",
                            description: "Glucose markers within range",
                            riskLabel: "Moderate",
                            riskValue: "58%",
                            color: .green,
                            progress: 0.58
                        )
                        
                        // Neurological Risk
                        ModernRiskDetailCard(
                            icon: "brain.head.profile",
                            title: "Neurological Risk",
                            description: "No significant anomalies specific",
                            riskLabel: "Low Risk",
                            riskValue: "24%",
                            color: .purple,
                            progress: 0.24
                        )
                    }
                    .padding(.horizontal)
                    
                    // MARK: - 3. Action Buttons
                    VStack(spacing: 16) {
                        Button(action: { showRecommendations = true }) {
                            HStack {
                                Text("View All Recommendations")
                                    .fontWeight(.semibold)
                                Image(systemName: "arrow.right")
                            }
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.appTint)
                            .cornerRadius(16)
                            .shadow(color: Color.appTint.opacity(0.3), radius: 8, x: 0, y: 4)
                        }
                        
                        Button(action: { showFamilyHistory = true }) {
                            HStack {
                                Image(systemName: "person.3.fill")
                                Text("Family History Influence")
                                    .fontWeight(.semibold)
                            }
                            .foregroundColor(.appText)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.appSecondaryBackground)
                            .cornerRadius(16)
                            //.overlay(RoundedRectangle(cornerRadius: 16).stroke(Color.appSecondaryText.opacity(0.2), lineWidth: 1))
                        }
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 40)
                }
            }
        }
        .navigationTitle("Risk Details")
        .navigationBarTitleDisplayMode(.inline)
        .standardBackButton()
        .sheet(isPresented: $showFamilyHistory) {
            FamilyDataView()
        }
        .sheet(isPresented: $showRecommendations) {
            AllRecommendationsView()
        }
    }
}

struct ModernRiskDetailCard: View {
    let icon: String
    let title: String
    let description: String
    let riskLabel: String
    let riskValue: String
    let color: Color
    let progress: CGFloat
    
    var body: some View {
        VStack(spacing: 16) {
            HStack(alignment: .top, spacing: 16) {
                // Soft Icon Container
                ZStack {
                    Circle()
                        .fill(color.opacity(0.1))
                        .frame(width: 48, height: 48)
                    
                    Image(systemName: icon)
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(color)
                }
                
                VStack(alignment: .leading, spacing: 6) {
                    HStack {
                        Text(title)
                            .font(.headline)
                            .foregroundColor(.appText)
                        
                        Spacer()
                        
                        Text(riskValue)
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundColor(color)
                    }
                    
                    Text(description)
                        .font(.subheadline)
                        .foregroundColor(.appSecondaryText)
                        .lineLimit(2)
                        .fixedSize(horizontal: false, vertical: true)
                }
            }
            
            // Progress Bar
            VStack(spacing: 6) {
                GeometryReader { geo in
                    ZStack(alignment: .leading) {
                        Capsule()
                            .fill(Color.gray.opacity(0.1))
                            .frame(height: 6)
                        
                        Capsule()
                            .fill(color)
                            .frame(width: geo.size.width * progress, height: 6)
                    }
                }
                .frame(height: 6)
                
                HStack {
                    Text(riskLabel)
                        .font(.caption)
                        .fontWeight(.medium)
                        .foregroundColor(color)
                    Spacer()
                }
            }
        }
        .padding(16)
        .background(Color.appSecondaryBackground)
        .cornerRadius(20)
        // Subtle shadow, adaptive
        .shadow(color: Color.black.opacity(0.05), radius: 8, x: 0, y: 2)
    }
}

#Preview {
    RiskDetailsView()
}