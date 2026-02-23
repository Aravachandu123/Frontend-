import SwiftUI

struct PersonalDetailsView: View {

    @Environment(\.dismiss) private var dismiss

    @AppStorage("userName") private var fullName = ""
    @AppStorage("userAge") private var age = ""
    @AppStorage("userGender") private var gender = ""
    @AppStorage("userBloodType") private var bloodType = ""
    @AppStorage("userPhone") private var phone = ""
    @AppStorage("userEmail") private var email = ""

    @State private var goToLifestyle = false
    
    // Options
    private let genders = ["Male", "Female", "Other"]
    private let bloodTypes = ["A+", "A-", "B+", "B-", "AB+", "AB-", "O+", "O-"]

    var body: some View {
        
        VStack(spacing: 0) {
            Form {
                Section(header: Text("Personal Details")) {
                    TextField("Full Name", text: $fullName)
                        .textContentType(.name)
                    
                    TextField("Age", text: $age)
                        .keyboardType(.numberPad)
                    
                    Picker("Gender", selection: $gender) {
                        ForEach(genders, id: \.self) { option in
                            Text(option).tag(option)
                        }
                    }
                    
                    Picker("Blood Type", selection: $bloodType) {
                        ForEach(bloodTypes, id: \.self) { option in
                            Text(option).tag(option)
                        }
                    }
                }
                
                Section(header: Text("Contact Information")) {
                    TextField("Phone", text: $phone)
                        .keyboardType(.phonePad)
                        .textContentType(.telephoneNumber)
                    
                    TextField("Email", text: $email)
                        .keyboardType(.emailAddress)
                        .textContentType(.emailAddress)
                        .textInputAutocapitalization(.never)
                }
            }
            
            Button(action: {
                goToLifestyle = true
            }) {
                Text("Continue")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(12)
                    .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 2)
                    .font(.headline)
                    .foregroundColor(.white)
            }
            .padding(.horizontal)
            .padding(.vertical, 20)
            .background(Color(UIColor.systemGroupedBackground))
        }
        .navigationTitle("Enter Personal Details")
        .navigationBarTitleDisplayMode(.large)
        .navigationDestination(isPresented: $goToLifestyle) {
            LifestyleView()
        }
        .navigationBarBackButtonHidden(true)
    }
}