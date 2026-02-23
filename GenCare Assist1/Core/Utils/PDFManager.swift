import SwiftUI
import PDFKit

class PDFManager {
    static let shared = PDFManager()
    
    // Data model for report
    struct ReportData {
        let userName: String
        let userAge: String
        let userGender: String
        let userBloodType: String
        let activity: String
        let diet: String
        let smoking: String
        let score: String
        let risks: [(name: String, level: String, color: Color)]
        let date: Date
    }

    func generateReport(data: ReportData) -> URL? {
        let format = UIGraphicsPDFRendererFormat()
        let pageWidth = 595.2 // A4 width in points
        let pageHeight = 841.8 // A4 height in points
        let pageRect = CGRect(x: 0, y: 0, width: pageWidth, height: pageHeight)
        
        let renderer = UIGraphicsPDFRenderer(bounds: pageRect, format: format)
        
        // 1. Create temporary URL
        let fileName = "GenCare_Health_Report_\(Date().formatted(date: .numeric, time: .omitted).replacingOccurrences(of: "/", with: "-")).pdf"
        let tempFolder = FileManager.default.temporaryDirectory
        let fileURL = tempFolder.appendingPathComponent(fileName)
        
        // 2. Render PDF
        do {
            try renderer.writePDF(to: fileURL) { context in
                context.beginPage()
                
                let titleAttributes: [NSAttributedString.Key: Any] = [
                    .font: UIFont.boldSystemFont(ofSize: 24),
                    .foregroundColor: UIColor.black
                ]
                
                let subtitleAttributes: [NSAttributedString.Key: Any] = [
                    .font: UIFont.systemFont(ofSize: 12),
                    .foregroundColor: UIColor.gray
                ]
                
                let headerAttributes: [NSAttributedString.Key: Any] = [
                    .font: UIFont.boldSystemFont(ofSize: 16),
                    .foregroundColor: UIColor.black
                ]
                
                let bodyAttributes: [NSAttributedString.Key: Any] = [
                    .font: UIFont.systemFont(ofSize: 12),
                    .foregroundColor: UIColor.darkGray
                ]
                
                var yPosition: CGFloat = 50
                let margin: CGFloat = 40
                let contentWidth = pageWidth - (margin * 2)
                
                // Draw Header
                let title = "Personal Health Report"
                title.draw(at: CGPoint(x: margin, y: yPosition), withAttributes: titleAttributes)
                yPosition += 30
                
                let dateString = "Generated on \(data.date.formatted(date: .abbreviated, time: .shortened))"
                dateString.draw(at: CGPoint(x: margin, y: yPosition), withAttributes: subtitleAttributes)
                yPosition += 40
                
                // Helper to draw a section
                func drawSection(title: String, items: [(String, String)]) {
                    title.draw(at: CGPoint(x: margin, y: yPosition), withAttributes: headerAttributes)
                    yPosition += 25
                    
                    for item in items {
                        let label = item.0
                        let value = item.1
                        
                        let labelString = NSAttributedString(string: label, attributes: bodyAttributes)
                        let valueString = NSAttributedString(string: value, attributes: [
                            .font: UIFont.boldSystemFont(ofSize: 12),
                            .foregroundColor: UIColor.black
                        ])
                        
                        labelString.draw(at: CGPoint(x: margin, y: yPosition))
                        
                        // Draw value aligned to the right (simple approximation)
                        let _ = valueString.size()
                        valueString.draw(at: CGPoint(x: margin + 150, y: yPosition)) // Indented value
                        
                        yPosition += 20
                    }
                    yPosition += 20 // Spacing after section
                }
                
                // Patient Details
                drawSection(title: "Patient Details", items: [
                    ("Name:", data.userName),
                    ("Age:", "\(data.userAge) Years"),
                    ("Gender:", data.userGender),
                    ("Blood Group:", data.userBloodType.isEmpty ? "Not Set" : data.userBloodType)
                ])
                
                // Lifestyle
                drawSection(title: "Lifestyle Profile", items: [
                    ("Activity:", data.activity),
                    ("Diet:", data.diet),
                    ("Smoking:", data.smoking)
                ])
                
                // Risk Summary
                "Clinical Risk Summary".draw(at: CGPoint(x: margin, y: yPosition), withAttributes: headerAttributes)
                yPosition += 25
                
                "Overall Score: \(data.score)".draw(at: CGPoint(x: margin, y: yPosition), withAttributes: [
                    .font: UIFont.boldSystemFont(ofSize: 14),
                    .foregroundColor: UIColor.orange
                ])
                yPosition += 25
                
                for risk in data.risks {
                    let riskString = NSAttributedString(string: "• \(risk.name) (\(risk.level))", attributes: [
                        .font: UIFont.systemFont(ofSize: 12),
                        .foregroundColor: UIColor(risk.color)
                    ])
                    riskString.draw(at: CGPoint(x: margin, y: yPosition))
                    yPosition += 20
                }
                 yPosition += 40
                
                // Footer
                let footer = "This report is generated by GenCare Assist algorithms based on provided data."
                let footerRect = CGRect(x: margin, y: pageHeight - 60, width: contentWidth, height: 40)
                let footerStyle = NSMutableParagraphStyle()
                footerStyle.alignment = .center
                
                let footerAttributes: [NSAttributedString.Key: Any] = [
                    .font: UIFont.systemFont(ofSize: 10),
                    .foregroundColor: UIColor.gray,
                    .paragraphStyle: footerStyle
                ]
                
                footer.draw(in: footerRect, withAttributes: footerAttributes)
            }
            
            return fileURL
        } catch {
            print("Could not create PDF file: \(error)")
            return nil
        }
    }
}
