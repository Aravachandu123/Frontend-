import SwiftUI

struct FamilyMedicalHistoryView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var viewModel: FamilyHealthViewModel
    @EnvironmentObject var sessionManager: SessionManager
    var body: some View {
        ZStack {
            Color.appBackground.ignoresSafeArea()
            
            VStack(spacing: 0) {
                List {
                    familyMemberSection(
                        memberName: "Father",
                        selectedConditions: Array(viewModel.conditionsByMember["Father", default: []]).sorted()
                    )

                    familyMemberSection(
                        memberName: "Mother",
                        selectedConditions: Array(viewModel.conditionsByMember["Mother", default: []]).sorted()
                    )

                    familyMemberSection(
                        memberName: "Grandparents",
                        selectedConditions: Array(viewModel.conditionsByMember["Grandparents", default: []]).sorted()
                    )

                    familyMemberSection(
                        memberName: "Siblings",
                        selectedConditions: Array(viewModel.conditionsByMember["Siblings", default: []]).sorted()
                    )
                }
                .listStyle(.insetGrouped)
                .scrollContentBackground(.hidden)
                
                // Bottom Continue Button
                VStack(spacing: 16) {
                    Button(action: {
                        sessionManager.completeProfile()
                    }) {
                        Text("Continue")
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .background(Color.blue)
                            .cornerRadius(12)
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 10)
                }
                .padding(.top, 10)
                .background(Color.appBackground)
            }
        }
        .navigationTitle("Family History")
        .navigationBarTitleDisplayMode(.large)
    }

    private func bindingForMember(_ member: String) -> Binding<Set<String>> {
        Binding(
            get: { viewModel.conditionsByMember[member, default: []] },
            set: { viewModel.conditionsByMember[member] = $0 }
        )
    }

    @ViewBuilder
    private func familyMemberSection(memberName: String, selectedConditions: [String]) -> some View {
        Section(header: Text(memberName)) {
            if selectedConditions.isEmpty {
                NavigationLink(destination: AddConditionsView(
                    selectedConditions: bindingForMember(memberName),
                    memberName: memberName
                )) {
                    HStack {
                        Text("Add conditions for \(memberName)")
                            .foregroundColor(.appSecondaryText)
                        Spacer()
                        Image(systemName: "plus.circle.fill")
                            .foregroundColor(.blue)
                    }
                }
            } else {
                ForEach(selectedConditions, id: \.self) { condition in
                    Text(condition)
                        .foregroundColor(.appText)
                }
                
                NavigationLink(destination: AddConditionsView(
                    selectedConditions: bindingForMember(memberName),
                    memberName: memberName
                )) {
                    Label("Edit Conditions", systemImage: "pencil")
                        .foregroundColor(.blue)
                }
            }
        }
    }
}