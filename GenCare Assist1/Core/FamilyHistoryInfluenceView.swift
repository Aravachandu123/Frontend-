//
//  FamilyHistoryInfluenceView.swift
//  GenCare Assist1
//
//  Created by SAIL on 20/02/26.
//

import SwiftUI

struct FamilyHistoryInfluenceView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            Color.appBackground.ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Header (Navigation Bar)
                HStack {
                    Button(action: { dismiss() }) {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundColor(.appText)
                            .frame(width: 40, height: 40)
                            .background(Color.appSecondaryBackground)
                            .clipShape(Circle())
                            .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
                    }
                    
                    Spacer()
                    
                    Text("Family History Influence")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(.appText)
                    
                    Spacer()
                    
                    // Invisible spacer for balance
                    Color.clear.frame(width: 40, height: 40)
                }
                .padding(.horizontal)
                .padding(.top, 10) // Added top padding for better spacing
                .padding(.bottom, 10)
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 24) {
                        
                        // Intro Text Card
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Your Genetic Legacy")
                                .font(.title3)
                                .fontWeight(.bold)
                                .foregroundColor(.appText)
                            
                            Text("Explore how your family's health history impacts your genetic risk assessment. Each family member's health conditions contribute to your overall risk profile.")
                                .font(.body)
                                .foregroundColor(.appSecondaryText)
                                .lineSpacing(6)
                                .fixedSize(horizontal: false, vertical: true)
                        }
                        .padding(20)
                        .background(Color.appSecondaryBackground)
                        .cornerRadius(16)
                        .shadow(color: Color.black.opacity(0.05), radius: 8, x: 0, y: 2)
                        
                        // Family Tree Visual
                        VStack(spacing: 16) {
                            Text("Family Tree Visualization")
                                .font(.headline)
                                .foregroundColor(.appText)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.horizontal, 4)
                            
                            // Image Container with Glow
                            ZStack {
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(Color.black)
                                    .frame(height: 300)
                                    .shadow(color: Color.appTint.opacity(0.4), radius: 20, x: 0, y: 10) // Glow effect
                                
                                Image("family_tree_glowing") // Requires asset, fallback to SF Symbol if missing?
                                    .resizable()
                                    .scaledToFit()
                                    .padding()
                                    .frame(height: 300)
                                    .overlay(
                                        // Simple fallback if image fails to load in preview
                                        VStack {
                                            if UIImage(named: "family_tree_glowing") == nil {
                                                Image(systemName: "network")
                                                    .font(.system(size: 80))
                                                    .foregroundColor(.cyan)
                                                    .opacity(0.5)
                                                Text("Family Tree Diagram")
                                                    .foregroundColor(.gray)
                                                    .padding(.top)
                                            }
                                        }
                                    )
                            }
                        }
                        
                        // Insights Breakdown
                        VStack(alignment: .leading, spacing: 16) {
                            Text("Key Influencers")
                                .font(.headline)
                                .foregroundColor(.appText)
                                .padding(.horizontal, 4)
                            
                            // Mother's Side
                            HStack(alignment: .top, spacing: 16) {
                                Circle()
                                    .fill(Color.red.opacity(0.2))
                                    .frame(width: 40, height: 40)
                                    .overlay(Image(systemName: "person.fill").foregroundColor(.red))
                                
                                VStack(alignment: .leading, spacing: 4) {
                                    Text("Maternal Influence")
                                        .font(.headline)
                                        .foregroundColor(.appText)
                                    Text("Significant history of cardiac issues identified on your mother's side.")
                                        .font(.subheadline)
                                        .foregroundColor(.appSecondaryText)
                                        .lineSpacing(2)
                                }
                            }
                            .padding()
                            .background(Color.appSecondaryBackground)
                            .cornerRadius(16)
                            
                            // Grandfather
                            HStack(alignment: .top, spacing: 16) {
                                Circle()
                                    .fill(Color.orange.opacity(0.2))
                                    .frame(width: 40, height: 40)
                                    .overlay(Image(systemName: "accessibility.fill").foregroundColor(.orange))
                                
                                VStack(alignment: .leading, spacing: 4) {
                                    Text("Grandfather's Traits")
                                        .font(.headline)
                                        .foregroundColor(.appText)
                                    Text("Metabolic markers align with patterns seen in your grandfather's health records.")
                                        .font(.subheadline)
                                        .foregroundColor(.appSecondaryText)
                                        .lineSpacing(2)
                                }
                            }
                            .padding()
                            .background(Color.appSecondaryBackground)
                            .cornerRadius(16)
                            
                            // General Note
                            HStack(alignment: .top, spacing: 16) {
                                Circle()
                                    .fill(Color.blue.opacity(0.2))
                                    .frame(width: 40, height: 40)
                                    .overlay(Image(systemName: "info.circle.fill").foregroundColor(.blue))
                                
                                VStack(alignment: .leading, spacing: 4) {
                                    Text("Interpretation")
                                        .font(.headline)
                                        .foregroundColor(.appText)
                                    Text("Nodes are color-coded based on the risk they contribute. Glowing nodes indicate active high-risk factors.")
                                        .font(.subheadline)
                                        .foregroundColor(.appSecondaryText)
                                        .lineSpacing(2)
                                }
                            }
                            .padding()
                            .background(Color.appSecondaryBackground)
                            .cornerRadius(16)
                        }
                        
                        Spacer(minLength: 40)
                    }
                    .padding(.horizontal)
                    .padding(.top, 10)
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    FamilyHistoryInfluenceView()
}
