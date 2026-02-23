import SwiftUI

struct SettingsView: View {
    @Environment(\.dismiss) private var dismiss
    
    @EnvironmentObject var themeManager: ThemeManager
    
    // Privacy Toggles
    @AppStorage("personalizedInsights") private var personalizedInsights = true
    @AppStorage("anonymousAnalytics") private var anonymousAnalytics = false
    
    var body: some View {
        ZStack {
            Color.appBackground.ignoresSafeArea()
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 24) {
                    
                    // MARK: - General
                    SettingsSection(title: "General") {
                        NavigationLink(destination: NotificationsView()) {
                            SettingsRow(icon: "bell.fill", color: .red, title: "Notifications")
                        }
                        
                        Divider().padding(.leading, 50)
                        
                        NavigationLink(destination: LanguageView()) {
                            SettingsRow(icon: "globe", color: .blue, title: "Language")
                        }
                        
                        Divider().padding(.leading, 50)
                        
                        ToggleRow(
                            icon: "moon.fill",
                            color: .purple,
                            title: "Dark Mode",
                            isOn: Binding(
                                get: { themeManager.selectedTheme == .dark },
                                set: { themeManager.selectedTheme = $0 ? .dark : .light }
                            )
                        )
                    }
                    
                    // MARK: - Intelligence
                    SettingsSection(title: "Privacy & Intelligence") {
                        ToggleRow(
                            icon: "brain.head.profile",
                            color: .orange,
                            title: "Personalized Insights",
                            isOn: $personalizedInsights
                        )
                        
                        Divider().padding(.leading, 50)
                        
                        ToggleRow(
                            icon: "chart.bar.xaxis",
                            color: .green,
                            title: "Share Analytics",
                            isOn: $anonymousAnalytics
                        )
                    }
                    .padding(.top, 4)
                    
                    // MARK: - Data Management
                    SettingsSection(title: "Data") {
                        NavigationLink(destination: DownloadDataView()) {
                            SettingsRow(icon: "square.and.arrow.down.fill", color: .blue, title: "Download Data")
                        }
                        
                        Divider().padding(.leading, 50)
                        
                        NavigationLink(destination: DeleteAccountView()) {
                            SettingsRow(icon: "trash.fill", color: .red, title: "Delete Account")
                        }
                    }
                    .padding(.top, 4)
                    
                    // Footer
                    Text("GenCare Assist v1.0.0")
                        .font(.caption)
                        .foregroundColor(.appSecondaryText)
                        .padding(.top, 20)
                        .padding(.bottom, 40)
                }
                .padding()
            }
        }
        .navigationTitle("Settings")
        .navigationBarTitleDisplayMode(.inline)
        .standardBackButton()
    }
}

// MARK: - Components

struct SettingsSection<Content: View>: View {
    let title: String
    let content: Content
    
    init(title: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.content = content()
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title.uppercased())
                .font(.caption)
                .fontWeight(.semibold)
                .foregroundColor(.appSecondaryText)
                .padding(.leading, 8)
            
            VStack(spacing: 0) {
                content
            }
            .background(Color.appSecondaryBackground)
            .cornerRadius(12)
            // .shadow(color: Color.black.opacity(0.05), radius: 2, x: 0, y: 1)
        }
    }
}

struct SettingsRow: View {
    let icon: String
    let color: Color
    let title: String
    
    var body: some View {
        HStack(spacing: 16) {
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .fill(color)
                    .frame(width: 30, height: 30)
                
                Image(systemName: icon)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.white)
            }
            
            Text(title)
                .font(.body)
                .foregroundColor(.appText)
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .font(.footnote)
                .foregroundColor(.gray)
        }
        .padding(.vertical, 12)
        .padding(.horizontal, 16)
        .background(Color.appSecondaryBackground) // Ensure touch target
    }
}

struct ToggleRow: View {
    let icon: String
    let color: Color
    let title: String
    @Binding var isOn: Bool
    
    var body: some View {
        HStack(spacing: 16) {
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .fill(color)
                    .frame(width: 30, height: 30)
                
                Image(systemName: icon)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.white)
            }
            
            Text(title)
                .font(.body)
                .foregroundColor(.appText)
            
            Spacer()
            
            Toggle("", isOn: $isOn)
                .labelsHidden()
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 16)
    }
}

#Preview {
    NavigationView {
        SettingsView()
    }
}