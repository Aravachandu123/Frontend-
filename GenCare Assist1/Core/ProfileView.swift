import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var languageManager: LanguageManager
    @AppStorage("userName") private var userName = "Ethan Carter"
    
    // Placeholder image logic
    let profileImageName = "profile_placeholder"

    var body: some View {
        ZStack {
            Color.appBackground.ignoresSafeArea()
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 24) {
                    
                    // 1. Profile Header
                    ProfileHeader(name: userName, imageName: profileImageName)
                    
                    // 2. Quick Stats
                    StatsRow(riskLevel: "Moderate", score: "64%", status: "GenCare")
                    
                    // 3. Menu Groups
                    VStack(spacing: 24) {
                        
                        // Health Management
                        MenuGroup(title: languageManager.localizedString("Health Management")) {
                            NavigationLink(destination: MyHealthDataView()) {
                                ProfileMenuRow(icon: "heart.fill", title: languageManager.localizedString("My Health Data"), color: .red)
                            }
                            
                            NavigationLink(destination: EditHealthInfoView()) {
                                ProfileMenuRow(icon: "pencil", title: languageManager.localizedString("Edit Health Info"), color: .blue)
                            }
                        }
                        
                        // Account & Settings
                        MenuGroup(title: languageManager.localizedString("Account & Settings")) {
                            NavigationLink(destination: SettingsView()) {
                                ProfileMenuRow(icon: "gearshape.fill", title: languageManager.localizedString("Settings & Privacy"), color: .gray)
                            }
                            
                            NavigationLink(destination: HelpSupportView()) {
                                ProfileMenuRow(icon: "questionmark.circle.fill", title: languageManager.localizedString("Help & Support"), color: .orange)
                            }
                            

                        }
                        
                        // Session (Sign Out)
                        MenuGroup(title: languageManager.localizedString("Session")) {
                            NavigationLink(destination: SignOutView()) {
                                ProfileMenuRow(
                                    icon: "rectangle.portrait.and.arrow.right",
                                    title: languageManager.localizedString("Sign Out"),
                                    color: .red,
                                    isDestructive: true
                                )
                            }
                        }
                    }
                    .padding(.horizontal)
                    
                    // Version Info
                    Text("Version 1.0.0 • GenCare Assist")
                        .font(.caption)
                        .foregroundColor(.appSecondaryText)
                        .padding(.top, 10)
                        
                    // Bottom Spacer for TabBar
                    Spacer(minLength: 100)
                }
                .padding(.top, 10)
            }
        }
        .navigationTitle("Profile")
        .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: - Components

struct MenuGroup<Content: View>: View {
    let title: String
    let content: Content
    
    init(title: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.content = content()
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title.uppercased())
                .font(.caption)
                .fontWeight(.bold)
                .foregroundColor(.appSecondaryText)
                .padding(.leading, 8)
            
            VStack(spacing: 0) {
                content
            }
            .background(Color.appSecondaryBackground)
            .cornerRadius(16)
            // .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
        }
    }
}

struct ProfileMenuRow: View {
    let icon: String
    let title: String
    let color: Color
    var isDestructive: Bool = false
    
    var body: some View {
        HStack(spacing: 16) {
            ZStack {
                Circle()
                    .fill(color.opacity(0.1))
                    .frame(width: 36, height: 36)
                
                Image(systemName: icon)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(color)
            }
            
            Text(title)
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(isDestructive ? .red : .appText)
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(.appSecondaryText.opacity(0.5))
        }
        .padding(16)
        // Divider logic would go here if we wanted separators, 
        // but for now simple stacking in the MenuGroup VStack works well.
    }
}

struct ProfileHeader: View {
    let name: String
    let imageName: String
    
    var body: some View {
        VStack(spacing: 16) {
            ZStack {
                Circle()
                    .fill(Color.appSecondaryBackground)
                    .frame(width: 100, height: 100)
                    .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 5)
                
                Image(systemName: "person.crop.circle.fill") // Using generic high-quality SF symbol for safety/consistency
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .foregroundColor(.appSecondaryText.opacity(0.5))
                    .clipShape(Circle())
                
                // Edit Icon Badge with Edit functionality implied (or could add button)
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Image(systemName: "pencil")
                            .font(.system(size: 12, weight: .bold))
                            .foregroundColor(.white)
                            .padding(8)
                            .background(Color.appTint)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.appBackground, lineWidth: 3))
                    }
                }
                .frame(width: 105, height: 105)
            }
            
            VStack(spacing: 4) {
                Text(name)
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.appText)
                
                Text("GenCare Member")
                    .font(.subheadline)
                    .foregroundColor(.appTint)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 4)
                    .background(Color.appTint.opacity(0.1))
                    .cornerRadius(20)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 10)
    }
}

struct StatsRow: View {
    let riskLevel: String
    let score: String
    let status: String
    
    var body: some View {
        HStack(spacing: 12) {
            StatCard(value: riskLevel, unit: "Risk Level", icon: "waveform.path.ecg", color: .orange)
            StatCard(value: score, unit: "Health Score", icon: "heart.text.square.fill", color: .blue)
            StatCard(value: status, unit: "Status", icon: "checkmark.shield.fill", color: .green)
        }
        .padding(.horizontal)
    }
}

struct StatCard: View {
    let value: String
    let unit: String
    let icon: String
    let color: Color
    
    var body: some View {
        VStack(spacing: 10) {
            Image(systemName: icon)
                .font(.system(size: 20))
                .foregroundColor(color)
            
            VStack(spacing: 2) {
                Text(value)
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .foregroundColor(.appText)
                
                Text(unit)
                    .font(.caption2)
                    .foregroundColor(.appSecondaryText)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 16)
        .background(Color.appSecondaryBackground)
        .cornerRadius(16)
    }
}

#Preview {
    NavigationStack {
        ProfileView()
    }
}