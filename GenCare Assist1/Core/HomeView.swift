import SwiftUI

struct HomeView: View {
    @EnvironmentObject var languageManager: LanguageManager
    @State private var healthScoreProgress: CGFloat = 0
    
    // Animation States
    @State private var isAnimating = false
    @State private var showContent = false
    
    var body: some View {
        ZStack {
            Color.appBackground.ignoresSafeArea()
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 28) {
                    
                    // MARK: - 1. Modern Header
                    HStack {
                        VStack(alignment: .leading, spacing: 6) {
                            Text("Welcome back,")
                                .font(.callout)
                                .foregroundColor(.appSecondaryText)
                            Text("Ethan Carter")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(.appText)
                        }
                        
                        Spacer()
                        
                        HStack(spacing: 12) {
                            NavigationLink(destination: NotificationsView()) {
                                Image(systemName: "bell.fill")
                                    .font(.system(size: 20))
                                    .foregroundColor(.appText)
                                    .padding(10)
                                    .background(.ultraThinMaterial)
                                    .clipShape(Circle())
                            }
                            
                            NavigationLink(destination: ProfileView()) {
                                Image(systemName: "person.circle.fill")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 42, height: 42)
                                    .clipShape(Circle())
                                    .overlay(Circle().stroke(Color.appSecondaryBackground, lineWidth: 2))
                                    .shadow(radius: 3)
                            }
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top, 10)
                    .opacity(showContent ? 1 : 0)
                    .offset(y: showContent ? 0 : -20)
                    
                    // MARK: - 2. Premium Health Score Card
                    VStack(spacing: 24) {
                        ZStack {
                            // Subtle Pulsing Glow
                            Circle()
                                .fill(Color.blue.opacity(0.15))
                                .frame(width: 220, height: 220)
                                .scaleEffect(isAnimating ? 1.1 : 1.0)
                                .opacity(isAnimating ? 0.6 : 0.3)
                                .blur(radius: 30)
                            
                            // Progress Ring
                            ZStack {
                                Circle()
                                    .stroke(Color.white.opacity(0.05), lineWidth: 22)
                                    .frame(width: 190, height: 190)
                                
                                Circle()
                                    .trim(from: 0, to: healthScoreProgress)
                                    .stroke(
                                        AngularGradient(
                                            gradient: Gradient(colors: [Color(hex: "4facfe"), Color(hex: "00f2fe"), Color(hex: "4facfe")]),
                                            center: .center
                                        ),
                                        style: StrokeStyle(lineWidth: 22, lineCap: .round)
                                    )
                                    .frame(width: 190, height: 190)
                                    .rotationEffect(.degrees(-90))
                                    .shadow(color: Color(hex: "00f2fe").opacity(0.5), radius: 10, x: 0, y: 0)
                                
                                VStack(spacing: 2) {
                                    Text("64")
                                        .font(.system(size: 56, weight: .heavy, design: .rounded))
                                        .foregroundColor(.white)
                                    Text("Health Score")
                                        .font(.footnote)
                                        .fontWeight(.semibold)
                                        .foregroundColor(.white.opacity(0.7))
                                        .textCase(.uppercase)
                                }
                            }
                        }
                        .padding(.top, 10)
                        
                        VStack(spacing: 16) {
                            Text("Your health is optimized based on genetic & lifestyle analysis.")
                                .font(.subheadline)
                                .multilineTextAlignment(.center)
                                .foregroundColor(.white.opacity(0.8))
                                .padding(.horizontal, 24)
                                .lineLimit(2)
                            
                            NavigationLink(destination: RiskDetailsView()) {
                                HStack {
                                    Text("View Details")
                                        .fontWeight(.bold)
                                    Image(systemName: "arrow.right")
                                        .font(.caption.weight(.bold))
                                }
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .frame(height: 50)
                                .background(
                                    LinearGradient(colors: [Color.blue, Color(hex: "0052D4")], startPoint: .topLeading, endPoint: .bottomTrailing)
                                )
                                .cornerRadius(16)
                                .shadow(color: Color.blue.opacity(0.4), radius: 10, x: 0, y: 4)
                            }
                            .padding(.horizontal, 32)
                        }
                    }
                    .padding(.vertical, 32)
                    .background(
                        ZStack {
                            Color(hex: "101216")
                            LinearGradient(colors: [Color.white.opacity(0.05), Color.clear], startPoint: .topLeading, endPoint: .bottomTrailing)
                        }
                    )
                    .cornerRadius(32)
                    .padding(.horizontal)
                    .shadow(color: Color.black.opacity(0.2), radius: 25, x: 0, y: 12)
                    .opacity(showContent ? 1 : 0)
                    .scaleEffect(showContent ? 1 : 0.95)
                    
                    // MARK: - 3. Risk Overview
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Top Risk Areas")
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(.appText)
                            .padding(.horizontal)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 20) {
                                NavigationLink(destination: CardiacDetailsView()) {
                                    ModernRiskCard(title: "Cardiac", icon: "heart.fill", color: .red, riskLevel: "High")
                                }
                                .buttonStyle(RiskCardButtonStyle(color: .red))
                                
                                NavigationLink(destination: Text("Metabolic Info")) {
                                    ModernRiskCard(title: "Metabolic", icon: "bolt.fill", color: .orange, riskLevel: "Med")
                                }
                                .buttonStyle(RiskCardButtonStyle(color: .orange))
                                
                                NavigationLink(destination: Text("Neural Info")) {
                                    ModernRiskCard(title: "Neural", icon: "brain.head.profile", color: .purple, riskLevel: "Low")
                                }
                                .buttonStyle(RiskCardButtonStyle(color: .purple))
                            }
                            .padding(.horizontal)
                            .padding(.vertical, 20) // Allow space for pop-up animation
                        }
                    }
                    .opacity(showContent ? 1 : 0)
                    .offset(y: showContent ? 0 : 20)
                    
                    // MARK: - 4. Recent Insights
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Recent Insights")
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(.appText)
                            .padding(.horizontal)
                        
                        VStack(spacing: 12) {
                            ModernInsightRow(title: "Risk profile updated successfully", time: "Updated 2 hours ago", icon: "checkmark.circle.fill", color: .green)
                            ModernInsightRow(title: "No major risk changes detected", time: "Checked 1 day ago", icon: "info.circle", color: .blue)
                            ModernInsightRow(title: "Family history data analyzed", time: "Analyzed 3 days ago", icon: "arrow.triangle.branch", color: .purple)
                        }
                        .padding(.horizontal)
                    }
                    .opacity(showContent ? 1 : 0)
                    .offset(y: showContent ? 0 : 30)
                    
                    Spacer(minLength: 100)
                }
            }
        }
        .onAppear {
            // Staggered Animation
            withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                showContent = true
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                withAnimation(.easeInOut(duration: 1.5).repeatForever(autoreverses: true)) {
                    isAnimating = true
                }
                withAnimation(.easeOut(duration: 1.2)) {
                    healthScoreProgress = 0.64
                }
            }
        }
    }
}

