import SwiftUI

struct NewPasswordView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var newPassword = ""
    @State private var confirmPassword = ""
    @State private var showSuccess = false
    
    // We might need a way to go back to root (Login)
    // For now, we will simulate it or assume a binding could be passed if needed.
    // Or we can use the NavigationStack path if available.
    // If usage is simple push, we might need a workaround to pop to root.
    // But let's build the UI first.
    
    var body: some View {
        ZStack {
            Color.appBackground.ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Header
                HStack {
                    Button { dismiss() } label: {
                        Image(systemName: "arrow.left")
                            .foregroundColor(.appText)
                            .font(.system(size: 20, weight: .medium))
                            .frame(width: 44, height: 44)
                    }
                    Spacer()
                    Text("Create New Password")
                        .foregroundColor(.appText)
                        .font(.system(size: 22, weight: .bold))
                    Spacer()
                    Color.clear.frame(width: 44, height: 44)
                }
                .padding(.horizontal, 18)
                .padding(.top, 8)
                .padding(.bottom, 6)
                
                ScrollView {
                    VStack(spacing: 24) {
                        
                        Text("Your new password must be different from previous used passwords.")
                            .foregroundColor(.appSecondaryText)
                            .font(.system(size: 16))
                            .multilineTextAlignment(.leading)
                            .padding(.horizontal, 18)
                            .padding(.top, 10)
                        
                        // New Password Field
                        SecureInputField(title: "New Password", placeholder: "Enter new password", text: $newPassword)
                            .padding(.horizontal, 18)
                        
                        // Confirm Password Field
                        SecureInputField(title: "Confirm Password", placeholder: "Confirm your password", text: $confirmPassword)
                            .padding(.horizontal, 18)
                        
                        // Reset Button
                        Button {
                            handleResetPassword()
                        } label: {
                            Text("Reset Password")
                                .font(.system(size: 20, weight: .bold))
                                .frame(maxWidth: .infinity)
                                .frame(height: 64)
                                .background(Color(hex: "#1380ec"))
                                .foregroundColor(.white)
                                .cornerRadius(18)
                        }
                        .padding(.horizontal, 18)
                        .padding(.top, 20)
                        .disabled(newPassword.isEmpty || confirmPassword.isEmpty)
                        .opacity((newPassword.isEmpty || confirmPassword.isEmpty) ? 0.6 : 1.0)
                    }
                }
            }
            
            // Success Overlay or Alert
            if showSuccess {
                Color.black.opacity(0.8).ignoresSafeArea()
                VStack(spacing: 20) {
                    Image(systemName: "checkmark.circle.fill")
                        .font(.system(size: 60))
                        .foregroundColor(.green)
                    
                    Text("Password Changed!")
                        .font(.title2.bold())
                        .foregroundColor(.white)
                    
                    Text("Your password has been successfully reset.")
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                    
                    Button {
                        // Navigate to Login
                        // Since we are likely in a NavigationStack, we need to pop to root.
                        // A known trick without passing bindings everywhere is utilizing the window root or a notification.
                        // However, simplest here if we lacked a router is to try finding the root or just dismiss.
                        // But dismissing only goes back one level.
                        // Let's rely on a notification to the App/Login or just dismiss repeatedly? No that's bad.
                        // Let's try sending a notification "resetToLogin" which LoginView or App listens to?
                        // Or better: Use navigationDestination logic from previous screens.
                        
                        navigateToLogin()
                    } label: {
                        Text("Back to Login")
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding()
                            .frame(width: 200)
                            .background(Color.blue)
                            .cornerRadius(12)
                    }
                }
                .padding()
                .background(Color(hex: "#1c2531"))
                .cornerRadius(24)
                .shadow(radius: 20)
                .padding(40)
            }
        }
        .navigationBarBackButtonHidden(true)
    }
    
    private func handleResetPassword() {
        // Simulate API call
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            withAnimation {
                showSuccess = true
            }
        }
    }
    
    private func navigateToLogin() {
        // Post a notification that we want to reset the navigation stack
        NotificationCenter.default.post(name: .resetToLogin, object: nil)
    }
}

// Notification for popping to root
extension Notification.Name {
    static let resetToLogin = Notification.Name("resetToLogin")
}

#Preview {
    NewPasswordView()
}