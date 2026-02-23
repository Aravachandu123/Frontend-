import SwiftUI
import UIKit

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var isSigningIn = false
    @FocusState private var focusedField: Field?
    @State private var isPasswordVisible = false
    @State private var showForgotPassword = false

    private enum Field {
        case email, password
    }

    @EnvironmentObject var sessionManager: SessionManager

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Adaptive Background
                Color.appBackground
                    .ignoresSafeArea()

                ScrollView(showsIndicators: false) {
                    VStack(spacing: 32) {

                        // Header
                        VStack(spacing: 16) {
                            Image(systemName: "figure.walk.circle.fill")
                                .font(.system(size: 72))
                                .foregroundStyle(
                                    LinearGradient(
                                        colors: [Color(hex: "#007AFF"), Color(hex: "#5856D6")],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    )
                                )
                                .padding(.top, geometry.safeAreaInsets.top + 20)

                            VStack(spacing: 8) {
                                Text("Welcome back")
                                    .font(.largeTitle.bold())
                                    .foregroundColor(.appText)
                                Text("Sign in to continue your journey")
                                    .font(.body)
                                    .foregroundColor(.appSecondaryText)
                            }
                        }
                        .padding(.bottom, 20)

                        // Form
                        VStack(spacing: 24) {

                            // Email
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Email")
                                    .font(.subheadline.weight(.medium))
                                    .foregroundColor(.appSecondaryText)

                                HStack(spacing: 12) {
                                    Image(systemName: "envelope")
                                        .font(.system(size: 18))
                                        .foregroundColor(
                                            focusedField == .email
                                            ? Color(hex: "#007AFF")
                                            : .appSecondaryText
                                        )
                                        .frame(width: 24)

                                    TextField("", text: $email)
                                        .font(.body)
                                        .foregroundColor(.appText)
                                        .focused($focusedField, equals: .email)
                                        .submitLabel(.next)
                                        .onSubmit { focusedField = .password }
                                        .placeholder(when: email.isEmpty) {
                                            Text("your@email.com")
                                                .foregroundColor(.appSecondaryText)
                                        }
                                        .keyboardType(.emailAddress)
                                        .textInputAutocapitalization(.never)
                                        .autocorrectionDisabled(true)
                                }
                                .padding(.horizontal, 16)
                                .frame(height: 52)
                                .background(
                                    RoundedRectangle(cornerRadius: 12)
                                        .fill(Color.appSecondaryBackground)
                                )
                                .overlay(
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(
                                            focusedField == .email
                                            ? Color(hex: "#007AFF")
                                            : Color.appText.opacity(0.1),
                                            lineWidth: 1
                                        )
                                )
                            }

                            // Password
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Password")
                                    .font(.subheadline.weight(.medium))
                                    .foregroundColor(.appSecondaryText)

                                HStack(spacing: 12) {
                                    Image(systemName: "lock")
                                        .font(.system(size: 18))
                                        .foregroundColor(
                                            focusedField == .password
                                            ? Color(hex: "#007AFF")
                                            : .appSecondaryText
                                        )
                                        .frame(width: 24)

                                    Group {
                                        if isPasswordVisible {
                                            TextField("", text: $password)
                                        } else {
                                            SecureField("", text: $password)
                                        }
                                    }
                                    .font(.body)
                                    .foregroundColor(.appText)
                                    .focused($focusedField, equals: .password)
                                    .submitLabel(.go)
                                    .onSubmit { signIn() }
                                    .placeholder(when: password.isEmpty) {
                                        Text("Enter your password")
                                            .foregroundColor(.appSecondaryText)
                                    }

                                    Button(action: { isPasswordVisible.toggle() }) {
                                        Image(systemName: isPasswordVisible ? "eye.slash" : "eye")
                                            .font(.system(size: 18))
                                            .foregroundColor(.appSecondaryText)
                                    }
                                }
                                .padding(.horizontal, 16)
                                .frame(height: 52)
                                .background(
                                    RoundedRectangle(cornerRadius: 12)
                                        .fill(Color.appSecondaryBackground)
                                )
                                .overlay(
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(
                                            focusedField == .password
                                            ? Color(hex: "#007AFF")
                                            : Color.appText.opacity(0.1),
                                            lineWidth: 1
                                        )
                                )
                            }

                            // Remember Me & Forgot Password
                            HStack {
                                Toggle(isOn: $sessionManager.rememberMe) {
                                    Text("Remember me")
                                        .font(.subheadline)
                                        .foregroundColor(.appText)
                                }
                                .toggleStyle(CheckboxToggleStyle()) // We will make a custom style or standard

                                Spacer()

                                NavigationLink(
                                    destination: ForgotPasswordView()
                                        .navigationBarBackButtonHidden(true),
                                    isActive: $showForgotPassword
                                ) {
                                    Text("Forgot password?")
                                        .font(.footnote.weight(.medium))
                                        .foregroundColor(Color(hex: "#007AFF"))
                                }
                            }
                            .padding(.top, 4)
                        }
                        .padding(.horizontal, 24)

                        // Sign In Button
                        Button(action: signIn) {
                            ZStack {
                                RoundedRectangle(cornerRadius: 14)
                                     .fill(Color(hex: "#007AFF"))
                                    .frame(height: 52)

                                HStack(spacing: 8) {
                                    if isSigningIn {
                                        ProgressView()
                                            .progressViewStyle(CircularProgressViewStyle(tint: .white))
                                            .scaleEffect(0.9)
                                    }
                                    Text(isSigningIn ? "Signing in..." : "Sign In")
                                        .font(.headline.weight(.semibold))
                                        .foregroundColor(.white)
                                }
                            }
                        }
                        .disabled(isSigningIn || email.isEmpty || password.isEmpty)
                        .opacity((isSigningIn || email.isEmpty || password.isEmpty) ? 0.6 : 1)
                        .padding(.horizontal, 24)
                        .padding(.top, 8)

                        // Sign Up Section
                        HStack(spacing: 4) {
                            Text("Don't have an account?")
                                .font(.footnote)
                                .foregroundColor(.appSecondaryText)

                            NavigationLink(
                                destination: CompleteProfileRegistrationView(resetToLogin: .constant(false))
                                    .navigationBarBackButtonHidden(true)
                            ) {
                                Text("Sign Up")
                                    .font(.footnote.weight(.semibold))
                                    .foregroundColor(Color(hex: "#007AFF"))
                            }
                        }
                        .padding(.top, 10)

                        Spacer(minLength: 20)
                    }
                    .frame(minHeight: geometry.size.height)
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .onReceive(NotificationCenter.default.publisher(for: .resetToLogin)) { _ in
            showForgotPassword = false
        }
    }

    private func signIn() {
        guard !email.isEmpty && !password.isEmpty else { return }
        isSigningIn = true
        focusedField = nil
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)

        // Simulate network delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
            isSigningIn = false
            
            let isNewUser = UserDefaults.standard.bool(forKey: "justRegistered")
            if isNewUser {
                UserDefaults.standard.removeObject(forKey: "justRegistered")
            }
            
            // Assume success for now
            sessionManager.signIn(isNewUser: isNewUser) 
            
            print("✓ Validated credentials for:", email)
        }
    }
}

// Simple Checkbox Style
struct CheckboxToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            Image(systemName: configuration.isOn ? "checkmark.square.fill" : "square")
                .foregroundColor(configuration.isOn ? .appTint : .gray)
                .font(.system(size: 20))
                .onTapGesture {
                    configuration.isOn.toggle()
                }
            configuration.label
        }
    }
}

#Preview {
    LoginView()
        .environmentObject(SessionManager())
}