//
//  FamilyHistoryInfluenceView.swift
//  GenCare Assist1
//
//  Created by SAIL on 20/02/26.
//

import SwiftUI

struct FamilyHistoryInfluenceView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var familyHealthVM: FamilyHealthViewModel
    
    var body: some View {
        ZStack {
            Color.appBackground.ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Header (Navigation Bar)
                HStack {
                    Button(action: { dismiss() }) {
                        Image(systemName: "arrow.left")
                            .font(.system(size: 20, weight: .regular))
                            .foregroundColor(.appText)
                            .frame(width: 40, height: 40)
                    }
                    
                    Spacer()
                    
                    Text("Family History Influence")
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(.appText)
                    
                    Spacer()
                    
                    // Invisible spacer for balance
                    Color.clear.frame(width: 40, height: 40)
                }
                .padding(.horizontal)
                .padding(.top, 10)
                .padding(.bottom, 10)
                
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 24) {
                        
                        // Intro Text
                        Text("Explore how your family's health history impacts your genetic risk assessment. Each family member's health conditions contribute to your overall risk profile.")
                            .font(.body)
                            .foregroundColor(.appText)
                            .lineSpacing(4)
                            .padding(.horizontal)
                        
                        Text("Family Tree")
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(.appText)
                            .padding(.horizontal)
                        
                        // Family Tree Graphic
                        Image("family_tree_glowing") // Based on Assets 2.xcassets/family_tree_glowing.imageset
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: .infinity)
                            .padding(.horizontal)
                        
                        // Bottom Explanation Text
                        Text("The family tree above visualizes the influence of each family member's health history on your genetic risk. Nodes are color-coded based on the risk they contribute, with larger, glowing nodes indicating significant inherited conditions from your mother and grandfather.")
                            .font(.body)
                            .foregroundColor(.appText)
                            .lineSpacing(4)
                            .padding(.horizontal)
                        
                        Spacer(minLength: 40)
                    }
                    .padding(.top, 10)
                }
            }
        }
        .navigationBarHidden(true)
    }
}

#Preview {
    FamilyHistoryInfluenceView()
        .environmentObject(FamilyHealthViewModel())
}
