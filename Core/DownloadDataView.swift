import SwiftUI

struct DownloadDataView: View {
    @Environment(\.dismiss) private var dismiss
    
    // User Data for Report
    @AppStorage("userName") private var userName = ""
    @AppStorage("userAge") private var userAge = "0"
    @AppStorage("userGender") private var userGender = ""
    @AppStorage("userBloodType") private var userBloodType = ""
    
    @AppStorage("lifestyleActivity") private var selectedActivity = ""
    @AppStorage("lifestyleDiet") private var selectedDiet = ""
    @AppStorage("lifestyleSmoking") private var selectedSmoking = ""
    
    // PDF Generation State
    @State private var showShareSheet = false
    @State private var pdfURL: URL?
    @State private var isGenerating = false
    
    var body: some View {
        ZStack {
            Color.appBackground.ignoresSafeArea()
            
            VStack(spacing: 20) {
                Spacer()
                
                Image(systemName: "arrow.down.doc.fill")
                    .font(.system(size: 60))
                    .foregroundColor(.blue)
                
                Text("Download Your Data")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.appText)
                
                Text("Your health data will be compiled into a secure PDF report. You can save or share it immediately.")
                    .font(.body)
                    .foregroundColor(.appSecondaryText)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 40)
                
                Button(action: {
                    generateAndSharePDF()
                }) {
                    HStack {
                        if isGenerating {
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        } else {
                            Text("Download Report")
                                .fontWeight(.bold)
                        }
                    }
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(12)
                }
                .disabled(isGenerating)
                .padding(.horizontal, 40)
                .padding(.top, 20)
                
                Spacer()
            }
            .background(Color.red.opacity(0.3)) // DEBUG: Check if VStack is visible
        }
        .standardBackButton()
        .navigationTitle("Download Data")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            print("DEBUG: DownloadDataView Appeared")
        }
        .sheet(isPresented: $showShareSheet) {
            if let url = pdfURL {
                ShareSheet(activityItems: [url])
            }
        }
    }
    
    private func generateAndSharePDF() {
        isGenerating = true
        
        // Simulate a brief delay for UX or if data processing was heavier
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            let data = PDFManager.ReportData(
                userName: userName,
                userAge: userAge,
                userGender: userGender,
                userBloodType: userBloodType,
                activity: selectedActivity,
                diet: selectedDiet,
                smoking: selectedSmoking,
                score: "64/100", // Using placeholder score consistent with other views
                risks: [
                    ("Cardiac", "Moderate", .red),
                    ("Metabolic", "Low", .green)
                ],
                date: Date()
            )
            
            if let url = PDFManager.shared.generateReport(data: data) {
                self.pdfURL = url
                self.showShareSheet = true
            }
            
            isGenerating = false
        }
    }
}

#Preview {
    DownloadDataView()
}
