import SwiftUI

struct CompleteProfileRegistrationView: View {
    @Binding var resetToLogin: Bool
    @Environment(\.dismiss) private var dismiss
    @Environment(\.presentationMode) private var presentationMode
    
    @State private var fullName = ""
    @State private var phone = ""
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    
    @State private var goToVerify = false
    @State private var underlineBackToLogin = false
    @State private var showSuccess = false
    
    var body: some View {
        ZStack {
            Color.appBackground.ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Header
                HStack {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "arrow.left")
                        .foregroundColor(.appText)
                        .font(.system(size: 18, weight: .medium))
                    }
                    Spacer()
                    Text("Complete Profile Registration")
                        .foregroundColor(.appText)
                        .font(.headline)
                    Spacer()
                    Color.clear.frame(width: 24)
                }
                .padding(.horizontal)
                .padding(.top, 12)
                .frame(height: 56)
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 20) {
                        InputField(title: "Full Name", placeholder: "Enter Full Name", text: $fullName)
                        InputField(title: "Phone Number", placeholder: "Enter Phone Number", text: $phone)
                        InputField(title: "Email ID", placeholder: "Enter Email ID", text: $email)
                        SecureInputField(title: "Password", placeholder: "Enter Password", text: $password)
                        SecureInputField(title: "Re-enter Password", placeholder: "Re-enter Password", text: $confirmPassword)
                        
                        Button {
                            // Simulate Sign Up API call
                            withAnimation { showSuccess = true }
                            
                            UserDefaults.standard.set(true, forKey: "justRegistered")
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                                dismiss()
                            }
                        } label: {
                            Text("Sign Up")
                                .fontWeight(.bold)
                                .frame(maxWidth: .infinity)
                                .frame(height: 54)
                                .background(Color(hex: "#1380ec"))
                                .foregroundColor(.white)
                                .cornerRadius(16)
                        }
                        .padding(.top, 16)
                        
                        Button {
                            underlineBackToLogin = true
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.12) {
                                dismiss()
                            }
                        } label: {
                            Text("Back to Login")
                                .foregroundColor(Color(hex: "#9dabb9"))
                                .underline(underlineBackToLogin)
                                .font(.system(size: 16, weight: .medium))
                        }
                        .padding(.top, 8)
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 40)
                }
            }
            
            // Success Overlay
            if showSuccess {
                Color.black.opacity(0.6).ignoresSafeArea()
                VStack(spacing: 20) {
                    Image(systemName: "checkmark.circle.fill")
                        .font(.system(size: 60))
                        .foregroundColor(.green)
                    
                    Text("Registration Successful")
                        .font(.title2.bold())
                        .foregroundColor(.white)
                    
                    Text("Your account has been created successfully. You can now login.")
                        .foregroundColor(.white.opacity(0.8))
                        .multilineTextAlignment(.center)
                        .font(.body)
                        .padding(.horizontal, 16)
                }
                .padding(30)
                .background(Color(hex: "#1c2531"))
                .cornerRadius(24)
                .shadow(radius: 20)
                .padding(40)
                .transition(.scale.combined(with: .opacity))
            }
        }
        .onAppear { underlineBackToLogin = false }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    NavigationStack {
        CompleteProfileRegistrationView(resetToLogin: .constant(false))
    }
}