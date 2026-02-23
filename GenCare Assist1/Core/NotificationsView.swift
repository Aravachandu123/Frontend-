import SwiftUI

struct NotificationsView: View {
    @Environment(\.dismiss) private var dismiss
    
    @State private var healthAlerts = true
    @State private var securityAlerts = true
    @State private var productUpdates = false
    
    var body: some View {
        ZStack {
            Color.appBackground.ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Header removed for standard navigation

                
                ScrollView {
                    VStack(alignment: .leading, spacing: 24) {
                        
                        Text("Preferences")
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundColor(.appText)
                            .padding(.top, 10)
                        
                        VStack(spacing: 0) {
                            NotificationToggleRow(
                                title: "Health Insight Alerts",
                                subtitle: "Receive alerts when new health insights are available.",
                                isOn: $healthAlerts
                            )
                            
                            Divider().background(Color.appSecondaryText.opacity(0.2))
                                .padding(.vertical, 16)
                            
                            NotificationToggleRow(
                                title: "Security Alerts",
                                subtitle: "Stay informed about security updates and alerts.",
                                isOn: $securityAlerts
                            )
                            
                            Divider().background(Color.appSecondaryText.opacity(0.2))
                                .padding(.vertical, 16)
                            
                            NotificationToggleRow(
                                title: "Product Updates",
                                subtitle: "Get updates on new features and product enhancements.",
                                isOn: $productUpdates
                            )
                        }
                    }
                    .padding()
                }
            }
        }
        .navigationTitle("Notifications")
        .navigationBarTitleDisplayMode(.inline)
        .standardBackButton()
    }
}

struct NotificationToggleRow: View {
    let title: String
    let subtitle: String
    @Binding var isOn: Bool
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.appText)
                
                Text(subtitle)
                    .font(.system(size: 14))
                    .foregroundColor(.appSecondaryText)
                    .fixedSize(horizontal: false, vertical: true)
            }
            
            Spacer()
            
            Toggle("", isOn: $isOn)
                .labelsHidden()
                .toggleStyle(SwitchToggleStyle(tint: .blue))
        }
    }
}

#Preview {
    NavigationStack {
        NotificationsView()
    }
}