// MARK: - Components

struct ModernRiskCard: View {
    let title: String
    let icon: String
    let color: Color
    let riskLevel: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                ZStack {
                    Circle()
                        .fill(color.opacity(0.1))
                        .frame(width: 44, height: 44)
                    Image(systemName: icon)
                        .font(.system(size: 20))
                        .foregroundColor(color)
                }
                Spacer()
                Text(riskLevel)
                    .font(.caption2)
                    .fontWeight(.bold)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(color.opacity(0.1))
                    .foregroundColor(color)
                    .cornerRadius(8)
            }
            
            Text(title)
                .font(.headline)
                .fontWeight(.semibold)
                .foregroundColor(.appText)
                .padding(.top, 4)
            
            Text("Analysis complete")
                .font(.caption)
                .foregroundColor(.appSecondaryText)
        }
        .padding(16)
        .frame(width: 140)
        .background(Color.appSecondaryBackground)
        .cornerRadius(24)
        .shadow(color: Color.black.opacity(0.05), radius: 10, x: 0, y: 5)
    }
}

struct ModernInsightRow: View {
    let title: String
    let time: String
    let icon: String
    let color: Color
    
    var body: some View {
        HStack(spacing: 16) {
            ZStack {
                Circle()
                    .fill(color.opacity(0.1))
                    .frame(width: 48, height: 48)
                Image(systemName: icon)
                    .font(.system(size: 20))
                    .foregroundColor(color)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(.appText)
                
                Text(time)
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
        .cornerRadius(20)
        // .shadow(color: Color.black.opacity(0.02), radius: 5, x: 0, y: 2)
    }
}

// Custom Button Style with Hover & Press Animation
struct RiskCardButtonStyle: ButtonStyle {
    let color: Color
    
    func makeBody(configuration: Configuration) -> some View {
        HoverScalingView(configuration: configuration, color: color)
    }
    
    struct HoverScalingView: View {
        let configuration: Configuration
        let color: Color
        @State private var isHovered = false
        
        var body: some View {
            configuration.label
                .scaleEffect(isHovered || configuration.isPressed ? 1.08 : 1.0)
                .shadow(
                    color: color.opacity(isHovered || configuration.isPressed ? 0.6 : 0.0),
                    radius: isHovered || configuration.isPressed ? 20 : 0,
                    x: 0, 
                    y: isHovered || configuration.isPressed ? 10 : 0
                )
                .animation(.spring(response: 0.35, dampingFraction: 0.6), value: isHovered)
                .animation(.spring(response: 0.35, dampingFraction: 0.6), value: configuration.isPressed)
                .onHover { hovering in
                    isHovered = hovering
                }
        }
    }
}

#Preview {
    HomeView()
}