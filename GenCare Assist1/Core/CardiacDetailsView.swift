import SwiftUI

struct CardiacDetailsView: View {
    @Environment(\.dismiss) private var dismiss
    
    // Animations
    @State private var animateChart = false
    
    var body: some View {
        ZStack {
            Color.appBackground.ignoresSafeArea()
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 24) {
                    
                    // MARK: - Risk Overview Card
                    VStack(spacing: 20) {
                        HStack {
                            VStack(alignment: .leading, spacing: 8) {
                                Text("OVERALL HEALTH")
                                    .font(.caption.weight(.bold))
                                    .foregroundColor(.appSecondaryText)
                                
                                Text("Moderate Risk")
                                    .font(.title.weight(.bold))
                                    .foregroundColor(Color(hex: "FF9F43")) // Warning Orange
                            }
                            Spacer()
                            
                            // 64% Circular Indicator
                            ZStack {
                                Circle()
                                    .stroke(Color.appSecondaryText.opacity(0.2), lineWidth: 8)
                                
                                Circle()
                                    .trim(from: 0, to: animateChart ? 0.64 : 0)
                                    .stroke(
                                        Color(hex: "FF9F43"),
                                        style: StrokeStyle(lineWidth: 8, lineCap: .round)
                                    )
                                    .rotationEffect(.degrees(-90))
                                    .animation(.easeOut(duration: 1.5), value: animateChart)
                                
                                Text("64%")
                                    .font(.headline.weight(.bold))
                                    .foregroundColor(.appText)
                            }
                            .frame(width: 70, height: 70)
                        }
                        
                        Text("Based on your genetic markers, we've identified a moderate predisposition to cardiovascular sensitivities.")
                            .font(.subheadline)
                            .foregroundColor(.appSecondaryText)
                            .lineSpacing(4)
                    }
                    .padding(24)
                    .background(
                        RoundedRectangle(cornerRadius: 24)
                            .fill(Color.appSecondaryBackground)
                            .shadow(color: Color.black.opacity(0.05), radius: 10, x: 0, y: 5)
                    )
                    .padding(.horizontal, 20)
                    .padding(.top, 10)
                    
                    // MARK: - Why this risk appears
                    VStack(alignment: .leading, spacing: 16) {
                        Label {
                            Text("Risk Analysis")
                                .font(.headline.weight(.semibold))
                                .foregroundColor(.appText)
                        } icon: {
                            Image(systemName: "magnifyingglass.circle.fill")
                                .foregroundColor(.blue)
                        }
                        
                        Text("Your maternal history shows a strong pattern of arterial markers, contributing significantly to this score.")
                            .font(.body)
                            .foregroundColor(.appSecondaryText)
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(Color.appSecondaryBackground)
                            .cornerRadius(16)
                    }
                    .padding(.horizontal, 20)
                    
                    // MARK: - General Description
                    VStack(alignment: .leading, spacing: 16) {
                        Label {
                            Text("About Cardiovascular Health")
                                .font(.headline.weight(.semibold))
                                .foregroundColor(.appText)
                        } icon: {
                            Image(systemName: "heart.text.square.fill")
                                .foregroundColor(.red)
                        }
                        
                        Text("Cardiovascular health refers to the efficient functioning of the heart and blood vessels, critical for long-term longevity and vitality.")
                            .font(.body)
                            .foregroundColor(.appSecondaryText)
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(Color.appSecondaryBackground)
                            .cornerRadius(16)
                    }
                    .padding(.horizontal, 20)
                    
                    // MARK: - Preventive Suggestions
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Preventive Suggestions")
                            .font(.title3.weight(.bold))
                            .foregroundColor(.appText)
                            .padding(.horizontal, 20)
                        
                        VStack(spacing: 12) {
                            SuggestionRow(icon: "waveform.path.ecg", color: .red, title: "Schedule annual ECG", subtitle: "Monitor heart rhythm regularly")
                            SuggestionRow(icon: "drop.fill", color: .blue, title: "Reduce daily sodium", subtitle: "Target < 2,300mg per day")
                            SuggestionRow(icon: "figure.run", color: .green, title: "Increase Zone 2 Cardio", subtitle: "30 mins of moderate activity daily")
                        }
                        .padding(.horizontal, 20)
                    }
                    
                    Spacer(minLength: 20)
                    
                    // Disclaimer
                    Text("This is not a medical diagnosis. Consult a healthcare professional for clinical advice.")
                        .font(.caption)
                        .foregroundColor(.appSecondaryText.opacity(0.7))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 40)
                        .padding(.bottom, 20)
                }
            }
        }
        .navigationTitle("Cardiac Details")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            animateChart = true
        }
    }
}

// Helper Row
struct SuggestionRow: View {
    let icon: String
    let color: Color
    let title: String
    let subtitle: String
    
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(color)
                .frame(width: 44, height: 44)
                .background(color.opacity(0.1))
                .clipShape(Circle())
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.body.weight(.medium))
                    .foregroundColor(.appText)
                
                Text(subtitle)
                    .font(.caption)
                    .foregroundColor(.appSecondaryText)
            }
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .font(.caption)
                .foregroundColor(.appSecondaryText.opacity(0.5))
        }
        .padding(16)
        .background(Color.appSecondaryBackground)
        .cornerRadius(16)
    }
}

#Preview {
    NavigationView {
        CardiacDetailsView()
    }
}